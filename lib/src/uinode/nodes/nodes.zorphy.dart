// dart format width=80
// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: type=lint

part of 'nodes.dart';

// **************************************************************************
// ZorphyGenerator
// **************************************************************************

sealed class ShadNode {
  ShadNode();

  String? get id;
}

extension ShadNodePropertyHelpers on ShadNode {
  bool get hasId {
    return this.id?.isNotEmpty == true;
  }

  bool get noId {
    return this.id?.isEmpty ?? true;
  }

  String get idRequired {
    return this.id ?? (throw StateError('id is required but was null'));
  }
}

/// Field descriptors for [ShadNode] query construction
abstract final class ShadNodeFields {
  static const id = Field<ShadNode, String?>('id', _$id);

  static String? _$id(ShadNode e) {
    return e.id;
  }
}

extension ShadNodeCompareE on ShadNode {
  Map<String, dynamic> compareToShadNode(ShadNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }
    return diff;
  }
}

class UnknownNode implements ShadNode {
  UnknownNode({
    String? this.id,
    required String this.widgetType,
    required Map<String, dynamic> this.raw,
  });

  final String? id;

  final String widgetType;

  final Map<String, dynamic> raw;

  UnknownNode copyWith({
    String? id,
    String? widgetType,
    Map<String, dynamic>? raw,
  }) {
    return UnknownNode(
      id: id ?? this.id,
      widgetType: widgetType ?? this.widgetType,
      raw: raw ?? this.raw,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  UnknownNode copyWithField<T>(Field<UnknownNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'widgetType':
        return copyWith(widgetType: value as String);
      case 'raw':
        return copyWith(raw: value as Map<String, dynamic>);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'UnknownNode has no settable field with this name',
        );
    }
  }

  UnknownNode copyWithUnknownNode({
    String? id,
    String? widgetType,
    Map<String, dynamic>? raw,
  }) {
    return copyWith(id: id, widgetType: widgetType, raw: raw);
  }

  UnknownNode patchWithUnknownNode([UnknownNodePatch? patchInput]) {
    final _patcher = patchInput ?? UnknownNodePatch();
    final _patchMap = _patcher.patchMap;
    return UnknownNode(
      id: _patchMap.containsKey(UnknownNode$.id)
          ? ((_patchMap[UnknownNode$.id] is Function)
                    ? _patchMap[UnknownNode$.id](this.id)
                    : (_patchMap[UnknownNode$.id] is Patch)
                    ? _patchMap[UnknownNode$.id].applyTo(this.id)
                    : _patchMap[UnknownNode$.id])
                as String?
          : this.id,
      widgetType: _patchMap.containsKey(UnknownNode$.widgetType)
          ? ((_patchMap[UnknownNode$.widgetType] is Function)
                    ? _patchMap[UnknownNode$.widgetType](this.widgetType)
                    : (_patchMap[UnknownNode$.widgetType] is Patch)
                    ? _patchMap[UnknownNode$.widgetType].applyTo(
                        this.widgetType,
                      )
                    : _patchMap[UnknownNode$.widgetType])
                as String
          : this.widgetType,
      raw: _patchMap.containsKey(UnknownNode$.raw)
          ? ((_patchMap[UnknownNode$.raw] is Function)
                    ? _patchMap[UnknownNode$.raw](this.raw)
                    : (_patchMap[UnknownNode$.raw] is Patch)
                    ? _patchMap[UnknownNode$.raw].applyTo(this.raw)
                    : _patchMap[UnknownNode$.raw])
                as Map<String, dynamic>
          : this.raw,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UnknownNode &&
        id == other.id &&
        widgetType == other.widgetType &&
        raw == other.raw;
  }

  @override
  int get hashCode {
    return Object.hash(this.id, this.widgetType, this.raw);
  }

  @override
  String toString() {
    return 'UnknownNode(' +
        'id: ${id}' +
        ', ' +
        'widgetType: ${widgetType}' +
        ', ' +
        'raw: ${raw})';
  }
}

extension UnknownNodePropertyHelpers on UnknownNode {
  bool get hasWidgetType {
    return this.widgetType.isNotEmpty;
  }

  bool get noWidgetType {
    return this.widgetType.isEmpty;
  }

  bool get hasRaw {
    return this.raw.isNotEmpty;
  }

  bool get noRaw {
    return this.raw.isEmpty;
  }
}

enum UnknownNode$ { id, widgetType, raw }

class UnknownNodePatch extends PatchBase<UnknownNode, UnknownNode$> {
  UnknownNode applyTo(UnknownNode entity) {
    return entity.patchWithUnknownNode(this);
  }

  UnknownNodePatch withId(String? value) {
    patchMap[UnknownNode$.id] = value;
    return this;
  }

  UnknownNodePatch withWidgetType(String? value) {
    patchMap[UnknownNode$.widgetType] = value;
    return this;
  }

  UnknownNodePatch withRaw(Map<String, dynamic>? value) {
    patchMap[UnknownNode$.raw] = value;
    return this;
  }
}

/// Field descriptors for [UnknownNode] query construction
abstract final class UnknownNodeFields {
  static const id = Field<UnknownNode, String?>('id', _$id);

  static const widgetType = Field<UnknownNode, String>(
    'widgetType',
    _$widgetType,
  );

  static const raw = Field<UnknownNode, Map<String, dynamic>>('raw', _$raw);

  static String? _$id(UnknownNode e) {
    return e.id;
  }

  static String _$widgetType(UnknownNode e) {
    return e.widgetType;
  }

  static Map<String, dynamic> _$raw(UnknownNode e) {
    return e.raw;
  }
}

extension UnknownNodeCompareE on UnknownNode {
  Map<String, dynamic> compareToUnknownNode(UnknownNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (widgetType != other.widgetType) {
      diff['widgetType'] = () => other.widgetType;
    }

    if (raw != other.raw) {
      diff['raw'] = () => other.raw;
    }
    return diff;
  }
}

class ButtonNode implements ShadNode {
  ButtonNode({
    String? this.id,
    String? this.label,
    String? this.variant,
    String? this.size,
    ActionId? this.action,
  });

  final String? id;

  final String? label;

  final String? variant;

  final String? size;

  final ActionId? action;

  ButtonNode copyWith({
    String? id,
    String? label,
    String? variant,
    String? size,
    ActionId? action,
  }) {
    return ButtonNode(
      id: id ?? this.id,
      label: label ?? this.label,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      action: action ?? this.action,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  ButtonNode copyWithField<T>(Field<ButtonNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'label':
        return copyWith(label: value as String?);
      case 'variant':
        return copyWith(variant: value as String?);
      case 'size':
        return copyWith(size: value as String?);
      case 'action':
        return copyWith(action: value as ActionId?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'ButtonNode has no settable field with this name',
        );
    }
  }

  ButtonNode copyWithButtonNode({
    String? id,
    String? label,
    String? variant,
    String? size,
    ActionId? action,
  }) {
    return copyWith(
      id: id,
      label: label,
      variant: variant,
      size: size,
      action: action,
    );
  }

  ButtonNode patchWithButtonNode([ButtonNodePatch? patchInput]) {
    final _patcher = patchInput ?? ButtonNodePatch();
    final _patchMap = _patcher.patchMap;
    return ButtonNode(
      id: _patchMap.containsKey(ButtonNode$.id)
          ? ((_patchMap[ButtonNode$.id] is Function)
                    ? _patchMap[ButtonNode$.id](this.id)
                    : (_patchMap[ButtonNode$.id] is Patch)
                    ? _patchMap[ButtonNode$.id].applyTo(this.id)
                    : _patchMap[ButtonNode$.id])
                as String?
          : this.id,
      label: _patchMap.containsKey(ButtonNode$.label)
          ? ((_patchMap[ButtonNode$.label] is Function)
                    ? _patchMap[ButtonNode$.label](this.label)
                    : (_patchMap[ButtonNode$.label] is Patch)
                    ? _patchMap[ButtonNode$.label].applyTo(this.label)
                    : _patchMap[ButtonNode$.label])
                as String?
          : this.label,
      variant: _patchMap.containsKey(ButtonNode$.variant)
          ? ((_patchMap[ButtonNode$.variant] is Function)
                    ? _patchMap[ButtonNode$.variant](this.variant)
                    : (_patchMap[ButtonNode$.variant] is Patch)
                    ? _patchMap[ButtonNode$.variant].applyTo(this.variant)
                    : _patchMap[ButtonNode$.variant])
                as String?
          : this.variant,
      size: _patchMap.containsKey(ButtonNode$.size)
          ? ((_patchMap[ButtonNode$.size] is Function)
                    ? _patchMap[ButtonNode$.size](this.size)
                    : (_patchMap[ButtonNode$.size] is Patch)
                    ? _patchMap[ButtonNode$.size].applyTo(this.size)
                    : _patchMap[ButtonNode$.size])
                as String?
          : this.size,
      action: _patchMap.containsKey(ButtonNode$.action)
          ? ((_patchMap[ButtonNode$.action] is Function)
                    ? _patchMap[ButtonNode$.action](this.action)
                    : (_patchMap[ButtonNode$.action] is Patch)
                    ? _patchMap[ButtonNode$.action].applyTo(this.action)
                    : _patchMap[ButtonNode$.action])
                as ActionId?
          : this.action,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ButtonNode &&
        id == other.id &&
        label == other.label &&
        variant == other.variant &&
        size == other.size &&
        action == other.action;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.label,
      this.variant,
      this.size,
      this.action,
    );
  }

  @override
  String toString() {
    return 'ButtonNode(' +
        'id: ${id}' +
        ', ' +
        'label: ${label}' +
        ', ' +
        'variant: ${variant}' +
        ', ' +
        'size: ${size}' +
        ', ' +
        'action: ${action})';
  }
}

extension ButtonNodePropertyHelpers on ButtonNode {
  bool get hasLabel {
    return this.label?.isNotEmpty == true;
  }

  bool get noLabel {
    return this.label?.isEmpty ?? true;
  }

  String get labelRequired {
    return this.label ?? (throw StateError('label is required but was null'));
  }

  bool get hasVariant {
    return this.variant?.isNotEmpty == true;
  }

  bool get noVariant {
    return this.variant?.isEmpty ?? true;
  }

  String get variantRequired {
    return this.variant ??
        (throw StateError('variant is required but was null'));
  }

  bool get hasSize {
    return this.size?.isNotEmpty == true;
  }

  bool get noSize {
    return this.size?.isEmpty ?? true;
  }

  String get sizeRequired {
    return this.size ?? (throw StateError('size is required but was null'));
  }

  bool get hasAction {
    return this.action != null;
  }

  bool get noAction {
    return this.action == null;
  }

  ActionId get actionRequired {
    return this.action ?? (throw StateError('action is required but was null'));
  }
}

enum ButtonNode$ { id, label, variant, size, action }

class ButtonNodePatch extends PatchBase<ButtonNode, ButtonNode$> {
  ButtonNode applyTo(ButtonNode entity) {
    return entity.patchWithButtonNode(this);
  }

  ButtonNodePatch withId(String? value) {
    patchMap[ButtonNode$.id] = value;
    return this;
  }

  ButtonNodePatch withLabel(String? value) {
    patchMap[ButtonNode$.label] = value;
    return this;
  }

  ButtonNodePatch withVariant(String? value) {
    patchMap[ButtonNode$.variant] = value;
    return this;
  }

  ButtonNodePatch withSize(String? value) {
    patchMap[ButtonNode$.size] = value;
    return this;
  }

  ButtonNodePatch withAction(ActionId? value) {
    patchMap[ButtonNode$.action] = value;
    return this;
  }
}

/// Field descriptors for [ButtonNode] query construction
abstract final class ButtonNodeFields {
  static const id = Field<ButtonNode, String?>('id', _$id);

  static const label = Field<ButtonNode, String?>('label', _$label);

  static const variant = Field<ButtonNode, String?>('variant', _$variant);

  static const size = Field<ButtonNode, String?>('size', _$size);

  static const action = Field<ButtonNode, ActionId?>('action', _$action);

  static String? _$id(ButtonNode e) {
    return e.id;
  }

  static String? _$label(ButtonNode e) {
    return e.label;
  }

  static String? _$variant(ButtonNode e) {
    return e.variant;
  }

  static String? _$size(ButtonNode e) {
    return e.size;
  }

  static ActionId? _$action(ButtonNode e) {
    return e.action;
  }
}

extension ButtonNodeCompareE on ButtonNode {
  Map<String, dynamic> compareToButtonNode(ButtonNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (label != other.label) {
      diff['label'] = () => other.label;
    }

    if (variant != other.variant) {
      diff['variant'] = () => other.variant;
    }

    if (size != other.size) {
      diff['size'] = () => other.size;
    }

    if (action != other.action) {
      diff['action'] = () => other.action;
    }
    return diff;
  }
}

class BadgeNode implements ShadNode {
  BadgeNode({
    String? this.id,
    required String this.label,
    String? this.variant,
  });

  final String? id;

  final String label;

  final String? variant;

  BadgeNode copyWith({String? id, String? label, String? variant}) {
    return BadgeNode(
      id: id ?? this.id,
      label: label ?? this.label,
      variant: variant ?? this.variant,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  BadgeNode copyWithField<T>(Field<BadgeNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'label':
        return copyWith(label: value as String);
      case 'variant':
        return copyWith(variant: value as String?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'BadgeNode has no settable field with this name',
        );
    }
  }

  BadgeNode copyWithBadgeNode({String? id, String? label, String? variant}) {
    return copyWith(id: id, label: label, variant: variant);
  }

  BadgeNode patchWithBadgeNode([BadgeNodePatch? patchInput]) {
    final _patcher = patchInput ?? BadgeNodePatch();
    final _patchMap = _patcher.patchMap;
    return BadgeNode(
      id: _patchMap.containsKey(BadgeNode$.id)
          ? ((_patchMap[BadgeNode$.id] is Function)
                    ? _patchMap[BadgeNode$.id](this.id)
                    : (_patchMap[BadgeNode$.id] is Patch)
                    ? _patchMap[BadgeNode$.id].applyTo(this.id)
                    : _patchMap[BadgeNode$.id])
                as String?
          : this.id,
      label: _patchMap.containsKey(BadgeNode$.label)
          ? ((_patchMap[BadgeNode$.label] is Function)
                    ? _patchMap[BadgeNode$.label](this.label)
                    : (_patchMap[BadgeNode$.label] is Patch)
                    ? _patchMap[BadgeNode$.label].applyTo(this.label)
                    : _patchMap[BadgeNode$.label])
                as String
          : this.label,
      variant: _patchMap.containsKey(BadgeNode$.variant)
          ? ((_patchMap[BadgeNode$.variant] is Function)
                    ? _patchMap[BadgeNode$.variant](this.variant)
                    : (_patchMap[BadgeNode$.variant] is Patch)
                    ? _patchMap[BadgeNode$.variant].applyTo(this.variant)
                    : _patchMap[BadgeNode$.variant])
                as String?
          : this.variant,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BadgeNode &&
        id == other.id &&
        label == other.label &&
        variant == other.variant;
  }

  @override
  int get hashCode {
    return Object.hash(this.id, this.label, this.variant);
  }

  @override
  String toString() {
    return 'BadgeNode(' +
        'id: ${id}' +
        ', ' +
        'label: ${label}' +
        ', ' +
        'variant: ${variant})';
  }
}

extension BadgeNodePropertyHelpers on BadgeNode {
  bool get hasLabel {
    return this.label.isNotEmpty;
  }

  bool get noLabel {
    return this.label.isEmpty;
  }

  bool get hasVariant {
    return this.variant?.isNotEmpty == true;
  }

  bool get noVariant {
    return this.variant?.isEmpty ?? true;
  }

  String get variantRequired {
    return this.variant ??
        (throw StateError('variant is required but was null'));
  }
}

enum BadgeNode$ { id, label, variant }

class BadgeNodePatch extends PatchBase<BadgeNode, BadgeNode$> {
  BadgeNode applyTo(BadgeNode entity) {
    return entity.patchWithBadgeNode(this);
  }

  BadgeNodePatch withId(String? value) {
    patchMap[BadgeNode$.id] = value;
    return this;
  }

  BadgeNodePatch withLabel(String? value) {
    patchMap[BadgeNode$.label] = value;
    return this;
  }

  BadgeNodePatch withVariant(String? value) {
    patchMap[BadgeNode$.variant] = value;
    return this;
  }
}

/// Field descriptors for [BadgeNode] query construction
abstract final class BadgeNodeFields {
  static const id = Field<BadgeNode, String?>('id', _$id);

  static const label = Field<BadgeNode, String>('label', _$label);

  static const variant = Field<BadgeNode, String?>('variant', _$variant);

  static String? _$id(BadgeNode e) {
    return e.id;
  }

  static String _$label(BadgeNode e) {
    return e.label;
  }

  static String? _$variant(BadgeNode e) {
    return e.variant;
  }
}

extension BadgeNodeCompareE on BadgeNode {
  Map<String, dynamic> compareToBadgeNode(BadgeNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (label != other.label) {
      diff['label'] = () => other.label;
    }

    if (variant != other.variant) {
      diff['variant'] = () => other.variant;
    }
    return diff;
  }
}

class TextNode implements ShadNode {
  TextNode({
    String? this.id,
    required String this.text,
    String? this.style,
    String? this.align,
  });

  final String? id;

  final String text;

  final String? style;

  final String? align;

  TextNode copyWith({String? id, String? text, String? style, String? align}) {
    return TextNode(
      id: id ?? this.id,
      text: text ?? this.text,
      style: style ?? this.style,
      align: align ?? this.align,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  TextNode copyWithField<T>(Field<TextNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'text':
        return copyWith(text: value as String);
      case 'style':
        return copyWith(style: value as String?);
      case 'align':
        return copyWith(align: value as String?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'TextNode has no settable field with this name',
        );
    }
  }

  TextNode copyWithTextNode({
    String? id,
    String? text,
    String? style,
    String? align,
  }) {
    return copyWith(id: id, text: text, style: style, align: align);
  }

  TextNode patchWithTextNode([TextNodePatch? patchInput]) {
    final _patcher = patchInput ?? TextNodePatch();
    final _patchMap = _patcher.patchMap;
    return TextNode(
      id: _patchMap.containsKey(TextNode$.id)
          ? ((_patchMap[TextNode$.id] is Function)
                    ? _patchMap[TextNode$.id](this.id)
                    : (_patchMap[TextNode$.id] is Patch)
                    ? _patchMap[TextNode$.id].applyTo(this.id)
                    : _patchMap[TextNode$.id])
                as String?
          : this.id,
      text: _patchMap.containsKey(TextNode$.text)
          ? ((_patchMap[TextNode$.text] is Function)
                    ? _patchMap[TextNode$.text](this.text)
                    : (_patchMap[TextNode$.text] is Patch)
                    ? _patchMap[TextNode$.text].applyTo(this.text)
                    : _patchMap[TextNode$.text])
                as String
          : this.text,
      style: _patchMap.containsKey(TextNode$.style)
          ? ((_patchMap[TextNode$.style] is Function)
                    ? _patchMap[TextNode$.style](this.style)
                    : (_patchMap[TextNode$.style] is Patch)
                    ? _patchMap[TextNode$.style].applyTo(this.style)
                    : _patchMap[TextNode$.style])
                as String?
          : this.style,
      align: _patchMap.containsKey(TextNode$.align)
          ? ((_patchMap[TextNode$.align] is Function)
                    ? _patchMap[TextNode$.align](this.align)
                    : (_patchMap[TextNode$.align] is Patch)
                    ? _patchMap[TextNode$.align].applyTo(this.align)
                    : _patchMap[TextNode$.align])
                as String?
          : this.align,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TextNode &&
        id == other.id &&
        text == other.text &&
        style == other.style &&
        align == other.align;
  }

  @override
  int get hashCode {
    return Object.hash(this.id, this.text, this.style, this.align);
  }

  @override
  String toString() {
    return 'TextNode(' +
        'id: ${id}' +
        ', ' +
        'text: ${text}' +
        ', ' +
        'style: ${style}' +
        ', ' +
        'align: ${align})';
  }
}

extension TextNodePropertyHelpers on TextNode {
  bool get hasText {
    return this.text.isNotEmpty;
  }

  bool get noText {
    return this.text.isEmpty;
  }

  bool get hasStyle {
    return this.style?.isNotEmpty == true;
  }

  bool get noStyle {
    return this.style?.isEmpty ?? true;
  }

  String get styleRequired {
    return this.style ?? (throw StateError('style is required but was null'));
  }

  bool get hasAlign {
    return this.align?.isNotEmpty == true;
  }

  bool get noAlign {
    return this.align?.isEmpty ?? true;
  }

  String get alignRequired {
    return this.align ?? (throw StateError('align is required but was null'));
  }
}

enum TextNode$ { id, text, style, align }

class TextNodePatch extends PatchBase<TextNode, TextNode$> {
  TextNode applyTo(TextNode entity) {
    return entity.patchWithTextNode(this);
  }

  TextNodePatch withId(String? value) {
    patchMap[TextNode$.id] = value;
    return this;
  }

  TextNodePatch withText(String? value) {
    patchMap[TextNode$.text] = value;
    return this;
  }

  TextNodePatch withStyle(String? value) {
    patchMap[TextNode$.style] = value;
    return this;
  }

  TextNodePatch withAlign(String? value) {
    patchMap[TextNode$.align] = value;
    return this;
  }
}

/// Field descriptors for [TextNode] query construction
abstract final class TextNodeFields {
  static const id = Field<TextNode, String?>('id', _$id);

  static const text = Field<TextNode, String>('text', _$text);

  static const style = Field<TextNode, String?>('style', _$style);

  static const align = Field<TextNode, String?>('align', _$align);

  static String? _$id(TextNode e) {
    return e.id;
  }

  static String _$text(TextNode e) {
    return e.text;
  }

  static String? _$style(TextNode e) {
    return e.style;
  }

  static String? _$align(TextNode e) {
    return e.align;
  }
}

extension TextNodeCompareE on TextNode {
  Map<String, dynamic> compareToTextNode(TextNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (text != other.text) {
      diff['text'] = () => other.text;
    }

    if (style != other.style) {
      diff['style'] = () => other.style;
    }

    if (align != other.align) {
      diff['align'] = () => other.align;
    }
    return diff;
  }
}

class CardNode implements ShadNode {
  CardNode({
    String? this.id,
    String? this.title,
    String? this.description,
    required List<ShadNode> this.content,
    ShadNode? this.header,
    ShadNode? this.footer,
  });

  final String? id;

  final String? title;

  final String? description;

  final List<ShadNode> content;

  final ShadNode? header;

  final ShadNode? footer;

  CardNode copyWith({
    String? id,
    String? title,
    String? description,
    List<ShadNode>? content,
    ShadNode? header,
    ShadNode? footer,
  }) {
    return CardNode(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      header: header ?? this.header,
      footer: footer ?? this.footer,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  CardNode copyWithField<T>(Field<CardNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'title':
        return copyWith(title: value as String?);
      case 'description':
        return copyWith(description: value as String?);
      case 'content':
        return copyWith(content: value as List<ShadNode>);
      case 'header':
        return copyWith(header: value as ShadNode?);
      case 'footer':
        return copyWith(footer: value as ShadNode?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'CardNode has no settable field with this name',
        );
    }
  }

  CardNode copyWithCardNode({
    String? id,
    String? title,
    String? description,
    List<ShadNode>? content,
    ShadNode? header,
    ShadNode? footer,
  }) {
    return copyWith(
      id: id,
      title: title,
      description: description,
      content: content,
      header: header,
      footer: footer,
    );
  }

  CardNode patchWithCardNode([CardNodePatch? patchInput]) {
    final _patcher = patchInput ?? CardNodePatch();
    final _patchMap = _patcher.patchMap;
    return CardNode(
      id: _patchMap.containsKey(CardNode$.id)
          ? ((_patchMap[CardNode$.id] is Function)
                    ? _patchMap[CardNode$.id](this.id)
                    : (_patchMap[CardNode$.id] is Patch)
                    ? _patchMap[CardNode$.id].applyTo(this.id)
                    : _patchMap[CardNode$.id])
                as String?
          : this.id,
      title: _patchMap.containsKey(CardNode$.title)
          ? ((_patchMap[CardNode$.title] is Function)
                    ? _patchMap[CardNode$.title](this.title)
                    : (_patchMap[CardNode$.title] is Patch)
                    ? _patchMap[CardNode$.title].applyTo(this.title)
                    : _patchMap[CardNode$.title])
                as String?
          : this.title,
      description: _patchMap.containsKey(CardNode$.description)
          ? ((_patchMap[CardNode$.description] is Function)
                    ? _patchMap[CardNode$.description](this.description)
                    : (_patchMap[CardNode$.description] is Patch)
                    ? _patchMap[CardNode$.description].applyTo(this.description)
                    : _patchMap[CardNode$.description])
                as String?
          : this.description,
      content: _patchMap.containsKey(CardNode$.content)
          ? ((_patchMap[CardNode$.content] is Function)
                    ? _patchMap[CardNode$.content](this.content)
                    : (_patchMap[CardNode$.content] is Patch)
                    ? _patchMap[CardNode$.content].applyTo(this.content)
                    : _patchMap[CardNode$.content])
                as List<ShadNode>
          : this.content,
      header: _patchMap.containsKey(CardNode$.header)
          ? ((_patchMap[CardNode$.header] is Function)
                    ? _patchMap[CardNode$.header](this.header)
                    : (_patchMap[CardNode$.header] is Patch)
                    ? _patchMap[CardNode$.header].applyTo(this.header)
                    : _patchMap[CardNode$.header])
                as ShadNode?
          : this.header,
      footer: _patchMap.containsKey(CardNode$.footer)
          ? ((_patchMap[CardNode$.footer] is Function)
                    ? _patchMap[CardNode$.footer](this.footer)
                    : (_patchMap[CardNode$.footer] is Patch)
                    ? _patchMap[CardNode$.footer].applyTo(this.footer)
                    : _patchMap[CardNode$.footer])
                as ShadNode?
          : this.footer,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CardNode &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        content == other.content &&
        header == other.header &&
        footer == other.footer;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.title,
      this.description,
      this.content,
      this.header,
      this.footer,
    );
  }

  @override
  String toString() {
    return 'CardNode(' +
        'id: ${id}' +
        ', ' +
        'title: ${title}' +
        ', ' +
        'description: ${description}' +
        ', ' +
        'content: ${content}' +
        ', ' +
        'header: ${header}' +
        ', ' +
        'footer: ${footer})';
  }
}

extension CardNodePropertyHelpers on CardNode {
  bool get hasTitle {
    return this.title?.isNotEmpty == true;
  }

  bool get noTitle {
    return this.title?.isEmpty ?? true;
  }

  String get titleRequired {
    return this.title ?? (throw StateError('title is required but was null'));
  }

  bool get hasDescription {
    return this.description?.isNotEmpty == true;
  }

  bool get noDescription {
    return this.description?.isEmpty ?? true;
  }

  String get descriptionRequired {
    return this.description ??
        (throw StateError('description is required but was null'));
  }

  bool get hasContent {
    return this.content.isNotEmpty;
  }

  bool get noContent {
    return this.content.isEmpty;
  }

  bool get hasHeader {
    return this.header != null;
  }

  bool get noHeader {
    return this.header == null;
  }

  ShadNode get headerRequired {
    return this.header ?? (throw StateError('header is required but was null'));
  }

  bool get hasFooter {
    return this.footer != null;
  }

  bool get noFooter {
    return this.footer == null;
  }

  ShadNode get footerRequired {
    return this.footer ?? (throw StateError('footer is required but was null'));
  }
}

enum CardNode$ { id, title, description, content, header, footer }

class CardNodePatch extends PatchBase<CardNode, CardNode$> {
  CardNode applyTo(CardNode entity) {
    return entity.patchWithCardNode(this);
  }

  CardNodePatch withId(String? value) {
    patchMap[CardNode$.id] = value;
    return this;
  }

  CardNodePatch withTitle(String? value) {
    patchMap[CardNode$.title] = value;
    return this;
  }

  CardNodePatch withDescription(String? value) {
    patchMap[CardNode$.description] = value;
    return this;
  }

  CardNodePatch withContent(List<ShadNode>? value) {
    patchMap[CardNode$.content] = value;
    return this;
  }

  CardNodePatch withHeader(ShadNode? value) {
    patchMap[CardNode$.header] = value;
    return this;
  }

  CardNodePatch withFooter(ShadNode? value) {
    patchMap[CardNode$.footer] = value;
    return this;
  }
}

/// Field descriptors for [CardNode] query construction
abstract final class CardNodeFields {
  static const id = Field<CardNode, String?>('id', _$id);

  static const title = Field<CardNode, String?>('title', _$title);

  static const description = Field<CardNode, String?>(
    'description',
    _$description,
  );

  static const content = Field<CardNode, List<ShadNode>>('content', _$content);

  static const header = Field<CardNode, ShadNode?>('header', _$header);

  static const footer = Field<CardNode, ShadNode?>('footer', _$footer);

  static String? _$id(CardNode e) {
    return e.id;
  }

  static String? _$title(CardNode e) {
    return e.title;
  }

  static String? _$description(CardNode e) {
    return e.description;
  }

  static List<ShadNode> _$content(CardNode e) {
    return e.content;
  }

  static ShadNode? _$header(CardNode e) {
    return e.header;
  }

  static ShadNode? _$footer(CardNode e) {
    return e.footer;
  }
}

extension CardNodeCompareE on CardNode {
  Map<String, dynamic> compareToCardNode(CardNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (title != other.title) {
      diff['title'] = () => other.title;
    }

    if (description != other.description) {
      diff['description'] = () => other.description;
    }

    if (content != other.content) {
      diff['content'] = () => other.content;
    }

    if (header != other.header) {
      diff['header'] = () => other.header;
    }

    if (footer != other.footer) {
      diff['footer'] = () => other.footer;
    }
    return diff;
  }
}

class CardHeaderNode implements ShadNode {
  CardHeaderNode({
    String? this.id,
    String? this.title,
    String? this.description,
  });

  final String? id;

  final String? title;

  final String? description;

  CardHeaderNode copyWith({String? id, String? title, String? description}) {
    return CardHeaderNode(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  CardHeaderNode copyWithField<T>(Field<CardHeaderNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'title':
        return copyWith(title: value as String?);
      case 'description':
        return copyWith(description: value as String?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'CardHeaderNode has no settable field with this name',
        );
    }
  }

  CardHeaderNode copyWithCardHeaderNode({
    String? id,
    String? title,
    String? description,
  }) {
    return copyWith(id: id, title: title, description: description);
  }

  CardHeaderNode patchWithCardHeaderNode([CardHeaderNodePatch? patchInput]) {
    final _patcher = patchInput ?? CardHeaderNodePatch();
    final _patchMap = _patcher.patchMap;
    return CardHeaderNode(
      id: _patchMap.containsKey(CardHeaderNode$.id)
          ? ((_patchMap[CardHeaderNode$.id] is Function)
                    ? _patchMap[CardHeaderNode$.id](this.id)
                    : (_patchMap[CardHeaderNode$.id] is Patch)
                    ? _patchMap[CardHeaderNode$.id].applyTo(this.id)
                    : _patchMap[CardHeaderNode$.id])
                as String?
          : this.id,
      title: _patchMap.containsKey(CardHeaderNode$.title)
          ? ((_patchMap[CardHeaderNode$.title] is Function)
                    ? _patchMap[CardHeaderNode$.title](this.title)
                    : (_patchMap[CardHeaderNode$.title] is Patch)
                    ? _patchMap[CardHeaderNode$.title].applyTo(this.title)
                    : _patchMap[CardHeaderNode$.title])
                as String?
          : this.title,
      description: _patchMap.containsKey(CardHeaderNode$.description)
          ? ((_patchMap[CardHeaderNode$.description] is Function)
                    ? _patchMap[CardHeaderNode$.description](this.description)
                    : (_patchMap[CardHeaderNode$.description] is Patch)
                    ? _patchMap[CardHeaderNode$.description].applyTo(
                        this.description,
                      )
                    : _patchMap[CardHeaderNode$.description])
                as String?
          : this.description,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CardHeaderNode &&
        id == other.id &&
        title == other.title &&
        description == other.description;
  }

  @override
  int get hashCode {
    return Object.hash(this.id, this.title, this.description);
  }

  @override
  String toString() {
    return 'CardHeaderNode(' +
        'id: ${id}' +
        ', ' +
        'title: ${title}' +
        ', ' +
        'description: ${description})';
  }
}

extension CardHeaderNodePropertyHelpers on CardHeaderNode {
  bool get hasTitle {
    return this.title?.isNotEmpty == true;
  }

  bool get noTitle {
    return this.title?.isEmpty ?? true;
  }

  String get titleRequired {
    return this.title ?? (throw StateError('title is required but was null'));
  }

  bool get hasDescription {
    return this.description?.isNotEmpty == true;
  }

  bool get noDescription {
    return this.description?.isEmpty ?? true;
  }

  String get descriptionRequired {
    return this.description ??
        (throw StateError('description is required but was null'));
  }
}

enum CardHeaderNode$ { id, title, description }

class CardHeaderNodePatch extends PatchBase<CardHeaderNode, CardHeaderNode$> {
  CardHeaderNode applyTo(CardHeaderNode entity) {
    return entity.patchWithCardHeaderNode(this);
  }

  CardHeaderNodePatch withId(String? value) {
    patchMap[CardHeaderNode$.id] = value;
    return this;
  }

  CardHeaderNodePatch withTitle(String? value) {
    patchMap[CardHeaderNode$.title] = value;
    return this;
  }

  CardHeaderNodePatch withDescription(String? value) {
    patchMap[CardHeaderNode$.description] = value;
    return this;
  }
}

/// Field descriptors for [CardHeaderNode] query construction
abstract final class CardHeaderNodeFields {
  static const id = Field<CardHeaderNode, String?>('id', _$id);

  static const title = Field<CardHeaderNode, String?>('title', _$title);

  static const description = Field<CardHeaderNode, String?>(
    'description',
    _$description,
  );

  static String? _$id(CardHeaderNode e) {
    return e.id;
  }

  static String? _$title(CardHeaderNode e) {
    return e.title;
  }

  static String? _$description(CardHeaderNode e) {
    return e.description;
  }
}

extension CardHeaderNodeCompareE on CardHeaderNode {
  Map<String, dynamic> compareToCardHeaderNode(CardHeaderNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (title != other.title) {
      diff['title'] = () => other.title;
    }

    if (description != other.description) {
      diff['description'] = () => other.description;
    }
    return diff;
  }
}

class CardFooterNode implements ShadNode {
  CardFooterNode({String? this.id, required List<ShadNode> this.content});

  final String? id;

  final List<ShadNode> content;

  CardFooterNode copyWith({String? id, List<ShadNode>? content}) {
    return CardFooterNode(id: id ?? this.id, content: content ?? this.content);
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  CardFooterNode copyWithField<T>(Field<CardFooterNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'content':
        return copyWith(content: value as List<ShadNode>);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'CardFooterNode has no settable field with this name',
        );
    }
  }

  CardFooterNode copyWithCardFooterNode({String? id, List<ShadNode>? content}) {
    return copyWith(id: id, content: content);
  }

  CardFooterNode patchWithCardFooterNode([CardFooterNodePatch? patchInput]) {
    final _patcher = patchInput ?? CardFooterNodePatch();
    final _patchMap = _patcher.patchMap;
    return CardFooterNode(
      id: _patchMap.containsKey(CardFooterNode$.id)
          ? ((_patchMap[CardFooterNode$.id] is Function)
                    ? _patchMap[CardFooterNode$.id](this.id)
                    : (_patchMap[CardFooterNode$.id] is Patch)
                    ? _patchMap[CardFooterNode$.id].applyTo(this.id)
                    : _patchMap[CardFooterNode$.id])
                as String?
          : this.id,
      content: _patchMap.containsKey(CardFooterNode$.content)
          ? ((_patchMap[CardFooterNode$.content] is Function)
                    ? _patchMap[CardFooterNode$.content](this.content)
                    : (_patchMap[CardFooterNode$.content] is Patch)
                    ? _patchMap[CardFooterNode$.content].applyTo(this.content)
                    : _patchMap[CardFooterNode$.content])
                as List<ShadNode>
          : this.content,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CardFooterNode &&
        id == other.id &&
        content == other.content;
  }

  @override
  int get hashCode {
    return Object.hash(this.id, this.content);
  }

  @override
  String toString() {
    return 'CardFooterNode(' + 'id: ${id}' + ', ' + 'content: ${content})';
  }
}

extension CardFooterNodePropertyHelpers on CardFooterNode {
  bool get hasContent {
    return this.content.isNotEmpty;
  }

  bool get noContent {
    return this.content.isEmpty;
  }
}

enum CardFooterNode$ { id, content }

class CardFooterNodePatch extends PatchBase<CardFooterNode, CardFooterNode$> {
  CardFooterNode applyTo(CardFooterNode entity) {
    return entity.patchWithCardFooterNode(this);
  }

  CardFooterNodePatch withId(String? value) {
    patchMap[CardFooterNode$.id] = value;
    return this;
  }

  CardFooterNodePatch withContent(List<ShadNode>? value) {
    patchMap[CardFooterNode$.content] = value;
    return this;
  }
}

/// Field descriptors for [CardFooterNode] query construction
abstract final class CardFooterNodeFields {
  static const id = Field<CardFooterNode, String?>('id', _$id);

  static const content = Field<CardFooterNode, List<ShadNode>>(
    'content',
    _$content,
  );

  static String? _$id(CardFooterNode e) {
    return e.id;
  }

  static List<ShadNode> _$content(CardFooterNode e) {
    return e.content;
  }
}

extension CardFooterNodeCompareE on CardFooterNode {
  Map<String, dynamic> compareToCardFooterNode(CardFooterNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (content != other.content) {
      diff['content'] = () => other.content;
    }
    return diff;
  }
}

class ProgressNode implements ShadNode {
  ProgressNode({
    String? this.id,
    required double this.value,
    bool? this.indeterminate,
  });

  final String? id;

  final double value;

  final bool? indeterminate;

  ProgressNode copyWith({String? id, double? value, bool? indeterminate}) {
    return ProgressNode(
      id: id ?? this.id,
      value: value ?? this.value,
      indeterminate: indeterminate ?? this.indeterminate,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  ProgressNode copyWithField<T>(Field<ProgressNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'value':
        return copyWith(value: value as double);
      case 'indeterminate':
        return copyWith(indeterminate: value as bool?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'ProgressNode has no settable field with this name',
        );
    }
  }

  ProgressNode copyWithProgressNode({
    String? id,
    double? value,
    bool? indeterminate,
  }) {
    return copyWith(id: id, value: value, indeterminate: indeterminate);
  }

  ProgressNode patchWithProgressNode([ProgressNodePatch? patchInput]) {
    final _patcher = patchInput ?? ProgressNodePatch();
    final _patchMap = _patcher.patchMap;
    return ProgressNode(
      id: _patchMap.containsKey(ProgressNode$.id)
          ? ((_patchMap[ProgressNode$.id] is Function)
                    ? _patchMap[ProgressNode$.id](this.id)
                    : (_patchMap[ProgressNode$.id] is Patch)
                    ? _patchMap[ProgressNode$.id].applyTo(this.id)
                    : _patchMap[ProgressNode$.id])
                as String?
          : this.id,
      value: _patchMap.containsKey(ProgressNode$.value)
          ? ((_patchMap[ProgressNode$.value] is Function)
                    ? _patchMap[ProgressNode$.value](this.value)
                    : (_patchMap[ProgressNode$.value] is Patch)
                    ? _patchMap[ProgressNode$.value].applyTo(this.value)
                    : _patchMap[ProgressNode$.value])
                as double
          : this.value,
      indeterminate: _patchMap.containsKey(ProgressNode$.indeterminate)
          ? ((_patchMap[ProgressNode$.indeterminate] is Function)
                    ? _patchMap[ProgressNode$.indeterminate](this.indeterminate)
                    : (_patchMap[ProgressNode$.indeterminate] is Patch)
                    ? _patchMap[ProgressNode$.indeterminate].applyTo(
                        this.indeterminate,
                      )
                    : _patchMap[ProgressNode$.indeterminate])
                as bool?
          : this.indeterminate,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProgressNode &&
        id == other.id &&
        value == other.value &&
        indeterminate == other.indeterminate;
  }

  @override
  int get hashCode {
    return Object.hash(this.id, this.value, this.indeterminate);
  }

  @override
  String toString() {
    return 'ProgressNode(' +
        'id: ${id}' +
        ', ' +
        'value: ${value}' +
        ', ' +
        'indeterminate: ${indeterminate})';
  }
}

extension ProgressNodePropertyHelpers on ProgressNode {
  bool get hasIndeterminate {
    return this.indeterminate != null;
  }

  bool get noIndeterminate {
    return this.indeterminate == null;
  }

  bool get indeterminateRequired {
    return this.indeterminate ??
        (throw StateError('indeterminate is required but was null'));
  }
}

enum ProgressNode$ { id, value, indeterminate }

class ProgressNodePatch extends PatchBase<ProgressNode, ProgressNode$> {
  ProgressNode applyTo(ProgressNode entity) {
    return entity.patchWithProgressNode(this);
  }

  ProgressNodePatch withId(String? value) {
    patchMap[ProgressNode$.id] = value;
    return this;
  }

  ProgressNodePatch withValue(double? value) {
    patchMap[ProgressNode$.value] = value;
    return this;
  }

  ProgressNodePatch withIndeterminate(bool? value) {
    patchMap[ProgressNode$.indeterminate] = value;
    return this;
  }
}

/// Field descriptors for [ProgressNode] query construction
abstract final class ProgressNodeFields {
  static const id = Field<ProgressNode, String?>('id', _$id);

  static const value = Field<ProgressNode, double>('value', _$value);

  static const indeterminate = Field<ProgressNode, bool?>(
    'indeterminate',
    _$indeterminate,
  );

  static String? _$id(ProgressNode e) {
    return e.id;
  }

  static double _$value(ProgressNode e) {
    return e.value;
  }

  static bool? _$indeterminate(ProgressNode e) {
    return e.indeterminate;
  }
}

extension ProgressNodeCompareE on ProgressNode {
  Map<String, dynamic> compareToProgressNode(ProgressNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (value != other.value) {
      diff['value'] = () => other.value;
    }

    if (indeterminate != other.indeterminate) {
      diff['indeterminate'] = () => other.indeterminate;
    }
    return diff;
  }
}

class SeparatorNode implements ShadNode {
  SeparatorNode({String? this.id, String? this.orientation});

  final String? id;

  final String? orientation;

  SeparatorNode copyWith({String? id, String? orientation}) {
    return SeparatorNode(
      id: id ?? this.id,
      orientation: orientation ?? this.orientation,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  SeparatorNode copyWithField<T>(Field<SeparatorNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'orientation':
        return copyWith(orientation: value as String?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'SeparatorNode has no settable field with this name',
        );
    }
  }

  SeparatorNode copyWithSeparatorNode({String? id, String? orientation}) {
    return copyWith(id: id, orientation: orientation);
  }

  SeparatorNode patchWithSeparatorNode([SeparatorNodePatch? patchInput]) {
    final _patcher = patchInput ?? SeparatorNodePatch();
    final _patchMap = _patcher.patchMap;
    return SeparatorNode(
      id: _patchMap.containsKey(SeparatorNode$.id)
          ? ((_patchMap[SeparatorNode$.id] is Function)
                    ? _patchMap[SeparatorNode$.id](this.id)
                    : (_patchMap[SeparatorNode$.id] is Patch)
                    ? _patchMap[SeparatorNode$.id].applyTo(this.id)
                    : _patchMap[SeparatorNode$.id])
                as String?
          : this.id,
      orientation: _patchMap.containsKey(SeparatorNode$.orientation)
          ? ((_patchMap[SeparatorNode$.orientation] is Function)
                    ? _patchMap[SeparatorNode$.orientation](this.orientation)
                    : (_patchMap[SeparatorNode$.orientation] is Patch)
                    ? _patchMap[SeparatorNode$.orientation].applyTo(
                        this.orientation,
                      )
                    : _patchMap[SeparatorNode$.orientation])
                as String?
          : this.orientation,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SeparatorNode &&
        id == other.id &&
        orientation == other.orientation;
  }

  @override
  int get hashCode {
    return Object.hash(this.id, this.orientation);
  }

  @override
  String toString() {
    return 'SeparatorNode(' +
        'id: ${id}' +
        ', ' +
        'orientation: ${orientation})';
  }
}

extension SeparatorNodePropertyHelpers on SeparatorNode {
  bool get hasOrientation {
    return this.orientation?.isNotEmpty == true;
  }

  bool get noOrientation {
    return this.orientation?.isEmpty ?? true;
  }

  String get orientationRequired {
    return this.orientation ??
        (throw StateError('orientation is required but was null'));
  }
}

enum SeparatorNode$ { id, orientation }

class SeparatorNodePatch extends PatchBase<SeparatorNode, SeparatorNode$> {
  SeparatorNode applyTo(SeparatorNode entity) {
    return entity.patchWithSeparatorNode(this);
  }

  SeparatorNodePatch withId(String? value) {
    patchMap[SeparatorNode$.id] = value;
    return this;
  }

  SeparatorNodePatch withOrientation(String? value) {
    patchMap[SeparatorNode$.orientation] = value;
    return this;
  }
}

/// Field descriptors for [SeparatorNode] query construction
abstract final class SeparatorNodeFields {
  static const id = Field<SeparatorNode, String?>('id', _$id);

  static const orientation = Field<SeparatorNode, String?>(
    'orientation',
    _$orientation,
  );

  static String? _$id(SeparatorNode e) {
    return e.id;
  }

  static String? _$orientation(SeparatorNode e) {
    return e.orientation;
  }
}

extension SeparatorNodeCompareE on SeparatorNode {
  Map<String, dynamic> compareToSeparatorNode(SeparatorNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (orientation != other.orientation) {
      diff['orientation'] = () => other.orientation;
    }
    return diff;
  }
}

class InputNode implements ShadNode {
  InputNode({
    String? this.id,
    String? this.value,
    String? this.placeholder,
    String? this.label,
    String? this.helper,
    String? this.errorText,
    bool? this.enabled,
    bool? this.obscure,
    String? this.keyboard,
    ActionId? this.action,
  });

  final String? id;

  final String? value;

  final String? placeholder;

  final String? label;

  final String? helper;

  final String? errorText;

  final bool? enabled;

  final bool? obscure;

  final String? keyboard;

  final ActionId? action;

  InputNode copyWith({
    String? id,
    String? value,
    String? placeholder,
    String? label,
    String? helper,
    String? errorText,
    bool? enabled,
    bool? obscure,
    String? keyboard,
    ActionId? action,
  }) {
    return InputNode(
      id: id ?? this.id,
      value: value ?? this.value,
      placeholder: placeholder ?? this.placeholder,
      label: label ?? this.label,
      helper: helper ?? this.helper,
      errorText: errorText ?? this.errorText,
      enabled: enabled ?? this.enabled,
      obscure: obscure ?? this.obscure,
      keyboard: keyboard ?? this.keyboard,
      action: action ?? this.action,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  InputNode copyWithField<T>(Field<InputNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'value':
        return copyWith(value: value as String?);
      case 'placeholder':
        return copyWith(placeholder: value as String?);
      case 'label':
        return copyWith(label: value as String?);
      case 'helper':
        return copyWith(helper: value as String?);
      case 'errorText':
        return copyWith(errorText: value as String?);
      case 'enabled':
        return copyWith(enabled: value as bool?);
      case 'obscure':
        return copyWith(obscure: value as bool?);
      case 'keyboard':
        return copyWith(keyboard: value as String?);
      case 'action':
        return copyWith(action: value as ActionId?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'InputNode has no settable field with this name',
        );
    }
  }

  InputNode copyWithInputNode({
    String? id,
    String? value,
    String? placeholder,
    String? label,
    String? helper,
    String? errorText,
    bool? enabled,
    bool? obscure,
    String? keyboard,
    ActionId? action,
  }) {
    return copyWith(
      id: id,
      value: value,
      placeholder: placeholder,
      label: label,
      helper: helper,
      errorText: errorText,
      enabled: enabled,
      obscure: obscure,
      keyboard: keyboard,
      action: action,
    );
  }

  InputNode patchWithInputNode([InputNodePatch? patchInput]) {
    final _patcher = patchInput ?? InputNodePatch();
    final _patchMap = _patcher.patchMap;
    return InputNode(
      id: _patchMap.containsKey(InputNode$.id)
          ? ((_patchMap[InputNode$.id] is Function)
                    ? _patchMap[InputNode$.id](this.id)
                    : (_patchMap[InputNode$.id] is Patch)
                    ? _patchMap[InputNode$.id].applyTo(this.id)
                    : _patchMap[InputNode$.id])
                as String?
          : this.id,
      value: _patchMap.containsKey(InputNode$.value)
          ? ((_patchMap[InputNode$.value] is Function)
                    ? _patchMap[InputNode$.value](this.value)
                    : (_patchMap[InputNode$.value] is Patch)
                    ? _patchMap[InputNode$.value].applyTo(this.value)
                    : _patchMap[InputNode$.value])
                as String?
          : this.value,
      placeholder: _patchMap.containsKey(InputNode$.placeholder)
          ? ((_patchMap[InputNode$.placeholder] is Function)
                    ? _patchMap[InputNode$.placeholder](this.placeholder)
                    : (_patchMap[InputNode$.placeholder] is Patch)
                    ? _patchMap[InputNode$.placeholder].applyTo(
                        this.placeholder,
                      )
                    : _patchMap[InputNode$.placeholder])
                as String?
          : this.placeholder,
      label: _patchMap.containsKey(InputNode$.label)
          ? ((_patchMap[InputNode$.label] is Function)
                    ? _patchMap[InputNode$.label](this.label)
                    : (_patchMap[InputNode$.label] is Patch)
                    ? _patchMap[InputNode$.label].applyTo(this.label)
                    : _patchMap[InputNode$.label])
                as String?
          : this.label,
      helper: _patchMap.containsKey(InputNode$.helper)
          ? ((_patchMap[InputNode$.helper] is Function)
                    ? _patchMap[InputNode$.helper](this.helper)
                    : (_patchMap[InputNode$.helper] is Patch)
                    ? _patchMap[InputNode$.helper].applyTo(this.helper)
                    : _patchMap[InputNode$.helper])
                as String?
          : this.helper,
      errorText: _patchMap.containsKey(InputNode$.errorText)
          ? ((_patchMap[InputNode$.errorText] is Function)
                    ? _patchMap[InputNode$.errorText](this.errorText)
                    : (_patchMap[InputNode$.errorText] is Patch)
                    ? _patchMap[InputNode$.errorText].applyTo(this.errorText)
                    : _patchMap[InputNode$.errorText])
                as String?
          : this.errorText,
      enabled: _patchMap.containsKey(InputNode$.enabled)
          ? ((_patchMap[InputNode$.enabled] is Function)
                    ? _patchMap[InputNode$.enabled](this.enabled)
                    : (_patchMap[InputNode$.enabled] is Patch)
                    ? _patchMap[InputNode$.enabled].applyTo(this.enabled)
                    : _patchMap[InputNode$.enabled])
                as bool?
          : this.enabled,
      obscure: _patchMap.containsKey(InputNode$.obscure)
          ? ((_patchMap[InputNode$.obscure] is Function)
                    ? _patchMap[InputNode$.obscure](this.obscure)
                    : (_patchMap[InputNode$.obscure] is Patch)
                    ? _patchMap[InputNode$.obscure].applyTo(this.obscure)
                    : _patchMap[InputNode$.obscure])
                as bool?
          : this.obscure,
      keyboard: _patchMap.containsKey(InputNode$.keyboard)
          ? ((_patchMap[InputNode$.keyboard] is Function)
                    ? _patchMap[InputNode$.keyboard](this.keyboard)
                    : (_patchMap[InputNode$.keyboard] is Patch)
                    ? _patchMap[InputNode$.keyboard].applyTo(this.keyboard)
                    : _patchMap[InputNode$.keyboard])
                as String?
          : this.keyboard,
      action: _patchMap.containsKey(InputNode$.action)
          ? ((_patchMap[InputNode$.action] is Function)
                    ? _patchMap[InputNode$.action](this.action)
                    : (_patchMap[InputNode$.action] is Patch)
                    ? _patchMap[InputNode$.action].applyTo(this.action)
                    : _patchMap[InputNode$.action])
                as ActionId?
          : this.action,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InputNode &&
        id == other.id &&
        value == other.value &&
        placeholder == other.placeholder &&
        label == other.label &&
        helper == other.helper &&
        errorText == other.errorText &&
        enabled == other.enabled &&
        obscure == other.obscure &&
        keyboard == other.keyboard &&
        action == other.action;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.value,
      this.placeholder,
      this.label,
      this.helper,
      this.errorText,
      this.enabled,
      this.obscure,
      this.keyboard,
      this.action,
    );
  }

  @override
  String toString() {
    return 'InputNode(' +
        'id: ${id}' +
        ', ' +
        'value: ${value}' +
        ', ' +
        'placeholder: ${placeholder}' +
        ', ' +
        'label: ${label}' +
        ', ' +
        'helper: ${helper}' +
        ', ' +
        'errorText: ${errorText}' +
        ', ' +
        'enabled: ${enabled}' +
        ', ' +
        'obscure: ${obscure}' +
        ', ' +
        'keyboard: ${keyboard}' +
        ', ' +
        'action: ${action})';
  }
}

extension InputNodePropertyHelpers on InputNode {
  bool get hasValue {
    return this.value?.isNotEmpty == true;
  }

  bool get noValue {
    return this.value?.isEmpty ?? true;
  }

  String get valueRequired {
    return this.value ?? (throw StateError('value is required but was null'));
  }

  bool get hasPlaceholder {
    return this.placeholder?.isNotEmpty == true;
  }

  bool get noPlaceholder {
    return this.placeholder?.isEmpty ?? true;
  }

  String get placeholderRequired {
    return this.placeholder ??
        (throw StateError('placeholder is required but was null'));
  }

  bool get hasLabel {
    return this.label?.isNotEmpty == true;
  }

  bool get noLabel {
    return this.label?.isEmpty ?? true;
  }

  String get labelRequired {
    return this.label ?? (throw StateError('label is required but was null'));
  }

  bool get hasHelper {
    return this.helper?.isNotEmpty == true;
  }

  bool get noHelper {
    return this.helper?.isEmpty ?? true;
  }

  String get helperRequired {
    return this.helper ?? (throw StateError('helper is required but was null'));
  }

  bool get hasErrorText {
    return this.errorText?.isNotEmpty == true;
  }

  bool get noErrorText {
    return this.errorText?.isEmpty ?? true;
  }

  String get errorTextRequired {
    return this.errorText ??
        (throw StateError('errorText is required but was null'));
  }

  bool get hasEnabled {
    return this.enabled != null;
  }

  bool get noEnabled {
    return this.enabled == null;
  }

  bool get enabledRequired {
    return this.enabled ??
        (throw StateError('enabled is required but was null'));
  }

  bool get hasObscure {
    return this.obscure != null;
  }

  bool get noObscure {
    return this.obscure == null;
  }

  bool get obscureRequired {
    return this.obscure ??
        (throw StateError('obscure is required but was null'));
  }

  bool get hasKeyboard {
    return this.keyboard?.isNotEmpty == true;
  }

  bool get noKeyboard {
    return this.keyboard?.isEmpty ?? true;
  }

  String get keyboardRequired {
    return this.keyboard ??
        (throw StateError('keyboard is required but was null'));
  }

  bool get hasAction {
    return this.action != null;
  }

  bool get noAction {
    return this.action == null;
  }

  ActionId get actionRequired {
    return this.action ?? (throw StateError('action is required but was null'));
  }
}

enum InputNode$ {
  id,
  value,
  placeholder,
  label,
  helper,
  errorText,
  enabled,
  obscure,
  keyboard,
  action,
}

class InputNodePatch extends PatchBase<InputNode, InputNode$> {
  InputNode applyTo(InputNode entity) {
    return entity.patchWithInputNode(this);
  }

  InputNodePatch withId(String? value) {
    patchMap[InputNode$.id] = value;
    return this;
  }

  InputNodePatch withValue(String? value) {
    patchMap[InputNode$.value] = value;
    return this;
  }

  InputNodePatch withPlaceholder(String? value) {
    patchMap[InputNode$.placeholder] = value;
    return this;
  }

  InputNodePatch withLabel(String? value) {
    patchMap[InputNode$.label] = value;
    return this;
  }

  InputNodePatch withHelper(String? value) {
    patchMap[InputNode$.helper] = value;
    return this;
  }

  InputNodePatch withErrorText(String? value) {
    patchMap[InputNode$.errorText] = value;
    return this;
  }

  InputNodePatch withEnabled(bool? value) {
    patchMap[InputNode$.enabled] = value;
    return this;
  }

  InputNodePatch withObscure(bool? value) {
    patchMap[InputNode$.obscure] = value;
    return this;
  }

  InputNodePatch withKeyboard(String? value) {
    patchMap[InputNode$.keyboard] = value;
    return this;
  }

  InputNodePatch withAction(ActionId? value) {
    patchMap[InputNode$.action] = value;
    return this;
  }
}

/// Field descriptors for [InputNode] query construction
abstract final class InputNodeFields {
  static const id = Field<InputNode, String?>('id', _$id);

  static const value = Field<InputNode, String?>('value', _$value);

  static const placeholder = Field<InputNode, String?>(
    'placeholder',
    _$placeholder,
  );

  static const label = Field<InputNode, String?>('label', _$label);

  static const helper = Field<InputNode, String?>('helper', _$helper);

  static const errorText = Field<InputNode, String?>('errorText', _$errorText);

  static const enabled = Field<InputNode, bool?>('enabled', _$enabled);

  static const obscure = Field<InputNode, bool?>('obscure', _$obscure);

  static const keyboard = Field<InputNode, String?>('keyboard', _$keyboard);

  static const action = Field<InputNode, ActionId?>('action', _$action);

  static String? _$id(InputNode e) {
    return e.id;
  }

  static String? _$value(InputNode e) {
    return e.value;
  }

  static String? _$placeholder(InputNode e) {
    return e.placeholder;
  }

  static String? _$label(InputNode e) {
    return e.label;
  }

  static String? _$helper(InputNode e) {
    return e.helper;
  }

  static String? _$errorText(InputNode e) {
    return e.errorText;
  }

  static bool? _$enabled(InputNode e) {
    return e.enabled;
  }

  static bool? _$obscure(InputNode e) {
    return e.obscure;
  }

  static String? _$keyboard(InputNode e) {
    return e.keyboard;
  }

  static ActionId? _$action(InputNode e) {
    return e.action;
  }
}

extension InputNodeCompareE on InputNode {
  Map<String, dynamic> compareToInputNode(InputNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (value != other.value) {
      diff['value'] = () => other.value;
    }

    if (placeholder != other.placeholder) {
      diff['placeholder'] = () => other.placeholder;
    }

    if (label != other.label) {
      diff['label'] = () => other.label;
    }

    if (helper != other.helper) {
      diff['helper'] = () => other.helper;
    }

    if (errorText != other.errorText) {
      diff['errorText'] = () => other.errorText;
    }

    if (enabled != other.enabled) {
      diff['enabled'] = () => other.enabled;
    }

    if (obscure != other.obscure) {
      diff['obscure'] = () => other.obscure;
    }

    if (keyboard != other.keyboard) {
      diff['keyboard'] = () => other.keyboard;
    }

    if (action != other.action) {
      diff['action'] = () => other.action;
    }
    return diff;
  }
}

class SelectNode implements ShadNode {
  SelectNode({
    String? this.id,
    required List<SelectOptionNode> this.options,
    String? this.value,
    String? this.placeholder,
    String? this.label,
    bool? this.enabled,
  });

  final String? id;

  final List<SelectOptionNode> options;

  final String? value;

  final String? placeholder;

  final String? label;

  final bool? enabled;

  SelectNode copyWith({
    String? id,
    List<SelectOptionNode>? options,
    String? value,
    String? placeholder,
    String? label,
    bool? enabled,
  }) {
    return SelectNode(
      id: id ?? this.id,
      options: options ?? this.options,
      value: value ?? this.value,
      placeholder: placeholder ?? this.placeholder,
      label: label ?? this.label,
      enabled: enabled ?? this.enabled,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  SelectNode copyWithField<T>(Field<SelectNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'options':
        return copyWith(options: value as List<SelectOptionNode>);
      case 'value':
        return copyWith(value: value as String?);
      case 'placeholder':
        return copyWith(placeholder: value as String?);
      case 'label':
        return copyWith(label: value as String?);
      case 'enabled':
        return copyWith(enabled: value as bool?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'SelectNode has no settable field with this name',
        );
    }
  }

  SelectNode copyWithSelectNode({
    String? id,
    List<SelectOptionNode>? options,
    String? value,
    String? placeholder,
    String? label,
    bool? enabled,
  }) {
    return copyWith(
      id: id,
      options: options,
      value: value,
      placeholder: placeholder,
      label: label,
      enabled: enabled,
    );
  }

  SelectNode patchWithSelectNode([SelectNodePatch? patchInput]) {
    final _patcher = patchInput ?? SelectNodePatch();
    final _patchMap = _patcher.patchMap;
    return SelectNode(
      id: _patchMap.containsKey(SelectNode$.id)
          ? ((_patchMap[SelectNode$.id] is Function)
                    ? _patchMap[SelectNode$.id](this.id)
                    : (_patchMap[SelectNode$.id] is Patch)
                    ? _patchMap[SelectNode$.id].applyTo(this.id)
                    : _patchMap[SelectNode$.id])
                as String?
          : this.id,
      options: _patchMap.containsKey(SelectNode$.options)
          ? ((_patchMap[SelectNode$.options] is Function)
                    ? _patchMap[SelectNode$.options](this.options)
                    : (_patchMap[SelectNode$.options] is Patch)
                    ? _patchMap[SelectNode$.options].applyTo(this.options)
                    : _patchMap[SelectNode$.options])
                as List<SelectOptionNode>
          : this.options,
      value: _patchMap.containsKey(SelectNode$.value)
          ? ((_patchMap[SelectNode$.value] is Function)
                    ? _patchMap[SelectNode$.value](this.value)
                    : (_patchMap[SelectNode$.value] is Patch)
                    ? _patchMap[SelectNode$.value].applyTo(this.value)
                    : _patchMap[SelectNode$.value])
                as String?
          : this.value,
      placeholder: _patchMap.containsKey(SelectNode$.placeholder)
          ? ((_patchMap[SelectNode$.placeholder] is Function)
                    ? _patchMap[SelectNode$.placeholder](this.placeholder)
                    : (_patchMap[SelectNode$.placeholder] is Patch)
                    ? _patchMap[SelectNode$.placeholder].applyTo(
                        this.placeholder,
                      )
                    : _patchMap[SelectNode$.placeholder])
                as String?
          : this.placeholder,
      label: _patchMap.containsKey(SelectNode$.label)
          ? ((_patchMap[SelectNode$.label] is Function)
                    ? _patchMap[SelectNode$.label](this.label)
                    : (_patchMap[SelectNode$.label] is Patch)
                    ? _patchMap[SelectNode$.label].applyTo(this.label)
                    : _patchMap[SelectNode$.label])
                as String?
          : this.label,
      enabled: _patchMap.containsKey(SelectNode$.enabled)
          ? ((_patchMap[SelectNode$.enabled] is Function)
                    ? _patchMap[SelectNode$.enabled](this.enabled)
                    : (_patchMap[SelectNode$.enabled] is Patch)
                    ? _patchMap[SelectNode$.enabled].applyTo(this.enabled)
                    : _patchMap[SelectNode$.enabled])
                as bool?
          : this.enabled,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SelectNode &&
        id == other.id &&
        options == other.options &&
        value == other.value &&
        placeholder == other.placeholder &&
        label == other.label &&
        enabled == other.enabled;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.options,
      this.value,
      this.placeholder,
      this.label,
      this.enabled,
    );
  }

  @override
  String toString() {
    return 'SelectNode(' +
        'id: ${id}' +
        ', ' +
        'options: ${options}' +
        ', ' +
        'value: ${value}' +
        ', ' +
        'placeholder: ${placeholder}' +
        ', ' +
        'label: ${label}' +
        ', ' +
        'enabled: ${enabled})';
  }
}

extension SelectNodePropertyHelpers on SelectNode {
  bool get hasOptions {
    return this.options.isNotEmpty;
  }

  bool get noOptions {
    return this.options.isEmpty;
  }

  bool get hasValue {
    return this.value?.isNotEmpty == true;
  }

  bool get noValue {
    return this.value?.isEmpty ?? true;
  }

  String get valueRequired {
    return this.value ?? (throw StateError('value is required but was null'));
  }

  bool get hasPlaceholder {
    return this.placeholder?.isNotEmpty == true;
  }

  bool get noPlaceholder {
    return this.placeholder?.isEmpty ?? true;
  }

  String get placeholderRequired {
    return this.placeholder ??
        (throw StateError('placeholder is required but was null'));
  }

  bool get hasLabel {
    return this.label?.isNotEmpty == true;
  }

  bool get noLabel {
    return this.label?.isEmpty ?? true;
  }

  String get labelRequired {
    return this.label ?? (throw StateError('label is required but was null'));
  }

  bool get hasEnabled {
    return this.enabled != null;
  }

  bool get noEnabled {
    return this.enabled == null;
  }

  bool get enabledRequired {
    return this.enabled ??
        (throw StateError('enabled is required but was null'));
  }
}

enum SelectNode$ { id, options, value, placeholder, label, enabled }

class SelectNodePatch extends PatchBase<SelectNode, SelectNode$> {
  SelectNode applyTo(SelectNode entity) {
    return entity.patchWithSelectNode(this);
  }

  SelectNodePatch withId(String? value) {
    patchMap[SelectNode$.id] = value;
    return this;
  }

  SelectNodePatch withOptions(List<SelectOptionNode>? value) {
    patchMap[SelectNode$.options] = value;
    return this;
  }

  SelectNodePatch updateOptionsAt(
    int index,
    SelectOptionNodePatch Function(SelectOptionNodePatch) patch,
  ) {
    patchMap[SelectNode$.options] = (List<dynamic> list) {
      var updatedList = List<SelectOptionNode>.from(list);
      if (index >= 0 && index < updatedList.length) {
        updatedList[index] = patch(
          SelectOptionNodePatch(),
        ).applyTo(updatedList[index] as SelectOptionNode);
      }
      return updatedList;
    };
    return this;
  }

  SelectNodePatch withValue(String? value) {
    patchMap[SelectNode$.value] = value;
    return this;
  }

  SelectNodePatch withPlaceholder(String? value) {
    patchMap[SelectNode$.placeholder] = value;
    return this;
  }

  SelectNodePatch withLabel(String? value) {
    patchMap[SelectNode$.label] = value;
    return this;
  }

  SelectNodePatch withEnabled(bool? value) {
    patchMap[SelectNode$.enabled] = value;
    return this;
  }
}

/// Field descriptors for [SelectNode] query construction
abstract final class SelectNodeFields {
  static const id = Field<SelectNode, String?>('id', _$id);

  static const options = Field<SelectNode, List<SelectOptionNode>>(
    'options',
    _$options,
  );

  static const value = Field<SelectNode, String?>('value', _$value);

  static const placeholder = Field<SelectNode, String?>(
    'placeholder',
    _$placeholder,
  );

  static const label = Field<SelectNode, String?>('label', _$label);

  static const enabled = Field<SelectNode, bool?>('enabled', _$enabled);

  static String? _$id(SelectNode e) {
    return e.id;
  }

  static List<SelectOptionNode> _$options(SelectNode e) {
    return e.options;
  }

  static String? _$value(SelectNode e) {
    return e.value;
  }

  static String? _$placeholder(SelectNode e) {
    return e.placeholder;
  }

  static String? _$label(SelectNode e) {
    return e.label;
  }

  static bool? _$enabled(SelectNode e) {
    return e.enabled;
  }
}

extension SelectNodeCompareE on SelectNode {
  Map<String, dynamic> compareToSelectNode(SelectNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (options != other.options) {
      diff['options'] = () => other.options;
    }

    if (value != other.value) {
      diff['value'] = () => other.value;
    }

    if (placeholder != other.placeholder) {
      diff['placeholder'] = () => other.placeholder;
    }

    if (label != other.label) {
      diff['label'] = () => other.label;
    }

    if (enabled != other.enabled) {
      diff['enabled'] = () => other.enabled;
    }
    return diff;
  }
}

class SelectOptionNode implements ShadNode {
  SelectOptionNode({
    String? this.id,
    required String this.value,
    required String this.label,
    bool? this.enabled,
  });

  final String? id;

  final String value;

  final String label;

  final bool? enabled;

  SelectOptionNode copyWith({
    String? id,
    String? value,
    String? label,
    bool? enabled,
  }) {
    return SelectOptionNode(
      id: id ?? this.id,
      value: value ?? this.value,
      label: label ?? this.label,
      enabled: enabled ?? this.enabled,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  SelectOptionNode copyWithField<T>(Field<SelectOptionNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'value':
        return copyWith(value: value as String);
      case 'label':
        return copyWith(label: value as String);
      case 'enabled':
        return copyWith(enabled: value as bool?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'SelectOptionNode has no settable field with this name',
        );
    }
  }

  SelectOptionNode copyWithSelectOptionNode({
    String? id,
    String? value,
    String? label,
    bool? enabled,
  }) {
    return copyWith(id: id, value: value, label: label, enabled: enabled);
  }

  SelectOptionNode patchWithSelectOptionNode([
    SelectOptionNodePatch? patchInput,
  ]) {
    final _patcher = patchInput ?? SelectOptionNodePatch();
    final _patchMap = _patcher.patchMap;
    return SelectOptionNode(
      id: _patchMap.containsKey(SelectOptionNode$.id)
          ? ((_patchMap[SelectOptionNode$.id] is Function)
                    ? _patchMap[SelectOptionNode$.id](this.id)
                    : (_patchMap[SelectOptionNode$.id] is Patch)
                    ? _patchMap[SelectOptionNode$.id].applyTo(this.id)
                    : _patchMap[SelectOptionNode$.id])
                as String?
          : this.id,
      value: _patchMap.containsKey(SelectOptionNode$.value)
          ? ((_patchMap[SelectOptionNode$.value] is Function)
                    ? _patchMap[SelectOptionNode$.value](this.value)
                    : (_patchMap[SelectOptionNode$.value] is Patch)
                    ? _patchMap[SelectOptionNode$.value].applyTo(this.value)
                    : _patchMap[SelectOptionNode$.value])
                as String
          : this.value,
      label: _patchMap.containsKey(SelectOptionNode$.label)
          ? ((_patchMap[SelectOptionNode$.label] is Function)
                    ? _patchMap[SelectOptionNode$.label](this.label)
                    : (_patchMap[SelectOptionNode$.label] is Patch)
                    ? _patchMap[SelectOptionNode$.label].applyTo(this.label)
                    : _patchMap[SelectOptionNode$.label])
                as String
          : this.label,
      enabled: _patchMap.containsKey(SelectOptionNode$.enabled)
          ? ((_patchMap[SelectOptionNode$.enabled] is Function)
                    ? _patchMap[SelectOptionNode$.enabled](this.enabled)
                    : (_patchMap[SelectOptionNode$.enabled] is Patch)
                    ? _patchMap[SelectOptionNode$.enabled].applyTo(this.enabled)
                    : _patchMap[SelectOptionNode$.enabled])
                as bool?
          : this.enabled,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SelectOptionNode &&
        id == other.id &&
        value == other.value &&
        label == other.label &&
        enabled == other.enabled;
  }

  @override
  int get hashCode {
    return Object.hash(this.id, this.value, this.label, this.enabled);
  }

  @override
  String toString() {
    return 'SelectOptionNode(' +
        'id: ${id}' +
        ', ' +
        'value: ${value}' +
        ', ' +
        'label: ${label}' +
        ', ' +
        'enabled: ${enabled})';
  }
}

extension SelectOptionNodePropertyHelpers on SelectOptionNode {
  bool get hasValue {
    return this.value.isNotEmpty;
  }

  bool get noValue {
    return this.value.isEmpty;
  }

  bool get hasLabel {
    return this.label.isNotEmpty;
  }

  bool get noLabel {
    return this.label.isEmpty;
  }

  bool get hasEnabled {
    return this.enabled != null;
  }

  bool get noEnabled {
    return this.enabled == null;
  }

  bool get enabledRequired {
    return this.enabled ??
        (throw StateError('enabled is required but was null'));
  }
}

enum SelectOptionNode$ { id, value, label, enabled }

class SelectOptionNodePatch
    extends PatchBase<SelectOptionNode, SelectOptionNode$> {
  SelectOptionNode applyTo(SelectOptionNode entity) {
    return entity.patchWithSelectOptionNode(this);
  }

  SelectOptionNodePatch withId(String? value) {
    patchMap[SelectOptionNode$.id] = value;
    return this;
  }

  SelectOptionNodePatch withValue(String? value) {
    patchMap[SelectOptionNode$.value] = value;
    return this;
  }

  SelectOptionNodePatch withLabel(String? value) {
    patchMap[SelectOptionNode$.label] = value;
    return this;
  }

  SelectOptionNodePatch withEnabled(bool? value) {
    patchMap[SelectOptionNode$.enabled] = value;
    return this;
  }
}

/// Field descriptors for [SelectOptionNode] query construction
abstract final class SelectOptionNodeFields {
  static const id = Field<SelectOptionNode, String?>('id', _$id);

  static const value = Field<SelectOptionNode, String>('value', _$value);

  static const label = Field<SelectOptionNode, String>('label', _$label);

  static const enabled = Field<SelectOptionNode, bool?>('enabled', _$enabled);

  static String? _$id(SelectOptionNode e) {
    return e.id;
  }

  static String _$value(SelectOptionNode e) {
    return e.value;
  }

  static String _$label(SelectOptionNode e) {
    return e.label;
  }

  static bool? _$enabled(SelectOptionNode e) {
    return e.enabled;
  }
}

extension SelectOptionNodeCompareE on SelectOptionNode {
  Map<String, dynamic> compareToSelectOptionNode(SelectOptionNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (value != other.value) {
      diff['value'] = () => other.value;
    }

    if (label != other.label) {
      diff['label'] = () => other.label;
    }

    if (enabled != other.enabled) {
      diff['enabled'] = () => other.enabled;
    }
    return diff;
  }
}

class CheckboxNode implements ShadNode {
  CheckboxNode({
    String? this.id,
    bool? this.value,
    String? this.label,
    bool? this.enabled,
    ActionId? this.action,
  });

  final String? id;

  final bool? value;

  final String? label;

  final bool? enabled;

  final ActionId? action;

  CheckboxNode copyWith({
    String? id,
    bool? value,
    String? label,
    bool? enabled,
    ActionId? action,
  }) {
    return CheckboxNode(
      id: id ?? this.id,
      value: value ?? this.value,
      label: label ?? this.label,
      enabled: enabled ?? this.enabled,
      action: action ?? this.action,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  CheckboxNode copyWithField<T>(Field<CheckboxNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'value':
        return copyWith(value: value as bool?);
      case 'label':
        return copyWith(label: value as String?);
      case 'enabled':
        return copyWith(enabled: value as bool?);
      case 'action':
        return copyWith(action: value as ActionId?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'CheckboxNode has no settable field with this name',
        );
    }
  }

  CheckboxNode copyWithCheckboxNode({
    String? id,
    bool? value,
    String? label,
    bool? enabled,
    ActionId? action,
  }) {
    return copyWith(
      id: id,
      value: value,
      label: label,
      enabled: enabled,
      action: action,
    );
  }

  CheckboxNode patchWithCheckboxNode([CheckboxNodePatch? patchInput]) {
    final _patcher = patchInput ?? CheckboxNodePatch();
    final _patchMap = _patcher.patchMap;
    return CheckboxNode(
      id: _patchMap.containsKey(CheckboxNode$.id)
          ? ((_patchMap[CheckboxNode$.id] is Function)
                    ? _patchMap[CheckboxNode$.id](this.id)
                    : (_patchMap[CheckboxNode$.id] is Patch)
                    ? _patchMap[CheckboxNode$.id].applyTo(this.id)
                    : _patchMap[CheckboxNode$.id])
                as String?
          : this.id,
      value: _patchMap.containsKey(CheckboxNode$.value)
          ? ((_patchMap[CheckboxNode$.value] is Function)
                    ? _patchMap[CheckboxNode$.value](this.value)
                    : (_patchMap[CheckboxNode$.value] is Patch)
                    ? _patchMap[CheckboxNode$.value].applyTo(this.value)
                    : _patchMap[CheckboxNode$.value])
                as bool?
          : this.value,
      label: _patchMap.containsKey(CheckboxNode$.label)
          ? ((_patchMap[CheckboxNode$.label] is Function)
                    ? _patchMap[CheckboxNode$.label](this.label)
                    : (_patchMap[CheckboxNode$.label] is Patch)
                    ? _patchMap[CheckboxNode$.label].applyTo(this.label)
                    : _patchMap[CheckboxNode$.label])
                as String?
          : this.label,
      enabled: _patchMap.containsKey(CheckboxNode$.enabled)
          ? ((_patchMap[CheckboxNode$.enabled] is Function)
                    ? _patchMap[CheckboxNode$.enabled](this.enabled)
                    : (_patchMap[CheckboxNode$.enabled] is Patch)
                    ? _patchMap[CheckboxNode$.enabled].applyTo(this.enabled)
                    : _patchMap[CheckboxNode$.enabled])
                as bool?
          : this.enabled,
      action: _patchMap.containsKey(CheckboxNode$.action)
          ? ((_patchMap[CheckboxNode$.action] is Function)
                    ? _patchMap[CheckboxNode$.action](this.action)
                    : (_patchMap[CheckboxNode$.action] is Patch)
                    ? _patchMap[CheckboxNode$.action].applyTo(this.action)
                    : _patchMap[CheckboxNode$.action])
                as ActionId?
          : this.action,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CheckboxNode &&
        id == other.id &&
        value == other.value &&
        label == other.label &&
        enabled == other.enabled &&
        action == other.action;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.value,
      this.label,
      this.enabled,
      this.action,
    );
  }

  @override
  String toString() {
    return 'CheckboxNode(' +
        'id: ${id}' +
        ', ' +
        'value: ${value}' +
        ', ' +
        'label: ${label}' +
        ', ' +
        'enabled: ${enabled}' +
        ', ' +
        'action: ${action})';
  }
}

extension CheckboxNodePropertyHelpers on CheckboxNode {
  bool get hasValue {
    return this.value != null;
  }

  bool get noValue {
    return this.value == null;
  }

  bool get valueRequired {
    return this.value ?? (throw StateError('value is required but was null'));
  }

  bool get hasLabel {
    return this.label?.isNotEmpty == true;
  }

  bool get noLabel {
    return this.label?.isEmpty ?? true;
  }

  String get labelRequired {
    return this.label ?? (throw StateError('label is required but was null'));
  }

  bool get hasEnabled {
    return this.enabled != null;
  }

  bool get noEnabled {
    return this.enabled == null;
  }

  bool get enabledRequired {
    return this.enabled ??
        (throw StateError('enabled is required but was null'));
  }

  bool get hasAction {
    return this.action != null;
  }

  bool get noAction {
    return this.action == null;
  }

  ActionId get actionRequired {
    return this.action ?? (throw StateError('action is required but was null'));
  }
}

enum CheckboxNode$ { id, value, label, enabled, action }

class CheckboxNodePatch extends PatchBase<CheckboxNode, CheckboxNode$> {
  CheckboxNode applyTo(CheckboxNode entity) {
    return entity.patchWithCheckboxNode(this);
  }

  CheckboxNodePatch withId(String? value) {
    patchMap[CheckboxNode$.id] = value;
    return this;
  }

  CheckboxNodePatch withValue(bool? value) {
    patchMap[CheckboxNode$.value] = value;
    return this;
  }

  CheckboxNodePatch withLabel(String? value) {
    patchMap[CheckboxNode$.label] = value;
    return this;
  }

  CheckboxNodePatch withEnabled(bool? value) {
    patchMap[CheckboxNode$.enabled] = value;
    return this;
  }

  CheckboxNodePatch withAction(ActionId? value) {
    patchMap[CheckboxNode$.action] = value;
    return this;
  }
}

/// Field descriptors for [CheckboxNode] query construction
abstract final class CheckboxNodeFields {
  static const id = Field<CheckboxNode, String?>('id', _$id);

  static const value = Field<CheckboxNode, bool?>('value', _$value);

  static const label = Field<CheckboxNode, String?>('label', _$label);

  static const enabled = Field<CheckboxNode, bool?>('enabled', _$enabled);

  static const action = Field<CheckboxNode, ActionId?>('action', _$action);

  static String? _$id(CheckboxNode e) {
    return e.id;
  }

  static bool? _$value(CheckboxNode e) {
    return e.value;
  }

  static String? _$label(CheckboxNode e) {
    return e.label;
  }

  static bool? _$enabled(CheckboxNode e) {
    return e.enabled;
  }

  static ActionId? _$action(CheckboxNode e) {
    return e.action;
  }
}

extension CheckboxNodeCompareE on CheckboxNode {
  Map<String, dynamic> compareToCheckboxNode(CheckboxNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (value != other.value) {
      diff['value'] = () => other.value;
    }

    if (label != other.label) {
      diff['label'] = () => other.label;
    }

    if (enabled != other.enabled) {
      diff['enabled'] = () => other.enabled;
    }

    if (action != other.action) {
      diff['action'] = () => other.action;
    }
    return diff;
  }
}

class SwitchNode implements ShadNode {
  SwitchNode({
    String? this.id,
    bool? this.value,
    String? this.label,
    bool? this.enabled,
    ActionId? this.action,
  });

  final String? id;

  final bool? value;

  final String? label;

  final bool? enabled;

  final ActionId? action;

  SwitchNode copyWith({
    String? id,
    bool? value,
    String? label,
    bool? enabled,
    ActionId? action,
  }) {
    return SwitchNode(
      id: id ?? this.id,
      value: value ?? this.value,
      label: label ?? this.label,
      enabled: enabled ?? this.enabled,
      action: action ?? this.action,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  SwitchNode copyWithField<T>(Field<SwitchNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'value':
        return copyWith(value: value as bool?);
      case 'label':
        return copyWith(label: value as String?);
      case 'enabled':
        return copyWith(enabled: value as bool?);
      case 'action':
        return copyWith(action: value as ActionId?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'SwitchNode has no settable field with this name',
        );
    }
  }

  SwitchNode copyWithSwitchNode({
    String? id,
    bool? value,
    String? label,
    bool? enabled,
    ActionId? action,
  }) {
    return copyWith(
      id: id,
      value: value,
      label: label,
      enabled: enabled,
      action: action,
    );
  }

  SwitchNode patchWithSwitchNode([SwitchNodePatch? patchInput]) {
    final _patcher = patchInput ?? SwitchNodePatch();
    final _patchMap = _patcher.patchMap;
    return SwitchNode(
      id: _patchMap.containsKey(SwitchNode$.id)
          ? ((_patchMap[SwitchNode$.id] is Function)
                    ? _patchMap[SwitchNode$.id](this.id)
                    : (_patchMap[SwitchNode$.id] is Patch)
                    ? _patchMap[SwitchNode$.id].applyTo(this.id)
                    : _patchMap[SwitchNode$.id])
                as String?
          : this.id,
      value: _patchMap.containsKey(SwitchNode$.value)
          ? ((_patchMap[SwitchNode$.value] is Function)
                    ? _patchMap[SwitchNode$.value](this.value)
                    : (_patchMap[SwitchNode$.value] is Patch)
                    ? _patchMap[SwitchNode$.value].applyTo(this.value)
                    : _patchMap[SwitchNode$.value])
                as bool?
          : this.value,
      label: _patchMap.containsKey(SwitchNode$.label)
          ? ((_patchMap[SwitchNode$.label] is Function)
                    ? _patchMap[SwitchNode$.label](this.label)
                    : (_patchMap[SwitchNode$.label] is Patch)
                    ? _patchMap[SwitchNode$.label].applyTo(this.label)
                    : _patchMap[SwitchNode$.label])
                as String?
          : this.label,
      enabled: _patchMap.containsKey(SwitchNode$.enabled)
          ? ((_patchMap[SwitchNode$.enabled] is Function)
                    ? _patchMap[SwitchNode$.enabled](this.enabled)
                    : (_patchMap[SwitchNode$.enabled] is Patch)
                    ? _patchMap[SwitchNode$.enabled].applyTo(this.enabled)
                    : _patchMap[SwitchNode$.enabled])
                as bool?
          : this.enabled,
      action: _patchMap.containsKey(SwitchNode$.action)
          ? ((_patchMap[SwitchNode$.action] is Function)
                    ? _patchMap[SwitchNode$.action](this.action)
                    : (_patchMap[SwitchNode$.action] is Patch)
                    ? _patchMap[SwitchNode$.action].applyTo(this.action)
                    : _patchMap[SwitchNode$.action])
                as ActionId?
          : this.action,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SwitchNode &&
        id == other.id &&
        value == other.value &&
        label == other.label &&
        enabled == other.enabled &&
        action == other.action;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.value,
      this.label,
      this.enabled,
      this.action,
    );
  }

  @override
  String toString() {
    return 'SwitchNode(' +
        'id: ${id}' +
        ', ' +
        'value: ${value}' +
        ', ' +
        'label: ${label}' +
        ', ' +
        'enabled: ${enabled}' +
        ', ' +
        'action: ${action})';
  }
}

extension SwitchNodePropertyHelpers on SwitchNode {
  bool get hasValue {
    return this.value != null;
  }

  bool get noValue {
    return this.value == null;
  }

  bool get valueRequired {
    return this.value ?? (throw StateError('value is required but was null'));
  }

  bool get hasLabel {
    return this.label?.isNotEmpty == true;
  }

  bool get noLabel {
    return this.label?.isEmpty ?? true;
  }

  String get labelRequired {
    return this.label ?? (throw StateError('label is required but was null'));
  }

  bool get hasEnabled {
    return this.enabled != null;
  }

  bool get noEnabled {
    return this.enabled == null;
  }

  bool get enabledRequired {
    return this.enabled ??
        (throw StateError('enabled is required but was null'));
  }

  bool get hasAction {
    return this.action != null;
  }

  bool get noAction {
    return this.action == null;
  }

  ActionId get actionRequired {
    return this.action ?? (throw StateError('action is required but was null'));
  }
}

enum SwitchNode$ { id, value, label, enabled, action }

class SwitchNodePatch extends PatchBase<SwitchNode, SwitchNode$> {
  SwitchNode applyTo(SwitchNode entity) {
    return entity.patchWithSwitchNode(this);
  }

  SwitchNodePatch withId(String? value) {
    patchMap[SwitchNode$.id] = value;
    return this;
  }

  SwitchNodePatch withValue(bool? value) {
    patchMap[SwitchNode$.value] = value;
    return this;
  }

  SwitchNodePatch withLabel(String? value) {
    patchMap[SwitchNode$.label] = value;
    return this;
  }

  SwitchNodePatch withEnabled(bool? value) {
    patchMap[SwitchNode$.enabled] = value;
    return this;
  }

  SwitchNodePatch withAction(ActionId? value) {
    patchMap[SwitchNode$.action] = value;
    return this;
  }
}

/// Field descriptors for [SwitchNode] query construction
abstract final class SwitchNodeFields {
  static const id = Field<SwitchNode, String?>('id', _$id);

  static const value = Field<SwitchNode, bool?>('value', _$value);

  static const label = Field<SwitchNode, String?>('label', _$label);

  static const enabled = Field<SwitchNode, bool?>('enabled', _$enabled);

  static const action = Field<SwitchNode, ActionId?>('action', _$action);

  static String? _$id(SwitchNode e) {
    return e.id;
  }

  static bool? _$value(SwitchNode e) {
    return e.value;
  }

  static String? _$label(SwitchNode e) {
    return e.label;
  }

  static bool? _$enabled(SwitchNode e) {
    return e.enabled;
  }

  static ActionId? _$action(SwitchNode e) {
    return e.action;
  }
}

extension SwitchNodeCompareE on SwitchNode {
  Map<String, dynamic> compareToSwitchNode(SwitchNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (value != other.value) {
      diff['value'] = () => other.value;
    }

    if (label != other.label) {
      diff['label'] = () => other.label;
    }

    if (enabled != other.enabled) {
      diff['enabled'] = () => other.enabled;
    }

    if (action != other.action) {
      diff['action'] = () => other.action;
    }
    return diff;
  }
}

class RadioGroupNode implements ShadNode {
  RadioGroupNode({
    String? this.id,
    required List<RadioOptionNode> this.options,
    String? this.value,
    bool? this.enabled,
    ActionId? this.action,
  });

  final String? id;

  final List<RadioOptionNode> options;

  final String? value;

  final bool? enabled;

  final ActionId? action;

  RadioGroupNode copyWith({
    String? id,
    List<RadioOptionNode>? options,
    String? value,
    bool? enabled,
    ActionId? action,
  }) {
    return RadioGroupNode(
      id: id ?? this.id,
      options: options ?? this.options,
      value: value ?? this.value,
      enabled: enabled ?? this.enabled,
      action: action ?? this.action,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  RadioGroupNode copyWithField<T>(Field<RadioGroupNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'options':
        return copyWith(options: value as List<RadioOptionNode>);
      case 'value':
        return copyWith(value: value as String?);
      case 'enabled':
        return copyWith(enabled: value as bool?);
      case 'action':
        return copyWith(action: value as ActionId?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'RadioGroupNode has no settable field with this name',
        );
    }
  }

  RadioGroupNode copyWithRadioGroupNode({
    String? id,
    List<RadioOptionNode>? options,
    String? value,
    bool? enabled,
    ActionId? action,
  }) {
    return copyWith(
      id: id,
      options: options,
      value: value,
      enabled: enabled,
      action: action,
    );
  }

  RadioGroupNode patchWithRadioGroupNode([RadioGroupNodePatch? patchInput]) {
    final _patcher = patchInput ?? RadioGroupNodePatch();
    final _patchMap = _patcher.patchMap;
    return RadioGroupNode(
      id: _patchMap.containsKey(RadioGroupNode$.id)
          ? ((_patchMap[RadioGroupNode$.id] is Function)
                    ? _patchMap[RadioGroupNode$.id](this.id)
                    : (_patchMap[RadioGroupNode$.id] is Patch)
                    ? _patchMap[RadioGroupNode$.id].applyTo(this.id)
                    : _patchMap[RadioGroupNode$.id])
                as String?
          : this.id,
      options: _patchMap.containsKey(RadioGroupNode$.options)
          ? ((_patchMap[RadioGroupNode$.options] is Function)
                    ? _patchMap[RadioGroupNode$.options](this.options)
                    : (_patchMap[RadioGroupNode$.options] is Patch)
                    ? _patchMap[RadioGroupNode$.options].applyTo(this.options)
                    : _patchMap[RadioGroupNode$.options])
                as List<RadioOptionNode>
          : this.options,
      value: _patchMap.containsKey(RadioGroupNode$.value)
          ? ((_patchMap[RadioGroupNode$.value] is Function)
                    ? _patchMap[RadioGroupNode$.value](this.value)
                    : (_patchMap[RadioGroupNode$.value] is Patch)
                    ? _patchMap[RadioGroupNode$.value].applyTo(this.value)
                    : _patchMap[RadioGroupNode$.value])
                as String?
          : this.value,
      enabled: _patchMap.containsKey(RadioGroupNode$.enabled)
          ? ((_patchMap[RadioGroupNode$.enabled] is Function)
                    ? _patchMap[RadioGroupNode$.enabled](this.enabled)
                    : (_patchMap[RadioGroupNode$.enabled] is Patch)
                    ? _patchMap[RadioGroupNode$.enabled].applyTo(this.enabled)
                    : _patchMap[RadioGroupNode$.enabled])
                as bool?
          : this.enabled,
      action: _patchMap.containsKey(RadioGroupNode$.action)
          ? ((_patchMap[RadioGroupNode$.action] is Function)
                    ? _patchMap[RadioGroupNode$.action](this.action)
                    : (_patchMap[RadioGroupNode$.action] is Patch)
                    ? _patchMap[RadioGroupNode$.action].applyTo(this.action)
                    : _patchMap[RadioGroupNode$.action])
                as ActionId?
          : this.action,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RadioGroupNode &&
        id == other.id &&
        options == other.options &&
        value == other.value &&
        enabled == other.enabled &&
        action == other.action;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.options,
      this.value,
      this.enabled,
      this.action,
    );
  }

  @override
  String toString() {
    return 'RadioGroupNode(' +
        'id: ${id}' +
        ', ' +
        'options: ${options}' +
        ', ' +
        'value: ${value}' +
        ', ' +
        'enabled: ${enabled}' +
        ', ' +
        'action: ${action})';
  }
}

extension RadioGroupNodePropertyHelpers on RadioGroupNode {
  bool get hasOptions {
    return this.options.isNotEmpty;
  }

  bool get noOptions {
    return this.options.isEmpty;
  }

  bool get hasValue {
    return this.value?.isNotEmpty == true;
  }

  bool get noValue {
    return this.value?.isEmpty ?? true;
  }

  String get valueRequired {
    return this.value ?? (throw StateError('value is required but was null'));
  }

  bool get hasEnabled {
    return this.enabled != null;
  }

  bool get noEnabled {
    return this.enabled == null;
  }

  bool get enabledRequired {
    return this.enabled ??
        (throw StateError('enabled is required but was null'));
  }

  bool get hasAction {
    return this.action != null;
  }

  bool get noAction {
    return this.action == null;
  }

  ActionId get actionRequired {
    return this.action ?? (throw StateError('action is required but was null'));
  }
}

enum RadioGroupNode$ { id, options, value, enabled, action }

class RadioGroupNodePatch extends PatchBase<RadioGroupNode, RadioGroupNode$> {
  RadioGroupNode applyTo(RadioGroupNode entity) {
    return entity.patchWithRadioGroupNode(this);
  }

  RadioGroupNodePatch withId(String? value) {
    patchMap[RadioGroupNode$.id] = value;
    return this;
  }

  RadioGroupNodePatch withOptions(List<RadioOptionNode>? value) {
    patchMap[RadioGroupNode$.options] = value;
    return this;
  }

  RadioGroupNodePatch updateOptionsAt(
    int index,
    RadioOptionNodePatch Function(RadioOptionNodePatch) patch,
  ) {
    patchMap[RadioGroupNode$.options] = (List<dynamic> list) {
      var updatedList = List<RadioOptionNode>.from(list);
      if (index >= 0 && index < updatedList.length) {
        updatedList[index] = patch(
          RadioOptionNodePatch(),
        ).applyTo(updatedList[index] as RadioOptionNode);
      }
      return updatedList;
    };
    return this;
  }

  RadioGroupNodePatch withValue(String? value) {
    patchMap[RadioGroupNode$.value] = value;
    return this;
  }

  RadioGroupNodePatch withEnabled(bool? value) {
    patchMap[RadioGroupNode$.enabled] = value;
    return this;
  }

  RadioGroupNodePatch withAction(ActionId? value) {
    patchMap[RadioGroupNode$.action] = value;
    return this;
  }
}

/// Field descriptors for [RadioGroupNode] query construction
abstract final class RadioGroupNodeFields {
  static const id = Field<RadioGroupNode, String?>('id', _$id);

  static const options = Field<RadioGroupNode, List<RadioOptionNode>>(
    'options',
    _$options,
  );

  static const value = Field<RadioGroupNode, String?>('value', _$value);

  static const enabled = Field<RadioGroupNode, bool?>('enabled', _$enabled);

  static const action = Field<RadioGroupNode, ActionId?>('action', _$action);

  static String? _$id(RadioGroupNode e) {
    return e.id;
  }

  static List<RadioOptionNode> _$options(RadioGroupNode e) {
    return e.options;
  }

  static String? _$value(RadioGroupNode e) {
    return e.value;
  }

  static bool? _$enabled(RadioGroupNode e) {
    return e.enabled;
  }

  static ActionId? _$action(RadioGroupNode e) {
    return e.action;
  }
}

extension RadioGroupNodeCompareE on RadioGroupNode {
  Map<String, dynamic> compareToRadioGroupNode(RadioGroupNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (options != other.options) {
      diff['options'] = () => other.options;
    }

    if (value != other.value) {
      diff['value'] = () => other.value;
    }

    if (enabled != other.enabled) {
      diff['enabled'] = () => other.enabled;
    }

    if (action != other.action) {
      diff['action'] = () => other.action;
    }
    return diff;
  }
}

class RadioOptionNode implements ShadNode {
  RadioOptionNode({
    String? this.id,
    required String this.value,
    required String this.label,
    bool? this.enabled,
  });

  final String? id;

  final String value;

  final String label;

  final bool? enabled;

  RadioOptionNode copyWith({
    String? id,
    String? value,
    String? label,
    bool? enabled,
  }) {
    return RadioOptionNode(
      id: id ?? this.id,
      value: value ?? this.value,
      label: label ?? this.label,
      enabled: enabled ?? this.enabled,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  RadioOptionNode copyWithField<T>(Field<RadioOptionNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'value':
        return copyWith(value: value as String);
      case 'label':
        return copyWith(label: value as String);
      case 'enabled':
        return copyWith(enabled: value as bool?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'RadioOptionNode has no settable field with this name',
        );
    }
  }

  RadioOptionNode copyWithRadioOptionNode({
    String? id,
    String? value,
    String? label,
    bool? enabled,
  }) {
    return copyWith(id: id, value: value, label: label, enabled: enabled);
  }

  RadioOptionNode patchWithRadioOptionNode([RadioOptionNodePatch? patchInput]) {
    final _patcher = patchInput ?? RadioOptionNodePatch();
    final _patchMap = _patcher.patchMap;
    return RadioOptionNode(
      id: _patchMap.containsKey(RadioOptionNode$.id)
          ? ((_patchMap[RadioOptionNode$.id] is Function)
                    ? _patchMap[RadioOptionNode$.id](this.id)
                    : (_patchMap[RadioOptionNode$.id] is Patch)
                    ? _patchMap[RadioOptionNode$.id].applyTo(this.id)
                    : _patchMap[RadioOptionNode$.id])
                as String?
          : this.id,
      value: _patchMap.containsKey(RadioOptionNode$.value)
          ? ((_patchMap[RadioOptionNode$.value] is Function)
                    ? _patchMap[RadioOptionNode$.value](this.value)
                    : (_patchMap[RadioOptionNode$.value] is Patch)
                    ? _patchMap[RadioOptionNode$.value].applyTo(this.value)
                    : _patchMap[RadioOptionNode$.value])
                as String
          : this.value,
      label: _patchMap.containsKey(RadioOptionNode$.label)
          ? ((_patchMap[RadioOptionNode$.label] is Function)
                    ? _patchMap[RadioOptionNode$.label](this.label)
                    : (_patchMap[RadioOptionNode$.label] is Patch)
                    ? _patchMap[RadioOptionNode$.label].applyTo(this.label)
                    : _patchMap[RadioOptionNode$.label])
                as String
          : this.label,
      enabled: _patchMap.containsKey(RadioOptionNode$.enabled)
          ? ((_patchMap[RadioOptionNode$.enabled] is Function)
                    ? _patchMap[RadioOptionNode$.enabled](this.enabled)
                    : (_patchMap[RadioOptionNode$.enabled] is Patch)
                    ? _patchMap[RadioOptionNode$.enabled].applyTo(this.enabled)
                    : _patchMap[RadioOptionNode$.enabled])
                as bool?
          : this.enabled,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RadioOptionNode &&
        id == other.id &&
        value == other.value &&
        label == other.label &&
        enabled == other.enabled;
  }

  @override
  int get hashCode {
    return Object.hash(this.id, this.value, this.label, this.enabled);
  }

  @override
  String toString() {
    return 'RadioOptionNode(' +
        'id: ${id}' +
        ', ' +
        'value: ${value}' +
        ', ' +
        'label: ${label}' +
        ', ' +
        'enabled: ${enabled})';
  }
}

extension RadioOptionNodePropertyHelpers on RadioOptionNode {
  bool get hasValue {
    return this.value.isNotEmpty;
  }

  bool get noValue {
    return this.value.isEmpty;
  }

  bool get hasLabel {
    return this.label.isNotEmpty;
  }

  bool get noLabel {
    return this.label.isEmpty;
  }

  bool get hasEnabled {
    return this.enabled != null;
  }

  bool get noEnabled {
    return this.enabled == null;
  }

  bool get enabledRequired {
    return this.enabled ??
        (throw StateError('enabled is required but was null'));
  }
}

enum RadioOptionNode$ { id, value, label, enabled }

class RadioOptionNodePatch
    extends PatchBase<RadioOptionNode, RadioOptionNode$> {
  RadioOptionNode applyTo(RadioOptionNode entity) {
    return entity.patchWithRadioOptionNode(this);
  }

  RadioOptionNodePatch withId(String? value) {
    patchMap[RadioOptionNode$.id] = value;
    return this;
  }

  RadioOptionNodePatch withValue(String? value) {
    patchMap[RadioOptionNode$.value] = value;
    return this;
  }

  RadioOptionNodePatch withLabel(String? value) {
    patchMap[RadioOptionNode$.label] = value;
    return this;
  }

  RadioOptionNodePatch withEnabled(bool? value) {
    patchMap[RadioOptionNode$.enabled] = value;
    return this;
  }
}

/// Field descriptors for [RadioOptionNode] query construction
abstract final class RadioOptionNodeFields {
  static const id = Field<RadioOptionNode, String?>('id', _$id);

  static const value = Field<RadioOptionNode, String>('value', _$value);

  static const label = Field<RadioOptionNode, String>('label', _$label);

  static const enabled = Field<RadioOptionNode, bool?>('enabled', _$enabled);

  static String? _$id(RadioOptionNode e) {
    return e.id;
  }

  static String _$value(RadioOptionNode e) {
    return e.value;
  }

  static String _$label(RadioOptionNode e) {
    return e.label;
  }

  static bool? _$enabled(RadioOptionNode e) {
    return e.enabled;
  }
}

extension RadioOptionNodeCompareE on RadioOptionNode {
  Map<String, dynamic> compareToRadioOptionNode(RadioOptionNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (value != other.value) {
      diff['value'] = () => other.value;
    }

    if (label != other.label) {
      diff['label'] = () => other.label;
    }

    if (enabled != other.enabled) {
      diff['enabled'] = () => other.enabled;
    }
    return diff;
  }
}

class FormItemNode implements ShadNode {
  FormItemNode({
    String? this.id,
    required String this.label,
    required ShadNode this.field,
    String? this.helper,
    String? this.errorText,
    bool? this.required_,
  });

  final String? id;

  final String label;

  final ShadNode field;

  final String? helper;

  final String? errorText;

  final bool? required_;

  FormItemNode copyWith({
    String? id,
    String? label,
    ShadNode? field,
    String? helper,
    String? errorText,
    bool? required_,
  }) {
    return FormItemNode(
      id: id ?? this.id,
      label: label ?? this.label,
      field: field ?? this.field,
      helper: helper ?? this.helper,
      errorText: errorText ?? this.errorText,
      required_: required_ ?? this.required_,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  FormItemNode copyWithField<T>(Field<FormItemNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'label':
        return copyWith(label: value as String);
      case 'field':
        return copyWith(field: value as ShadNode);
      case 'helper':
        return copyWith(helper: value as String?);
      case 'errorText':
        return copyWith(errorText: value as String?);
      case 'required_':
        return copyWith(required_: value as bool?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'FormItemNode has no settable field with this name',
        );
    }
  }

  FormItemNode copyWithFormItemNode({
    String? id,
    String? label,
    ShadNode? field,
    String? helper,
    String? errorText,
    bool? required_,
  }) {
    return copyWith(
      id: id,
      label: label,
      field: field,
      helper: helper,
      errorText: errorText,
      required_: required_,
    );
  }

  FormItemNode patchWithFormItemNode([FormItemNodePatch? patchInput]) {
    final _patcher = patchInput ?? FormItemNodePatch();
    final _patchMap = _patcher.patchMap;
    return FormItemNode(
      id: _patchMap.containsKey(FormItemNode$.id)
          ? ((_patchMap[FormItemNode$.id] is Function)
                    ? _patchMap[FormItemNode$.id](this.id)
                    : (_patchMap[FormItemNode$.id] is Patch)
                    ? _patchMap[FormItemNode$.id].applyTo(this.id)
                    : _patchMap[FormItemNode$.id])
                as String?
          : this.id,
      label: _patchMap.containsKey(FormItemNode$.label)
          ? ((_patchMap[FormItemNode$.label] is Function)
                    ? _patchMap[FormItemNode$.label](this.label)
                    : (_patchMap[FormItemNode$.label] is Patch)
                    ? _patchMap[FormItemNode$.label].applyTo(this.label)
                    : _patchMap[FormItemNode$.label])
                as String
          : this.label,
      field: _patchMap.containsKey(FormItemNode$.field)
          ? ((_patchMap[FormItemNode$.field] is Function)
                    ? _patchMap[FormItemNode$.field](this.field)
                    : (_patchMap[FormItemNode$.field] is Patch)
                    ? _patchMap[FormItemNode$.field].applyTo(this.field)
                    : _patchMap[FormItemNode$.field])
                as ShadNode
          : this.field,
      helper: _patchMap.containsKey(FormItemNode$.helper)
          ? ((_patchMap[FormItemNode$.helper] is Function)
                    ? _patchMap[FormItemNode$.helper](this.helper)
                    : (_patchMap[FormItemNode$.helper] is Patch)
                    ? _patchMap[FormItemNode$.helper].applyTo(this.helper)
                    : _patchMap[FormItemNode$.helper])
                as String?
          : this.helper,
      errorText: _patchMap.containsKey(FormItemNode$.errorText)
          ? ((_patchMap[FormItemNode$.errorText] is Function)
                    ? _patchMap[FormItemNode$.errorText](this.errorText)
                    : (_patchMap[FormItemNode$.errorText] is Patch)
                    ? _patchMap[FormItemNode$.errorText].applyTo(this.errorText)
                    : _patchMap[FormItemNode$.errorText])
                as String?
          : this.errorText,
      required_: _patchMap.containsKey(FormItemNode$.required_)
          ? ((_patchMap[FormItemNode$.required_] is Function)
                    ? _patchMap[FormItemNode$.required_](this.required_)
                    : (_patchMap[FormItemNode$.required_] is Patch)
                    ? _patchMap[FormItemNode$.required_].applyTo(this.required_)
                    : _patchMap[FormItemNode$.required_])
                as bool?
          : this.required_,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FormItemNode &&
        id == other.id &&
        label == other.label &&
        field == other.field &&
        helper == other.helper &&
        errorText == other.errorText &&
        required_ == other.required_;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.label,
      this.field,
      this.helper,
      this.errorText,
      this.required_,
    );
  }

  @override
  String toString() {
    return 'FormItemNode(' +
        'id: ${id}' +
        ', ' +
        'label: ${label}' +
        ', ' +
        'field: ${field}' +
        ', ' +
        'helper: ${helper}' +
        ', ' +
        'errorText: ${errorText}' +
        ', ' +
        'required_: ${required_})';
  }
}

extension FormItemNodePropertyHelpers on FormItemNode {
  bool get hasLabel {
    return this.label.isNotEmpty;
  }

  bool get noLabel {
    return this.label.isEmpty;
  }

  bool get hasHelper {
    return this.helper?.isNotEmpty == true;
  }

  bool get noHelper {
    return this.helper?.isEmpty ?? true;
  }

  String get helperRequired {
    return this.helper ?? (throw StateError('helper is required but was null'));
  }

  bool get hasErrorText {
    return this.errorText?.isNotEmpty == true;
  }

  bool get noErrorText {
    return this.errorText?.isEmpty ?? true;
  }

  String get errorTextRequired {
    return this.errorText ??
        (throw StateError('errorText is required but was null'));
  }

  bool get hasRequired_ {
    return this.required_ != null;
  }

  bool get noRequired_ {
    return this.required_ == null;
  }

  bool get required_Required {
    return this.required_ ??
        (throw StateError('required_ is required but was null'));
  }
}

enum FormItemNode$ { id, label, field, helper, errorText, required_ }

class FormItemNodePatch extends PatchBase<FormItemNode, FormItemNode$> {
  FormItemNode applyTo(FormItemNode entity) {
    return entity.patchWithFormItemNode(this);
  }

  FormItemNodePatch withId(String? value) {
    patchMap[FormItemNode$.id] = value;
    return this;
  }

  FormItemNodePatch withLabel(String? value) {
    patchMap[FormItemNode$.label] = value;
    return this;
  }

  FormItemNodePatch withField(ShadNode? value) {
    patchMap[FormItemNode$.field] = value;
    return this;
  }

  FormItemNodePatch withHelper(String? value) {
    patchMap[FormItemNode$.helper] = value;
    return this;
  }

  FormItemNodePatch withErrorText(String? value) {
    patchMap[FormItemNode$.errorText] = value;
    return this;
  }

  FormItemNodePatch withRequired_(bool? value) {
    patchMap[FormItemNode$.required_] = value;
    return this;
  }
}

/// Field descriptors for [FormItemNode] query construction
abstract final class FormItemNodeFields {
  static const id = Field<FormItemNode, String?>('id', _$id);

  static const label = Field<FormItemNode, String>('label', _$label);

  static const field = Field<FormItemNode, ShadNode>('field', _$field);

  static const helper = Field<FormItemNode, String?>('helper', _$helper);

  static const errorText = Field<FormItemNode, String?>(
    'errorText',
    _$errorText,
  );

  static const required_ = Field<FormItemNode, bool?>('required_', _$required_);

  static String? _$id(FormItemNode e) {
    return e.id;
  }

  static String _$label(FormItemNode e) {
    return e.label;
  }

  static ShadNode _$field(FormItemNode e) {
    return e.field;
  }

  static String? _$helper(FormItemNode e) {
    return e.helper;
  }

  static String? _$errorText(FormItemNode e) {
    return e.errorText;
  }

  static bool? _$required_(FormItemNode e) {
    return e.required_;
  }
}

extension FormItemNodeCompareE on FormItemNode {
  Map<String, dynamic> compareToFormItemNode(FormItemNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (label != other.label) {
      diff['label'] = () => other.label;
    }

    if (field != other.field) {
      diff['field'] = () => other.field;
    }

    if (helper != other.helper) {
      diff['helper'] = () => other.helper;
    }

    if (errorText != other.errorText) {
      diff['errorText'] = () => other.errorText;
    }

    if (required_ != other.required_) {
      diff['required_'] = () => other.required_;
    }
    return diff;
  }
}

class TabsNode implements ShadNode {
  TabsNode({
    String? this.id,
    required List<TabNode> this.tabs,
    required List<TabPaneNode> this.panes,
    String? this.value,
    ActionId? this.action,
  });

  final String? id;

  final List<TabNode> tabs;

  final List<TabPaneNode> panes;

  final String? value;

  final ActionId? action;

  TabsNode copyWith({
    String? id,
    List<TabNode>? tabs,
    List<TabPaneNode>? panes,
    String? value,
    ActionId? action,
  }) {
    return TabsNode(
      id: id ?? this.id,
      tabs: tabs ?? this.tabs,
      panes: panes ?? this.panes,
      value: value ?? this.value,
      action: action ?? this.action,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  TabsNode copyWithField<T>(Field<TabsNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'tabs':
        return copyWith(tabs: value as List<TabNode>);
      case 'panes':
        return copyWith(panes: value as List<TabPaneNode>);
      case 'value':
        return copyWith(value: value as String?);
      case 'action':
        return copyWith(action: value as ActionId?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'TabsNode has no settable field with this name',
        );
    }
  }

  TabsNode copyWithTabsNode({
    String? id,
    List<TabNode>? tabs,
    List<TabPaneNode>? panes,
    String? value,
    ActionId? action,
  }) {
    return copyWith(
      id: id,
      tabs: tabs,
      panes: panes,
      value: value,
      action: action,
    );
  }

  TabsNode patchWithTabsNode([TabsNodePatch? patchInput]) {
    final _patcher = patchInput ?? TabsNodePatch();
    final _patchMap = _patcher.patchMap;
    return TabsNode(
      id: _patchMap.containsKey(TabsNode$.id)
          ? ((_patchMap[TabsNode$.id] is Function)
                    ? _patchMap[TabsNode$.id](this.id)
                    : (_patchMap[TabsNode$.id] is Patch)
                    ? _patchMap[TabsNode$.id].applyTo(this.id)
                    : _patchMap[TabsNode$.id])
                as String?
          : this.id,
      tabs: _patchMap.containsKey(TabsNode$.tabs)
          ? ((_patchMap[TabsNode$.tabs] is Function)
                    ? _patchMap[TabsNode$.tabs](this.tabs)
                    : (_patchMap[TabsNode$.tabs] is Patch)
                    ? _patchMap[TabsNode$.tabs].applyTo(this.tabs)
                    : _patchMap[TabsNode$.tabs])
                as List<TabNode>
          : this.tabs,
      panes: _patchMap.containsKey(TabsNode$.panes)
          ? ((_patchMap[TabsNode$.panes] is Function)
                    ? _patchMap[TabsNode$.panes](this.panes)
                    : (_patchMap[TabsNode$.panes] is Patch)
                    ? _patchMap[TabsNode$.panes].applyTo(this.panes)
                    : _patchMap[TabsNode$.panes])
                as List<TabPaneNode>
          : this.panes,
      value: _patchMap.containsKey(TabsNode$.value)
          ? ((_patchMap[TabsNode$.value] is Function)
                    ? _patchMap[TabsNode$.value](this.value)
                    : (_patchMap[TabsNode$.value] is Patch)
                    ? _patchMap[TabsNode$.value].applyTo(this.value)
                    : _patchMap[TabsNode$.value])
                as String?
          : this.value,
      action: _patchMap.containsKey(TabsNode$.action)
          ? ((_patchMap[TabsNode$.action] is Function)
                    ? _patchMap[TabsNode$.action](this.action)
                    : (_patchMap[TabsNode$.action] is Patch)
                    ? _patchMap[TabsNode$.action].applyTo(this.action)
                    : _patchMap[TabsNode$.action])
                as ActionId?
          : this.action,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TabsNode &&
        id == other.id &&
        tabs == other.tabs &&
        panes == other.panes &&
        value == other.value &&
        action == other.action;
  }

  @override
  int get hashCode {
    return Object.hash(this.id, this.tabs, this.panes, this.value, this.action);
  }

  @override
  String toString() {
    return 'TabsNode(' +
        'id: ${id}' +
        ', ' +
        'tabs: ${tabs}' +
        ', ' +
        'panes: ${panes}' +
        ', ' +
        'value: ${value}' +
        ', ' +
        'action: ${action})';
  }
}

extension TabsNodePropertyHelpers on TabsNode {
  bool get hasTabs {
    return this.tabs.isNotEmpty;
  }

  bool get noTabs {
    return this.tabs.isEmpty;
  }

  bool get hasPanes {
    return this.panes.isNotEmpty;
  }

  bool get noPanes {
    return this.panes.isEmpty;
  }

  bool get hasValue {
    return this.value?.isNotEmpty == true;
  }

  bool get noValue {
    return this.value?.isEmpty ?? true;
  }

  String get valueRequired {
    return this.value ?? (throw StateError('value is required but was null'));
  }

  bool get hasAction {
    return this.action != null;
  }

  bool get noAction {
    return this.action == null;
  }

  ActionId get actionRequired {
    return this.action ?? (throw StateError('action is required but was null'));
  }
}

enum TabsNode$ { id, tabs, panes, value, action }

class TabsNodePatch extends PatchBase<TabsNode, TabsNode$> {
  TabsNode applyTo(TabsNode entity) {
    return entity.patchWithTabsNode(this);
  }

  TabsNodePatch withId(String? value) {
    patchMap[TabsNode$.id] = value;
    return this;
  }

  TabsNodePatch withTabs(List<TabNode>? value) {
    patchMap[TabsNode$.tabs] = value;
    return this;
  }

  TabsNodePatch updateTabsAt(
    int index,
    TabNodePatch Function(TabNodePatch) patch,
  ) {
    patchMap[TabsNode$.tabs] = (List<dynamic> list) {
      var updatedList = List<TabNode>.from(list);
      if (index >= 0 && index < updatedList.length) {
        updatedList[index] = patch(
          TabNodePatch(),
        ).applyTo(updatedList[index] as TabNode);
      }
      return updatedList;
    };
    return this;
  }

  TabsNodePatch withPanes(List<TabPaneNode>? value) {
    patchMap[TabsNode$.panes] = value;
    return this;
  }

  TabsNodePatch updatePanesAt(
    int index,
    TabPaneNodePatch Function(TabPaneNodePatch) patch,
  ) {
    patchMap[TabsNode$.panes] = (List<dynamic> list) {
      var updatedList = List<TabPaneNode>.from(list);
      if (index >= 0 && index < updatedList.length) {
        updatedList[index] = patch(
          TabPaneNodePatch(),
        ).applyTo(updatedList[index] as TabPaneNode);
      }
      return updatedList;
    };
    return this;
  }

  TabsNodePatch withValue(String? value) {
    patchMap[TabsNode$.value] = value;
    return this;
  }

  TabsNodePatch withAction(ActionId? value) {
    patchMap[TabsNode$.action] = value;
    return this;
  }
}

/// Field descriptors for [TabsNode] query construction
abstract final class TabsNodeFields {
  static const id = Field<TabsNode, String?>('id', _$id);

  static const tabs = Field<TabsNode, List<TabNode>>('tabs', _$tabs);

  static const panes = Field<TabsNode, List<TabPaneNode>>('panes', _$panes);

  static const value = Field<TabsNode, String?>('value', _$value);

  static const action = Field<TabsNode, ActionId?>('action', _$action);

  static String? _$id(TabsNode e) {
    return e.id;
  }

  static List<TabNode> _$tabs(TabsNode e) {
    return e.tabs;
  }

  static List<TabPaneNode> _$panes(TabsNode e) {
    return e.panes;
  }

  static String? _$value(TabsNode e) {
    return e.value;
  }

  static ActionId? _$action(TabsNode e) {
    return e.action;
  }
}

extension TabsNodeCompareE on TabsNode {
  Map<String, dynamic> compareToTabsNode(TabsNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (tabs != other.tabs) {
      diff['tabs'] = () => other.tabs;
    }

    if (panes != other.panes) {
      diff['panes'] = () => other.panes;
    }

    if (value != other.value) {
      diff['value'] = () => other.value;
    }

    if (action != other.action) {
      diff['action'] = () => other.action;
    }
    return diff;
  }
}

class TabNode implements ShadNode {
  TabNode({
    String? this.id,
    required String this.value,
    required String this.label,
    bool? this.enabled,
    ActionId? this.action,
  });

  final String? id;

  final String value;

  final String label;

  final bool? enabled;

  final ActionId? action;

  TabNode copyWith({
    String? id,
    String? value,
    String? label,
    bool? enabled,
    ActionId? action,
  }) {
    return TabNode(
      id: id ?? this.id,
      value: value ?? this.value,
      label: label ?? this.label,
      enabled: enabled ?? this.enabled,
      action: action ?? this.action,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  TabNode copyWithField<T>(Field<TabNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'value':
        return copyWith(value: value as String);
      case 'label':
        return copyWith(label: value as String);
      case 'enabled':
        return copyWith(enabled: value as bool?);
      case 'action':
        return copyWith(action: value as ActionId?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'TabNode has no settable field with this name',
        );
    }
  }

  TabNode copyWithTabNode({
    String? id,
    String? value,
    String? label,
    bool? enabled,
    ActionId? action,
  }) {
    return copyWith(
      id: id,
      value: value,
      label: label,
      enabled: enabled,
      action: action,
    );
  }

  TabNode patchWithTabNode([TabNodePatch? patchInput]) {
    final _patcher = patchInput ?? TabNodePatch();
    final _patchMap = _patcher.patchMap;
    return TabNode(
      id: _patchMap.containsKey(TabNode$.id)
          ? ((_patchMap[TabNode$.id] is Function)
                    ? _patchMap[TabNode$.id](this.id)
                    : (_patchMap[TabNode$.id] is Patch)
                    ? _patchMap[TabNode$.id].applyTo(this.id)
                    : _patchMap[TabNode$.id])
                as String?
          : this.id,
      value: _patchMap.containsKey(TabNode$.value)
          ? ((_patchMap[TabNode$.value] is Function)
                    ? _patchMap[TabNode$.value](this.value)
                    : (_patchMap[TabNode$.value] is Patch)
                    ? _patchMap[TabNode$.value].applyTo(this.value)
                    : _patchMap[TabNode$.value])
                as String
          : this.value,
      label: _patchMap.containsKey(TabNode$.label)
          ? ((_patchMap[TabNode$.label] is Function)
                    ? _patchMap[TabNode$.label](this.label)
                    : (_patchMap[TabNode$.label] is Patch)
                    ? _patchMap[TabNode$.label].applyTo(this.label)
                    : _patchMap[TabNode$.label])
                as String
          : this.label,
      enabled: _patchMap.containsKey(TabNode$.enabled)
          ? ((_patchMap[TabNode$.enabled] is Function)
                    ? _patchMap[TabNode$.enabled](this.enabled)
                    : (_patchMap[TabNode$.enabled] is Patch)
                    ? _patchMap[TabNode$.enabled].applyTo(this.enabled)
                    : _patchMap[TabNode$.enabled])
                as bool?
          : this.enabled,
      action: _patchMap.containsKey(TabNode$.action)
          ? ((_patchMap[TabNode$.action] is Function)
                    ? _patchMap[TabNode$.action](this.action)
                    : (_patchMap[TabNode$.action] is Patch)
                    ? _patchMap[TabNode$.action].applyTo(this.action)
                    : _patchMap[TabNode$.action])
                as ActionId?
          : this.action,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TabNode &&
        id == other.id &&
        value == other.value &&
        label == other.label &&
        enabled == other.enabled &&
        action == other.action;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.value,
      this.label,
      this.enabled,
      this.action,
    );
  }

  @override
  String toString() {
    return 'TabNode(' +
        'id: ${id}' +
        ', ' +
        'value: ${value}' +
        ', ' +
        'label: ${label}' +
        ', ' +
        'enabled: ${enabled}' +
        ', ' +
        'action: ${action})';
  }
}

extension TabNodePropertyHelpers on TabNode {
  bool get hasValue {
    return this.value.isNotEmpty;
  }

  bool get noValue {
    return this.value.isEmpty;
  }

  bool get hasLabel {
    return this.label.isNotEmpty;
  }

  bool get noLabel {
    return this.label.isEmpty;
  }

  bool get hasEnabled {
    return this.enabled != null;
  }

  bool get noEnabled {
    return this.enabled == null;
  }

  bool get enabledRequired {
    return this.enabled ??
        (throw StateError('enabled is required but was null'));
  }

  bool get hasAction {
    return this.action != null;
  }

  bool get noAction {
    return this.action == null;
  }

  ActionId get actionRequired {
    return this.action ?? (throw StateError('action is required but was null'));
  }
}

enum TabNode$ { id, value, label, enabled, action }

class TabNodePatch extends PatchBase<TabNode, TabNode$> {
  TabNode applyTo(TabNode entity) {
    return entity.patchWithTabNode(this);
  }

  TabNodePatch withId(String? value) {
    patchMap[TabNode$.id] = value;
    return this;
  }

  TabNodePatch withValue(String? value) {
    patchMap[TabNode$.value] = value;
    return this;
  }

  TabNodePatch withLabel(String? value) {
    patchMap[TabNode$.label] = value;
    return this;
  }

  TabNodePatch withEnabled(bool? value) {
    patchMap[TabNode$.enabled] = value;
    return this;
  }

  TabNodePatch withAction(ActionId? value) {
    patchMap[TabNode$.action] = value;
    return this;
  }
}

/// Field descriptors for [TabNode] query construction
abstract final class TabNodeFields {
  static const id = Field<TabNode, String?>('id', _$id);

  static const value = Field<TabNode, String>('value', _$value);

  static const label = Field<TabNode, String>('label', _$label);

  static const enabled = Field<TabNode, bool?>('enabled', _$enabled);

  static const action = Field<TabNode, ActionId?>('action', _$action);

  static String? _$id(TabNode e) {
    return e.id;
  }

  static String _$value(TabNode e) {
    return e.value;
  }

  static String _$label(TabNode e) {
    return e.label;
  }

  static bool? _$enabled(TabNode e) {
    return e.enabled;
  }

  static ActionId? _$action(TabNode e) {
    return e.action;
  }
}

extension TabNodeCompareE on TabNode {
  Map<String, dynamic> compareToTabNode(TabNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (value != other.value) {
      diff['value'] = () => other.value;
    }

    if (label != other.label) {
      diff['label'] = () => other.label;
    }

    if (enabled != other.enabled) {
      diff['enabled'] = () => other.enabled;
    }

    if (action != other.action) {
      diff['action'] = () => other.action;
    }
    return diff;
  }
}

class TabPaneNode implements ShadNode {
  TabPaneNode({
    String? this.id,
    required String this.value,
    required List<ShadNode> this.content,
  });

  final String? id;

  final String value;

  final List<ShadNode> content;

  TabPaneNode copyWith({String? id, String? value, List<ShadNode>? content}) {
    return TabPaneNode(
      id: id ?? this.id,
      value: value ?? this.value,
      content: content ?? this.content,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  TabPaneNode copyWithField<T>(Field<TabPaneNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'value':
        return copyWith(value: value as String);
      case 'content':
        return copyWith(content: value as List<ShadNode>);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'TabPaneNode has no settable field with this name',
        );
    }
  }

  TabPaneNode copyWithTabPaneNode({
    String? id,
    String? value,
    List<ShadNode>? content,
  }) {
    return copyWith(id: id, value: value, content: content);
  }

  TabPaneNode patchWithTabPaneNode([TabPaneNodePatch? patchInput]) {
    final _patcher = patchInput ?? TabPaneNodePatch();
    final _patchMap = _patcher.patchMap;
    return TabPaneNode(
      id: _patchMap.containsKey(TabPaneNode$.id)
          ? ((_patchMap[TabPaneNode$.id] is Function)
                    ? _patchMap[TabPaneNode$.id](this.id)
                    : (_patchMap[TabPaneNode$.id] is Patch)
                    ? _patchMap[TabPaneNode$.id].applyTo(this.id)
                    : _patchMap[TabPaneNode$.id])
                as String?
          : this.id,
      value: _patchMap.containsKey(TabPaneNode$.value)
          ? ((_patchMap[TabPaneNode$.value] is Function)
                    ? _patchMap[TabPaneNode$.value](this.value)
                    : (_patchMap[TabPaneNode$.value] is Patch)
                    ? _patchMap[TabPaneNode$.value].applyTo(this.value)
                    : _patchMap[TabPaneNode$.value])
                as String
          : this.value,
      content: _patchMap.containsKey(TabPaneNode$.content)
          ? ((_patchMap[TabPaneNode$.content] is Function)
                    ? _patchMap[TabPaneNode$.content](this.content)
                    : (_patchMap[TabPaneNode$.content] is Patch)
                    ? _patchMap[TabPaneNode$.content].applyTo(this.content)
                    : _patchMap[TabPaneNode$.content])
                as List<ShadNode>
          : this.content,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TabPaneNode &&
        id == other.id &&
        value == other.value &&
        content == other.content;
  }

  @override
  int get hashCode {
    return Object.hash(this.id, this.value, this.content);
  }

  @override
  String toString() {
    return 'TabPaneNode(' +
        'id: ${id}' +
        ', ' +
        'value: ${value}' +
        ', ' +
        'content: ${content})';
  }
}

extension TabPaneNodePropertyHelpers on TabPaneNode {
  bool get hasValue {
    return this.value.isNotEmpty;
  }

  bool get noValue {
    return this.value.isEmpty;
  }

  bool get hasContent {
    return this.content.isNotEmpty;
  }

  bool get noContent {
    return this.content.isEmpty;
  }
}

enum TabPaneNode$ { id, value, content }

class TabPaneNodePatch extends PatchBase<TabPaneNode, TabPaneNode$> {
  TabPaneNode applyTo(TabPaneNode entity) {
    return entity.patchWithTabPaneNode(this);
  }

  TabPaneNodePatch withId(String? value) {
    patchMap[TabPaneNode$.id] = value;
    return this;
  }

  TabPaneNodePatch withValue(String? value) {
    patchMap[TabPaneNode$.value] = value;
    return this;
  }

  TabPaneNodePatch withContent(List<ShadNode>? value) {
    patchMap[TabPaneNode$.content] = value;
    return this;
  }
}

/// Field descriptors for [TabPaneNode] query construction
abstract final class TabPaneNodeFields {
  static const id = Field<TabPaneNode, String?>('id', _$id);

  static const value = Field<TabPaneNode, String>('value', _$value);

  static const content = Field<TabPaneNode, List<ShadNode>>(
    'content',
    _$content,
  );

  static String? _$id(TabPaneNode e) {
    return e.id;
  }

  static String _$value(TabPaneNode e) {
    return e.value;
  }

  static List<ShadNode> _$content(TabPaneNode e) {
    return e.content;
  }
}

extension TabPaneNodeCompareE on TabPaneNode {
  Map<String, dynamic> compareToTabPaneNode(TabPaneNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (value != other.value) {
      diff['value'] = () => other.value;
    }

    if (content != other.content) {
      diff['content'] = () => other.content;
    }
    return diff;
  }
}

class TooltipNode implements ShadNode {
  TooltipNode({
    String? this.id,
    required String this.message,
    ShadNode? this.child,
  });

  final String? id;

  final String message;

  final ShadNode? child;

  TooltipNode copyWith({String? id, String? message, ShadNode? child}) {
    return TooltipNode(
      id: id ?? this.id,
      message: message ?? this.message,
      child: child ?? this.child,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  TooltipNode copyWithField<T>(Field<TooltipNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'message':
        return copyWith(message: value as String);
      case 'child':
        return copyWith(child: value as ShadNode?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'TooltipNode has no settable field with this name',
        );
    }
  }

  TooltipNode copyWithTooltipNode({
    String? id,
    String? message,
    ShadNode? child,
  }) {
    return copyWith(id: id, message: message, child: child);
  }

  TooltipNode patchWithTooltipNode([TooltipNodePatch? patchInput]) {
    final _patcher = patchInput ?? TooltipNodePatch();
    final _patchMap = _patcher.patchMap;
    return TooltipNode(
      id: _patchMap.containsKey(TooltipNode$.id)
          ? ((_patchMap[TooltipNode$.id] is Function)
                    ? _patchMap[TooltipNode$.id](this.id)
                    : (_patchMap[TooltipNode$.id] is Patch)
                    ? _patchMap[TooltipNode$.id].applyTo(this.id)
                    : _patchMap[TooltipNode$.id])
                as String?
          : this.id,
      message: _patchMap.containsKey(TooltipNode$.message)
          ? ((_patchMap[TooltipNode$.message] is Function)
                    ? _patchMap[TooltipNode$.message](this.message)
                    : (_patchMap[TooltipNode$.message] is Patch)
                    ? _patchMap[TooltipNode$.message].applyTo(this.message)
                    : _patchMap[TooltipNode$.message])
                as String
          : this.message,
      child: _patchMap.containsKey(TooltipNode$.child)
          ? ((_patchMap[TooltipNode$.child] is Function)
                    ? _patchMap[TooltipNode$.child](this.child)
                    : (_patchMap[TooltipNode$.child] is Patch)
                    ? _patchMap[TooltipNode$.child].applyTo(this.child)
                    : _patchMap[TooltipNode$.child])
                as ShadNode?
          : this.child,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TooltipNode &&
        id == other.id &&
        message == other.message &&
        child == other.child;
  }

  @override
  int get hashCode {
    return Object.hash(this.id, this.message, this.child);
  }

  @override
  String toString() {
    return 'TooltipNode(' +
        'id: ${id}' +
        ', ' +
        'message: ${message}' +
        ', ' +
        'child: ${child})';
  }
}

extension TooltipNodePropertyHelpers on TooltipNode {
  bool get hasMessage {
    return this.message.isNotEmpty;
  }

  bool get noMessage {
    return this.message.isEmpty;
  }

  bool get hasChild {
    return this.child != null;
  }

  bool get noChild {
    return this.child == null;
  }

  ShadNode get childRequired {
    return this.child ?? (throw StateError('child is required but was null'));
  }
}

enum TooltipNode$ { id, message, child }

class TooltipNodePatch extends PatchBase<TooltipNode, TooltipNode$> {
  TooltipNode applyTo(TooltipNode entity) {
    return entity.patchWithTooltipNode(this);
  }

  TooltipNodePatch withId(String? value) {
    patchMap[TooltipNode$.id] = value;
    return this;
  }

  TooltipNodePatch withMessage(String? value) {
    patchMap[TooltipNode$.message] = value;
    return this;
  }

  TooltipNodePatch withChild(ShadNode? value) {
    patchMap[TooltipNode$.child] = value;
    return this;
  }
}

/// Field descriptors for [TooltipNode] query construction
abstract final class TooltipNodeFields {
  static const id = Field<TooltipNode, String?>('id', _$id);

  static const message = Field<TooltipNode, String>('message', _$message);

  static const child = Field<TooltipNode, ShadNode?>('child', _$child);

  static String? _$id(TooltipNode e) {
    return e.id;
  }

  static String _$message(TooltipNode e) {
    return e.message;
  }

  static ShadNode? _$child(TooltipNode e) {
    return e.child;
  }
}

extension TooltipNodeCompareE on TooltipNode {
  Map<String, dynamic> compareToTooltipNode(TooltipNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (message != other.message) {
      diff['message'] = () => other.message;
    }

    if (child != other.child) {
      diff['child'] = () => other.child;
    }
    return diff;
  }
}

class SheetNode implements ShadNode {
  SheetNode({
    String? this.id,
    String? this.side,
    String? this.title,
    String? this.description,
    bool? this.open,
    required List<ShadNode> this.content,
    ShadNode? this.trigger,
    ActionId? this.action,
  });

  final String? id;

  final String? side;

  final String? title;

  final String? description;

  final bool? open;

  final List<ShadNode> content;

  final ShadNode? trigger;

  final ActionId? action;

  SheetNode copyWith({
    String? id,
    String? side,
    String? title,
    String? description,
    bool? open,
    List<ShadNode>? content,
    ShadNode? trigger,
    ActionId? action,
  }) {
    return SheetNode(
      id: id ?? this.id,
      side: side ?? this.side,
      title: title ?? this.title,
      description: description ?? this.description,
      open: open ?? this.open,
      content: content ?? this.content,
      trigger: trigger ?? this.trigger,
      action: action ?? this.action,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  SheetNode copyWithField<T>(Field<SheetNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'side':
        return copyWith(side: value as String?);
      case 'title':
        return copyWith(title: value as String?);
      case 'description':
        return copyWith(description: value as String?);
      case 'open':
        return copyWith(open: value as bool?);
      case 'content':
        return copyWith(content: value as List<ShadNode>);
      case 'trigger':
        return copyWith(trigger: value as ShadNode?);
      case 'action':
        return copyWith(action: value as ActionId?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'SheetNode has no settable field with this name',
        );
    }
  }

  SheetNode copyWithSheetNode({
    String? id,
    String? side,
    String? title,
    String? description,
    bool? open,
    List<ShadNode>? content,
    ShadNode? trigger,
    ActionId? action,
  }) {
    return copyWith(
      id: id,
      side: side,
      title: title,
      description: description,
      open: open,
      content: content,
      trigger: trigger,
      action: action,
    );
  }

  SheetNode patchWithSheetNode([SheetNodePatch? patchInput]) {
    final _patcher = patchInput ?? SheetNodePatch();
    final _patchMap = _patcher.patchMap;
    return SheetNode(
      id: _patchMap.containsKey(SheetNode$.id)
          ? ((_patchMap[SheetNode$.id] is Function)
                    ? _patchMap[SheetNode$.id](this.id)
                    : (_patchMap[SheetNode$.id] is Patch)
                    ? _patchMap[SheetNode$.id].applyTo(this.id)
                    : _patchMap[SheetNode$.id])
                as String?
          : this.id,
      side: _patchMap.containsKey(SheetNode$.side)
          ? ((_patchMap[SheetNode$.side] is Function)
                    ? _patchMap[SheetNode$.side](this.side)
                    : (_patchMap[SheetNode$.side] is Patch)
                    ? _patchMap[SheetNode$.side].applyTo(this.side)
                    : _patchMap[SheetNode$.side])
                as String?
          : this.side,
      title: _patchMap.containsKey(SheetNode$.title)
          ? ((_patchMap[SheetNode$.title] is Function)
                    ? _patchMap[SheetNode$.title](this.title)
                    : (_patchMap[SheetNode$.title] is Patch)
                    ? _patchMap[SheetNode$.title].applyTo(this.title)
                    : _patchMap[SheetNode$.title])
                as String?
          : this.title,
      description: _patchMap.containsKey(SheetNode$.description)
          ? ((_patchMap[SheetNode$.description] is Function)
                    ? _patchMap[SheetNode$.description](this.description)
                    : (_patchMap[SheetNode$.description] is Patch)
                    ? _patchMap[SheetNode$.description].applyTo(
                        this.description,
                      )
                    : _patchMap[SheetNode$.description])
                as String?
          : this.description,
      open: _patchMap.containsKey(SheetNode$.open)
          ? ((_patchMap[SheetNode$.open] is Function)
                    ? _patchMap[SheetNode$.open](this.open)
                    : (_patchMap[SheetNode$.open] is Patch)
                    ? _patchMap[SheetNode$.open].applyTo(this.open)
                    : _patchMap[SheetNode$.open])
                as bool?
          : this.open,
      content: _patchMap.containsKey(SheetNode$.content)
          ? ((_patchMap[SheetNode$.content] is Function)
                    ? _patchMap[SheetNode$.content](this.content)
                    : (_patchMap[SheetNode$.content] is Patch)
                    ? _patchMap[SheetNode$.content].applyTo(this.content)
                    : _patchMap[SheetNode$.content])
                as List<ShadNode>
          : this.content,
      trigger: _patchMap.containsKey(SheetNode$.trigger)
          ? ((_patchMap[SheetNode$.trigger] is Function)
                    ? _patchMap[SheetNode$.trigger](this.trigger)
                    : (_patchMap[SheetNode$.trigger] is Patch)
                    ? _patchMap[SheetNode$.trigger].applyTo(this.trigger)
                    : _patchMap[SheetNode$.trigger])
                as ShadNode?
          : this.trigger,
      action: _patchMap.containsKey(SheetNode$.action)
          ? ((_patchMap[SheetNode$.action] is Function)
                    ? _patchMap[SheetNode$.action](this.action)
                    : (_patchMap[SheetNode$.action] is Patch)
                    ? _patchMap[SheetNode$.action].applyTo(this.action)
                    : _patchMap[SheetNode$.action])
                as ActionId?
          : this.action,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SheetNode &&
        id == other.id &&
        side == other.side &&
        title == other.title &&
        description == other.description &&
        open == other.open &&
        content == other.content &&
        trigger == other.trigger &&
        action == other.action;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.side,
      this.title,
      this.description,
      this.open,
      this.content,
      this.trigger,
      this.action,
    );
  }

  @override
  String toString() {
    return 'SheetNode(' +
        'id: ${id}' +
        ', ' +
        'side: ${side}' +
        ', ' +
        'title: ${title}' +
        ', ' +
        'description: ${description}' +
        ', ' +
        'open: ${open}' +
        ', ' +
        'content: ${content}' +
        ', ' +
        'trigger: ${trigger}' +
        ', ' +
        'action: ${action})';
  }
}

extension SheetNodePropertyHelpers on SheetNode {
  bool get hasSide {
    return this.side?.isNotEmpty == true;
  }

  bool get noSide {
    return this.side?.isEmpty ?? true;
  }

  String get sideRequired {
    return this.side ?? (throw StateError('side is required but was null'));
  }

  bool get hasTitle {
    return this.title?.isNotEmpty == true;
  }

  bool get noTitle {
    return this.title?.isEmpty ?? true;
  }

  String get titleRequired {
    return this.title ?? (throw StateError('title is required but was null'));
  }

  bool get hasDescription {
    return this.description?.isNotEmpty == true;
  }

  bool get noDescription {
    return this.description?.isEmpty ?? true;
  }

  String get descriptionRequired {
    return this.description ??
        (throw StateError('description is required but was null'));
  }

  bool get hasOpen {
    return this.open != null;
  }

  bool get noOpen {
    return this.open == null;
  }

  bool get openRequired {
    return this.open ?? (throw StateError('open is required but was null'));
  }

  bool get hasContent {
    return this.content.isNotEmpty;
  }

  bool get noContent {
    return this.content.isEmpty;
  }

  bool get hasTrigger {
    return this.trigger != null;
  }

  bool get noTrigger {
    return this.trigger == null;
  }

  ShadNode get triggerRequired {
    return this.trigger ??
        (throw StateError('trigger is required but was null'));
  }

  bool get hasAction {
    return this.action != null;
  }

  bool get noAction {
    return this.action == null;
  }

  ActionId get actionRequired {
    return this.action ?? (throw StateError('action is required but was null'));
  }
}

enum SheetNode$ { id, side, title, description, open, content, trigger, action }

class SheetNodePatch extends PatchBase<SheetNode, SheetNode$> {
  SheetNode applyTo(SheetNode entity) {
    return entity.patchWithSheetNode(this);
  }

  SheetNodePatch withId(String? value) {
    patchMap[SheetNode$.id] = value;
    return this;
  }

  SheetNodePatch withSide(String? value) {
    patchMap[SheetNode$.side] = value;
    return this;
  }

  SheetNodePatch withTitle(String? value) {
    patchMap[SheetNode$.title] = value;
    return this;
  }

  SheetNodePatch withDescription(String? value) {
    patchMap[SheetNode$.description] = value;
    return this;
  }

  SheetNodePatch withOpen(bool? value) {
    patchMap[SheetNode$.open] = value;
    return this;
  }

  SheetNodePatch withContent(List<ShadNode>? value) {
    patchMap[SheetNode$.content] = value;
    return this;
  }

  SheetNodePatch withTrigger(ShadNode? value) {
    patchMap[SheetNode$.trigger] = value;
    return this;
  }

  SheetNodePatch withAction(ActionId? value) {
    patchMap[SheetNode$.action] = value;
    return this;
  }
}

/// Field descriptors for [SheetNode] query construction
abstract final class SheetNodeFields {
  static const id = Field<SheetNode, String?>('id', _$id);

  static const side = Field<SheetNode, String?>('side', _$side);

  static const title = Field<SheetNode, String?>('title', _$title);

  static const description = Field<SheetNode, String?>(
    'description',
    _$description,
  );

  static const open = Field<SheetNode, bool?>('open', _$open);

  static const content = Field<SheetNode, List<ShadNode>>('content', _$content);

  static const trigger = Field<SheetNode, ShadNode?>('trigger', _$trigger);

  static const action = Field<SheetNode, ActionId?>('action', _$action);

  static String? _$id(SheetNode e) {
    return e.id;
  }

  static String? _$side(SheetNode e) {
    return e.side;
  }

  static String? _$title(SheetNode e) {
    return e.title;
  }

  static String? _$description(SheetNode e) {
    return e.description;
  }

  static bool? _$open(SheetNode e) {
    return e.open;
  }

  static List<ShadNode> _$content(SheetNode e) {
    return e.content;
  }

  static ShadNode? _$trigger(SheetNode e) {
    return e.trigger;
  }

  static ActionId? _$action(SheetNode e) {
    return e.action;
  }
}

extension SheetNodeCompareE on SheetNode {
  Map<String, dynamic> compareToSheetNode(SheetNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (side != other.side) {
      diff['side'] = () => other.side;
    }

    if (title != other.title) {
      diff['title'] = () => other.title;
    }

    if (description != other.description) {
      diff['description'] = () => other.description;
    }

    if (open != other.open) {
      diff['open'] = () => other.open;
    }

    if (content != other.content) {
      diff['content'] = () => other.content;
    }

    if (trigger != other.trigger) {
      diff['trigger'] = () => other.trigger;
    }

    if (action != other.action) {
      diff['action'] = () => other.action;
    }
    return diff;
  }
}

class DialogNode implements ShadNode {
  DialogNode({
    String? this.id,
    String? this.title,
    String? this.description,
    bool? this.open,
    required List<ButtonNode> this.actions,
    required List<ShadNode> this.content,
    ShadNode? this.trigger,
    ActionId? this.action,
  });

  final String? id;

  final String? title;

  final String? description;

  final bool? open;

  final List<ButtonNode> actions;

  final List<ShadNode> content;

  final ShadNode? trigger;

  final ActionId? action;

  DialogNode copyWith({
    String? id,
    String? title,
    String? description,
    bool? open,
    List<ButtonNode>? actions,
    List<ShadNode>? content,
    ShadNode? trigger,
    ActionId? action,
  }) {
    return DialogNode(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      open: open ?? this.open,
      actions: actions ?? this.actions,
      content: content ?? this.content,
      trigger: trigger ?? this.trigger,
      action: action ?? this.action,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  DialogNode copyWithField<T>(Field<DialogNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'title':
        return copyWith(title: value as String?);
      case 'description':
        return copyWith(description: value as String?);
      case 'open':
        return copyWith(open: value as bool?);
      case 'actions':
        return copyWith(actions: value as List<ButtonNode>);
      case 'content':
        return copyWith(content: value as List<ShadNode>);
      case 'trigger':
        return copyWith(trigger: value as ShadNode?);
      case 'action':
        return copyWith(action: value as ActionId?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'DialogNode has no settable field with this name',
        );
    }
  }

  DialogNode copyWithDialogNode({
    String? id,
    String? title,
    String? description,
    bool? open,
    List<ButtonNode>? actions,
    List<ShadNode>? content,
    ShadNode? trigger,
    ActionId? action,
  }) {
    return copyWith(
      id: id,
      title: title,
      description: description,
      open: open,
      actions: actions,
      content: content,
      trigger: trigger,
      action: action,
    );
  }

  DialogNode patchWithDialogNode([DialogNodePatch? patchInput]) {
    final _patcher = patchInput ?? DialogNodePatch();
    final _patchMap = _patcher.patchMap;
    return DialogNode(
      id: _patchMap.containsKey(DialogNode$.id)
          ? ((_patchMap[DialogNode$.id] is Function)
                    ? _patchMap[DialogNode$.id](this.id)
                    : (_patchMap[DialogNode$.id] is Patch)
                    ? _patchMap[DialogNode$.id].applyTo(this.id)
                    : _patchMap[DialogNode$.id])
                as String?
          : this.id,
      title: _patchMap.containsKey(DialogNode$.title)
          ? ((_patchMap[DialogNode$.title] is Function)
                    ? _patchMap[DialogNode$.title](this.title)
                    : (_patchMap[DialogNode$.title] is Patch)
                    ? _patchMap[DialogNode$.title].applyTo(this.title)
                    : _patchMap[DialogNode$.title])
                as String?
          : this.title,
      description: _patchMap.containsKey(DialogNode$.description)
          ? ((_patchMap[DialogNode$.description] is Function)
                    ? _patchMap[DialogNode$.description](this.description)
                    : (_patchMap[DialogNode$.description] is Patch)
                    ? _patchMap[DialogNode$.description].applyTo(
                        this.description,
                      )
                    : _patchMap[DialogNode$.description])
                as String?
          : this.description,
      open: _patchMap.containsKey(DialogNode$.open)
          ? ((_patchMap[DialogNode$.open] is Function)
                    ? _patchMap[DialogNode$.open](this.open)
                    : (_patchMap[DialogNode$.open] is Patch)
                    ? _patchMap[DialogNode$.open].applyTo(this.open)
                    : _patchMap[DialogNode$.open])
                as bool?
          : this.open,
      actions: _patchMap.containsKey(DialogNode$.actions)
          ? ((_patchMap[DialogNode$.actions] is Function)
                    ? _patchMap[DialogNode$.actions](this.actions)
                    : (_patchMap[DialogNode$.actions] is Patch)
                    ? _patchMap[DialogNode$.actions].applyTo(this.actions)
                    : _patchMap[DialogNode$.actions])
                as List<ButtonNode>
          : this.actions,
      content: _patchMap.containsKey(DialogNode$.content)
          ? ((_patchMap[DialogNode$.content] is Function)
                    ? _patchMap[DialogNode$.content](this.content)
                    : (_patchMap[DialogNode$.content] is Patch)
                    ? _patchMap[DialogNode$.content].applyTo(this.content)
                    : _patchMap[DialogNode$.content])
                as List<ShadNode>
          : this.content,
      trigger: _patchMap.containsKey(DialogNode$.trigger)
          ? ((_patchMap[DialogNode$.trigger] is Function)
                    ? _patchMap[DialogNode$.trigger](this.trigger)
                    : (_patchMap[DialogNode$.trigger] is Patch)
                    ? _patchMap[DialogNode$.trigger].applyTo(this.trigger)
                    : _patchMap[DialogNode$.trigger])
                as ShadNode?
          : this.trigger,
      action: _patchMap.containsKey(DialogNode$.action)
          ? ((_patchMap[DialogNode$.action] is Function)
                    ? _patchMap[DialogNode$.action](this.action)
                    : (_patchMap[DialogNode$.action] is Patch)
                    ? _patchMap[DialogNode$.action].applyTo(this.action)
                    : _patchMap[DialogNode$.action])
                as ActionId?
          : this.action,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DialogNode &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        open == other.open &&
        actions == other.actions &&
        content == other.content &&
        trigger == other.trigger &&
        action == other.action;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.title,
      this.description,
      this.open,
      this.actions,
      this.content,
      this.trigger,
      this.action,
    );
  }

  @override
  String toString() {
    return 'DialogNode(' +
        'id: ${id}' +
        ', ' +
        'title: ${title}' +
        ', ' +
        'description: ${description}' +
        ', ' +
        'open: ${open}' +
        ', ' +
        'actions: ${actions}' +
        ', ' +
        'content: ${content}' +
        ', ' +
        'trigger: ${trigger}' +
        ', ' +
        'action: ${action})';
  }
}

extension DialogNodePropertyHelpers on DialogNode {
  bool get hasTitle {
    return this.title?.isNotEmpty == true;
  }

  bool get noTitle {
    return this.title?.isEmpty ?? true;
  }

  String get titleRequired {
    return this.title ?? (throw StateError('title is required but was null'));
  }

  bool get hasDescription {
    return this.description?.isNotEmpty == true;
  }

  bool get noDescription {
    return this.description?.isEmpty ?? true;
  }

  String get descriptionRequired {
    return this.description ??
        (throw StateError('description is required but was null'));
  }

  bool get hasOpen {
    return this.open != null;
  }

  bool get noOpen {
    return this.open == null;
  }

  bool get openRequired {
    return this.open ?? (throw StateError('open is required but was null'));
  }

  bool get hasActions {
    return this.actions.isNotEmpty;
  }

  bool get noActions {
    return this.actions.isEmpty;
  }

  bool get hasContent {
    return this.content.isNotEmpty;
  }

  bool get noContent {
    return this.content.isEmpty;
  }

  bool get hasTrigger {
    return this.trigger != null;
  }

  bool get noTrigger {
    return this.trigger == null;
  }

  ShadNode get triggerRequired {
    return this.trigger ??
        (throw StateError('trigger is required but was null'));
  }

  bool get hasAction {
    return this.action != null;
  }

  bool get noAction {
    return this.action == null;
  }

  ActionId get actionRequired {
    return this.action ?? (throw StateError('action is required but was null'));
  }
}

enum DialogNode$ {
  id,
  title,
  description,
  open,
  actions,
  content,
  trigger,
  action,
}

class DialogNodePatch extends PatchBase<DialogNode, DialogNode$> {
  DialogNode applyTo(DialogNode entity) {
    return entity.patchWithDialogNode(this);
  }

  DialogNodePatch withId(String? value) {
    patchMap[DialogNode$.id] = value;
    return this;
  }

  DialogNodePatch withTitle(String? value) {
    patchMap[DialogNode$.title] = value;
    return this;
  }

  DialogNodePatch withDescription(String? value) {
    patchMap[DialogNode$.description] = value;
    return this;
  }

  DialogNodePatch withOpen(bool? value) {
    patchMap[DialogNode$.open] = value;
    return this;
  }

  DialogNodePatch withActions(List<ButtonNode>? value) {
    patchMap[DialogNode$.actions] = value;
    return this;
  }

  DialogNodePatch updateActionsAt(
    int index,
    ButtonNodePatch Function(ButtonNodePatch) patch,
  ) {
    patchMap[DialogNode$.actions] = (List<dynamic> list) {
      var updatedList = List<ButtonNode>.from(list);
      if (index >= 0 && index < updatedList.length) {
        updatedList[index] = patch(
          ButtonNodePatch(),
        ).applyTo(updatedList[index] as ButtonNode);
      }
      return updatedList;
    };
    return this;
  }

  DialogNodePatch withContent(List<ShadNode>? value) {
    patchMap[DialogNode$.content] = value;
    return this;
  }

  DialogNodePatch withTrigger(ShadNode? value) {
    patchMap[DialogNode$.trigger] = value;
    return this;
  }

  DialogNodePatch withAction(ActionId? value) {
    patchMap[DialogNode$.action] = value;
    return this;
  }
}

/// Field descriptors for [DialogNode] query construction
abstract final class DialogNodeFields {
  static const id = Field<DialogNode, String?>('id', _$id);

  static const title = Field<DialogNode, String?>('title', _$title);

  static const description = Field<DialogNode, String?>(
    'description',
    _$description,
  );

  static const open = Field<DialogNode, bool?>('open', _$open);

  static const actions = Field<DialogNode, List<ButtonNode>>(
    'actions',
    _$actions,
  );

  static const content = Field<DialogNode, List<ShadNode>>(
    'content',
    _$content,
  );

  static const trigger = Field<DialogNode, ShadNode?>('trigger', _$trigger);

  static const action = Field<DialogNode, ActionId?>('action', _$action);

  static String? _$id(DialogNode e) {
    return e.id;
  }

  static String? _$title(DialogNode e) {
    return e.title;
  }

  static String? _$description(DialogNode e) {
    return e.description;
  }

  static bool? _$open(DialogNode e) {
    return e.open;
  }

  static List<ButtonNode> _$actions(DialogNode e) {
    return e.actions;
  }

  static List<ShadNode> _$content(DialogNode e) {
    return e.content;
  }

  static ShadNode? _$trigger(DialogNode e) {
    return e.trigger;
  }

  static ActionId? _$action(DialogNode e) {
    return e.action;
  }
}

extension DialogNodeCompareE on DialogNode {
  Map<String, dynamic> compareToDialogNode(DialogNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (title != other.title) {
      diff['title'] = () => other.title;
    }

    if (description != other.description) {
      diff['description'] = () => other.description;
    }

    if (open != other.open) {
      diff['open'] = () => other.open;
    }

    if (actions != other.actions) {
      diff['actions'] = () => other.actions;
    }

    if (content != other.content) {
      diff['content'] = () => other.content;
    }

    if (trigger != other.trigger) {
      diff['trigger'] = () => other.trigger;
    }

    if (action != other.action) {
      diff['action'] = () => other.action;
    }
    return diff;
  }
}

class PopoverNode implements ShadNode {
  PopoverNode({
    String? this.id,
    bool? this.open,
    required List<ShadNode> this.content,
    ShadNode? this.trigger,
    ActionId? this.action,
  });

  final String? id;

  final bool? open;

  final List<ShadNode> content;

  final ShadNode? trigger;

  final ActionId? action;

  PopoverNode copyWith({
    String? id,
    bool? open,
    List<ShadNode>? content,
    ShadNode? trigger,
    ActionId? action,
  }) {
    return PopoverNode(
      id: id ?? this.id,
      open: open ?? this.open,
      content: content ?? this.content,
      trigger: trigger ?? this.trigger,
      action: action ?? this.action,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  PopoverNode copyWithField<T>(Field<PopoverNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'open':
        return copyWith(open: value as bool?);
      case 'content':
        return copyWith(content: value as List<ShadNode>);
      case 'trigger':
        return copyWith(trigger: value as ShadNode?);
      case 'action':
        return copyWith(action: value as ActionId?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'PopoverNode has no settable field with this name',
        );
    }
  }

  PopoverNode copyWithPopoverNode({
    String? id,
    bool? open,
    List<ShadNode>? content,
    ShadNode? trigger,
    ActionId? action,
  }) {
    return copyWith(
      id: id,
      open: open,
      content: content,
      trigger: trigger,
      action: action,
    );
  }

  PopoverNode patchWithPopoverNode([PopoverNodePatch? patchInput]) {
    final _patcher = patchInput ?? PopoverNodePatch();
    final _patchMap = _patcher.patchMap;
    return PopoverNode(
      id: _patchMap.containsKey(PopoverNode$.id)
          ? ((_patchMap[PopoverNode$.id] is Function)
                    ? _patchMap[PopoverNode$.id](this.id)
                    : (_patchMap[PopoverNode$.id] is Patch)
                    ? _patchMap[PopoverNode$.id].applyTo(this.id)
                    : _patchMap[PopoverNode$.id])
                as String?
          : this.id,
      open: _patchMap.containsKey(PopoverNode$.open)
          ? ((_patchMap[PopoverNode$.open] is Function)
                    ? _patchMap[PopoverNode$.open](this.open)
                    : (_patchMap[PopoverNode$.open] is Patch)
                    ? _patchMap[PopoverNode$.open].applyTo(this.open)
                    : _patchMap[PopoverNode$.open])
                as bool?
          : this.open,
      content: _patchMap.containsKey(PopoverNode$.content)
          ? ((_patchMap[PopoverNode$.content] is Function)
                    ? _patchMap[PopoverNode$.content](this.content)
                    : (_patchMap[PopoverNode$.content] is Patch)
                    ? _patchMap[PopoverNode$.content].applyTo(this.content)
                    : _patchMap[PopoverNode$.content])
                as List<ShadNode>
          : this.content,
      trigger: _patchMap.containsKey(PopoverNode$.trigger)
          ? ((_patchMap[PopoverNode$.trigger] is Function)
                    ? _patchMap[PopoverNode$.trigger](this.trigger)
                    : (_patchMap[PopoverNode$.trigger] is Patch)
                    ? _patchMap[PopoverNode$.trigger].applyTo(this.trigger)
                    : _patchMap[PopoverNode$.trigger])
                as ShadNode?
          : this.trigger,
      action: _patchMap.containsKey(PopoverNode$.action)
          ? ((_patchMap[PopoverNode$.action] is Function)
                    ? _patchMap[PopoverNode$.action](this.action)
                    : (_patchMap[PopoverNode$.action] is Patch)
                    ? _patchMap[PopoverNode$.action].applyTo(this.action)
                    : _patchMap[PopoverNode$.action])
                as ActionId?
          : this.action,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PopoverNode &&
        id == other.id &&
        open == other.open &&
        content == other.content &&
        trigger == other.trigger &&
        action == other.action;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.open,
      this.content,
      this.trigger,
      this.action,
    );
  }

  @override
  String toString() {
    return 'PopoverNode(' +
        'id: ${id}' +
        ', ' +
        'open: ${open}' +
        ', ' +
        'content: ${content}' +
        ', ' +
        'trigger: ${trigger}' +
        ', ' +
        'action: ${action})';
  }
}

extension PopoverNodePropertyHelpers on PopoverNode {
  bool get hasOpen {
    return this.open != null;
  }

  bool get noOpen {
    return this.open == null;
  }

  bool get openRequired {
    return this.open ?? (throw StateError('open is required but was null'));
  }

  bool get hasContent {
    return this.content.isNotEmpty;
  }

  bool get noContent {
    return this.content.isEmpty;
  }

  bool get hasTrigger {
    return this.trigger != null;
  }

  bool get noTrigger {
    return this.trigger == null;
  }

  ShadNode get triggerRequired {
    return this.trigger ??
        (throw StateError('trigger is required but was null'));
  }

  bool get hasAction {
    return this.action != null;
  }

  bool get noAction {
    return this.action == null;
  }

  ActionId get actionRequired {
    return this.action ?? (throw StateError('action is required but was null'));
  }
}

enum PopoverNode$ { id, open, content, trigger, action }

class PopoverNodePatch extends PatchBase<PopoverNode, PopoverNode$> {
  PopoverNode applyTo(PopoverNode entity) {
    return entity.patchWithPopoverNode(this);
  }

  PopoverNodePatch withId(String? value) {
    patchMap[PopoverNode$.id] = value;
    return this;
  }

  PopoverNodePatch withOpen(bool? value) {
    patchMap[PopoverNode$.open] = value;
    return this;
  }

  PopoverNodePatch withContent(List<ShadNode>? value) {
    patchMap[PopoverNode$.content] = value;
    return this;
  }

  PopoverNodePatch withTrigger(ShadNode? value) {
    patchMap[PopoverNode$.trigger] = value;
    return this;
  }

  PopoverNodePatch withAction(ActionId? value) {
    patchMap[PopoverNode$.action] = value;
    return this;
  }
}

/// Field descriptors for [PopoverNode] query construction
abstract final class PopoverNodeFields {
  static const id = Field<PopoverNode, String?>('id', _$id);

  static const open = Field<PopoverNode, bool?>('open', _$open);

  static const content = Field<PopoverNode, List<ShadNode>>(
    'content',
    _$content,
  );

  static const trigger = Field<PopoverNode, ShadNode?>('trigger', _$trigger);

  static const action = Field<PopoverNode, ActionId?>('action', _$action);

  static String? _$id(PopoverNode e) {
    return e.id;
  }

  static bool? _$open(PopoverNode e) {
    return e.open;
  }

  static List<ShadNode> _$content(PopoverNode e) {
    return e.content;
  }

  static ShadNode? _$trigger(PopoverNode e) {
    return e.trigger;
  }

  static ActionId? _$action(PopoverNode e) {
    return e.action;
  }
}

extension PopoverNodeCompareE on PopoverNode {
  Map<String, dynamic> compareToPopoverNode(PopoverNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (open != other.open) {
      diff['open'] = () => other.open;
    }

    if (content != other.content) {
      diff['content'] = () => other.content;
    }

    if (trigger != other.trigger) {
      diff['trigger'] = () => other.trigger;
    }

    if (action != other.action) {
      diff['action'] = () => other.action;
    }
    return diff;
  }
}

class ToastNode implements ShadNode {
  ToastNode({
    String? this.id,
    required String this.title,
    String? this.description,
    String? this.variant,
    ActionId? this.action,
  });

  final String? id;

  final String title;

  final String? description;

  final String? variant;

  final ActionId? action;

  ToastNode copyWith({
    String? id,
    String? title,
    String? description,
    String? variant,
    ActionId? action,
  }) {
    return ToastNode(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      variant: variant ?? this.variant,
      action: action ?? this.action,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  ToastNode copyWithField<T>(Field<ToastNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'title':
        return copyWith(title: value as String);
      case 'description':
        return copyWith(description: value as String?);
      case 'variant':
        return copyWith(variant: value as String?);
      case 'action':
        return copyWith(action: value as ActionId?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'ToastNode has no settable field with this name',
        );
    }
  }

  ToastNode copyWithToastNode({
    String? id,
    String? title,
    String? description,
    String? variant,
    ActionId? action,
  }) {
    return copyWith(
      id: id,
      title: title,
      description: description,
      variant: variant,
      action: action,
    );
  }

  ToastNode patchWithToastNode([ToastNodePatch? patchInput]) {
    final _patcher = patchInput ?? ToastNodePatch();
    final _patchMap = _patcher.patchMap;
    return ToastNode(
      id: _patchMap.containsKey(ToastNode$.id)
          ? ((_patchMap[ToastNode$.id] is Function)
                    ? _patchMap[ToastNode$.id](this.id)
                    : (_patchMap[ToastNode$.id] is Patch)
                    ? _patchMap[ToastNode$.id].applyTo(this.id)
                    : _patchMap[ToastNode$.id])
                as String?
          : this.id,
      title: _patchMap.containsKey(ToastNode$.title)
          ? ((_patchMap[ToastNode$.title] is Function)
                    ? _patchMap[ToastNode$.title](this.title)
                    : (_patchMap[ToastNode$.title] is Patch)
                    ? _patchMap[ToastNode$.title].applyTo(this.title)
                    : _patchMap[ToastNode$.title])
                as String
          : this.title,
      description: _patchMap.containsKey(ToastNode$.description)
          ? ((_patchMap[ToastNode$.description] is Function)
                    ? _patchMap[ToastNode$.description](this.description)
                    : (_patchMap[ToastNode$.description] is Patch)
                    ? _patchMap[ToastNode$.description].applyTo(
                        this.description,
                      )
                    : _patchMap[ToastNode$.description])
                as String?
          : this.description,
      variant: _patchMap.containsKey(ToastNode$.variant)
          ? ((_patchMap[ToastNode$.variant] is Function)
                    ? _patchMap[ToastNode$.variant](this.variant)
                    : (_patchMap[ToastNode$.variant] is Patch)
                    ? _patchMap[ToastNode$.variant].applyTo(this.variant)
                    : _patchMap[ToastNode$.variant])
                as String?
          : this.variant,
      action: _patchMap.containsKey(ToastNode$.action)
          ? ((_patchMap[ToastNode$.action] is Function)
                    ? _patchMap[ToastNode$.action](this.action)
                    : (_patchMap[ToastNode$.action] is Patch)
                    ? _patchMap[ToastNode$.action].applyTo(this.action)
                    : _patchMap[ToastNode$.action])
                as ActionId?
          : this.action,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ToastNode &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        variant == other.variant &&
        action == other.action;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.title,
      this.description,
      this.variant,
      this.action,
    );
  }

  @override
  String toString() {
    return 'ToastNode(' +
        'id: ${id}' +
        ', ' +
        'title: ${title}' +
        ', ' +
        'description: ${description}' +
        ', ' +
        'variant: ${variant}' +
        ', ' +
        'action: ${action})';
  }
}

extension ToastNodePropertyHelpers on ToastNode {
  bool get hasTitle {
    return this.title.isNotEmpty;
  }

  bool get noTitle {
    return this.title.isEmpty;
  }

  bool get hasDescription {
    return this.description?.isNotEmpty == true;
  }

  bool get noDescription {
    return this.description?.isEmpty ?? true;
  }

  String get descriptionRequired {
    return this.description ??
        (throw StateError('description is required but was null'));
  }

  bool get hasVariant {
    return this.variant?.isNotEmpty == true;
  }

  bool get noVariant {
    return this.variant?.isEmpty ?? true;
  }

  String get variantRequired {
    return this.variant ??
        (throw StateError('variant is required but was null'));
  }

  bool get hasAction {
    return this.action != null;
  }

  bool get noAction {
    return this.action == null;
  }

  ActionId get actionRequired {
    return this.action ?? (throw StateError('action is required but was null'));
  }
}

enum ToastNode$ { id, title, description, variant, action }

class ToastNodePatch extends PatchBase<ToastNode, ToastNode$> {
  ToastNode applyTo(ToastNode entity) {
    return entity.patchWithToastNode(this);
  }

  ToastNodePatch withId(String? value) {
    patchMap[ToastNode$.id] = value;
    return this;
  }

  ToastNodePatch withTitle(String? value) {
    patchMap[ToastNode$.title] = value;
    return this;
  }

  ToastNodePatch withDescription(String? value) {
    patchMap[ToastNode$.description] = value;
    return this;
  }

  ToastNodePatch withVariant(String? value) {
    patchMap[ToastNode$.variant] = value;
    return this;
  }

  ToastNodePatch withAction(ActionId? value) {
    patchMap[ToastNode$.action] = value;
    return this;
  }
}

/// Field descriptors for [ToastNode] query construction
abstract final class ToastNodeFields {
  static const id = Field<ToastNode, String?>('id', _$id);

  static const title = Field<ToastNode, String>('title', _$title);

  static const description = Field<ToastNode, String?>(
    'description',
    _$description,
  );

  static const variant = Field<ToastNode, String?>('variant', _$variant);

  static const action = Field<ToastNode, ActionId?>('action', _$action);

  static String? _$id(ToastNode e) {
    return e.id;
  }

  static String _$title(ToastNode e) {
    return e.title;
  }

  static String? _$description(ToastNode e) {
    return e.description;
  }

  static String? _$variant(ToastNode e) {
    return e.variant;
  }

  static ActionId? _$action(ToastNode e) {
    return e.action;
  }
}

extension ToastNodeCompareE on ToastNode {
  Map<String, dynamic> compareToToastNode(ToastNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (title != other.title) {
      diff['title'] = () => other.title;
    }

    if (description != other.description) {
      diff['description'] = () => other.description;
    }

    if (variant != other.variant) {
      diff['variant'] = () => other.variant;
    }

    if (action != other.action) {
      diff['action'] = () => other.action;
    }
    return diff;
  }
}

class RowNode implements ShadNode {
  RowNode({
    String? this.id,
    required List<ShadNode> this.children,
    String? this.mainAxisAlignment,
    String? this.crossAxisAlignment,
    double? this.gap,
  });

  final String? id;

  final List<ShadNode> children;

  final String? mainAxisAlignment;

  final String? crossAxisAlignment;

  final double? gap;

  RowNode copyWith({
    String? id,
    List<ShadNode>? children,
    String? mainAxisAlignment,
    String? crossAxisAlignment,
    double? gap,
  }) {
    return RowNode(
      id: id ?? this.id,
      children: children ?? this.children,
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      gap: gap ?? this.gap,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  RowNode copyWithField<T>(Field<RowNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'children':
        return copyWith(children: value as List<ShadNode>);
      case 'mainAxisAlignment':
        return copyWith(mainAxisAlignment: value as String?);
      case 'crossAxisAlignment':
        return copyWith(crossAxisAlignment: value as String?);
      case 'gap':
        return copyWith(gap: value as double?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'RowNode has no settable field with this name',
        );
    }
  }

  RowNode copyWithRowNode({
    String? id,
    List<ShadNode>? children,
    String? mainAxisAlignment,
    String? crossAxisAlignment,
    double? gap,
  }) {
    return copyWith(
      id: id,
      children: children,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      gap: gap,
    );
  }

  RowNode patchWithRowNode([RowNodePatch? patchInput]) {
    final _patcher = patchInput ?? RowNodePatch();
    final _patchMap = _patcher.patchMap;
    return RowNode(
      id: _patchMap.containsKey(RowNode$.id)
          ? ((_patchMap[RowNode$.id] is Function)
                    ? _patchMap[RowNode$.id](this.id)
                    : (_patchMap[RowNode$.id] is Patch)
                    ? _patchMap[RowNode$.id].applyTo(this.id)
                    : _patchMap[RowNode$.id])
                as String?
          : this.id,
      children: _patchMap.containsKey(RowNode$.children)
          ? ((_patchMap[RowNode$.children] is Function)
                    ? _patchMap[RowNode$.children](this.children)
                    : (_patchMap[RowNode$.children] is Patch)
                    ? _patchMap[RowNode$.children].applyTo(this.children)
                    : _patchMap[RowNode$.children])
                as List<ShadNode>
          : this.children,
      mainAxisAlignment: _patchMap.containsKey(RowNode$.mainAxisAlignment)
          ? ((_patchMap[RowNode$.mainAxisAlignment] is Function)
                    ? _patchMap[RowNode$.mainAxisAlignment](
                        this.mainAxisAlignment,
                      )
                    : (_patchMap[RowNode$.mainAxisAlignment] is Patch)
                    ? _patchMap[RowNode$.mainAxisAlignment].applyTo(
                        this.mainAxisAlignment,
                      )
                    : _patchMap[RowNode$.mainAxisAlignment])
                as String?
          : this.mainAxisAlignment,
      crossAxisAlignment: _patchMap.containsKey(RowNode$.crossAxisAlignment)
          ? ((_patchMap[RowNode$.crossAxisAlignment] is Function)
                    ? _patchMap[RowNode$.crossAxisAlignment](
                        this.crossAxisAlignment,
                      )
                    : (_patchMap[RowNode$.crossAxisAlignment] is Patch)
                    ? _patchMap[RowNode$.crossAxisAlignment].applyTo(
                        this.crossAxisAlignment,
                      )
                    : _patchMap[RowNode$.crossAxisAlignment])
                as String?
          : this.crossAxisAlignment,
      gap: _patchMap.containsKey(RowNode$.gap)
          ? ((_patchMap[RowNode$.gap] is Function)
                    ? _patchMap[RowNode$.gap](this.gap)
                    : (_patchMap[RowNode$.gap] is Patch)
                    ? _patchMap[RowNode$.gap].applyTo(this.gap)
                    : _patchMap[RowNode$.gap])
                as double?
          : this.gap,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RowNode &&
        id == other.id &&
        children == other.children &&
        mainAxisAlignment == other.mainAxisAlignment &&
        crossAxisAlignment == other.crossAxisAlignment &&
        gap == other.gap;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.children,
      this.mainAxisAlignment,
      this.crossAxisAlignment,
      this.gap,
    );
  }

  @override
  String toString() {
    return 'RowNode(' +
        'id: ${id}' +
        ', ' +
        'children: ${children}' +
        ', ' +
        'mainAxisAlignment: ${mainAxisAlignment}' +
        ', ' +
        'crossAxisAlignment: ${crossAxisAlignment}' +
        ', ' +
        'gap: ${gap})';
  }
}

extension RowNodePropertyHelpers on RowNode {
  bool get hasChildren {
    return this.children.isNotEmpty;
  }

  bool get noChildren {
    return this.children.isEmpty;
  }

  bool get hasMainAxisAlignment {
    return this.mainAxisAlignment?.isNotEmpty == true;
  }

  bool get noMainAxisAlignment {
    return this.mainAxisAlignment?.isEmpty ?? true;
  }

  String get mainAxisAlignmentRequired {
    return this.mainAxisAlignment ??
        (throw StateError('mainAxisAlignment is required but was null'));
  }

  bool get hasCrossAxisAlignment {
    return this.crossAxisAlignment?.isNotEmpty == true;
  }

  bool get noCrossAxisAlignment {
    return this.crossAxisAlignment?.isEmpty ?? true;
  }

  String get crossAxisAlignmentRequired {
    return this.crossAxisAlignment ??
        (throw StateError('crossAxisAlignment is required but was null'));
  }

  bool get hasGap {
    return this.gap != null;
  }

  bool get noGap {
    return this.gap == null;
  }

  double get gapRequired {
    return this.gap ?? (throw StateError('gap is required but was null'));
  }
}

enum RowNode$ { id, children, mainAxisAlignment, crossAxisAlignment, gap }

class RowNodePatch extends PatchBase<RowNode, RowNode$> {
  RowNode applyTo(RowNode entity) {
    return entity.patchWithRowNode(this);
  }

  RowNodePatch withId(String? value) {
    patchMap[RowNode$.id] = value;
    return this;
  }

  RowNodePatch withChildren(List<ShadNode>? value) {
    patchMap[RowNode$.children] = value;
    return this;
  }

  RowNodePatch withMainAxisAlignment(String? value) {
    patchMap[RowNode$.mainAxisAlignment] = value;
    return this;
  }

  RowNodePatch withCrossAxisAlignment(String? value) {
    patchMap[RowNode$.crossAxisAlignment] = value;
    return this;
  }

  RowNodePatch withGap(double? value) {
    patchMap[RowNode$.gap] = value;
    return this;
  }
}

/// Field descriptors for [RowNode] query construction
abstract final class RowNodeFields {
  static const id = Field<RowNode, String?>('id', _$id);

  static const children = Field<RowNode, List<ShadNode>>(
    'children',
    _$children,
  );

  static const mainAxisAlignment = Field<RowNode, String?>(
    'mainAxisAlignment',
    _$mainAxisAlignment,
  );

  static const crossAxisAlignment = Field<RowNode, String?>(
    'crossAxisAlignment',
    _$crossAxisAlignment,
  );

  static const gap = Field<RowNode, double?>('gap', _$gap);

  static String? _$id(RowNode e) {
    return e.id;
  }

  static List<ShadNode> _$children(RowNode e) {
    return e.children;
  }

  static String? _$mainAxisAlignment(RowNode e) {
    return e.mainAxisAlignment;
  }

  static String? _$crossAxisAlignment(RowNode e) {
    return e.crossAxisAlignment;
  }

  static double? _$gap(RowNode e) {
    return e.gap;
  }
}

extension RowNodeCompareE on RowNode {
  Map<String, dynamic> compareToRowNode(RowNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (children != other.children) {
      diff['children'] = () => other.children;
    }

    if (mainAxisAlignment != other.mainAxisAlignment) {
      diff['mainAxisAlignment'] = () => other.mainAxisAlignment;
    }

    if (crossAxisAlignment != other.crossAxisAlignment) {
      diff['crossAxisAlignment'] = () => other.crossAxisAlignment;
    }

    if (gap != other.gap) {
      diff['gap'] = () => other.gap;
    }
    return diff;
  }
}

class ColumnNode implements ShadNode {
  ColumnNode({
    String? this.id,
    required List<ShadNode> this.children,
    String? this.mainAxisAlignment,
    String? this.crossAxisAlignment,
    double? this.gap,
  });

  final String? id;

  final List<ShadNode> children;

  final String? mainAxisAlignment;

  final String? crossAxisAlignment;

  final double? gap;

  ColumnNode copyWith({
    String? id,
    List<ShadNode>? children,
    String? mainAxisAlignment,
    String? crossAxisAlignment,
    double? gap,
  }) {
    return ColumnNode(
      id: id ?? this.id,
      children: children ?? this.children,
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      gap: gap ?? this.gap,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  ColumnNode copyWithField<T>(Field<ColumnNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'children':
        return copyWith(children: value as List<ShadNode>);
      case 'mainAxisAlignment':
        return copyWith(mainAxisAlignment: value as String?);
      case 'crossAxisAlignment':
        return copyWith(crossAxisAlignment: value as String?);
      case 'gap':
        return copyWith(gap: value as double?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'ColumnNode has no settable field with this name',
        );
    }
  }

  ColumnNode copyWithColumnNode({
    String? id,
    List<ShadNode>? children,
    String? mainAxisAlignment,
    String? crossAxisAlignment,
    double? gap,
  }) {
    return copyWith(
      id: id,
      children: children,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      gap: gap,
    );
  }

  ColumnNode patchWithColumnNode([ColumnNodePatch? patchInput]) {
    final _patcher = patchInput ?? ColumnNodePatch();
    final _patchMap = _patcher.patchMap;
    return ColumnNode(
      id: _patchMap.containsKey(ColumnNode$.id)
          ? ((_patchMap[ColumnNode$.id] is Function)
                    ? _patchMap[ColumnNode$.id](this.id)
                    : (_patchMap[ColumnNode$.id] is Patch)
                    ? _patchMap[ColumnNode$.id].applyTo(this.id)
                    : _patchMap[ColumnNode$.id])
                as String?
          : this.id,
      children: _patchMap.containsKey(ColumnNode$.children)
          ? ((_patchMap[ColumnNode$.children] is Function)
                    ? _patchMap[ColumnNode$.children](this.children)
                    : (_patchMap[ColumnNode$.children] is Patch)
                    ? _patchMap[ColumnNode$.children].applyTo(this.children)
                    : _patchMap[ColumnNode$.children])
                as List<ShadNode>
          : this.children,
      mainAxisAlignment: _patchMap.containsKey(ColumnNode$.mainAxisAlignment)
          ? ((_patchMap[ColumnNode$.mainAxisAlignment] is Function)
                    ? _patchMap[ColumnNode$.mainAxisAlignment](
                        this.mainAxisAlignment,
                      )
                    : (_patchMap[ColumnNode$.mainAxisAlignment] is Patch)
                    ? _patchMap[ColumnNode$.mainAxisAlignment].applyTo(
                        this.mainAxisAlignment,
                      )
                    : _patchMap[ColumnNode$.mainAxisAlignment])
                as String?
          : this.mainAxisAlignment,
      crossAxisAlignment: _patchMap.containsKey(ColumnNode$.crossAxisAlignment)
          ? ((_patchMap[ColumnNode$.crossAxisAlignment] is Function)
                    ? _patchMap[ColumnNode$.crossAxisAlignment](
                        this.crossAxisAlignment,
                      )
                    : (_patchMap[ColumnNode$.crossAxisAlignment] is Patch)
                    ? _patchMap[ColumnNode$.crossAxisAlignment].applyTo(
                        this.crossAxisAlignment,
                      )
                    : _patchMap[ColumnNode$.crossAxisAlignment])
                as String?
          : this.crossAxisAlignment,
      gap: _patchMap.containsKey(ColumnNode$.gap)
          ? ((_patchMap[ColumnNode$.gap] is Function)
                    ? _patchMap[ColumnNode$.gap](this.gap)
                    : (_patchMap[ColumnNode$.gap] is Patch)
                    ? _patchMap[ColumnNode$.gap].applyTo(this.gap)
                    : _patchMap[ColumnNode$.gap])
                as double?
          : this.gap,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ColumnNode &&
        id == other.id &&
        children == other.children &&
        mainAxisAlignment == other.mainAxisAlignment &&
        crossAxisAlignment == other.crossAxisAlignment &&
        gap == other.gap;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.children,
      this.mainAxisAlignment,
      this.crossAxisAlignment,
      this.gap,
    );
  }

  @override
  String toString() {
    return 'ColumnNode(' +
        'id: ${id}' +
        ', ' +
        'children: ${children}' +
        ', ' +
        'mainAxisAlignment: ${mainAxisAlignment}' +
        ', ' +
        'crossAxisAlignment: ${crossAxisAlignment}' +
        ', ' +
        'gap: ${gap})';
  }
}

extension ColumnNodePropertyHelpers on ColumnNode {
  bool get hasChildren {
    return this.children.isNotEmpty;
  }

  bool get noChildren {
    return this.children.isEmpty;
  }

  bool get hasMainAxisAlignment {
    return this.mainAxisAlignment?.isNotEmpty == true;
  }

  bool get noMainAxisAlignment {
    return this.mainAxisAlignment?.isEmpty ?? true;
  }

  String get mainAxisAlignmentRequired {
    return this.mainAxisAlignment ??
        (throw StateError('mainAxisAlignment is required but was null'));
  }

  bool get hasCrossAxisAlignment {
    return this.crossAxisAlignment?.isNotEmpty == true;
  }

  bool get noCrossAxisAlignment {
    return this.crossAxisAlignment?.isEmpty ?? true;
  }

  String get crossAxisAlignmentRequired {
    return this.crossAxisAlignment ??
        (throw StateError('crossAxisAlignment is required but was null'));
  }

  bool get hasGap {
    return this.gap != null;
  }

  bool get noGap {
    return this.gap == null;
  }

  double get gapRequired {
    return this.gap ?? (throw StateError('gap is required but was null'));
  }
}

enum ColumnNode$ { id, children, mainAxisAlignment, crossAxisAlignment, gap }

class ColumnNodePatch extends PatchBase<ColumnNode, ColumnNode$> {
  ColumnNode applyTo(ColumnNode entity) {
    return entity.patchWithColumnNode(this);
  }

  ColumnNodePatch withId(String? value) {
    patchMap[ColumnNode$.id] = value;
    return this;
  }

  ColumnNodePatch withChildren(List<ShadNode>? value) {
    patchMap[ColumnNode$.children] = value;
    return this;
  }

  ColumnNodePatch withMainAxisAlignment(String? value) {
    patchMap[ColumnNode$.mainAxisAlignment] = value;
    return this;
  }

  ColumnNodePatch withCrossAxisAlignment(String? value) {
    patchMap[ColumnNode$.crossAxisAlignment] = value;
    return this;
  }

  ColumnNodePatch withGap(double? value) {
    patchMap[ColumnNode$.gap] = value;
    return this;
  }
}

/// Field descriptors for [ColumnNode] query construction
abstract final class ColumnNodeFields {
  static const id = Field<ColumnNode, String?>('id', _$id);

  static const children = Field<ColumnNode, List<ShadNode>>(
    'children',
    _$children,
  );

  static const mainAxisAlignment = Field<ColumnNode, String?>(
    'mainAxisAlignment',
    _$mainAxisAlignment,
  );

  static const crossAxisAlignment = Field<ColumnNode, String?>(
    'crossAxisAlignment',
    _$crossAxisAlignment,
  );

  static const gap = Field<ColumnNode, double?>('gap', _$gap);

  static String? _$id(ColumnNode e) {
    return e.id;
  }

  static List<ShadNode> _$children(ColumnNode e) {
    return e.children;
  }

  static String? _$mainAxisAlignment(ColumnNode e) {
    return e.mainAxisAlignment;
  }

  static String? _$crossAxisAlignment(ColumnNode e) {
    return e.crossAxisAlignment;
  }

  static double? _$gap(ColumnNode e) {
    return e.gap;
  }
}

extension ColumnNodeCompareE on ColumnNode {
  Map<String, dynamic> compareToColumnNode(ColumnNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (children != other.children) {
      diff['children'] = () => other.children;
    }

    if (mainAxisAlignment != other.mainAxisAlignment) {
      diff['mainAxisAlignment'] = () => other.mainAxisAlignment;
    }

    if (crossAxisAlignment != other.crossAxisAlignment) {
      diff['crossAxisAlignment'] = () => other.crossAxisAlignment;
    }

    if (gap != other.gap) {
      diff['gap'] = () => other.gap;
    }
    return diff;
  }
}

class StackNode implements ShadNode {
  StackNode({
    String? this.id,
    required List<ShadNode> this.children,
    String? this.alignment,
  });

  final String? id;

  final List<ShadNode> children;

  final String? alignment;

  StackNode copyWith({
    String? id,
    List<ShadNode>? children,
    String? alignment,
  }) {
    return StackNode(
      id: id ?? this.id,
      children: children ?? this.children,
      alignment: alignment ?? this.alignment,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  StackNode copyWithField<T>(Field<StackNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'children':
        return copyWith(children: value as List<ShadNode>);
      case 'alignment':
        return copyWith(alignment: value as String?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'StackNode has no settable field with this name',
        );
    }
  }

  StackNode copyWithStackNode({
    String? id,
    List<ShadNode>? children,
    String? alignment,
  }) {
    return copyWith(id: id, children: children, alignment: alignment);
  }

  StackNode patchWithStackNode([StackNodePatch? patchInput]) {
    final _patcher = patchInput ?? StackNodePatch();
    final _patchMap = _patcher.patchMap;
    return StackNode(
      id: _patchMap.containsKey(StackNode$.id)
          ? ((_patchMap[StackNode$.id] is Function)
                    ? _patchMap[StackNode$.id](this.id)
                    : (_patchMap[StackNode$.id] is Patch)
                    ? _patchMap[StackNode$.id].applyTo(this.id)
                    : _patchMap[StackNode$.id])
                as String?
          : this.id,
      children: _patchMap.containsKey(StackNode$.children)
          ? ((_patchMap[StackNode$.children] is Function)
                    ? _patchMap[StackNode$.children](this.children)
                    : (_patchMap[StackNode$.children] is Patch)
                    ? _patchMap[StackNode$.children].applyTo(this.children)
                    : _patchMap[StackNode$.children])
                as List<ShadNode>
          : this.children,
      alignment: _patchMap.containsKey(StackNode$.alignment)
          ? ((_patchMap[StackNode$.alignment] is Function)
                    ? _patchMap[StackNode$.alignment](this.alignment)
                    : (_patchMap[StackNode$.alignment] is Patch)
                    ? _patchMap[StackNode$.alignment].applyTo(this.alignment)
                    : _patchMap[StackNode$.alignment])
                as String?
          : this.alignment,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StackNode &&
        id == other.id &&
        children == other.children &&
        alignment == other.alignment;
  }

  @override
  int get hashCode {
    return Object.hash(this.id, this.children, this.alignment);
  }

  @override
  String toString() {
    return 'StackNode(' +
        'id: ${id}' +
        ', ' +
        'children: ${children}' +
        ', ' +
        'alignment: ${alignment})';
  }
}

extension StackNodePropertyHelpers on StackNode {
  bool get hasChildren {
    return this.children.isNotEmpty;
  }

  bool get noChildren {
    return this.children.isEmpty;
  }

  bool get hasAlignment {
    return this.alignment?.isNotEmpty == true;
  }

  bool get noAlignment {
    return this.alignment?.isEmpty ?? true;
  }

  String get alignmentRequired {
    return this.alignment ??
        (throw StateError('alignment is required but was null'));
  }
}

enum StackNode$ { id, children, alignment }

class StackNodePatch extends PatchBase<StackNode, StackNode$> {
  StackNode applyTo(StackNode entity) {
    return entity.patchWithStackNode(this);
  }

  StackNodePatch withId(String? value) {
    patchMap[StackNode$.id] = value;
    return this;
  }

  StackNodePatch withChildren(List<ShadNode>? value) {
    patchMap[StackNode$.children] = value;
    return this;
  }

  StackNodePatch withAlignment(String? value) {
    patchMap[StackNode$.alignment] = value;
    return this;
  }
}

/// Field descriptors for [StackNode] query construction
abstract final class StackNodeFields {
  static const id = Field<StackNode, String?>('id', _$id);

  static const children = Field<StackNode, List<ShadNode>>(
    'children',
    _$children,
  );

  static const alignment = Field<StackNode, String?>('alignment', _$alignment);

  static String? _$id(StackNode e) {
    return e.id;
  }

  static List<ShadNode> _$children(StackNode e) {
    return e.children;
  }

  static String? _$alignment(StackNode e) {
    return e.alignment;
  }
}

extension StackNodeCompareE on StackNode {
  Map<String, dynamic> compareToStackNode(StackNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (children != other.children) {
      diff['children'] = () => other.children;
    }

    if (alignment != other.alignment) {
      diff['alignment'] = () => other.alignment;
    }
    return diff;
  }
}

class PaddingNode implements ShadNode {
  PaddingNode({
    String? this.id,
    required PaddingSpec this.padding,
    ShadNode? this.child,
  });

  final String? id;

  final PaddingSpec padding;

  final ShadNode? child;

  PaddingNode copyWith({String? id, PaddingSpec? padding, ShadNode? child}) {
    return PaddingNode(
      id: id ?? this.id,
      padding: padding ?? this.padding,
      child: child ?? this.child,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  PaddingNode copyWithField<T>(Field<PaddingNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'padding':
        return copyWith(padding: value as PaddingSpec);
      case 'child':
        return copyWith(child: value as ShadNode?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'PaddingNode has no settable field with this name',
        );
    }
  }

  PaddingNode copyWithPaddingNode({
    String? id,
    PaddingSpec? padding,
    ShadNode? child,
  }) {
    return copyWith(id: id, padding: padding, child: child);
  }

  PaddingNode patchWithPaddingNode([PaddingNodePatch? patchInput]) {
    final _patcher = patchInput ?? PaddingNodePatch();
    final _patchMap = _patcher.patchMap;
    return PaddingNode(
      id: _patchMap.containsKey(PaddingNode$.id)
          ? ((_patchMap[PaddingNode$.id] is Function)
                    ? _patchMap[PaddingNode$.id](this.id)
                    : (_patchMap[PaddingNode$.id] is Patch)
                    ? _patchMap[PaddingNode$.id].applyTo(this.id)
                    : _patchMap[PaddingNode$.id])
                as String?
          : this.id,
      padding: _patchMap.containsKey(PaddingNode$.padding)
          ? ((_patchMap[PaddingNode$.padding] is Function)
                    ? _patchMap[PaddingNode$.padding](this.padding)
                    : (_patchMap[PaddingNode$.padding] is Patch)
                    ? _patchMap[PaddingNode$.padding].applyTo(this.padding)
                    : _patchMap[PaddingNode$.padding])
                as PaddingSpec
          : this.padding,
      child: _patchMap.containsKey(PaddingNode$.child)
          ? ((_patchMap[PaddingNode$.child] is Function)
                    ? _patchMap[PaddingNode$.child](this.child)
                    : (_patchMap[PaddingNode$.child] is Patch)
                    ? _patchMap[PaddingNode$.child].applyTo(this.child)
                    : _patchMap[PaddingNode$.child])
                as ShadNode?
          : this.child,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaddingNode &&
        id == other.id &&
        padding == other.padding &&
        child == other.child;
  }

  @override
  int get hashCode {
    return Object.hash(this.id, this.padding, this.child);
  }

  @override
  String toString() {
    return 'PaddingNode(' +
        'id: ${id}' +
        ', ' +
        'padding: ${padding}' +
        ', ' +
        'child: ${child})';
  }
}

extension PaddingNodePropertyHelpers on PaddingNode {
  bool get hasChild {
    return this.child != null;
  }

  bool get noChild {
    return this.child == null;
  }

  ShadNode get childRequired {
    return this.child ?? (throw StateError('child is required but was null'));
  }
}

enum PaddingNode$ { id, padding, child }

class PaddingNodePatch extends PatchBase<PaddingNode, PaddingNode$> {
  PaddingNode applyTo(PaddingNode entity) {
    return entity.patchWithPaddingNode(this);
  }

  PaddingNodePatch withId(String? value) {
    patchMap[PaddingNode$.id] = value;
    return this;
  }

  PaddingNodePatch withPadding(PaddingSpec? value) {
    patchMap[PaddingNode$.padding] = value;
    return this;
  }

  PaddingNodePatch withChild(ShadNode? value) {
    patchMap[PaddingNode$.child] = value;
    return this;
  }
}

/// Field descriptors for [PaddingNode] query construction
abstract final class PaddingNodeFields {
  static const id = Field<PaddingNode, String?>('id', _$id);

  static const padding = Field<PaddingNode, PaddingSpec>('padding', _$padding);

  static const child = Field<PaddingNode, ShadNode?>('child', _$child);

  static String? _$id(PaddingNode e) {
    return e.id;
  }

  static PaddingSpec _$padding(PaddingNode e) {
    return e.padding;
  }

  static ShadNode? _$child(PaddingNode e) {
    return e.child;
  }
}

extension PaddingNodeCompareE on PaddingNode {
  Map<String, dynamic> compareToPaddingNode(PaddingNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (padding != other.padding) {
      diff['padding'] = () => other.padding;
    }

    if (child != other.child) {
      diff['child'] = () => other.child;
    }
    return diff;
  }
}

class ExpandedNode implements ShadNode {
  ExpandedNode({String? this.id, required ShadNode this.child, int? this.flex});

  final String? id;

  final ShadNode child;

  final int? flex;

  ExpandedNode copyWith({String? id, ShadNode? child, int? flex}) {
    return ExpandedNode(
      id: id ?? this.id,
      child: child ?? this.child,
      flex: flex ?? this.flex,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  ExpandedNode copyWithField<T>(Field<ExpandedNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'child':
        return copyWith(child: value as ShadNode);
      case 'flex':
        return copyWith(flex: value as int?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'ExpandedNode has no settable field with this name',
        );
    }
  }

  ExpandedNode copyWithExpandedNode({String? id, ShadNode? child, int? flex}) {
    return copyWith(id: id, child: child, flex: flex);
  }

  ExpandedNode patchWithExpandedNode([ExpandedNodePatch? patchInput]) {
    final _patcher = patchInput ?? ExpandedNodePatch();
    final _patchMap = _patcher.patchMap;
    return ExpandedNode(
      id: _patchMap.containsKey(ExpandedNode$.id)
          ? ((_patchMap[ExpandedNode$.id] is Function)
                    ? _patchMap[ExpandedNode$.id](this.id)
                    : (_patchMap[ExpandedNode$.id] is Patch)
                    ? _patchMap[ExpandedNode$.id].applyTo(this.id)
                    : _patchMap[ExpandedNode$.id])
                as String?
          : this.id,
      child: _patchMap.containsKey(ExpandedNode$.child)
          ? ((_patchMap[ExpandedNode$.child] is Function)
                    ? _patchMap[ExpandedNode$.child](this.child)
                    : (_patchMap[ExpandedNode$.child] is Patch)
                    ? _patchMap[ExpandedNode$.child].applyTo(this.child)
                    : _patchMap[ExpandedNode$.child])
                as ShadNode
          : this.child,
      flex: _patchMap.containsKey(ExpandedNode$.flex)
          ? ((_patchMap[ExpandedNode$.flex] is Function)
                    ? _patchMap[ExpandedNode$.flex](this.flex)
                    : (_patchMap[ExpandedNode$.flex] is Patch)
                    ? _patchMap[ExpandedNode$.flex].applyTo(this.flex)
                    : _patchMap[ExpandedNode$.flex])
                as int?
          : this.flex,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ExpandedNode &&
        id == other.id &&
        child == other.child &&
        flex == other.flex;
  }

  @override
  int get hashCode {
    return Object.hash(this.id, this.child, this.flex);
  }

  @override
  String toString() {
    return 'ExpandedNode(' +
        'id: ${id}' +
        ', ' +
        'child: ${child}' +
        ', ' +
        'flex: ${flex})';
  }
}

extension ExpandedNodePropertyHelpers on ExpandedNode {
  bool get hasFlex {
    return this.flex != null;
  }

  bool get noFlex {
    return this.flex == null;
  }

  int get flexRequired {
    return this.flex ?? (throw StateError('flex is required but was null'));
  }
}

enum ExpandedNode$ { id, child, flex }

class ExpandedNodePatch extends PatchBase<ExpandedNode, ExpandedNode$> {
  ExpandedNode applyTo(ExpandedNode entity) {
    return entity.patchWithExpandedNode(this);
  }

  ExpandedNodePatch withId(String? value) {
    patchMap[ExpandedNode$.id] = value;
    return this;
  }

  ExpandedNodePatch withChild(ShadNode? value) {
    patchMap[ExpandedNode$.child] = value;
    return this;
  }

  ExpandedNodePatch withFlex(int? value) {
    patchMap[ExpandedNode$.flex] = value;
    return this;
  }
}

/// Field descriptors for [ExpandedNode] query construction
abstract final class ExpandedNodeFields {
  static const id = Field<ExpandedNode, String?>('id', _$id);

  static const child = Field<ExpandedNode, ShadNode>('child', _$child);

  static const flex = Field<ExpandedNode, int?>('flex', _$flex);

  static String? _$id(ExpandedNode e) {
    return e.id;
  }

  static ShadNode _$child(ExpandedNode e) {
    return e.child;
  }

  static int? _$flex(ExpandedNode e) {
    return e.flex;
  }
}

extension ExpandedNodeCompareE on ExpandedNode {
  Map<String, dynamic> compareToExpandedNode(ExpandedNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (child != other.child) {
      diff['child'] = () => other.child;
    }

    if (flex != other.flex) {
      diff['flex'] = () => other.flex;
    }
    return diff;
  }
}

class SizedBoxNode implements ShadNode {
  SizedBoxNode({
    String? this.id,
    ShadNode? this.child,
    double? this.width,
    double? this.height,
  });

  final String? id;

  final ShadNode? child;

  final double? width;

  final double? height;

  SizedBoxNode copyWith({
    String? id,
    ShadNode? child,
    double? width,
    double? height,
  }) {
    return SizedBoxNode(
      id: id ?? this.id,
      child: child ?? this.child,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  SizedBoxNode copyWithField<T>(Field<SizedBoxNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'child':
        return copyWith(child: value as ShadNode?);
      case 'width':
        return copyWith(width: value as double?);
      case 'height':
        return copyWith(height: value as double?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'SizedBoxNode has no settable field with this name',
        );
    }
  }

  SizedBoxNode copyWithSizedBoxNode({
    String? id,
    ShadNode? child,
    double? width,
    double? height,
  }) {
    return copyWith(id: id, child: child, width: width, height: height);
  }

  SizedBoxNode patchWithSizedBoxNode([SizedBoxNodePatch? patchInput]) {
    final _patcher = patchInput ?? SizedBoxNodePatch();
    final _patchMap = _patcher.patchMap;
    return SizedBoxNode(
      id: _patchMap.containsKey(SizedBoxNode$.id)
          ? ((_patchMap[SizedBoxNode$.id] is Function)
                    ? _patchMap[SizedBoxNode$.id](this.id)
                    : (_patchMap[SizedBoxNode$.id] is Patch)
                    ? _patchMap[SizedBoxNode$.id].applyTo(this.id)
                    : _patchMap[SizedBoxNode$.id])
                as String?
          : this.id,
      child: _patchMap.containsKey(SizedBoxNode$.child)
          ? ((_patchMap[SizedBoxNode$.child] is Function)
                    ? _patchMap[SizedBoxNode$.child](this.child)
                    : (_patchMap[SizedBoxNode$.child] is Patch)
                    ? _patchMap[SizedBoxNode$.child].applyTo(this.child)
                    : _patchMap[SizedBoxNode$.child])
                as ShadNode?
          : this.child,
      width: _patchMap.containsKey(SizedBoxNode$.width)
          ? ((_patchMap[SizedBoxNode$.width] is Function)
                    ? _patchMap[SizedBoxNode$.width](this.width)
                    : (_patchMap[SizedBoxNode$.width] is Patch)
                    ? _patchMap[SizedBoxNode$.width].applyTo(this.width)
                    : _patchMap[SizedBoxNode$.width])
                as double?
          : this.width,
      height: _patchMap.containsKey(SizedBoxNode$.height)
          ? ((_patchMap[SizedBoxNode$.height] is Function)
                    ? _patchMap[SizedBoxNode$.height](this.height)
                    : (_patchMap[SizedBoxNode$.height] is Patch)
                    ? _patchMap[SizedBoxNode$.height].applyTo(this.height)
                    : _patchMap[SizedBoxNode$.height])
                as double?
          : this.height,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SizedBoxNode &&
        id == other.id &&
        child == other.child &&
        width == other.width &&
        height == other.height;
  }

  @override
  int get hashCode {
    return Object.hash(this.id, this.child, this.width, this.height);
  }

  @override
  String toString() {
    return 'SizedBoxNode(' +
        'id: ${id}' +
        ', ' +
        'child: ${child}' +
        ', ' +
        'width: ${width}' +
        ', ' +
        'height: ${height})';
  }
}

extension SizedBoxNodePropertyHelpers on SizedBoxNode {
  bool get hasChild {
    return this.child != null;
  }

  bool get noChild {
    return this.child == null;
  }

  ShadNode get childRequired {
    return this.child ?? (throw StateError('child is required but was null'));
  }

  bool get hasWidth {
    return this.width != null;
  }

  bool get noWidth {
    return this.width == null;
  }

  double get widthRequired {
    return this.width ?? (throw StateError('width is required but was null'));
  }

  bool get hasHeight {
    return this.height != null;
  }

  bool get noHeight {
    return this.height == null;
  }

  double get heightRequired {
    return this.height ?? (throw StateError('height is required but was null'));
  }
}

enum SizedBoxNode$ { id, child, width, height }

class SizedBoxNodePatch extends PatchBase<SizedBoxNode, SizedBoxNode$> {
  SizedBoxNode applyTo(SizedBoxNode entity) {
    return entity.patchWithSizedBoxNode(this);
  }

  SizedBoxNodePatch withId(String? value) {
    patchMap[SizedBoxNode$.id] = value;
    return this;
  }

  SizedBoxNodePatch withChild(ShadNode? value) {
    patchMap[SizedBoxNode$.child] = value;
    return this;
  }

  SizedBoxNodePatch withWidth(double? value) {
    patchMap[SizedBoxNode$.width] = value;
    return this;
  }

  SizedBoxNodePatch withHeight(double? value) {
    patchMap[SizedBoxNode$.height] = value;
    return this;
  }
}

/// Field descriptors for [SizedBoxNode] query construction
abstract final class SizedBoxNodeFields {
  static const id = Field<SizedBoxNode, String?>('id', _$id);

  static const child = Field<SizedBoxNode, ShadNode?>('child', _$child);

  static const width = Field<SizedBoxNode, double?>('width', _$width);

  static const height = Field<SizedBoxNode, double?>('height', _$height);

  static String? _$id(SizedBoxNode e) {
    return e.id;
  }

  static ShadNode? _$child(SizedBoxNode e) {
    return e.child;
  }

  static double? _$width(SizedBoxNode e) {
    return e.width;
  }

  static double? _$height(SizedBoxNode e) {
    return e.height;
  }
}

extension SizedBoxNodeCompareE on SizedBoxNode {
  Map<String, dynamic> compareToSizedBoxNode(SizedBoxNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (child != other.child) {
      diff['child'] = () => other.child;
    }

    if (width != other.width) {
      diff['width'] = () => other.width;
    }

    if (height != other.height) {
      diff['height'] = () => other.height;
    }
    return diff;
  }
}

class ListViewNode implements ShadNode {
  ListViewNode({
    String? this.id,
    required List<ShadNode> this.children,
    double? this.spacing,
    bool? this.shrinkWrap,
    bool? this.reverse,
  });

  final String? id;

  final List<ShadNode> children;

  final double? spacing;

  final bool? shrinkWrap;

  final bool? reverse;

  ListViewNode copyWith({
    String? id,
    List<ShadNode>? children,
    double? spacing,
    bool? shrinkWrap,
    bool? reverse,
  }) {
    return ListViewNode(
      id: id ?? this.id,
      children: children ?? this.children,
      spacing: spacing ?? this.spacing,
      shrinkWrap: shrinkWrap ?? this.shrinkWrap,
      reverse: reverse ?? this.reverse,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  ListViewNode copyWithField<T>(Field<ListViewNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'children':
        return copyWith(children: value as List<ShadNode>);
      case 'spacing':
        return copyWith(spacing: value as double?);
      case 'shrinkWrap':
        return copyWith(shrinkWrap: value as bool?);
      case 'reverse':
        return copyWith(reverse: value as bool?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'ListViewNode has no settable field with this name',
        );
    }
  }

  ListViewNode copyWithListViewNode({
    String? id,
    List<ShadNode>? children,
    double? spacing,
    bool? shrinkWrap,
    bool? reverse,
  }) {
    return copyWith(
      id: id,
      children: children,
      spacing: spacing,
      shrinkWrap: shrinkWrap,
      reverse: reverse,
    );
  }

  ListViewNode patchWithListViewNode([ListViewNodePatch? patchInput]) {
    final _patcher = patchInput ?? ListViewNodePatch();
    final _patchMap = _patcher.patchMap;
    return ListViewNode(
      id: _patchMap.containsKey(ListViewNode$.id)
          ? ((_patchMap[ListViewNode$.id] is Function)
                    ? _patchMap[ListViewNode$.id](this.id)
                    : (_patchMap[ListViewNode$.id] is Patch)
                    ? _patchMap[ListViewNode$.id].applyTo(this.id)
                    : _patchMap[ListViewNode$.id])
                as String?
          : this.id,
      children: _patchMap.containsKey(ListViewNode$.children)
          ? ((_patchMap[ListViewNode$.children] is Function)
                    ? _patchMap[ListViewNode$.children](this.children)
                    : (_patchMap[ListViewNode$.children] is Patch)
                    ? _patchMap[ListViewNode$.children].applyTo(this.children)
                    : _patchMap[ListViewNode$.children])
                as List<ShadNode>
          : this.children,
      spacing: _patchMap.containsKey(ListViewNode$.spacing)
          ? ((_patchMap[ListViewNode$.spacing] is Function)
                    ? _patchMap[ListViewNode$.spacing](this.spacing)
                    : (_patchMap[ListViewNode$.spacing] is Patch)
                    ? _patchMap[ListViewNode$.spacing].applyTo(this.spacing)
                    : _patchMap[ListViewNode$.spacing])
                as double?
          : this.spacing,
      shrinkWrap: _patchMap.containsKey(ListViewNode$.shrinkWrap)
          ? ((_patchMap[ListViewNode$.shrinkWrap] is Function)
                    ? _patchMap[ListViewNode$.shrinkWrap](this.shrinkWrap)
                    : (_patchMap[ListViewNode$.shrinkWrap] is Patch)
                    ? _patchMap[ListViewNode$.shrinkWrap].applyTo(
                        this.shrinkWrap,
                      )
                    : _patchMap[ListViewNode$.shrinkWrap])
                as bool?
          : this.shrinkWrap,
      reverse: _patchMap.containsKey(ListViewNode$.reverse)
          ? ((_patchMap[ListViewNode$.reverse] is Function)
                    ? _patchMap[ListViewNode$.reverse](this.reverse)
                    : (_patchMap[ListViewNode$.reverse] is Patch)
                    ? _patchMap[ListViewNode$.reverse].applyTo(this.reverse)
                    : _patchMap[ListViewNode$.reverse])
                as bool?
          : this.reverse,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ListViewNode &&
        id == other.id &&
        children == other.children &&
        spacing == other.spacing &&
        shrinkWrap == other.shrinkWrap &&
        reverse == other.reverse;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.children,
      this.spacing,
      this.shrinkWrap,
      this.reverse,
    );
  }

  @override
  String toString() {
    return 'ListViewNode(' +
        'id: ${id}' +
        ', ' +
        'children: ${children}' +
        ', ' +
        'spacing: ${spacing}' +
        ', ' +
        'shrinkWrap: ${shrinkWrap}' +
        ', ' +
        'reverse: ${reverse})';
  }
}

extension ListViewNodePropertyHelpers on ListViewNode {
  bool get hasChildren {
    return this.children.isNotEmpty;
  }

  bool get noChildren {
    return this.children.isEmpty;
  }

  bool get hasSpacing {
    return this.spacing != null;
  }

  bool get noSpacing {
    return this.spacing == null;
  }

  double get spacingRequired {
    return this.spacing ??
        (throw StateError('spacing is required but was null'));
  }

  bool get hasShrinkWrap {
    return this.shrinkWrap != null;
  }

  bool get noShrinkWrap {
    return this.shrinkWrap == null;
  }

  bool get shrinkWrapRequired {
    return this.shrinkWrap ??
        (throw StateError('shrinkWrap is required but was null'));
  }

  bool get hasReverse {
    return this.reverse != null;
  }

  bool get noReverse {
    return this.reverse == null;
  }

  bool get reverseRequired {
    return this.reverse ??
        (throw StateError('reverse is required but was null'));
  }
}

enum ListViewNode$ { id, children, spacing, shrinkWrap, reverse }

class ListViewNodePatch extends PatchBase<ListViewNode, ListViewNode$> {
  ListViewNode applyTo(ListViewNode entity) {
    return entity.patchWithListViewNode(this);
  }

  ListViewNodePatch withId(String? value) {
    patchMap[ListViewNode$.id] = value;
    return this;
  }

  ListViewNodePatch withChildren(List<ShadNode>? value) {
    patchMap[ListViewNode$.children] = value;
    return this;
  }

  ListViewNodePatch withSpacing(double? value) {
    patchMap[ListViewNode$.spacing] = value;
    return this;
  }

  ListViewNodePatch withShrinkWrap(bool? value) {
    patchMap[ListViewNode$.shrinkWrap] = value;
    return this;
  }

  ListViewNodePatch withReverse(bool? value) {
    patchMap[ListViewNode$.reverse] = value;
    return this;
  }
}

/// Field descriptors for [ListViewNode] query construction
abstract final class ListViewNodeFields {
  static const id = Field<ListViewNode, String?>('id', _$id);

  static const children = Field<ListViewNode, List<ShadNode>>(
    'children',
    _$children,
  );

  static const spacing = Field<ListViewNode, double?>('spacing', _$spacing);

  static const shrinkWrap = Field<ListViewNode, bool?>(
    'shrinkWrap',
    _$shrinkWrap,
  );

  static const reverse = Field<ListViewNode, bool?>('reverse', _$reverse);

  static String? _$id(ListViewNode e) {
    return e.id;
  }

  static List<ShadNode> _$children(ListViewNode e) {
    return e.children;
  }

  static double? _$spacing(ListViewNode e) {
    return e.spacing;
  }

  static bool? _$shrinkWrap(ListViewNode e) {
    return e.shrinkWrap;
  }

  static bool? _$reverse(ListViewNode e) {
    return e.reverse;
  }
}

extension ListViewNodeCompareE on ListViewNode {
  Map<String, dynamic> compareToListViewNode(ListViewNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (children != other.children) {
      diff['children'] = () => other.children;
    }

    if (spacing != other.spacing) {
      diff['spacing'] = () => other.spacing;
    }

    if (shrinkWrap != other.shrinkWrap) {
      diff['shrinkWrap'] = () => other.shrinkWrap;
    }

    if (reverse != other.reverse) {
      diff['reverse'] = () => other.reverse;
    }
    return diff;
  }
}

class ImageNode implements ShadNode {
  ImageNode({
    String? this.id,
    required String this.src,
    String? this.fit,
    double? this.width,
    double? this.height,
    String? this.alt,
  });

  final String? id;

  final String src;

  final String? fit;

  final double? width;

  final double? height;

  final String? alt;

  ImageNode copyWith({
    String? id,
    String? src,
    String? fit,
    double? width,
    double? height,
    String? alt,
  }) {
    return ImageNode(
      id: id ?? this.id,
      src: src ?? this.src,
      fit: fit ?? this.fit,
      width: width ?? this.width,
      height: height ?? this.height,
      alt: alt ?? this.alt,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  ImageNode copyWithField<T>(Field<ImageNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'src':
        return copyWith(src: value as String);
      case 'fit':
        return copyWith(fit: value as String?);
      case 'width':
        return copyWith(width: value as double?);
      case 'height':
        return copyWith(height: value as double?);
      case 'alt':
        return copyWith(alt: value as String?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'ImageNode has no settable field with this name',
        );
    }
  }

  ImageNode copyWithImageNode({
    String? id,
    String? src,
    String? fit,
    double? width,
    double? height,
    String? alt,
  }) {
    return copyWith(
      id: id,
      src: src,
      fit: fit,
      width: width,
      height: height,
      alt: alt,
    );
  }

  ImageNode patchWithImageNode([ImageNodePatch? patchInput]) {
    final _patcher = patchInput ?? ImageNodePatch();
    final _patchMap = _patcher.patchMap;
    return ImageNode(
      id: _patchMap.containsKey(ImageNode$.id)
          ? ((_patchMap[ImageNode$.id] is Function)
                    ? _patchMap[ImageNode$.id](this.id)
                    : (_patchMap[ImageNode$.id] is Patch)
                    ? _patchMap[ImageNode$.id].applyTo(this.id)
                    : _patchMap[ImageNode$.id])
                as String?
          : this.id,
      src: _patchMap.containsKey(ImageNode$.src)
          ? ((_patchMap[ImageNode$.src] is Function)
                    ? _patchMap[ImageNode$.src](this.src)
                    : (_patchMap[ImageNode$.src] is Patch)
                    ? _patchMap[ImageNode$.src].applyTo(this.src)
                    : _patchMap[ImageNode$.src])
                as String
          : this.src,
      fit: _patchMap.containsKey(ImageNode$.fit)
          ? ((_patchMap[ImageNode$.fit] is Function)
                    ? _patchMap[ImageNode$.fit](this.fit)
                    : (_patchMap[ImageNode$.fit] is Patch)
                    ? _patchMap[ImageNode$.fit].applyTo(this.fit)
                    : _patchMap[ImageNode$.fit])
                as String?
          : this.fit,
      width: _patchMap.containsKey(ImageNode$.width)
          ? ((_patchMap[ImageNode$.width] is Function)
                    ? _patchMap[ImageNode$.width](this.width)
                    : (_patchMap[ImageNode$.width] is Patch)
                    ? _patchMap[ImageNode$.width].applyTo(this.width)
                    : _patchMap[ImageNode$.width])
                as double?
          : this.width,
      height: _patchMap.containsKey(ImageNode$.height)
          ? ((_patchMap[ImageNode$.height] is Function)
                    ? _patchMap[ImageNode$.height](this.height)
                    : (_patchMap[ImageNode$.height] is Patch)
                    ? _patchMap[ImageNode$.height].applyTo(this.height)
                    : _patchMap[ImageNode$.height])
                as double?
          : this.height,
      alt: _patchMap.containsKey(ImageNode$.alt)
          ? ((_patchMap[ImageNode$.alt] is Function)
                    ? _patchMap[ImageNode$.alt](this.alt)
                    : (_patchMap[ImageNode$.alt] is Patch)
                    ? _patchMap[ImageNode$.alt].applyTo(this.alt)
                    : _patchMap[ImageNode$.alt])
                as String?
          : this.alt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ImageNode &&
        id == other.id &&
        src == other.src &&
        fit == other.fit &&
        width == other.width &&
        height == other.height &&
        alt == other.alt;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.src,
      this.fit,
      this.width,
      this.height,
      this.alt,
    );
  }

  @override
  String toString() {
    return 'ImageNode(' +
        'id: ${id}' +
        ', ' +
        'src: ${src}' +
        ', ' +
        'fit: ${fit}' +
        ', ' +
        'width: ${width}' +
        ', ' +
        'height: ${height}' +
        ', ' +
        'alt: ${alt})';
  }
}

extension ImageNodePropertyHelpers on ImageNode {
  bool get hasSrc {
    return this.src.isNotEmpty;
  }

  bool get noSrc {
    return this.src.isEmpty;
  }

  bool get hasFit {
    return this.fit?.isNotEmpty == true;
  }

  bool get noFit {
    return this.fit?.isEmpty ?? true;
  }

  String get fitRequired {
    return this.fit ?? (throw StateError('fit is required but was null'));
  }

  bool get hasWidth {
    return this.width != null;
  }

  bool get noWidth {
    return this.width == null;
  }

  double get widthRequired {
    return this.width ?? (throw StateError('width is required but was null'));
  }

  bool get hasHeight {
    return this.height != null;
  }

  bool get noHeight {
    return this.height == null;
  }

  double get heightRequired {
    return this.height ?? (throw StateError('height is required but was null'));
  }

  bool get hasAlt {
    return this.alt?.isNotEmpty == true;
  }

  bool get noAlt {
    return this.alt?.isEmpty ?? true;
  }

  String get altRequired {
    return this.alt ?? (throw StateError('alt is required but was null'));
  }
}

enum ImageNode$ { id, src, fit, width, height, alt }

class ImageNodePatch extends PatchBase<ImageNode, ImageNode$> {
  ImageNode applyTo(ImageNode entity) {
    return entity.patchWithImageNode(this);
  }

  ImageNodePatch withId(String? value) {
    patchMap[ImageNode$.id] = value;
    return this;
  }

  ImageNodePatch withSrc(String? value) {
    patchMap[ImageNode$.src] = value;
    return this;
  }

  ImageNodePatch withFit(String? value) {
    patchMap[ImageNode$.fit] = value;
    return this;
  }

  ImageNodePatch withWidth(double? value) {
    patchMap[ImageNode$.width] = value;
    return this;
  }

  ImageNodePatch withHeight(double? value) {
    patchMap[ImageNode$.height] = value;
    return this;
  }

  ImageNodePatch withAlt(String? value) {
    patchMap[ImageNode$.alt] = value;
    return this;
  }
}

/// Field descriptors for [ImageNode] query construction
abstract final class ImageNodeFields {
  static const id = Field<ImageNode, String?>('id', _$id);

  static const src = Field<ImageNode, String>('src', _$src);

  static const fit = Field<ImageNode, String?>('fit', _$fit);

  static const width = Field<ImageNode, double?>('width', _$width);

  static const height = Field<ImageNode, double?>('height', _$height);

  static const alt = Field<ImageNode, String?>('alt', _$alt);

  static String? _$id(ImageNode e) {
    return e.id;
  }

  static String _$src(ImageNode e) {
    return e.src;
  }

  static String? _$fit(ImageNode e) {
    return e.fit;
  }

  static double? _$width(ImageNode e) {
    return e.width;
  }

  static double? _$height(ImageNode e) {
    return e.height;
  }

  static String? _$alt(ImageNode e) {
    return e.alt;
  }
}

extension ImageNodeCompareE on ImageNode {
  Map<String, dynamic> compareToImageNode(ImageNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (src != other.src) {
      diff['src'] = () => other.src;
    }

    if (fit != other.fit) {
      diff['fit'] = () => other.fit;
    }

    if (width != other.width) {
      diff['width'] = () => other.width;
    }

    if (height != other.height) {
      diff['height'] = () => other.height;
    }

    if (alt != other.alt) {
      diff['alt'] = () => other.alt;
    }
    return diff;
  }
}

class IconNode implements ShadNode {
  IconNode({
    String? this.id,
    required String this.name,
    double? this.size,
    String? this.style,
  });

  final String? id;

  final String name;

  final double? size;

  final String? style;

  IconNode copyWith({String? id, String? name, double? size, String? style}) {
    return IconNode(
      id: id ?? this.id,
      name: name ?? this.name,
      size: size ?? this.size,
      style: style ?? this.style,
    );
  }

  /// Returns a copy of this entity with [field] set to [value].
  ///
  /// Delegates to [copyWith]: the receiver is never mutated and a
  /// null [value] keeps the current field value.
  IconNode copyWithField<T>(Field<IconNode, T> field, T value) {
    switch (field.name) {
      case 'id':
        return copyWith(id: value as String?);
      case 'name':
        return copyWith(name: value as String);
      case 'size':
        return copyWith(size: value as double?);
      case 'style':
        return copyWith(style: value as String?);
      default:
        throw ArgumentError.value(
          field.name,
          'field',
          'IconNode has no settable field with this name',
        );
    }
  }

  IconNode copyWithIconNode({
    String? id,
    String? name,
    double? size,
    String? style,
  }) {
    return copyWith(id: id, name: name, size: size, style: style);
  }

  IconNode patchWithIconNode([IconNodePatch? patchInput]) {
    final _patcher = patchInput ?? IconNodePatch();
    final _patchMap = _patcher.patchMap;
    return IconNode(
      id: _patchMap.containsKey(IconNode$.id)
          ? ((_patchMap[IconNode$.id] is Function)
                    ? _patchMap[IconNode$.id](this.id)
                    : (_patchMap[IconNode$.id] is Patch)
                    ? _patchMap[IconNode$.id].applyTo(this.id)
                    : _patchMap[IconNode$.id])
                as String?
          : this.id,
      name: _patchMap.containsKey(IconNode$.name_)
          ? ((_patchMap[IconNode$.name_] is Function)
                    ? _patchMap[IconNode$.name_](this.name)
                    : (_patchMap[IconNode$.name_] is Patch)
                    ? _patchMap[IconNode$.name_].applyTo(this.name)
                    : _patchMap[IconNode$.name_])
                as String
          : this.name,
      size: _patchMap.containsKey(IconNode$.size)
          ? ((_patchMap[IconNode$.size] is Function)
                    ? _patchMap[IconNode$.size](this.size)
                    : (_patchMap[IconNode$.size] is Patch)
                    ? _patchMap[IconNode$.size].applyTo(this.size)
                    : _patchMap[IconNode$.size])
                as double?
          : this.size,
      style: _patchMap.containsKey(IconNode$.style)
          ? ((_patchMap[IconNode$.style] is Function)
                    ? _patchMap[IconNode$.style](this.style)
                    : (_patchMap[IconNode$.style] is Patch)
                    ? _patchMap[IconNode$.style].applyTo(this.style)
                    : _patchMap[IconNode$.style])
                as String?
          : this.style,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is IconNode &&
        id == other.id &&
        name == other.name &&
        size == other.size &&
        style == other.style;
  }

  @override
  int get hashCode {
    return Object.hash(this.id, this.name, this.size, this.style);
  }

  @override
  String toString() {
    return 'IconNode(' +
        'id: ${id}' +
        ', ' +
        'name: ${name}' +
        ', ' +
        'size: ${size}' +
        ', ' +
        'style: ${style})';
  }
}

extension IconNodePropertyHelpers on IconNode {
  bool get hasName {
    return this.name.isNotEmpty;
  }

  bool get noName {
    return this.name.isEmpty;
  }

  bool get hasSize {
    return this.size != null;
  }

  bool get noSize {
    return this.size == null;
  }

  double get sizeRequired {
    return this.size ?? (throw StateError('size is required but was null'));
  }

  bool get hasStyle {
    return this.style?.isNotEmpty == true;
  }

  bool get noStyle {
    return this.style?.isEmpty ?? true;
  }

  String get styleRequired {
    return this.style ?? (throw StateError('style is required but was null'));
  }
}

enum IconNode$ { id, name_, size, style }

class IconNodePatch extends PatchBase<IconNode, IconNode$> {
  IconNode applyTo(IconNode entity) {
    return entity.patchWithIconNode(this);
  }

  IconNodePatch withId(String? value) {
    patchMap[IconNode$.id] = value;
    return this;
  }

  IconNodePatch withName(String? value) {
    patchMap[IconNode$.name_] = value;
    return this;
  }

  IconNodePatch withSize(double? value) {
    patchMap[IconNode$.size] = value;
    return this;
  }

  IconNodePatch withStyle(String? value) {
    patchMap[IconNode$.style] = value;
    return this;
  }
}

/// Field descriptors for [IconNode] query construction
abstract final class IconNodeFields {
  static const id = Field<IconNode, String?>('id', _$id);

  static const name = Field<IconNode, String>('name', _$name);

  static const size = Field<IconNode, double?>('size', _$size);

  static const style = Field<IconNode, String?>('style', _$style);

  static String? _$id(IconNode e) {
    return e.id;
  }

  static String _$name(IconNode e) {
    return e.name;
  }

  static double? _$size(IconNode e) {
    return e.size;
  }

  static String? _$style(IconNode e) {
    return e.style;
  }
}

extension IconNodeCompareE on IconNode {
  Map<String, dynamic> compareToIconNode(IconNode other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }

    if (name != other.name) {
      diff['name'] = () => other.name;
    }

    if (size != other.size) {
      diff['size'] = () => other.size;
    }

    if (style != other.style) {
      diff['style'] = () => other.style;
    }
    return diff;
  }
}
