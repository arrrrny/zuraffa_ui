import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/zfa.dart';

// U11: layout primitives map to the expected engine widgets with correct
// arrangement props.

ShadNodeTree _tree(Map<String, dynamic> root) =>
    ShadNodeParser().parse({'root': root});

Widget _harness(ShadNodeTree tree) => ShadApp(
  home: Scaffold(
    body: SingleChildScrollView(child: ShadNodeRenderer(tree: tree)),
  ),
);

void main() {
  testWidgets('row maps to Row with arrangement props and gap', (tester) async {
    final tree = _tree({
      'widgetType': 'row',
      'mainAxisAlignment': 'spaceBetween',
      'crossAxisAlignment': 'center',
      'gap': 12,
      'children': [
        {'widgetType': 'text', 'text': 'a'},
        {'widgetType': 'text', 'text': 'b'},
      ],
    });
    await tester.pumpWidget(_harness(tree));
    final row = tester.widget<Row>(
      find.ancestor(of: find.text('a'), matching: find.byType(Row)).first,
    );
    expect(row.mainAxisAlignment, MainAxisAlignment.spaceBetween);
    expect(row.crossAxisAlignment, CrossAxisAlignment.center);
    // gap: one 12px spacer between two children
    expect(row.children.whereType<SizedBox>(), isNotEmpty);
  });

  testWidgets('column maps to Column with gap spacer', (tester) async {
    final tree = _tree({
      'widgetType': 'column',
      'gap': 8,
      'children': [
        {'widgetType': 'text', 'text': 'a'},
        {'widgetType': 'text', 'text': 'b'},
      ],
    });
    await tester.pumpWidget(_harness(tree));
    final column = tester.widget<Column>(
      find.ancestor(of: find.text('a'), matching: find.byType(Column)).first,
    );
    expect(column.children.length, 3); // 2 children + 1 spacer
  });

  testWidgets('stack maps to Stack with center alignment', (tester) async {
    final tree = _tree({
      'widgetType': 'stack',
      'alignment': 'center',
      'children': [
        {'widgetType': 'text', 'text': 'under'},
        {'widgetType': 'text', 'text': 'over'},
      ],
    });
    await tester.pumpWidget(_harness(tree));
    final stack = tester.widget<Stack>(
      find.ancestor(of: find.text('over'), matching: find.byType(Stack)).first,
    );
    expect(stack.alignment, AlignmentDirectional.center);
  });

  testWidgets('padding maps to EdgeInsets from the spec', (tester) async {
    final tree = _tree({
      'widgetType': 'padding',
      'padding': {'left': 4, 'top': 6, 'right': 8, 'bottom': 10},
      'child': {'widgetType': 'text', 'text': 'padded'},
    });
    await tester.pumpWidget(_harness(tree));
    final padding = tester.widget<Padding>(
      find
          .ancestor(of: find.text('padded'), matching: find.byType(Padding))
          .last,
    );
    expect(
      padding.padding,
      isA<EdgeInsets>()
          .having((e) => e.left, 'left', 4)
          .having((e) => e.top, 'top', 6)
          .having((e) => e.right, 'right', 8)
          .having((e) => e.bottom, 'bottom', 10),
    );
  });

  testWidgets('expanded maps to Expanded with flex', (tester) async {
    final tree = _tree({
      'widgetType': 'row',
      'children': [
        {
          'widgetType': 'expanded',
          'flex': 3,
          'child': {'widgetType': 'text', 'text': 'wide'},
        },
      ],
    });
    await tester.pumpWidget(_harness(tree));
    final expanded = tester.widget<Expanded>(find.byType(Expanded).first);
    expect(expanded.flex, 3);
  });

  testWidgets('sizedBox maps to SizedBox with dimensions', (tester) async {
    final tree = _tree({
      'widgetType': 'sizedBox',
      'width': 40,
      'height': 24,
      'child': {'widgetType': 'text', 'text': 'boxed'},
    });
    await tester.pumpWidget(_harness(tree));
    final box = tester.widget<SizedBox>(
      find
          .ancestor(of: find.text('boxed'), matching: find.byType(SizedBox))
          .first,
    );
    expect(box.width, 40);
    expect(box.height, 24);
  });

  testWidgets('listView maps to ListView with spacing separators', (
    tester,
  ) async {
    final tree = _tree({
      'widgetType': 'listView',
      'spacing': 16,
      'shrinkWrap': true,
      'children': [
        {'widgetType': 'text', 'text': 'one'},
        {'widgetType': 'text', 'text': 'two'},
        {'widgetType': 'text', 'text': 'three'},
      ],
    });
    await tester.pumpWidget(_harness(tree));
    final list = tester.widget<ListView>(find.byType(ListView).first);
    expect(list.shrinkWrap, isTrue);
  });
}
