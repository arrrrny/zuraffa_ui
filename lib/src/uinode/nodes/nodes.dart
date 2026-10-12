// The UINode node vocabulary — ONE library by necessity.
//
// WORKAROUND (misfire: https://github.com/arrrrny/zuraffa/issues/1717):
// zorphy generates the union base as a Dart `sealed` class, which can only
// be implemented inside its declaring library. A node hierarchy split
// across multiple files therefore cannot compile. All node classes live in
// this single library (with one generated part) so the sealed
// exhaustiveness contract survives; splitting by component family again is
// blocked on the upstream report above.
//
// Nodes are data only — strings, numbers, booleans, enums, theme-token
// references, nested nodes (spec 1100 FR-4/FR-5). Serialization does NOT
// live on the entities: (de)serialization is owned by `ShadNodeParser` and
// `canonicalJson` (research D2), and the wire discriminator
// ([ShadNodeX.widgetType]) is derived from the type, not stored — a stored
// one would leak into every constructor and invite mismatches (`button`
// nodes labeled `card`). `UnknownNode` is the one kind whose discriminator
// is data — the unrecognized type as it appeared on the wire.
import 'package:zorphy_annotation/zorphy_annotation.dart';

import 'package:zuraffa_ui/src/uinode/nodes/props.dart';

part 'nodes.zorphy.dart';

/// The serializable UI node union: one node kind per certified component
/// family plus the structural layout primitives.
@Zorphy()
abstract class $$ShadNode {
  /// Host-stable identity for action targets / controller binding.
  String? get id;
}

/// Placeholder for a `widgetType` this runtime does not know.
///
/// Parsing tolerates it and preserves the raw object so future trees
/// round-trip (research D3); the renderer shows a visible placeholder in
/// debug or omits the node with an event in release (FR-9).
@Zorphy()
abstract class $UnknownNode implements $$ShadNode {
  /// The unrecognized discriminator as it appeared on the wire.
  String get widgetType;

  /// The untouched original object.
  Map<String, dynamic> get raw;
}

// ── Basic components ────────────────────────────────────────────────────────

@Zorphy()
abstract class $ButtonNode implements $$ShadNode {
  String? get label;
  String? get variant;
  String? get size;
  ActionId? get action;
}

@Zorphy()
abstract class $BadgeNode implements $$ShadNode {
  String get label;
  String? get variant;
}

@Zorphy()
abstract class $TextNode implements $$ShadNode {
  String get text;
  String? get style;
  String? get align;
}

@Zorphy()
abstract class $CardNode implements $$ShadNode {
  String? get title;
  String? get description;
  List<$$ShadNode> get content;
  $$ShadNode? get header;
  $$ShadNode? get footer;
}

@Zorphy()
abstract class $CardHeaderNode implements $$ShadNode {
  String? get title;
  String? get description;
}

@Zorphy()
abstract class $CardFooterNode implements $$ShadNode {
  List<$$ShadNode> get content;
}

@Zorphy()
abstract class $ProgressNode implements $$ShadNode {
  double get value;
  bool? get indeterminate;
}

@Zorphy()
abstract class $SeparatorNode implements $$ShadNode {
  String? get orientation;
}

// ── Form components ─────────────────────────────────────────────────────────

@Zorphy()
abstract class $InputNode implements $$ShadNode {
  String? get value;
  String? get placeholder;
  String? get label;
  String? get helper;
  String? get errorText;
  bool? get enabled;
  bool? get obscure;
  String? get keyboard;
  ActionId? get action;
}

@Zorphy()
abstract class $SelectNode implements $$ShadNode {
  List<$SelectOptionNode> get options;
  String? get value;
  String? get placeholder;
  String? get label;
  bool? get enabled;
}

@Zorphy()
abstract class $SelectOptionNode implements $$ShadNode {
  String get value;
  String get label;
  bool? get enabled;
}

@Zorphy()
abstract class $CheckboxNode implements $$ShadNode {
  bool? get value;
  String? get label;
  bool? get enabled;
  ActionId? get action;
}

@Zorphy()
abstract class $SwitchNode implements $$ShadNode {
  bool? get value;
  String? get label;
  bool? get enabled;
  ActionId? get action;
}

@Zorphy()
abstract class $RadioGroupNode implements $$ShadNode {
  List<$RadioOptionNode> get options;
  String? get value;
  bool? get enabled;
  ActionId? get action;
}

@Zorphy()
abstract class $RadioOptionNode implements $$ShadNode {
  String get value;
  String get label;
  bool? get enabled;
}

@Zorphy()
abstract class $FormItemNode implements $$ShadNode {
  String get label;
  $$ShadNode get field;
  String? get helper;
  String? get errorText;
  bool? get required_;
}

// ── Overlay components ──────────────────────────────────────────────────────

@Zorphy()
abstract class $TabsNode implements $$ShadNode {
  List<$TabNode> get tabs;
  List<$TabPaneNode> get panes;
  String? get value;
  ActionId? get action;
}

@Zorphy()
abstract class $TabNode implements $$ShadNode {
  String get value;
  String get label;
  bool? get enabled;
  ActionId? get action;
}

@Zorphy()
abstract class $TabPaneNode implements $$ShadNode {
  String get value;
  List<$$ShadNode> get content;
}

@Zorphy()
abstract class $TooltipNode implements $$ShadNode {
  String get message;
  $$ShadNode? get child;
}

@Zorphy()
abstract class $SheetNode implements $$ShadNode {
  String? get side;
  String? get title;
  String? get description;
  bool? get open;
  List<$$ShadNode> get content;
  $$ShadNode? get trigger;
  ActionId? get action;
}

@Zorphy()
abstract class $DialogNode implements $$ShadNode {
  String? get title;
  String? get description;
  bool? get open;
  List<$ButtonNode> get actions;
  List<$$ShadNode> get content;
  $$ShadNode? get trigger;
  ActionId? get action;
}

@Zorphy()
abstract class $PopoverNode implements $$ShadNode {
  bool? get open;
  List<$$ShadNode> get content;
  $$ShadNode? get trigger;
  ActionId? get action;
}

@Zorphy()
abstract class $ToastNode implements $$ShadNode {
  String get title;
  String? get description;
  String? get variant;
  ActionId? get action;
}

// ── Structural primitives ───────────────────────────────────────────────────

@Zorphy()
abstract class $RowNode implements $$ShadNode {
  List<$$ShadNode> get children;
  String? get mainAxisAlignment;
  String? get crossAxisAlignment;
  double? get gap;
}

@Zorphy()
abstract class $ColumnNode implements $$ShadNode {
  List<$$ShadNode> get children;
  String? get mainAxisAlignment;
  String? get crossAxisAlignment;
  double? get gap;
}

@Zorphy()
abstract class $StackNode implements $$ShadNode {
  List<$$ShadNode> get children;
  String? get alignment;
}

@Zorphy()
abstract class $PaddingNode implements $$ShadNode {
  PaddingSpec get padding;
  $$ShadNode? get child;
}

@Zorphy()
abstract class $ExpandedNode implements $$ShadNode {
  $$ShadNode get child;
  int? get flex;
}

@Zorphy()
abstract class $SizedBoxNode implements $$ShadNode {
  $$ShadNode? get child;
  double? get width;
  double? get height;
}

@Zorphy()
abstract class $ListViewNode implements $$ShadNode {
  List<$$ShadNode> get children;
  double? get spacing;
  bool? get shrinkWrap;
  bool? get reverse;
}

@Zorphy()
abstract class $ImageNode implements $$ShadNode {
  String get src;
  String? get fit;
  double? get width;
  double? get height;
  String? get alt;
}

@Zorphy()
abstract class $IconNode implements $$ShadNode {
  String get name;
  double? get size;
  String? get style;
}

/// Wire discriminators, declared once per kind.
///
/// The exhaustive switch is the single source of truth for the vocabulary
/// (spec 1100 A4): adding a node class without a wire name — or removing
/// one without updating this switch — is a compile error.
extension ShadNodeX on ShadNode {
  /// The wire discriminator for this node kind.
  String get widgetType => switch (this) {
    ButtonNode() => 'button',
    BadgeNode() => 'badge',
    TextNode() => 'text',
    CardNode() => 'card',
    CardHeaderNode() => 'cardHeader',
    CardFooterNode() => 'cardFooter',
    InputNode() => 'input',
    SelectNode() => 'select',
    SelectOptionNode() => 'selectOption',
    CheckboxNode() => 'checkbox',
    SwitchNode() => 'switch',
    RadioGroupNode() => 'radioGroup',
    RadioOptionNode() => 'radioOption',
    FormItemNode() => 'formItem',
    TabsNode() => 'tabs',
    TabNode() => 'tab',
    TabPaneNode() => 'tabPane',
    ProgressNode() => 'progress',
    SeparatorNode() => 'separator',
    TooltipNode() => 'tooltip',
    SheetNode() => 'sheet',
    DialogNode() => 'dialog',
    PopoverNode() => 'popover',
    ToastNode() => 'toast',
    RowNode() => 'row',
    ColumnNode() => 'column',
    StackNode() => 'stack',
    PaddingNode() => 'padding',
    ExpandedNode() => 'expanded',
    SizedBoxNode() => 'sizedBox',
    ListViewNode() => 'listView',
    ImageNode() => 'image',
    IconNode() => 'icon',
    UnknownNode(:final widgetType) => widgetType,
  };
}
