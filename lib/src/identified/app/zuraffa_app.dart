import 'package:material_ui/material_ui.dart';
import 'package:zuraffa_ui/src/app.dart';
import 'package:zuraffa_ui/src/identified/contract/skin_contract_kit.dart';
import 'package:zuraffa_ui/src/identified/theme/zfa_theme.dart';

/// The certified app shell of the skin lane.
///
/// Wraps [ShadApp] and mounts the skin contract infrastructure by default,
/// in one place:
///
/// - the route-contract observer ([ZuraffaRouteObserver]) appended to the
///   user's [navigatorObservers];
/// - the shared [ZfaAuditBus] driving both the observer and the chrome;
/// - the violation chrome ([ZfaViolationChrome]) overlaid on the navigator
///   through [builder] — disable it with [showViolationChrome];
/// - a [ScaffoldMessenger] above the navigator, so Material feedback APIs
///   (`showSnackBar`, undo bars) resolve for every widget under the shell
///   (the wrapped [ShadApp] mounts none of its own);
/// - theme, toaster and sonner through the wrapped [ShadApp] (the engine
///   mounts `ShadToaster` and `ShadSonner` inside its own builder chain).
///
/// This is the wiring the 006-login-skin pilot assembled by hand in
/// `main_skin.dart`; here it is the default.
///
/// ```dart
/// ZuraffaApp(
///   theme: ZfaThemeData(brightness: Brightness.dark),
///   home: const SkinShell(),
/// )
/// ```
class ZuraffaApp extends StatefulWidget with ZfaContract {
  /// Creates a certified app shell.
  const ZuraffaApp({
    super.key,
    this.home,
    this.routes = const {},
    this.initialRoute,
    this.navigatorKey,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.title = '',
    this.theme,
    this.darkTheme,
    this.themeMode,
    this.locale,
    this.supportedLocales = const [Locale('en', 'US')],
    this.debugShowCheckedModeBanner = false,
    this.navigatorObservers = const [],
    this.builder,
    this.materialThemeBuilder,
    this.showViolationChrome = true,
    this.auditBus,
    this.contractEnabled = true,
  }) : routeInformationProvider = null,
       routeInformationParser = null,
       routerDelegate = null,
       backButtonDispatcher = null,
       routerConfig = null;

  /// Creates a certified app shell for a router-based application.
  ///
  /// Accepts the same router inputs [ShadApp.router] accepts and forwards them
  /// unchanged, so an application loses no capability by adopting the shell.
  /// At least one of [routerConfig] or [routerDelegate] must be non-null —
  /// those are the inputs `ShadApp` itself routes on; a provider/parser or
  /// back-button dispatcher alone is rejected by the constructor assert,
  /// because `ShadApp` would fall into its navigator path and crash on the
  /// shell's nulled `home`/`navigatorObservers`.
  ///
  /// The shell mounts a [ScaffoldMessenger] above the router and wraps the app
  /// in the violation chrome, exactly like the navigator constructor. The
  /// audit bus is created (or reused from [auditBus]).
  ///
  /// Route-push auditing: `RouterConfig` carries no navigator observers (an
  /// SDK constraint), so the shell cannot attach its [ZuraffaRouteObserver] to
  /// a navigator it does not own. To audit routes in a router application, add
  /// the observer to your delegate's own navigator:
  ///
  /// ```dart
  /// final kit = SkinContractKit();
  /// ZuraffaApp.router(
  ///   routerConfig: myRouterConfig,
  ///   auditBus: kit.bus,
  ///   // in your delegate's navigator: observers: [kit.observer],
  /// )
  /// ```
  const ZuraffaApp.router({
    super.key,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.backButtonDispatcher,
    this.routerConfig,
    this.title = '',
    this.theme,
    this.darkTheme,
    this.themeMode,
    this.locale,
    this.supportedLocales = const [Locale('en', 'US')],
    this.debugShowCheckedModeBanner = false,
    this.builder,
    this.materialThemeBuilder,
    this.showViolationChrome = true,
    this.auditBus,
    this.contractEnabled = true,
  }) : home = null,
       routes = const {},
       initialRoute = null,
       navigatorKey = null,
       onGenerateRoute = null,
       onUnknownRoute = null,
       navigatorObservers = const [],
       assert(
         routerDelegate != null || routerConfig != null,
         'ZuraffaApp.router requires a router delegate: pass routerConfig or '
         'routerDelegate — the engine app only takes its router path when one of '
         'those is present; a dispatcher/provider-only configuration would '
         'otherwise crash in the navigator path.',
       );

  /// The home widget of the app.
  final Widget? home;

  /// The named routes of the app.
  final Map<String, WidgetBuilder> routes;

  /// The initial route name of the app.
  final String? initialRoute;

  /// The navigator key of the app.
  final GlobalKey<NavigatorState>? navigatorKey;

  /// Called when a named route is not defined in [routes].
  final RouteFactory? onGenerateRoute;

  /// Called when [onGenerateRoute] fails to build a route.
  final RouteFactory? onUnknownRoute;

  /// The router inputs, forwarded to [ShadApp.router] unchanged.
  ///
  /// Null on the navigator construction path.
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final BackButtonDispatcher? backButtonDispatcher;
  final RouterConfig<Object>? routerConfig;

  /// The title of the app.
  final String title;

  /// The light [ZfaThemeData] of the app.
  final ZfaThemeData? theme;

  /// The dark [ZfaThemeData] of the app.
  final ZfaThemeData? darkTheme;

  /// The theme mode of the app.
  final ThemeMode? themeMode;

  /// The locale of the app.
  final Locale? locale;

  /// The supported locales of the app.
  final Iterable<Locale> supportedLocales;

  /// Whether to show the debug checked mode banner.
  final bool debugShowCheckedModeBanner;

  /// The user's navigator observers, merged with the contract observer.
  final List<NavigatorObserver> navigatorObservers;

  /// The user's app builder, preserved inside the violation chrome.
  final TransitionBuilder? builder;

  /// The user's Material theme hook, forwarded to the wrapped app. Runs after
  /// the shell's own Material derivation, so the consumer wins.
  final ThemeData Function(BuildContext context, ThemeData theme)?
  materialThemeBuilder;

  /// Whether the violation chrome is visible.
  ///
  /// Defaults to `true`. When `false` the observer still records violations
  /// into the audit bus — only the banner is hidden.
  final bool showViolationChrome;

  /// The shared audit bus.
  ///
  /// When null, the app creates its own. Pass a bus to inspect or clear the
  /// violations from tests or tooling.
  final ZfaAuditBus? auditBus;

  @override
  String get contractId => 'zfa.app';

  @override
  final bool contractEnabled;

  @override
  State<ZuraffaApp> createState() => _ZuraffaAppState();
}

class _ZuraffaAppState extends State<ZuraffaApp> {
  ZfaAuditBus? _createdBus;
  late final ZuraffaRouteObserver _observer = ZuraffaRouteObserver(bus: _bus);

  ZfaAuditBus get _bus => widget.auditBus ?? (_createdBus ??= ZfaAuditBus());

  @override
  Widget build(BuildContext context) {
    final usesRouter =
        widget.routeInformationProvider != null ||
        widget.routeInformationParser != null ||
        widget.routerDelegate != null ||
        widget.backButtonDispatcher != null ||
        widget.routerConfig != null;
    if (usesRouter) {
      return ShadApp.router(
        routeInformationProvider: widget.routeInformationProvider,
        routeInformationParser: widget.routeInformationParser,
        routerDelegate: widget.routerDelegate,
        backButtonDispatcher: widget.backButtonDispatcher,
        routerConfig: widget.routerConfig,
        title: widget.title,
        theme: widget.theme,
        darkTheme: widget.darkTheme,
        themeMode: widget.themeMode,
        locale: widget.locale,
        supportedLocales: widget.supportedLocales,
        debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
        materialThemeBuilder: widget.materialThemeBuilder,
        builder: (context, child) {
          final inner = widget.builder?.call(context, child) ?? child;
          return ScaffoldMessenger(
            child: ZfaViolationChrome(
              bus: _bus,
              enabled: widget.showViolationChrome,
              child: inner ?? const SizedBox.shrink(),
            ),
          );
        },
      );
    }
    return ShadApp(
      home: widget.home,
      routes: widget.routes,
      initialRoute: widget.initialRoute,
      navigatorKey: widget.navigatorKey,
      onGenerateRoute: widget.onGenerateRoute,
      onUnknownRoute: widget.onUnknownRoute,
      title: widget.title,
      theme: widget.theme,
      darkTheme: widget.darkTheme,
      themeMode: widget.themeMode,
      locale: widget.locale,
      supportedLocales: widget.supportedLocales,
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
      materialThemeBuilder: widget.materialThemeBuilder,
      navigatorObservers: [...widget.navigatorObservers, _observer],
      builder: (context, child) {
        final inner = widget.builder?.call(context, child) ?? child;
        return ScaffoldMessenger(
          child: ZfaViolationChrome(
            bus: _bus,
            enabled: widget.showViolationChrome,
            child: inner ?? const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}

/// The violation chrome mounted by [ZuraffaApp].
///
/// Listens to the audit bus; while it holds violations and [enabled] is true,
/// a banner is overlaid at the top of the wrapped [child].
class ZfaViolationChrome extends StatelessWidget {
  /// Creates the chrome wrapping [child].
  const ZfaViolationChrome({
    super.key,
    required this.bus,
    this.enabled = true,
    required this.child,
  });

  /// The audit bus listened to.
  final ZfaAuditBus bus;

  /// Whether the banner is shown when violations exist.
  final bool enabled;

  /// The wrapped app content.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: bus,
      builder: (context, _) {
        final violations = bus.violations;
        if (!enabled || violations.isEmpty) {
          return child;
        }
        return Stack(
          children: [
            Positioned.fill(child: child),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _ZfaViolationBanner(violations: violations),
            ),
          ],
        );
      },
    );
  }
}

class _ZfaViolationBanner extends StatelessWidget {
  const _ZfaViolationBanner({required this.violations});

  final List<ZfaContractViolation> violations;

  @override
  Widget build(BuildContext context) {
    final directionality = Directionality.maybeOf(context);
    Widget banner = ColoredBox(
      color: const Color(0xCCB3261E),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Zfa contract violation (${violations.length})',
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              violations.last.message,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 12),
            ),
          ],
        ),
      ),
    );
    if (directionality == null) {
      // The chrome may sit above any Directionality (e.g. when the user's
      // builder introduces its own); default to LTR for the banner itself.
      banner = Directionality(textDirection: TextDirection.ltr, child: banner);
    }
    return banner;
  }
}
