import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/zfa.dart';

Widget _harness(ShadNodeTree tree, UiActionRegistry registry) => ShadApp(
  home: Scaffold(
    body: ShadNodeRenderer(tree: tree, actions: registry),
  ),
);

void main() {
  final tree = ShadNodeParser().parse(const {
    'root': {
      'widgetType': 'column',
      'children': [
        {
          'widgetType': 'button',
          'label': 'Save',
          'action': {
            'action': 'save',
            'args': {'id': 7},
          },
        },
        {
          'widgetType': 'button',
          'label': 'Unknown',
          'action': {'action': 'does_not_exist'},
        },
        {
          'widgetType': 'button',
          'label': 'Boom',
          'action': {'action': 'boom'},
        },
      ],
    },
  });

  test(
    'U17-U19: registry resolves, contains unknown and throwing handlers',
    () {
      final registry = UiActionRegistry(
        onUnknownAction: (_) {},
        onHandlerError: (_, __, ___) {},
      );
      registry.register('save', (_, __) {});
      registry.register('boom', (_, __) {});
      expect(registry.handles('save'), isTrue);
      expect(registry.handles('does_not_exist'), isFalse);
      registry.unregister('save');
      expect(registry.handles('save'), isFalse);
    },
  );

  testWidgets('U17: resolved handler is invoked with its args', (tester) async {
    final names = <String>[];
    final argses = <Map<String, dynamic>>[];
    final registry = UiActionRegistry()
      ..register('save', (name, args) {
        names.add(name);
        argses.add(args);
      });

    await tester.pumpWidget(_harness(tree, registry));
    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(names, ['save']);
    expect(argses.single['id'], 7);
  });

  testWidgets('U18: unknown action surfaces via callback, never throws', (
    tester,
  ) async {
    final unknown = <String>[];
    final registry = UiActionRegistry(
      onUnknownAction: (name) => unknown.add(name),
    )..register('save', (_, __) {});

    await tester.pumpWidget(_harness(tree, registry));
    await tester.tap(find.text('Unknown'));
    await tester.pump();

    expect(unknown, ['does_not_exist']);
    // The tree still renders and interacts.
    await tester.tap(find.text('Save'));
    expect(tester.takeException(), isNull);
  });

  testWidgets('U19: throwing handler is contained; siblings stay interactive', (
    tester,
  ) async {
    final errors = <String>[];
    var saveCount = 0;
    final registry =
        UiActionRegistry(
            onHandlerError: (name, _, __) => errors.add(name),
          )
          ..register('boom', (_, __) => throw StateError('boom'))
          ..register('save', (_, __) => saveCount++);

    await tester.pumpWidget(_harness(tree, registry));
    await tester.tap(find.text('Boom'));
    await tester.pump();

    expect(errors, ['boom']);
    expect(saveCount, 0);

    await tester.tap(find.text('Save'));
    await tester.pump();
    expect(saveCount, 1);
    expect(tester.takeException(), isNull);
  });

  test('ActionId equality is deep on args, not instance-based', () {
    // Map identity used to decide args equality, so structurally equal
    // actions from separately-parsed nodes compared unequal. Map.of keeps
    // the two instances distinct (a const literal would canonicalize).
    final a = ActionId('save', args: Map.of(const {'id': 7}));
    final b = ActionId('save', args: Map.of(const {'id': 7}));
    expect(identical(a, b), isFalse);
    expect(a, equals(b));
    expect(a.hashCode, b.hashCode);
    expect(a, isNot(equals(ActionId('save', args: Map.of(const {'id': 8})))));
    expect(a, isNot(equals(const ActionId('save'))));
    expect(const ActionId('x'), equals(const ActionId('x')));
  });
}
