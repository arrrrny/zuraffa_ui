import 'package:flutter/widgets.dart';

/// The typed contract protocol every identified Zfa component carries.
///
/// This is the protocol the 006-login-skin pilot's runtime auditor had to
/// work around with duck typing (`try`/`on NoSuchMethodError` probes on
/// `.onPressed`). An identified component answers directly:
///
/// ```dart
/// final button = ZfaButton();
/// button.contractId; // 'zfa.button'
/// button.contractEnabled; // true
/// ```
///
/// Runtime contract auditors, xray decks and slice manifests can ask any
/// widget in the tree *which contract element it is* without grepping source.
mixin ZfaContract {
  /// The stable contract element id, e.g. `zfa.button`.
  String get contractId;

  /// Whether this instance participates in contract auditing.
  ///
  /// Defaults to `true`; construct with `contractEnabled: false` to exempt a
  /// specific instance (e.g. a purely decorative button) from the audit.
  bool get contractEnabled;
}

/// A single contract violation collected by the audit bus.
class ZfaContractViolation {
  /// Creates a violation record.
  ZfaContractViolation({
    required this.code,
    required this.message,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  /// The stable violation code, e.g. `route.unidentified`.
  final String code;

  /// A human readable description of the violation.
  final String message;

  /// When the violation was recorded.
  final DateTime timestamp;

  @override
  String toString() => 'ZfaContractViolation[$code] $message';
}

/// The shared audit bus for a skin.
///
/// The route-contract observer reports into it, the violation chrome listens
/// to it, and skins may report their own violations through it. One bus is
/// mounted per ZuraffaApp and shared by everything the app shell wires up.
class ZfaAuditBus extends ChangeNotifier {
  final List<ZfaContractViolation> _violations = [];

  /// The recorded violations, oldest first, unmodifiable.
  List<ZfaContractViolation> get violations => List.unmodifiable(_violations);

  /// Records [violation] and notifies the chrome and any listeners.
  void report(ZfaContractViolation violation) {
    _violations.add(violation);
    notifyListeners();
  }

  /// Clears the recorded violations and notifies the listeners.
  void clear() {
    _violations.clear();
    notifyListeners();
  }
}

/// The route-contract observer mounted by ZuraffaApp by default.
///
/// A route pushed without contract identity — no RouteSettings.name —
/// violates the skin contract and is reported to the audit bus as a
/// `route.unidentified` violation. Named pushes are contract-clean.
class ZuraffaRouteObserver extends NavigatorObserver {
  /// Creates an observer reporting into [bus].
  ZuraffaRouteObserver({this.bus});

  /// The bus violations are reported to; may be null for a silent observer.
  final ZfaAuditBus? bus;

  /// The violation code used for routes without contract identity.
  static const String unidentifiedRouteCode = 'route.unidentified';

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _audit(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      _audit(newRoute);
    }
  }

  void _audit(Route<dynamic> route) {
    final name = route.settings.name;
    if (name == null || name.isEmpty) {
      bus?.report(
        ZfaContractViolation(
          code: unidentifiedRouteCode,
          message: 'Route pushed without contract identity: $route',
        ),
      );
    }
  }
}

/// The skin contract kit: one audit bus plus one route observer wired to it.
///
/// Promoted from the 006-login-skin pilot (#1102), where the auditor kit,
/// the observer wiring and the violation banner were assembled by hand in
/// every skin's `main_skin.dart`. Skins that need manual control can build
/// their own kit; skins that mount ZuraffaApp get one by default.
class SkinContractKit {
  /// Creates a kit owning a fresh bus, or reusing [bus].
  SkinContractKit({ZfaAuditBus? bus}) : bus = bus ?? ZfaAuditBus();

  /// The audit bus shared by everything this kit wires.
  final ZfaAuditBus bus;

  /// The route observer reporting into [bus].
  late final ZuraffaRouteObserver observer = ZuraffaRouteObserver(bus: bus);

  /// The certified contract ids of the identified vocabulary.
  ///
  /// Components beyond this list are engine-only (reachable through
  /// `package:zuraffa_ui/zfa.dart`) until a later spec identifies them.
  static const List<String> certifiedIds = [
    'zfa.app',
    'zfa.button',
    'zfa.input',
    'zfa.card',
    'zfa.sheet',
    'zfa.dialog',
    'zfa.toaster',
  ];

  /// The pilot's `zfa:` key convention: a [ValueKey] whose value starts with
  /// `zfa:` carries the contract element name, optionally suffixed with
  /// `#fragment` for per-instance disambiguation. The bare element name maps
  /// to its certified id: `button` is `zfa.button`.
  ///
  /// ```dart
  /// SkinContractKit.contractIdOf(const ValueKey('zfa:button#login'))
  ///   // 'zfa.button'
  /// SkinContractKit.contractIdOf(const ValueKey('zfa:zfa.button'))
  ///   // 'zfa.button' (fully-qualified names pass through)
  /// ```
  static String? contractIdOf(Key? key) {
    if (key is ValueKey<String> && key.value.startsWith('zfa:')) {
      var raw = key.value.substring('zfa:'.length);
      final hash = raw.indexOf('#');
      if (hash != -1) {
        raw = raw.substring(0, hash);
      }
      if (raw.isEmpty) {
        return null;
      }
      return raw.startsWith('zfa.') ? raw : 'zfa.$raw';
    }
    return null;
  }
}
