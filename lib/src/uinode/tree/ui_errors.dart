/// Typed parse/validate failures and render events (spec 1100 FR-8/FR-9/FR-12).
///
/// Every hostile-tree outcome is one of these types — nothing in the layer
/// throws anything else, and nothing escapes as a crash (research D4).
library;

/// Which composition cap a [UiTreeTooLarge] hit.
enum UiCapKind { depth, nodes, textLength }

/// Why a [UiParseError] was raised.
enum UiParseErrorKind {
  /// Unknown key, wrong prop type, or wrong value shape.
  schema,

  /// A prop value outside the allowed vocabulary (e.g. `variant: 'mega'`).
  enumValue,

  /// A child-arity violation (0 children where exactly 1 is required, …).
  arity,

  /// A raw color where a theme-token reference belongs (FR-16).
  colorRejected,

  /// The payload is not a JSON object where one was required.
  malformed,
}

/// Base type of every parse/validation failure.
///
/// [path] is the location inside the tree, e.g. `root/content[2]/child`.
sealed class UiParseException implements Exception {
  UiParseException(this.path, this.message);

  /// Human-readable explanation (includes [path]).
  final String message;

  /// Location inside the tree, `root`-rooted.
  final String path;

  @override
  String toString() => 'UiParseException($message)';
}

/// A composition cap was exceeded (FR-12): depth > 32, nodes > 500, or
/// text > the configured maximum.
class UiTreeTooLarge extends UiParseException {
  UiTreeTooLarge({
    required this.cap,
    required String path,
    required String message,
  }) : super(path, message);

  /// The cap that was exceeded.
  final UiCapKind cap;
}

/// The tree's `schemaVersion` is newer than this runtime understands (FR-8).
class UiVersionError extends UiParseException {
  UiVersionError({
    required this.found,
    required this.supported,
    String? path,
  }) : super(
         path ?? 'root',
         'schemaVersion $found newer than supported $supported',
       );

  /// The version found on the wire.
  final int found;

  /// The newest major version this runtime supports.
  final int supported;
}

/// A malformed or rule-violating tree (unknown keys, wrong types, bad enum
/// values, raw colors, arity violations — the kind names it).
class UiParseError extends UiParseException {
  UiParseError({
    required this.kind,
    required String path,
    required String message,
  }) : super(path, message);

  /// Why the tree was rejected.
  final UiParseErrorKind kind;
}

/// A render-time notice (FR-9): e.g. an `UnknownNode` omitted in release
/// mode. Events never throw; hosts observe them through the renderer.
class UiNodeEvent {
  UiNodeEvent({required this.kind, this.path});

  /// Event name, e.g. `'unknownNodeOmitted'`.
  final String kind;

  /// Location inside the tree, if the event concerns a node.
  final String? path;

  @override
  String toString() => 'UiNodeEvent($kind, path: $path)';
}
