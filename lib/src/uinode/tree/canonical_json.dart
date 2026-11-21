/// Canonical, byte-stable emission (spec 1100 FR-13, research D2).
///
/// Keys are emitted in the documented schema order — `widgetType`, `id`,
/// then the kind's props — and absent props are omitted. The same tree
/// always produces the same bytes; the parser accepts any key order on
/// input. The canonical form is the diffing currency between agents and
/// tests, and (via [shadNodeEquals]) the layer's deep equality.
library;

import 'dart:convert';

import 'package:zuraffa_ui/src/uinode/nodes/nodes.dart';
import 'package:zuraffa_ui/src/uinode/tree/shad_node_tree.dart';

final Map<String, List<String>> _keyOrder = {
  'button': ['label', 'variant', 'size', 'action'],
  'badge': ['label', 'variant'],
  'text': ['text', 'style', 'align'],
  'card': ['title', 'description', 'content', 'header', 'footer'],
  'cardHeader': ['title', 'description'],
  'cardFooter': ['content'],
  'input': [
    'value',
    'placeholder',
    'label',
    'helper',
    'errorText',
    'enabled',
    'obscure',
    'keyboard',
    'action',
  ],
  'select': ['options', 'value', 'placeholder', 'label', 'enabled'],
  'selectOption': ['value', 'label', 'enabled'],
  'checkbox': ['value', 'label', 'enabled', 'action'],
  'switch': ['value', 'label', 'enabled', 'action'],
  'radioGroup': ['options', 'value', 'enabled', 'action'],
  'radioOption': ['value', 'label', 'enabled'],
  'formItem': ['label', 'field', 'helper', 'errorText', 'required'],
  'tabs': ['tabs', 'panes', 'value', 'action'],
  'tab': ['value', 'label', 'enabled', 'action'],
  'tabPane': ['value', 'content'],
  'progress': ['value', 'indeterminate'],
  'separator': ['orientation'],
  'tooltip': ['message', 'child'],
  'sheet': [
    'side',
    'title',
    'description',
    'open',
    'content',
    'trigger',
    'action',
  ],
  'dialog': [
    'title',
    'description',
    'open',
    'actions',
    'content',
    'trigger',
    'action',
  ],
  'popover': ['open', 'content', 'trigger', 'action'],
  'toast': ['title', 'description', 'variant', 'action'],
  'row': ['children', 'mainAxisAlignment', 'crossAxisAlignment', 'gap'],
  'column': ['children', 'mainAxisAlignment', 'crossAxisAlignment', 'gap'],
  'stack': ['children', 'alignment'],
  'padding': ['padding', 'child'],
  'expanded': ['child', 'flex'],
  'sizedBox': ['child', 'width', 'height'],
  'listView': ['children', 'spacing', 'shrinkWrap', 'reverse'],
  'image': ['src', 'fit', 'width', 'height', 'alt'],
  'icon': ['name', 'size', 'style'],
};

/// Emits [tree] in canonical form.
String canonicalJson(ShadNodeTree tree) => jsonEncode(<String, dynamic>{
  'schemaVersion': tree.schemaVersion,
  'root': _nodeMap(tree.root),
});

/// Emits a single [node] in canonical form (envelope-less).
String canonicalNodeJson(ShadNode node) => jsonEncode(_nodeMap(node));

/// Deep equality for nodes: two nodes are equal iff their canonical forms
/// are byte-identical (the canonical form is injective per tree).
bool shadNodeEquals(ShadNode a, ShadNode b) =>
    identical(a, b) || canonicalNodeJson(a) == canonicalNodeJson(b);

/// Deep equality for trees.
bool shadTreeEquals(ShadNodeTree a, ShadNodeTree b) =>
    a.schemaVersion == b.schemaVersion && shadNodeEquals(a.root, b.root);

Map<String, dynamic> _nodeMap(ShadNode node) {
  final map = <String, dynamic>{'widgetType': node.widgetType};
  if (node.id != null) map['id'] = node.id;

  final rest = switch (node) {
    ButtonNode() => {
      'label': node.label,
      'variant': node.variant,
      'size': node.size,
      'action': node.action?.toJson(),
    },
    BadgeNode() => {'label': node.label, 'variant': node.variant},
    TextNode() => {'text': node.text, 'style': node.style, 'align': node.align},
    CardNode() => {
      'title': node.title,
      'description': node.description,
      'content': node.content.map(_nodeMap).toList(),
      'header': node.header?.let(_nodeMap),
      'footer': node.footer?.let(_nodeMap),
    },
    CardHeaderNode() => {'title': node.title, 'description': node.description},
    CardFooterNode() => {'content': node.content.map(_nodeMap).toList()},
    InputNode() => {
      'value': node.value,
      'placeholder': node.placeholder,
      'label': node.label,
      'helper': node.helper,
      'errorText': node.errorText,
      'enabled': node.enabled,
      'obscure': node.obscure,
      'keyboard': node.keyboard,
      'action': node.action?.toJson(),
    },
    SelectNode() => {
      'options': node.options.map(_nodeMap).toList(),
      'value': node.value,
      'placeholder': node.placeholder,
      'label': node.label,
      'enabled': node.enabled,
    },
    SelectOptionNode() => {
      'value': node.value,
      'label': node.label,
      'enabled': node.enabled,
    },
    CheckboxNode() => {
      'value': node.value,
      'label': node.label,
      'enabled': node.enabled,
      'action': node.action?.toJson(),
    },
    SwitchNode() => {
      'value': node.value,
      'label': node.label,
      'enabled': node.enabled,
      'action': node.action?.toJson(),
    },
    RadioGroupNode() => {
      'options': node.options.map(_nodeMap).toList(),
      'value': node.value,
      'enabled': node.enabled,
      'action': node.action?.toJson(),
    },
    RadioOptionNode() => {
      'value': node.value,
      'label': node.label,
      'enabled': node.enabled,
    },
    FormItemNode() => {
      'label': node.label,
      'field': _nodeMap(node.field),
      'helper': node.helper,
      'errorText': node.errorText,
      'required': node.required_,
    },
    TabsNode() => {
      'tabs': node.tabs.map(_nodeMap).toList(),
      'panes': node.panes.map(_nodeMap).toList(),
      'value': node.value,
      'action': node.action?.toJson(),
    },
    TabNode() => {
      'value': node.value,
      'label': node.label,
      'enabled': node.enabled,
      'action': node.action?.toJson(),
    },
    TabPaneNode() => {
      'value': node.value,
      'content': node.content.map(_nodeMap).toList(),
    },
    ProgressNode() => {
      'value': node.value,
      'indeterminate': node.indeterminate,
    },
    SeparatorNode() => {'orientation': node.orientation},
    TooltipNode() => {
      'message': node.message,
      'child': node.child?.let(_nodeMap),
    },
    SheetNode() => {
      'side': node.side,
      'title': node.title,
      'description': node.description,
      'open': node.open,
      'content': node.content.map(_nodeMap).toList(),
      'trigger': node.trigger?.let(_nodeMap),
      'action': node.action?.toJson(),
    },
    DialogNode() => {
      'title': node.title,
      'description': node.description,
      'open': node.open,
      'actions': node.actions.map(_nodeMap).toList(),
      'content': node.content.map(_nodeMap).toList(),
      'trigger': node.trigger?.let(_nodeMap),
      'action': node.action?.toJson(),
    },
    PopoverNode() => {
      'open': node.open,
      'content': node.content.map(_nodeMap).toList(),
      'trigger': node.trigger?.let(_nodeMap),
      'action': node.action?.toJson(),
    },
    ToastNode() => {
      'title': node.title,
      'description': node.description,
      'variant': node.variant,
      'action': node.action?.toJson(),
    },
    RowNode() => {
      'children': node.children.map(_nodeMap).toList(),
      'mainAxisAlignment': node.mainAxisAlignment,
      'crossAxisAlignment': node.crossAxisAlignment,
      'gap': node.gap,
    },
    ColumnNode() => {
      'children': node.children.map(_nodeMap).toList(),
      'mainAxisAlignment': node.mainAxisAlignment,
      'crossAxisAlignment': node.crossAxisAlignment,
      'gap': node.gap,
    },
    StackNode() => {
      'children': node.children.map(_nodeMap).toList(),
      'alignment': node.alignment,
    },
    PaddingNode() => {
      'padding': node.padding.toJson(),
      'child': node.child?.let(_nodeMap),
    },
    ExpandedNode() => {'child': _nodeMap(node.child), 'flex': node.flex},
    SizedBoxNode() => {
      'child': node.child?.let(_nodeMap),
      'width': node.width,
      'height': node.height,
    },
    ListViewNode() => {
      'children': node.children.map(_nodeMap).toList(),
      'spacing': node.spacing,
      'shrinkWrap': node.shrinkWrap,
      'reverse': node.reverse,
    },
    ImageNode() => {
      'src': node.src,
      'fit': node.fit,
      'width': node.width,
      'height': node.height,
      'alt': node.alt,
    },
    IconNode() => {'name': node.name, 'size': node.size, 'style': node.style},
    UnknownNode() => <String, dynamic>{
      ..._rawWithoutKnownKeys(node.raw),
    },
  };

  final order = _keyOrder[node.widgetType] ?? const <String>[];
  for (final key in order) {
    final value = rest[key];
    if (value != null) {
      map[key] = value;
    }
  }
  // Unknown nodes carry arbitrary preserved keys (minus the ones already
  // emitted), in their original wire order.
  if (node is UnknownNode) {
    for (final entry in rest.entries) {
      if (!map.containsKey(entry.key) && entry.value != null) {
        map[entry.key] = entry.value;
      }
    }
  }
  return map;
}

Map<String, dynamic> _rawWithoutKnownKeys(Map<String, dynamic> raw) => {
  for (final entry in raw.entries)
    if (entry.key != 'widgetType' && entry.key != 'id') entry.key: entry.value,
};

extension _Let<T> on T {
  R? let<R extends Object?>(R? Function(T) f) => f(this);
}
