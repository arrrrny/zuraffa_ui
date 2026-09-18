import 'package:flutter/foundation.dart' show immutable;

/// A semantic action reference: `{"action": name, "args": {...}}`.
///
/// Opaque to this layer — the host's `UiActionRegistry` resolves the name
/// at interaction time (spec 1100 FR-6). Args pass through verbatim.
@immutable
class ActionId {
  const ActionId(this.name, {this.args = const <String, dynamic>{}});

  factory ActionId.fromJson(Map<String, dynamic> json) => ActionId(
    json['action']! as String,
    args: (json['args'] as Map<String, dynamic>?) ?? const <String, dynamic>{},
  );

  final String name;
  final Map<String, dynamic> args;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'action': name,
    if (args.isNotEmpty) 'args': args,
  };

  @override
  bool operator ==(Object other) =>
      other is ActionId && other.name == name && other.args == args;

  @override
  int get hashCode => Object.hash(name, args);

  @override
  String toString() => 'ActionId${toJson()}';
}

/// Edge insets as pure data (logical pixels per edge).
///
/// Hand-written rather than generated so the canonical JSON key order is
/// fixed by contract (research D2): emitted as
/// `{"bottom":…,"left":…,"right":…,"top":…}` with only the non-zero edges
/// present; an all-around inset collapses to `{"all":…}`.
@immutable
class PaddingSpec {
  const PaddingSpec.all(double value)
    : left = value,
      top = value,
      right = value,
      bottom = value,
      all = value;

  const PaddingSpec.only({
    this.left = 0,
    this.top = 0,
    this.right = 0,
    this.bottom = 0,
  }) : all = null;

  const PaddingSpec.symmetric({double horizontal = 0, double vertical = 0})
    : left = horizontal,
      top = vertical,
      right = horizontal,
      bottom = vertical,
      all = null;

  final double? all;
  final double left;
  final double top;
  final double right;
  final double bottom;

  Map<String, dynamic> toJson() => all != null
      ? <String, dynamic>{'all': all}
      : <String, dynamic>{
          'bottom': bottom,
          'left': left,
          'right': right,
          'top': top,
        };

  static PaddingSpec fromJson(Map<String, dynamic> json) {
    final all = (json['all'] as num?)?.toDouble();
    if (all != null) return PaddingSpec.all(all);
    return PaddingSpec.only(
      left: (json['left'] as num?)?.toDouble() ?? 0,
      top: (json['top'] as num?)?.toDouble() ?? 0,
      right: (json['right'] as num?)?.toDouble() ?? 0,
      bottom: (json['bottom'] as num?)?.toDouble() ?? 0,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is PaddingSpec &&
      other.all == all &&
      other.left == left &&
      other.top == top &&
      other.right == right &&
      other.bottom == bottom;

  @override
  int get hashCode => Object.hash(all, left, top, right, bottom);

  @override
  String toString() => 'PaddingSpec${toJson()}';
}
