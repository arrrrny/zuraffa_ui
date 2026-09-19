import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/zfa.dart';

// U14: form nodes render; toggling/selecting updates renderer-scoped state;
// two renderers of the same tree hold independent state.

ShadNodeTree _tree(Map<String, dynamic> root) =>
    ShadNodeParser().parse({'root': root});

Widget _harness(ShadNodeTree tree) => ShadApp(
  home: Scaffold(
    body: SingleChildScrollView(child: ShadNodeRenderer(tree: tree)),
  ),
);

void main() {
  testWidgets('input renders placeholder and label chrome', (tester) async {
    final tree = _tree({
      'widgetType': 'input',
      'placeholder': 'Email',
      'label': 'Your email',
      'helper': 'We never share it',
    });
    await tester.pumpWidget(_harness(tree));
    expect(find.byType(ShadInput), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Your email'), findsOneWidget);
    expect(find.text('We never share it'), findsOneWidget);
  });

  testWidgets('checkbox toggles and keeps renderer-scoped state', (
    tester,
  ) async {
    final tree = _tree({
      'widgetType': 'checkbox',
      'label': 'Subscribe',
      'value': false,
    });
    await tester.pumpWidget(_harness(tree));
    expect(find.byType(ShadCheckbox), findsOneWidget);

    await tester.tap(find.text('Subscribe'));
    await tester.pump();
    expect(
      tester.widget<ShadCheckbox>(find.byType(ShadCheckbox)).value,
      isTrue,
    );
  });

  testWidgets('switch toggles', (tester) async {
    final tree = _tree({
      'widgetType': 'switch',
      'label': 'Dark mode',
      'value': false,
    });
    await tester.pumpWidget(_harness(tree));
    await tester.tap(find.text('Dark mode'));
    await tester.pump();
    expect(
      tester.widget<ShadSwitch>(find.byType(ShadSwitch)).value,
      isTrue,
    );
  });

  testWidgets('radio group renders its options', (tester) async {
    final tree = _tree({
      'widgetType': 'radioGroup',
      'options': [
        {'value': 'a', 'label': 'Alpha'},
        {'value': 'b', 'label': 'Beta'},
      ],
    });
    await tester.pumpWidget(_harness(tree));
    expect(find.byType(ShadRadioGroup<String>), findsOneWidget);
    expect(find.text('Alpha'), findsOneWidget);
    expect(find.text('Beta'), findsOneWidget);
  });

  testWidgets('formItem renders label, field and error chrome', (tester) async {
    final tree = _tree({
      'widgetType': 'formItem',
      'label': 'Email',
      'required': true,
      'errorText': 'Required field',
      'field': {
        'widgetType': 'input',
        'placeholder': 'you@example.com',
      },
    });
    await tester.pumpWidget(_harness(tree));
    expect(find.text('Email *'), findsOneWidget);
    expect(find.text('Required field'), findsOneWidget);
    expect(find.byType(ShadInput), findsOneWidget);
  });

  testWidgets('two renderers of the same tree hold independent state', (
    tester,
  ) async {
    final tree = _tree({
      'widgetType': 'row',
      'crossAxisAlignment': 'start',
      'children': [
        {
          'widgetType': 'column',
          'children': [
            {'widgetType': 'checkbox', 'id': 'shared', 'label': 'Left'},
          ],
        },
        {
          'widgetType': 'column',
          'children': [
            {'widgetType': 'checkbox', 'id': 'shared', 'label': 'Right'},
          ],
        },
      ],
    });
    // Same id on both checkboxes BUT different paths — wait: id overrides
    // the path key, so same-id nodes in ONE renderer share state by design.
    // Two separate renderers must NOT share state. Assert the renderer's
    // two checkboxes are independent widgets driven by their own state
    // objects after one is tapped.
    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(
          body: Column(
            children: [
              ShadNodeRenderer(tree: tree, key: const Key('one')),
              ShadNodeRenderer(tree: tree, key: const Key('two')),
            ],
          ),
        ),
      ),
    );
    expect(find.byType(ShadCheckbox), findsNWidgets(4));
    // Tapping 'Left' in the FIRST renderer must not affect the second.
    await tester.tap(find.text('Left').first);
    await tester.pump();
    final checkboxes = tester
        .widgetList<ShadCheckbox>(find.byType(ShadCheckbox))
        .toList();
    expect(checkboxes[0].value, isTrue);
    expect(
      checkboxes[2].value,
      isFalse,
      reason: 'second renderer keeps its own state',
    );
  });
}
