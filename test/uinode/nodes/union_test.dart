import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/uinode.dart';

// U1: every node class reports its const `widgetType` discriminator, carries
// an optional `id`, and the `ShadNode` union switches exhaustively.
// U2: `UnknownNode` preserves an unrecognized object's `widgetType` and raw
// JSON through parse → canonical → parse (round-trip proof lands with the
// parser/canonical behaviors; this file asserts the entity contract).

void main() {
  // Exhaustive switch over the union — a missing case is a compile error.
  String describe(ShadNode node) => switch (node) {
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
    UnknownNode() => 'unknown',
  };

  test('every node class reports its const wire widgetType', () {
    final cases = <Object, String>{
      ButtonNode(label: 'Go'): 'button',
      BadgeNode(label: 'new'): 'badge',
      TextNode(text: 'hi'): 'text',
      CardNode(content: const []): 'card',
      CardHeaderNode(): 'cardHeader',
      CardFooterNode(content: const []): 'cardFooter',
      InputNode(): 'input',
      SelectNode(options: const []): 'select',
      SelectOptionNode(value: 'a', label: 'A'): 'selectOption',
      CheckboxNode(): 'checkbox',
      SwitchNode(): 'switch',
      RadioGroupNode(options: const []): 'radioGroup',
      RadioOptionNode(value: 'a', label: 'A'): 'radioOption',
      FormItemNode(
        label: 'Email',
        field: TextNode(text: 'x'),
      ): 'formItem',
      TabsNode(tabs: const [], panes: const []): 'tabs',
      TabNode(value: 'a', label: 'A'): 'tab',
      TabPaneNode(value: 'a', content: const []): 'tabPane',
      ProgressNode(value: 0.5): 'progress',
      SeparatorNode(): 'separator',
      TooltipNode(message: 'hi'): 'tooltip',
      SheetNode(content: const []): 'sheet',
      DialogNode(actions: const [], content: const []): 'dialog',
      PopoverNode(content: const []): 'popover',
      ToastNode(title: 'Saved'): 'toast',
      RowNode(children: const []): 'row',
      ColumnNode(children: const []): 'column',
      StackNode(children: const []): 'stack',
      PaddingNode(padding: const PaddingSpec.all(8)): 'padding',
      ExpandedNode(child: TextNode(text: 'x')): 'expanded',
      SizedBoxNode(): 'sizedBox',
      ListViewNode(children: const []): 'listView',
      ImageNode(src: 'https://example.com/a.png'): 'image',
      IconNode(name: 'plus'): 'icon',
    };
    for (final entry in cases.entries) {
      final node = entry.key as ShadNode;
      expect(
        node.widgetType,
        entry.value,
        reason: '${node.runtimeType} wire name',
      );
      expect(describe(node), entry.value, reason: 'exhaustive switch');
    }
  });

  test('id is optional on every node and preserved when set', () {
    final node = ButtonNode(label: 'Go', id: 'submit-btn');
    expect(node.id, 'submit-btn');
    expect(BadgeNode(label: 'new').id, isNull);
  });

  test('UnknownNode keeps the offending widgetType and raw object', () {
    final raw = <String, dynamic>{
      'widgetType': 'hologram',
      'intensity': 11,
    };
    final node = UnknownNode(widgetType: 'hologram', raw: raw);
    expect(node.widgetType, 'hologram');
    expect(node.raw['intensity'], 11);
    expect(describe(node), 'unknown');
  });
}
