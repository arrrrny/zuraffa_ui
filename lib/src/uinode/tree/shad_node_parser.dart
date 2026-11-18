import 'dart:convert';

import 'package:zuraffa_ui/src/uinode/nodes/nodes.dart';
import 'package:zuraffa_ui/src/uinode/nodes/props.dart';
import 'package:zuraffa_ui/src/uinode/tree/shad_node_tree.dart';
import 'package:zuraffa_ui/src/uinode/tree/ui_errors.dart';

/// Parses and validates wire JSON into a [ShadNodeTree] (spec 1100 FR-10,
/// contracts/uinode-api.md).
///
/// One walk enforces the schema; composition caps and the schema-version
/// policy arrive with US4 (the fields below are their configuration).
/// Every failure is a [UiParseException] naming the node path — parse never
/// returns a partial tree and never throws anything else (research D4).
class ShadNodeParser {
  ShadNodeParser({
    this.maxDepth = 32,
    this.maxNodes = 500,
    this.maxTextLength = 10000,
    this.currentSchemaVersion = ShadNodeTree.currentSchemaVersion,
  });

  /// Maximum tree depth (US4).
  final int maxDepth;

  /// Maximum node count (US4).
  final int maxNodes;

  /// Maximum characters in any text-bearing prop (US4).
  final int maxTextLength;

  /// The wire version this runtime accepts.
  final int currentSchemaVersion;

  /// Parses [json] — an encoded JSON string or an already-decoded map —
  /// into a tree.
  ///
  /// Throws a [UiParseException] subtype on any violation.
  /// Parses and checks [json] without building any widget (FR-14).
  ///
  /// All violations are collected (parse stops at the first of the same
  /// kind to keep paths meaningful); the report is the agent/CI contract.
  UiParseReport validate(Object? json) {
    final errors = <UiParseException>[];
    try {
      final map = _decodePayload(json);
      final version = map['schemaVersion'];
      final hasVersion = version == null || (version is int && version >= 1);
      if (!hasVersion || (version is int && version > currentSchemaVersion)) {
        errors.add(
          UiParseError(
            kind: UiParseErrorKind.malformed,
            path: 'root',
            message: 'unsupported schemaVersion $version',
          ),
        );
        return UiParseReport(errors);
      }
      if (!map.containsKey('root')) {
        errors.add(
          UiParseError(
            kind: UiParseErrorKind.arity,
            path: 'root',
            message: 'envelope requires a "root" node',
          ),
        );
        return UiParseReport(errors);
      }
      _collect(map['root'], 'root', errors);
    } on UiParseException catch (e) {
      errors.add(e);
    }
    return UiParseReport(errors);
  }

  /// Keys whose values are child nodes — the multi-error walk descends
  /// only into these. Every other key is a prop (`action`, `args`,
  /// `padding`, an unknown node's `raw`, …) whose maps/lists are not
  /// nodes; decoding them would report false errors on valid trees.
  static const _childKeys = {
    'content', 'children', 'child', 'header', 'footer', 'trigger',
    'field', 'actions',
  };

  /// Walks [json] recording every violation instead of stopping at the
  /// first: validation is a report, parse is a gate.
  void _collect(Object? json, String path, List<UiParseException> errors) {
    _visitedNodes = 0;
    try {
      _decodeNode(json, path);
    } on UiParseException catch (e) {
      final duplicate = errors.any(
        (x) => x.path == e.path && x.message == e.message,
      );
      if (!duplicate) errors.add(e);
    }
    if (json is! Map) return;
    final type = json['widgetType'];
    if (type is! String || !_decoders.containsKey(type)) {
      // Unknown nodes carry their raw payload verbatim and option entries
      // (tabs/options) are not nodes — there is nothing valid to walk.
      return;
    }
    void walk(Object? value, String prefix) {
      if (value is List) {
        for (var i = 0; i < value.length; i++) {
          _collect(value[i], '$prefix[$i]', errors);
        }
      } else if (value is Map) {
        _collect(value, prefix, errors);
      }
    }

    json.forEach((key, value) {
      if (key == 'panes' && value is List) {
        // Pane entries carry no widgetType on the wire; their content
        // children sit at <pane path>[j] (the _childrenList naming).
        for (var i = 0; i < value.length; i++) {
          final pane = value[i];
          if (pane is Map) walk(pane['content'], '$path/panes[$i]');
        }
      } else if (_childKeys.contains(key)) {
        walk(value, '$path/$key');
      }
    });
  }

  /// The wire types this runtime knows (the certified v1 vocabulary,
  /// spec 1100 A4). Unknown types parse as [UnknownNode] instead.
  Set<String> get supportedWidgetTypes => _decoders.keys.toSet();

  /// Parses [json] — an encoded JSON string or an already-decoded map —
  /// into a tree.
  ///
  /// Throws a [UiParseException] subtype on any violation.
  ShadNodeTree parse(Object? json) {
    _visitedNodes = 0;
    final map = _decodePayload(json);
    final version = map['schemaVersion'];
    final int schemaVersion;
    if (version == null) {
      schemaVersion = currentSchemaVersion;
    } else if (version is int && version >= 1) {
      schemaVersion = version;
    } else {
      throw UiParseError(
        kind: UiParseErrorKind.malformed,
        path: 'root',
        message: 'schemaVersion must be a positive integer, got $version',
      );
    }
    if (schemaVersion > currentSchemaVersion) {
      // FR-8: never silently misparse a future wire.
      throw UiVersionError(
        found: schemaVersion,
        supported: currentSchemaVersion,
      );
    }
    if (!map.containsKey('root')) {
      throw UiParseError(
        kind: UiParseErrorKind.arity,
        path: 'root',
        message: 'envelope requires a "root" node',
      );
    }
    return ShadNodeTree(
      schemaVersion: schemaVersion,
      root: _decodeNode(map['root'], 'root'),
    );
  }

  Map<String, dynamic> _decodePayload(Object? json) {
    if (json is String) {
      try {
        return _decodePayload(jsonDecode(json));
      } on FormatException catch (e) {
        throw UiParseError(
          kind: UiParseErrorKind.malformed,
          path: 'root',
          message: 'payload is not valid JSON: ${e.message}',
        );
      }
    }
    if (json is Map<String, dynamic>) return json;
    if (json is Map) {
      return json.map((k, v) => MapEntry(k.toString(), v));
    }
    throw UiParseError(
      kind: UiParseErrorKind.malformed,
      path: 'root',
      message: 'payload must be a JSON object, got ${json.runtimeType}',
    );
  }

  // ── node dispatch ────────────────────────────────────────────────────

  int _visitedNodes = 0;

  ShadNode _decodeNode(Object? json, String path, {int depth = 0}) {
    if (depth > maxDepth) {
      throw UiTreeTooLarge(
        cap: UiCapKind.depth,
        path: path,
        message: 'tree exceeds the maximum depth of $maxDepth',
      );
    }
    _visitedNodes += 1;
    if (_visitedNodes > maxNodes) {
      throw UiTreeTooLarge(
        cap: UiCapKind.nodes,
        path: path,
        message: 'tree exceeds the maximum node count of $maxNodes',
      );
    }
    if (json is! Map) {
      throw UiParseError(
        kind: UiParseErrorKind.malformed,
        path: path,
        message: 'node must be a JSON object, got ${json.runtimeType}',
      );
    }
    final node = json.map((k, v) => MapEntry(k.toString(), v));
    final type = node['widgetType'];
    if (type is! String || type.isEmpty) {
      throw UiParseError(
        kind: UiParseErrorKind.schema,
        path: path,
        message: 'node requires a non-empty string "widgetType"',
      );
    }
    final decoder = _decoders[type];
    if (decoder == null) {
      return UnknownNode(
        widgetType: type,
        raw: node,
        id: _optId(node, path),
      );
    }
    _checkKeys(type, node, path);
    return decoder(node, path, depth);
  }

  String? _optId(Map<String, dynamic> node, String path) {
    final id = node['id'];
    if (id == null) return null;
    if (id is! String) {
      throw UiParseError(
        kind: UiParseErrorKind.schema,
        path: path,
        message: '"id" must be a string',
      );
    }
    return id;
  }

  void _checkKeys(String type, Map<String, dynamic> node, String path) {
    final allowed = _allowedKeys[type];
    if (allowed == null) return; // unknown types never reach here
    for (final key in node.keys) {
      if (key != 'widgetType' && !allowed.contains(key)) {
        throw UiParseError(
          kind: UiParseErrorKind.schema,
          path: path,
          message:
              'unknown key "$key" on $type node '
              '(allowed: ${allowed.join(', ')})',
        );
      }
    }
  }

  // ── prop readers ─────────────────────────────────────────────────────

  String _reqStr(Map<String, dynamic> node, String key, String path) {
    final value = node[key];
    if (value is String && value.isNotEmpty) {
      _checkTextLength(value, key, path);
      return value;
    }
    throw UiParseError(
      kind: UiParseErrorKind.schema,
      path: path,
      message: '"$key" must be a non-empty string',
    );
  }

  String? _optStr(Map<String, dynamic> node, String key, String path) {
    final value = node[key];
    if (value == null) return null;
    if (value is String) {
      _checkTextLength(value, key, path);
      return value;
    }
    throw UiParseError(
      kind: UiParseErrorKind.schema,
      path: path,
      message: '"$key" must be a string',
    );
  }

  /// Reads a theme-token prop (FR-5/FR-16): raw colors are rejected as
  /// [UiParseErrorKind.colorRejected] before anything else looks at them.
  String? _optToken(Map<String, dynamic> node, String key, String path) {
    final value = _optStr(node, key, path);
    if (value == null) return null;
    if (_colorPattern.hasMatch(value)) {
      throw UiParseError(
        kind: UiParseErrorKind.colorRejected,
        path: path,
        message: '"$key" must be a theme-token name, got raw color "$value"',
      );
    }
    return value;
  }

  void _checkTextLength(String value, String key, String path) {
    if (value.length > maxTextLength) {
      throw UiTreeTooLarge(
        cap: UiCapKind.textLength,
        path: path,
        message: '"$key" exceeds the maximum text length of $maxTextLength',
      );
    }
  }

  static final RegExp _colorPattern = RegExp(
    r'^(#[0-9a-fA-F]{3,8}|0x[0-9a-fA-F]{6,8}|rgba?\(\s*[\d.,\s]+\))$',
  );

  bool? _optBool(Map<String, dynamic> node, String key, String path) {
    final value = node[key];
    if (value == null) return null;
    if (value is bool) return value;
    throw UiParseError(
      kind: UiParseErrorKind.schema,
      path: path,
      message: '"$key" must be a boolean',
    );
  }

  double? _optDouble(Map<String, dynamic> node, String key, String path) {
    final value = node[key];
    if (value == null) return null;
    if (value is num) return value.toDouble();
    throw UiParseError(
      kind: UiParseErrorKind.schema,
      path: path,
      message: '"$key" must be a number',
    );
  }

  int? _optInt(Map<String, dynamic> node, String key, String path) {
    final value = node[key];
    if (value == null) return null;
    if (value is int) return value;
    throw UiParseError(
      kind: UiParseErrorKind.schema,
      path: path,
      message: '"$key" must be an integer',
    );
  }

  String? _optEnum(
    Map<String, dynamic> node,
    String key,
    String path,
    Set<String> values,
  ) {
    final value = _optStr(node, key, path);
    if (value == null) return null;
    if (!values.contains(value)) {
      throw UiParseError(
        kind: UiParseErrorKind.enumValue,
        path: path,
        message: '"$key" must be one of ${values.join(', ')}, got "$value"',
      );
    }
    return value;
  }

  ActionId? _optAction(Map<String, dynamic> node, String key, String path) {
    final value = node[key];
    if (value == null) return null;
    if (value is! Map) {
      throw UiParseError(
        kind: UiParseErrorKind.schema,
        path: path,
        message: '"$key" must be an action object {action, args}',
      );
    }
    final name = value['action'];
    if (name is! String || name.isEmpty) {
      throw UiParseError(
        kind: UiParseErrorKind.schema,
        path: path,
        message: '"$key.action" must be a non-empty string',
      );
    }
    final args = value['args'];
    if (args != null && args is! Map) {
      throw UiParseError(
        kind: UiParseErrorKind.schema,
        path: path,
        message: '"$key.args" must be an object',
      );
    }
    return ActionId(
      name,
      args: args == null
          ? const {}
          : (args as Map).map((k, v) => MapEntry(k.toString(), v)),
    );
  }

  /// A required child (data-model arity: exactly one).
  ShadNode _reqChild(
    Map<String, dynamic> node,
    String key,
    String path, {
    int depth = 0,
  }) {
    final value = node[key];
    if (value == null) {
      throw UiParseError(
        kind: UiParseErrorKind.arity,
        path: path,
        message: '$node requires a "$key" child',
      );
    }
    return _decodeNode(value, '$path/$key', depth: depth + 1);
  }

  List<ShadNode> _childrenList(
    Object? value,
    String path, {
    int depth = 0,
  }) {
    if (value is! List) {
      throw UiParseError(
        kind: UiParseErrorKind.schema,
        path: path,
        message: 'children must be an array',
      );
    }
    return [
      for (var i = 0; i < value.length; i++)
        _decodeNode(value[i], '$path[$i]', depth: depth + 1),
    ];
  }

  PaddingSpec _padding(Map<String, dynamic> node, String key, String path) {
    final value = node[key];
    if (value is! Map) {
      throw UiParseError(
        kind: UiParseErrorKind.schema,
        path: path,
        message: '"$key" must be an insets object',
      );
    }
    // `value` is dynamic until the cast: the lint can't see that.
    // ignore: unnecessary_cast
    final map = value as Map;
    return PaddingSpec.fromJson(
      map.map((k, v) => MapEntry(k as String, v)),
    );
  }

  // ── the schema: allowed keys + decoders per wire type ────────────────

  static const _mainAxis = {
    'start',
    'end',
    'center',
    'spaceBetween',
    'spaceAround',
    'spaceEvenly',
  };
  static const _crossAxis = {'start', 'end', 'center', 'stretch', 'baseline'};
  static const _stackAlignment = {
    'topLeft',
    'topCenter',
    'topRight',
    'centerLeft',
    'center',
    'centerRight',
    'bottomLeft',
    'bottomCenter',
    'bottomRight',
  };
  static const _sides = {'top', 'bottom', 'left', 'right'};
  static const _textStyles = {
    'h1',
    'h2',
    'h3',
    'h4',
    'p',
    'muted',
    'small',
    'large',
    'bold',
  };
  static const _textAligns = {
    'start',
    'center',
    'end',
    'justify',
    'left',
    'right',
  };
  static const _buttonVariants = {
    'primary',
    'secondary',
    'destructive',
    'outline',
    'ghost',
    'link',
  };
  static const _badgeVariants = {
    'default',
    'secondary',
    'destructive',
    'outline',
  };
  static const _toastVariants = {
    'default',
    'destructive',
    'success',
    'warning',
    'info',
  };
  static const _imageFits = {
    'cover',
    'contain',
    'fill',
    'fitWidth',
    'fitHeight',
    'none',
    'scaleDown',
  };
  static const _keyboards = {
    'text',
    'number',
    'phone',
    'emailAddress',
    'url',
    'multiline',
  };

  late final Map<String, Set<String>> _allowedKeys = {
    'button': {'label', 'variant', 'size', 'action', 'id'},
    'badge': {'label', 'variant', 'id'},
    'text': {'text', 'style', 'align', 'id'},
    'card': {'title', 'description', 'content', 'header', 'footer', 'id'},
    'cardHeader': {'title', 'description', 'id'},
    'cardFooter': {'content', 'id'},
    'input': {
      'value',
      'placeholder',
      'label',
      'helper',
      'errorText',
      'enabled',
      'obscure',
      'keyboard',
      'action',
      'id',
    },
    'select': {'options', 'value', 'placeholder', 'label', 'enabled', 'id'},
    'selectOption': {'value', 'label', 'enabled', 'id'},
    'checkbox': {'value', 'label', 'enabled', 'action', 'id'},
    'switch': {'value', 'label', 'enabled', 'action', 'id'},
    'radioGroup': {'options', 'value', 'enabled', 'action', 'id'},
    'radioOption': {'value', 'label', 'enabled', 'id'},
    'formItem': {'label', 'field', 'helper', 'errorText', 'required', 'id'},
    'tabs': {'tabs', 'panes', 'value', 'action', 'id'},
    'tab': {'value', 'label', 'enabled', 'action', 'id'},
    'tabPane': {'value', 'content', 'id'},
    'progress': {'value', 'indeterminate', 'id'},
    'separator': {'orientation', 'id'},
    'tooltip': {'message', 'child', 'id'},
    'sheet': {
      'side',
      'title',
      'description',
      'open',
      'content',
      'trigger',
      'action',
      'id',
    },
    'dialog': {
      'title',
      'description',
      'open',
      'actions',
      'content',
      'trigger',
      'action',
      'id',
    },
    'popover': {'open', 'content', 'trigger', 'action', 'id'},
    'toast': {'title', 'description', 'variant', 'action', 'id'},
    'row': {'children', 'mainAxisAlignment', 'crossAxisAlignment', 'gap', 'id'},
    'column': {
      'children',
      'mainAxisAlignment',
      'crossAxisAlignment',
      'gap',
      'id',
    },
    'stack': {'children', 'alignment', 'id'},
    'padding': {'padding', 'child', 'id'},
    'expanded': {'child', 'flex', 'id'},
    'sizedBox': {'child', 'width', 'height', 'id'},
    'listView': {'children', 'spacing', 'shrinkWrap', 'reverse', 'id'},
    'image': {'src', 'fit', 'width', 'height', 'alt', 'id'},
    'icon': {'name', 'size', 'style', 'id'},
  };

  late final Map<String, ShadNode Function(Map<String, dynamic>, String, int)>
  _decoders = {
    'button': (n, p, depth) => ButtonNode(
      id: _optId(n, p),
      label: _optStr(n, 'label', p),
      variant: _optEnum(n, 'variant', p, _buttonVariants),
      size: _optEnum(n, 'size', p, const {'sm', 'md', 'lg'}),
      action: _optAction(n, 'action', p),
    ),
    'badge': (n, p, depth) => BadgeNode(
      id: _optId(n, p),
      label: _reqStr(n, 'label', p),
      variant: _optEnum(n, 'variant', p, _badgeVariants),
    ),
    'text': (n, p, depth) => TextNode(
      id: _optId(n, p),
      text: _reqStr(n, 'text', p),
      style: _optStyleToken(n, 'style', p, _textStyles),
      align: _optEnum(n, 'align', p, _textAligns),
    ),
    'card': (n, p, depth) => CardNode(
      id: _optId(n, p),
      title: _optStr(n, 'title', p),
      description: _optStr(n, 'description', p),
      content: _childrenList(
        n['content'] ?? const [],
        '$p/content',
        depth: depth,
      ),
      header: n['header'] == null
          ? null
          : _decodeNode(n['header'], '$p/header', depth: depth + 1),
      footer: n['footer'] == null
          ? null
          : _decodeNode(n['footer'], '$p/footer', depth: depth + 1),
    ),
    'cardHeader': (n, p, depth) => CardHeaderNode(
      id: _optId(n, p),
      title: _optStr(n, 'title', p),
      description: _optStr(n, 'description', p),
    ),
    'cardFooter': (n, p, depth) => CardFooterNode(
      id: _optId(n, p),
      content: _childrenList(
        n['content'] ?? const [],
        '$p/content',
        depth: depth,
      ),
    ),
    'input': (n, p, depth) => InputNode(
      id: _optId(n, p),
      value: _optStr(n, 'value', p),
      placeholder: _optStr(n, 'placeholder', p),
      label: _optStr(n, 'label', p),
      helper: _optStr(n, 'helper', p),
      errorText: _optStr(n, 'errorText', p),
      enabled: _optBool(n, 'enabled', p),
      obscure: _optBool(n, 'obscure', p),
      keyboard: _optEnum(n, 'keyboard', p, _keyboards),
      action: _optAction(n, 'action', p),
    ),
    'select': (n, p, depth) => SelectNode(
      id: _optId(n, p),
      options: _options(
        n,
        'options',
        p,
        (o, op) => SelectOptionNode(
          id: _optId(o, op),
          value: _reqStr(o, 'value', op),
          label: _reqStr(o, 'label', op),
          enabled: _optBool(o, 'enabled', op),
        ),
      ),
      value: _optStr(n, 'value', p),
      placeholder: _optStr(n, 'placeholder', p),
      label: _optStr(n, 'label', p),
      enabled: _optBool(n, 'enabled', p),
    ),
    'selectOption': (n, p, depth) => SelectOptionNode(
      id: _optId(n, p),
      value: _reqStr(n, 'value', p),
      label: _reqStr(n, 'label', p),
      enabled: _optBool(n, 'enabled', p),
    ),
    'checkbox': (n, p, depth) => CheckboxNode(
      id: _optId(n, p),
      value: _optBool(n, 'value', p),
      label: _optStr(n, 'label', p),
      enabled: _optBool(n, 'enabled', p),
      action: _optAction(n, 'action', p),
    ),
    'switch': (n, p, depth) => SwitchNode(
      id: _optId(n, p),
      value: _optBool(n, 'value', p),
      label: _optStr(n, 'label', p),
      enabled: _optBool(n, 'enabled', p),
      action: _optAction(n, 'action', p),
    ),
    'radioGroup': (n, p, depth) => RadioGroupNode(
      id: _optId(n, p),
      options: _options(
        n,
        'options',
        p,
        (o, op) => RadioOptionNode(
          id: _optId(o, op),
          value: _reqStr(o, 'value', op),
          label: _reqStr(o, 'label', op),
          enabled: _optBool(o, 'enabled', op),
        ),
      ),
      value: _optStr(n, 'value', p),
      enabled: _optBool(n, 'enabled', p),
      action: _optAction(n, 'action', p),
    ),
    'radioOption': (n, p, depth) => RadioOptionNode(
      id: _optId(n, p),
      value: _reqStr(n, 'value', p),
      label: _reqStr(n, 'label', p),
      enabled: _optBool(n, 'enabled', p),
    ),
    'formItem': (n, p, depth) => FormItemNode(
      id: _optId(n, p),
      label: _reqStr(n, 'label', p),
      field: _reqChild(n, 'field', p, depth: depth),
      helper: _optStr(n, 'helper', p),
      errorText: _optStr(n, 'errorText', p),
      required_: _optBool(n, 'required', p),
    ),
    'tabs': (n, p, depth) => TabsNode(
      id: _optId(n, p),
      tabs: _options(
        n,
        'tabs',
        p,
        (o, op) => TabNode(
          id: _optId(o, op),
          value: _reqStr(o, 'value', op),
          label: _reqStr(o, 'label', op),
          enabled: _optBool(o, 'enabled', op),
          action: _optAction(o, 'action', op),
        ),
      ),
      panes: _panes(n, p, depth),
      value: _optStr(n, 'value', p),
      action: _optAction(n, 'action', p),
    ),
    'tab': (n, p, depth) => TabNode(
      id: _optId(n, p),
      value: _reqStr(n, 'value', p),
      label: _reqStr(n, 'label', p),
      enabled: _optBool(n, 'enabled', p),
      action: _optAction(n, 'action', p),
    ),
    'tabPane': (n, p, depth) => TabPaneNode(
      id: _optId(n, p),
      value: _reqStr(n, 'value', p),
      content: _childrenList(
        n['content'] ?? const [],
        '$p/content',
        depth: depth,
      ),
    ),
    'progress': (n, p, depth) {
      final value = _optDouble(n, 'value', p);
      if (value == null) {
        throw UiParseError(
          kind: UiParseErrorKind.schema,
          path: p,
          message: 'progress requires a "value"',
        );
      }
      if (value < 0 || value > 1) {
        throw UiParseError(
          kind: UiParseErrorKind.schema,
          path: p,
          message: 'progress "value" must be between 0 and 1, got $value',
        );
      }
      return ProgressNode(
        id: _optId(n, p),
        value: value,
        indeterminate: _optBool(n, 'indeterminate', p),
      );
    },
    'separator': (n, p, depth) => SeparatorNode(
      id: _optId(n, p),
      orientation: _optEnum(
        n,
        'orientation',
        p,
        const {'horizontal', 'vertical'},
      ),
    ),
    'tooltip': (n, p, depth) => TooltipNode(
      id: _optId(n, p),
      message: _reqStr(n, 'message', p),
      child: _reqChild(n, 'child', p, depth: depth),
    ),
    'sheet': (n, p, depth) => SheetNode(
      id: _optId(n, p),
      side: _optEnum(n, 'side', p, _sides),
      title: _optStr(n, 'title', p),
      description: _optStr(n, 'description', p),
      open: _optBool(n, 'open', p),
      content: _childrenList(
        n['content'] ?? const [],
        '$p/content',
        depth: depth,
      ),
      trigger: n['trigger'] == null
          ? null
          : _decodeNode(n['trigger'], '$p/trigger', depth: depth + 1),
      action: _optAction(n, 'action', p),
    ),
    'dialog': (n, p, depth) => DialogNode(
      id: _optId(n, p),
      title: _optStr(n, 'title', p),
      description: _optStr(n, 'description', p),
      open: _optBool(n, 'open', p),
      actions: _buttonActions(n, p, depth),
      content: _childrenList(
        n['content'] ?? const [],
        '$p/content',
        depth: depth,
      ),
      trigger: n['trigger'] == null
          ? null
          : _decodeNode(n['trigger'], '$p/trigger', depth: depth + 1),
      action: _optAction(n, 'action', p),
    ),
    'popover': (n, p, depth) => PopoverNode(
      id: _optId(n, p),
      open: _optBool(n, 'open', p),
      content: _childrenList(
        n['content'] ?? const [],
        '$p/content',
        depth: depth,
      ),
      trigger: n['trigger'] == null
          ? null
          : _decodeNode(n['trigger'], '$p/trigger', depth: depth + 1),
      action: _optAction(n, 'action', p),
    ),
    'toast': (n, p, depth) => ToastNode(
      id: _optId(n, p),
      title: _reqStr(n, 'title', p),
      description: _optStr(n, 'description', p),
      variant: _optEnum(n, 'variant', p, _toastVariants),
      action: _optAction(n, 'action', p),
    ),
    'row': (n, p, depth) => RowNode(
      id: _optId(n, p),
      children: _childrenList(
        n['children'] ?? const [],
        '$p/children',
        depth: depth,
      ),
      mainAxisAlignment: _optEnum(n, 'mainAxisAlignment', p, _mainAxis),
      crossAxisAlignment: _optEnum(n, 'crossAxisAlignment', p, _crossAxis),
      gap: _optDouble(n, 'gap', p),
    ),
    'column': (n, p, depth) => ColumnNode(
      id: _optId(n, p),
      children: _childrenList(
        n['children'] ?? const [],
        '$p/children',
        depth: depth,
      ),
      mainAxisAlignment: _optEnum(n, 'mainAxisAlignment', p, _mainAxis),
      crossAxisAlignment: _optEnum(n, 'crossAxisAlignment', p, _crossAxis),
      gap: _optDouble(n, 'gap', p),
    ),
    'stack': (n, p, depth) => StackNode(
      id: _optId(n, p),
      children: _childrenList(
        n['children'] ?? const [],
        '$p/children',
        depth: depth,
      ),
      alignment: _optEnum(n, 'alignment', p, _stackAlignment),
    ),
    'padding': (n, p, depth) => PaddingNode(
      id: _optId(n, p),
      padding: _padding(n, 'padding', p),
      child: _reqChild(n, 'child', p, depth: depth),
    ),
    'expanded': (n, p, depth) => ExpandedNode(
      id: _optId(n, p),
      child: _reqChild(n, 'child', p, depth: depth),
      flex: _optInt(n, 'flex', p),
    ),
    'sizedBox': (n, p, depth) => SizedBoxNode(
      id: _optId(n, p),
      child: n['child'] == null
          ? null
          : _decodeNode(n['child'], '$p/child', depth: depth + 1),
      width: _optDouble(n, 'width', p),
      height: _optDouble(n, 'height', p),
    ),
    'listView': (n, p, depth) => ListViewNode(
      id: _optId(n, p),
      children: _childrenList(
        n['children'] ?? const [],
        '$p/children',
        depth: depth,
      ),
      spacing: _optDouble(n, 'spacing', p),
      shrinkWrap: _optBool(n, 'shrinkWrap', p),
      reverse: _optBool(n, 'reverse', p),
    ),
    'image': (n, p, depth) => ImageNode(
      id: _optId(n, p),
      src: _reqStr(n, 'src', p),
      fit: _optEnum(n, 'fit', p, _imageFits),
      width: _optDouble(n, 'width', p),
      height: _optDouble(n, 'height', p),
      alt: _optStr(n, 'alt', p),
    ),
    'icon': (n, p, depth) => IconNode(
      id: _optId(n, p),
      name: _reqStr(n, 'name', p),
      size: _optDouble(n, 'size', p),
      style: _optToken(n, 'style', p),
    ),
  };

  /// Theme-token style props: a raw color surfaces as
  /// [UiParseErrorKind.colorRejected] before the enum check (FR-16).
  String? _optStyleToken(
    Map<String, dynamic> node,
    String key,
    String path,
    Set<String> values,
  ) {
    final raw = _optStr(node, key, path);
    if (raw == null) return null;
    if (_colorPattern.hasMatch(raw)) {
      throw UiParseError(
        kind: UiParseErrorKind.colorRejected,
        path: path,
        message: '"$key" must be a theme-token name, got raw color "$raw"',
      );
    }
    if (!values.contains(raw)) {
      throw UiParseError(
        kind: UiParseErrorKind.enumValue,
        path: path,
        message: '"$key" must be one of ${values.join(', ')}, got "$raw"',
      );
    }
    return raw;
  }

  List<T> _options<T>(
    Map<String, dynamic> node,
    String key,
    String path,
    T Function(Map<String, dynamic>, String) decode,
  ) {
    final value = node[key];
    if (value == null) {
      throw UiParseError(
        kind: UiParseErrorKind.arity,
        path: path,
        message: 'node requires "$key"',
      );
    }
    if (value is! List) {
      throw UiParseError(
        kind: UiParseErrorKind.schema,
        path: path,
        message: '"$key" must be an array',
      );
    }
    return [
      for (var i = 0; i < value.length; i++)
        () {
          final item = value[i];
          if (item is! Map) {
            throw UiParseError(
              kind: UiParseErrorKind.schema,
              path: '$path/$key[$i]',
              message: 'option must be a JSON object',
            );
          }
          final map = item.map((k, v) => MapEntry(k.toString(), v));
          _checkKeys(_optionTypes[key]!, map, '$path/$key[$i]');
          return decode(map, '$path/$key[$i]');
        }(),
    ];
  }

  static const _optionTypes = {
    'options': 'selectOption',
    'tabs': 'tab',
  };

  // Dialog actions are buttons on the wire and in the entity. `_childrenList`
  // decodes any node kind, so a non-button here is a schema violation —
  // reject it instead of silently dropping data.
  List<ButtonNode> _buttonActions(Map<String, dynamic> n, String p, int depth) {
    final children = _childrenList(
      n['actions'] ?? const [],
      '$p/actions',
      depth: depth,
    );
    for (var i = 0; i < children.length; i++) {
      if (children[i] is! ButtonNode) {
        throw UiParseError(
          kind: UiParseErrorKind.schema,
          path: '$p/actions[$i]',
          message:
              'dialog "actions" entries must be button nodes, '
              'got "${children[i].widgetType}"',
        );
      }
    }
    return children.cast<ButtonNode>();
  }

  List<TabPaneNode> _panes(Map<String, dynamic> n, String p, int depth) {
    final value = n['panes'];
    if (value == null) {
      throw UiParseError(
        kind: UiParseErrorKind.arity,
        path: p,
        message: 'tabs requires "panes"',
      );
    }
    if (value is! List) {
      throw UiParseError(
        kind: UiParseErrorKind.schema,
        path: p,
        message: '"panes" must be an array',
      );
    }
    return [
      for (var i = 0; i < value.length; i++)
        () {
          final item = value[i];
          if (item is! Map) {
            throw UiParseError(
              kind: UiParseErrorKind.schema,
              path: '$p/panes[$i]',
              message: 'pane must be a JSON object',
            );
          }
          final map = item.map((k, v) => MapEntry(k.toString(), v));
          _checkKeys('tabPane', map, '$p/panes[$i]');
          return TabPaneNode(
            id: _optId(map, '$p/panes[$i]'),
            value: _reqStr(map, 'value', '$p/panes[$i]'),
            content: _childrenList(
              map['content'] ?? const [],
              '$p/panes[$i]',
              depth: depth,
            ),
          );
        }(),
    ];
  }
}
