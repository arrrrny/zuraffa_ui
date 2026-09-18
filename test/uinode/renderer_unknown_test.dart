import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/zfa.dart';

// U16: UnknownNode renders a visible placeholder in debug
// (debugFallbacks: true), is omitted with a UiNodeEvent in release
// (false), and never breaks sibling rendering.

ShadNodeTree _tree() => ShadNodeParser().parse(const {
  'root': {
    'widgetType': 'column',
    'children': [
      {'widgetType': 'text', 'text': 'before'},
      {'widgetType': 'hologram', 'intensity': 11},
      {'widgetType': 'text', 'text': 'after'},
    ],
  },
});

void main() {
  testWidgets('debug: visible placeholder with the offending type', (
    tester,
  ) async {
    final events = <UiNodeEvent>[];
    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(
          body: ShadNodeRenderer(
            tree: _tree(),
            onNodeEvent: events.add,
          ),
        ),
      ),
    );
    expect(find.text('before'), findsOneWidget);
    expect(find.text('after'), findsOneWidget);
    expect(find.textContaining('hologram'), findsOneWidget);
    expect(events, isEmpty);
  });

  testWidgets('release: omitted with an event, siblings unaffected', (
    tester,
  ) async {
    final events = <UiNodeEvent>[];
    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(
          body: ShadNodeRenderer(
            tree: _tree(),
            debugFallbacks: false,
            onNodeEvent: events.add,
          ),
        ),
      ),
    );
    expect(find.text('before'), findsOneWidget);
    expect(find.text('after'), findsOneWidget);
    expect(find.textContaining('hologram'), findsNothing);
    expect(events, hasLength(1));
    expect(events.single.kind, 'unknownNodeOmitted');
    expect(events.single.path, contains('children[1]'));
  });
}
