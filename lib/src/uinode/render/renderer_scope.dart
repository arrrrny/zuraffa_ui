import 'package:flutter/widgets.dart';

/// Renderer-scoped lifted state (spec 1100 FR-11, research D5).
///
/// Interactive nodes (tabs, checkbox, switch, input, select, radio group)
/// keep their state here, keyed by the node's structural path
/// (`root/content[1]`). Paths derive from the tree, so identical JSON
/// re-renders deterministically, and two renderers of one tree never share
/// state. A node's host `id`, when present, is used instead of the path so
/// hosts can address state stably across edits.
class NodeRenderScope extends InheritedWidget {
  const NodeRenderScope({
    super.key,
    required this.store,
    required super.child,
  });

  /// The state store of the enclosing renderer.
  final Map<String, Object?> store;

  static NodeRenderScope? maybeOf(BuildContext context) =>
      context.getInheritedWidgetOfExactType<NodeRenderScope>();

  @override
  bool updateShouldNotify(NodeRenderScope oldWidget) => false;

  /// Reads the value stored for [key].
  static T? state<T extends Object?>(BuildContext context, String key) =>
      maybeOf(context)?.store[key] as T?;

  /// Writes [value] for [key] without rebuilding the whole renderer —
  /// interactive mappers own their local rebuild via their own setState.
  static void put(BuildContext context, String key, Object? value) {
    maybeOf(context)?.store[key] = value;
  }
}
