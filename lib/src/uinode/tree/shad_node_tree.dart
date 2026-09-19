import 'package:flutter/foundation.dart' show immutable;
import 'package:zuraffa_ui/src/uinode/nodes/nodes.dart';
import 'package:zuraffa_ui/src/uinode/tree/canonical_json.dart';

/// The tree envelope: one versioned root (spec 1100 FR-8, contracts).
///
/// Hand-written rather than generated: two fields and canonical-form deep
/// equality (the generated node equality is identity-based for lists/maps,
/// so trees compare through [shadTreeEquals]). Note the hash is therefore
/// *not* equality-consistent — do not use trees as map keys; compare and
/// diff them through the canonical form instead.
@immutable
class ShadNodeTree {
  const ShadNodeTree({required this.schemaVersion, required this.root});

  /// Current wire version of this runtime.
  static const int currentSchemaVersion = 1;

  /// The version this tree was authored against.
  final int schemaVersion;

  /// The root node; never null (an empty UI is e.g. an empty column).
  final ShadNode root;

  @override
  bool operator ==(Object other) =>
      other is ShadNodeTree && shadTreeEquals(other, this);

  @override
  int get hashCode => Object.hash(schemaVersion, root.hashCode);

  @override
  String toString() => 'ShadNodeTree(v$schemaVersion, ${root.widgetType})';
}
