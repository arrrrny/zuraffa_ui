/// Deterministic tree generator over the node prop space (research D9).
///
/// Seeded so every run — local or CI — explores the same variations. Used
/// by the round-trip suite (SC-2 / behavior A1).
library;

import 'dart:math';

import 'package:zuraffa_ui/uinode.dart';

final Random _rng = Random(1100);

int _pick(int max) => _rng.nextInt(max);

String _slug(String prefix, int i) => '$prefix-$i';

/// A random prop-filled instance of every node kind.
List<ShadNode> generateEveryNodeType({int variationsPerType = 3}) => [
  for (var v = 0; v < variationsPerType; v++) ..._oneOfEach(v),
];

List<ShadNode> _oneOfEach(int v) {
  final flag = _pick(2) == 0;
  final n = _pick(100);
  return [
    ButtonNode(
      id: _slug('btn', v),
      label: _slug('Go', n),
      variant: [
        'primary',
        'secondary',
        'destructive',
        'outline',
        'ghost',
        'link',
      ][_pick(6)],
      size: ['sm', 'md', 'lg'][_pick(3)],
      action: ActionId('a$v', args: {'k': n}),
    ),
    BadgeNode(
      label: _slug('badge', v),
      variant: ['default', 'secondary', 'destructive', 'outline'][_pick(4)],
    ),
    TextNode(
      text: _slug('text', v),
      style: [
        'h1',
        'h2',
        'h3',
        'h4',
        'p',
        'muted',
        'small',
        'large',
        'bold',
      ][_pick(9)],
      align: ['start', 'center', 'end', 'justify'][_pick(4)],
    ),
    CardHeaderNode(title: _slug('h', v), description: _slug('d', v)),
    CardFooterNode(
      content: [TextNode(text: _slug('f', v))],
    ),
    CardNode(
      title: _slug('card', v),
      description: flag ? _slug('desc', v) : null,
      content: [TextNode(text: _slug('c', v))],
      header: CardHeaderNode(title: _slug('ch', v)),
    ),
    InputNode(
      id: _slug('in', v),
      value: _slug('v', v),
      placeholder: _slug('ph', v),
      label: _slug('l', v),
      helper: _slug('h', v),
      errorText: flag ? _slug('e', v) : null,
      enabled: flag,
      obscure: !flag,
      keyboard: ['text', 'number', 'emailAddress'][_pick(3)],
    ),
    SelectNode(
      options: [
        SelectOptionNode(value: 'a$v', label: 'A$v'),
        SelectOptionNode(value: 'b$v', label: 'B$v', enabled: flag),
      ],
      value: 'a$v',
      placeholder: _slug('sel', v),
      enabled: flag,
    ),
    SelectOptionNode(value: _slug('o', v), label: _slug('O', v), enabled: flag),
    CheckboxNode(value: flag, label: _slug('cb', v), enabled: flag),
    SwitchNode(value: !flag, label: _slug('sw', v)),
    RadioGroupNode(
      options: [
        RadioOptionNode(value: 'r$v', label: 'R$v'),
        RadioOptionNode(value: 's$v', label: 'S$v'),
      ],
      value: 'r$v',
      action: ActionId('radio$v'),
    ),
    RadioOptionNode(value: _slug('ro', v), label: _slug('RO', v)),
    FormItemNode(
      label: _slug('fi', v),
      field: InputNode(placeholder: _slug('fip', v)),
      required_: flag,
    ),
    TabsNode(
      tabs: [
        TabNode(value: 't$v', label: 'T$v'),
        TabNode(value: 'u$v', label: 'U$v'),
      ],
      panes: [
        TabPaneNode(
          value: 't$v',
          content: [TextNode(text: _slug('tp', v))],
        ),
        TabPaneNode(
          value: 'u$v',
          content: [TextNode(text: _slug('up', v))],
        ),
      ],
      value: 't$v',
    ),
    TabNode(value: _slug('t', v), label: _slug('T', v)),
    TabPaneNode(
      value: _slug('p', v),
      content: [TextNode(text: _slug('pc', v))],
    ),
    ProgressNode(
      value: _pick(101) / 100,
      indeterminate: flag,
    ),
    SeparatorNode(orientation: flag ? 'horizontal' : 'vertical'),
    TooltipNode(
      message: _slug('tip', v),
      child: TextNode(text: _slug('tc', v)),
    ),
    SheetNode(
      side: ['top', 'bottom', 'left', 'right'][_pick(4)],
      title: _slug('sheet', v),
      open: flag,
      content: [TextNode(text: _slug('sc', v))],
      trigger: ButtonNode(label: _slug('open', v)),
    ),
    DialogNode(
      title: _slug('dlg', v),
      open: flag,
      actions: [ButtonNode(label: _slug('ok', v))],
      content: [TextNode(text: _slug('dc', v))],
      trigger: ButtonNode(label: _slug('dl', v)),
    ),
    PopoverNode(
      open: flag,
      content: [TextNode(text: _slug('pc', v))],
      trigger: ButtonNode(label: _slug('po', v)),
    ),
    ToastNode(
      title: _slug('toast', v),
      description: _slug('td', v),
      variant: [
        'default',
        'destructive',
        'success',
        'warning',
        'info',
      ][_pick(5)],
    ),
    RowNode(
      children: [TextNode(text: _slug('r', v))],
      mainAxisAlignment: ['start', 'center', 'spaceBetween'][_pick(3)],
      crossAxisAlignment: ['start', 'center', 'stretch'][_pick(3)],
      gap: n.toDouble(),
    ),
    ColumnNode(
      children: [TextNode(text: _slug('c2', v))],
      mainAxisAlignment: 'start',
      gap: n.toDouble(),
    ),
    StackNode(
      children: [TextNode(text: _slug('st', v))],
      alignment: ['center', 'topLeft', 'bottomRight'][_pick(3)],
    ),
    PaddingNode(
      padding: flag
          ? const PaddingSpec.all(8)
          : const PaddingSpec.only(left: 2),
      child: TextNode(text: _slug('pd', v)),
    ),
    ExpandedNode(
      child: TextNode(text: _slug('ex', v)),
      flex: 1 + _pick(4),
    ),
    SizedBoxNode(width: n.toDouble(), height: _pick(50).toDouble()),
    ListViewNode(
      children: [TextNode(text: _slug('lv', v))],
      spacing: _pick(20).toDouble(),
      shrinkWrap: true,
      reverse: flag,
    ),
    ImageNode(
      src: 'https://example.com/$v.png',
      fit: ['cover', 'contain', 'fill'][_pick(3)],
      width: _pick(200).toDouble(),
      alt: _slug('alt', v),
    ),
    IconNode(name: 'plus', size: _pick(32).toDouble(), style: 'primary'),
    UnknownNode(
      widgetType: 'mystery$v',
      raw: {'widgetType': 'mystery$v', 'level': n},
    ),
  ];
}
