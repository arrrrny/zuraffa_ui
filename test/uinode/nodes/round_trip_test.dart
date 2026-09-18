import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/uinode.dart';

import '../helpers/gen.dart';

// A1 / SC-2: every node type survives `tree → canonical JSON → tree` with
// equality, over the seeded prop space. Equality is canonical-form
// byte-equality (the contract's diffing currency).

void main() {
  final trees = generateEveryNodeType()
      .map((root) => ShadNodeTree(schemaVersion: 1, root: root))
      .toList();

  test('every v1 node type is covered by the generator', () {
    final kinds = trees.map((t) => t.root.widgetType).toSet();
    expect(kinds, containsAll(ShadNodeParser().supportedWidgetTypes));
  });

  test('round-trip preserves every node (equality + byte stability)', () {
    for (final tree in trees) {
      final canonical = canonicalJson(tree);
      final reparsed = ShadNodeParser().parse(canonical);
      expect(
        canonicalJson(reparsed),
        canonical,
        reason: 'round-trip altered ${tree.root.widgetType}',
      );
    }
  });

  test('UnknownNode raw objects survive the round-trip', () {
    final unknown = trees
        .map((t) => t.root)
        .whereType<UnknownNode>()
        .first;
    final canonical = canonicalJson(
      ShadNodeTree(schemaVersion: 1, root: unknown),
    );
    final reparsed =
        ShadNodeParser().parse(canonical).root as UnknownNode;
    expect(reparsed.widgetType, unknown.widgetType);
    expect(reparsed.raw['level'], unknown.raw['level']);
  });
}
