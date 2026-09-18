/// Actions are semantic IDs resolved by the host (spec 1100 FR-6/FR-7).
///
/// A node's `action` never carries behavior — only a name and args. The
/// host registers handlers here; dispatch failures surface through the
/// typed callbacks, never as exceptions (research D6).
library;

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
}
