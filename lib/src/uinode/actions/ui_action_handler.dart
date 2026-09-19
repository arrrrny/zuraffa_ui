/// Actions are semantic IDs resolved by the host (spec 1100 FR-6/FR-7).
///
/// A node's `action` never carries behavior — only a name and args. The
/// host registers handlers here; dispatch failures surface through the
/// typed callbacks, never as exceptions (research D6).
library;

import 'package:flutter/foundation.dart';

/// A host-provided handler for one action name; registered on
/// `UiActionRegistry` and invoked with the wire args verbatim.
typedef UiActionHandler = void Function(String name, Map<String, dynamic> args);

/// Observes an action name no handler was registered for; see the
/// `onUnknownAction` field of the registry.
typedef UiUnknownActionCallback = void Function(String name);

/// Observes a registered handler that threw; the error is contained.
typedef UiHandlerErrorCallback =
    void Function(
      String name,
      Object error,
      StackTrace stackTrace,
    );

/// The host's name → handler map plus its error surface.
class UiActionRegistry {
  UiActionRegistry({
    Map<String, UiActionHandler> handlers = const {},
    this.onUnknownAction,
    this.onHandlerError,
  }) : _handlers = Map.of(handlers);

  final Map<String, UiActionHandler> _handlers;

  /// Called when `dispatch` receives a name nobody registered.
  final UiUnknownActionCallback? onUnknownAction;

  /// Called when a handler throws; the error never escapes `dispatch`.
  final UiHandlerErrorCallback? onHandlerError;

  /// Registers (or replaces) the handler for [name].
  void register(String name, UiActionHandler handler) {
    _handlers[name] = handler;
  }

  /// Removes the handler for [name], if any.
  void unregister(String name) {
    _handlers.remove(name);
  }

  /// Whether a handler is registered for [name].
  bool handles(String name) => _handlers.containsKey(name);

  /// Resolves [name] against the registry and invokes the handler with
  /// [args] (spec 1100 FR-6).
  ///
  /// Never throws (FR-7): an unknown name surfaces through
  /// [onUnknownAction]; a throwing handler surfaces through
  /// [onHandlerError]. With no observers installed the failure is swallowed
  /// in release and reported through [FlutterError] in debug — the host
  /// stays interactive either way (research D6).
  void dispatch(String name, Map<String, dynamic> args) {
    final handler = _handlers[name];
    if (handler == null) {
      final onUnknown = onUnknownAction;
      if (onUnknown != null) {
        onUnknown(name);
      } else {
        _debugReport('no handler registered for action "$name"');
      }
      return;
    }
    try {
      handler(name, args);
      // Handlers may throw Error or Exception — both are contained.
      // ignore: avoid_catches_without_on_clauses
    } catch (error, stackTrace) {
      final onError = onHandlerError;
      if (onError != null) {
        onError(name, error, stackTrace);
      } else {
        _debugReport(
          'action handler "$name" threw: $error',
          error,
          stackTrace,
        );
      }
    }
  }

  void _debugReport(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error ?? StateError(message),
          stack: stackTrace,
          library: 'zuraffa_ui/uinode',
          informationCollector: () => [DiagnosticsNode.message(message)],
        ),
      );
    }
  }
}
