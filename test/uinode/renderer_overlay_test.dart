import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/zfa.dart';

// U15: overlay nodes render trigger/panes; the `open` prop and tab
// switching behave.

ShadNodeTree _tree(Map<String, dynamic> root) =>
    ShadNodeParser().parse({'root': root});

Widget _harness(ShadNodeTree tree) => ShadApp(
  home: Scaffold(
    body: SingleChildScrollView(child: ShadNodeRenderer(tree: tree)),
  ),
);

void main() {
  testWidgets('tabs render panes and switch on tap', (tester) async {
    final tree = _tree({
      'widgetType': 'tabs',
      'value': 'account',
      'tabs': [
        {'value': 'account', 'label': 'Account'},
        {'value': 'password', 'label': 'Password'},
      ],
      'panes': [
        {
          'value': 'account',
          'content': [
            {'widgetType': 'text', 'text': 'account pane'},
          ],
        },
        {
          'value': 'password',
          'content': [
            {'widgetType': 'text', 'text': 'password pane'},
          ],
        },
      ],
    });
    await tester.pumpWidget(_harness(tree));
    expect(find.byType(ShadTabs<String>), findsOneWidget);
    expect(find.text('account pane'), findsOneWidget);
    expect(find.text('password pane'), findsNothing);

    await tester.tap(find.text('Password'));
    await tester.pumpAndSettle();
    expect(find.text('password pane'), findsOneWidget);
    expect(find.text('account pane'), findsNothing);
  });

  testWidgets('tooltip wraps its child', (tester) async {
    final tree = _tree({
      'widgetType': 'tooltip',
      'message': 'Helpful hint',
      'child': {
        'widgetType': 'text',
        'text': 'hover me',
      },
    });
    await tester.pumpWidget(_harness(tree));
    expect(find.byType(ShadTooltip), findsOneWidget);
    expect(find.text('hover me'), findsOneWidget);
  });

  testWidgets('pane state keys do not collide across panes', (tester) async {
    // Children used to derive state keys from the tabs node's path
    // alone, so pane 0 child 0 and pane 1 child 0 shared one lifted-state
    // slot and a remount re-seeded from the other pane's last value.
    final tree = _tree({
      'widgetType': 'tabs',
      'value': 'a',
      'tabs': [
        {'value': 'a', 'label': 'A'},
        {'value': 'b', 'label': 'B'},
      ],
      'panes': [
        {
          'value': 'a',
          'content': [
            {'widgetType': 'input', 'placeholder': 'first pane'},
          ],
        },
        {
          'value': 'b',
          'content': [
            {'widgetType': 'input', 'placeholder': 'second pane'},
          ],
        },
      ],
    });
    await tester.pumpWidget(_harness(tree));

    await tester.enterText(find.byType(ShadInput).first, 'from pane a');
    await tester.pump();

    await tester.tap(find.text('B'));
    await tester.pumpAndSettle();
    // Pane b's id-less input must not pick up pane a's value on mount.
    expect(find.text('from pane a'), findsNothing);
    final paneB = tester.widget<EditableText>(find.byType(EditableText));
    expect(paneB.controller.text, isEmpty);
  });

  testWidgets('hand-built tooltip with a null child renders, not crashes', (
    tester,
  ) async {
    // The entity allows a null child; only the parser enforces arity.
    // A Dart-constructed tree used to hit a null-check crash.
    final tree = ShadNodeTree(
      schemaVersion: 1,
      root: TooltipNode(message: 'hi'),
    );
    await tester.pumpWidget(_harness(tree));
    expect(tester.takeException(), isNull);
  });

  testWidgets('sheet with open=true shows natively', (tester) async {
    final tree = _tree({
      'widgetType': 'sheet',
      'open': true,
      'side': 'bottom',
      'title': 'Edit profile',
      'content': [
        {'widgetType': 'text', 'text': 'sheet body'},
      ],
    });
    await tester.pumpWidget(_harness(tree));
    await tester.pumpAndSettle();
    expect(find.byType(ShadSheet), findsOneWidget);
    expect(find.text('sheet body'), findsOneWidget);
  });

  testWidgets('dialog trigger opens on tap', (tester) async {
    final tree = _tree({
      'widgetType': 'dialog',
      'title': 'Confirm',
      'content': [
        {'widgetType': 'text', 'text': 'dialog body'},
      ],
      'actions': [
        {'widgetType': 'button', 'label': 'OK'},
      ],
      'trigger': {'widgetType': 'button', 'label': 'Open dialog'},
    });
    await tester.pumpWidget(_harness(tree));
    expect(find.byType(ShadDialog), findsNothing);

    await tester.tap(find.text('Open dialog'));
    await tester.pumpAndSettle();
    expect(find.byType(ShadDialog), findsOneWidget);
    expect(find.text('dialog body'), findsOneWidget);
  });

  testWidgets('popover trigger toggles its content', (tester) async {
    final tree = _tree({
      'widgetType': 'popover',
      'content': [
        {'widgetType': 'text', 'text': 'popover body'},
      ],
      'trigger': {'widgetType': 'button', 'label': 'Open popover'},
    });
    await tester.pumpWidget(_harness(tree));
    expect(find.text('popover body'), findsNothing);

    await tester.tap(find.text('Open popover'));
    await tester.pumpAndSettle();
    expect(find.text('popover body'), findsOneWidget);
  });

  testWidgets('toast renders inline', (tester) async {
    final tree = _tree({
      'widgetType': 'toast',
      'title': 'Saved',
      'description': 'All changes stored',
      'variant': 'success',
    });
    await tester.pumpWidget(_harness(tree));
    expect(find.byType(ShadToast), findsOneWidget);
    expect(find.text('Saved'), findsOneWidget);
  });
}
