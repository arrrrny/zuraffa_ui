# API Contract: 1101 App Shell Router Support

**Date**: 2026-11-19

## `ZuraffaApp.router`

```dart
/// Creates a certified app shell for a router-based application.
///
/// Accepts the same router inputs [ShadApp.router] accepts and forwards them
/// unchanged, so an application loses no capability by adopting the shell
/// (FR-002).
///
/// The shell mounts a [ScaffoldMessenger] above the router and wraps the app
/// in the violation chrome, exactly like the navigator constructor (FR-003,
/// FR-004). The audit bus is created (or reused from [auditBus]).
///
/// Route-push auditing: `RouterConfig` carries no navigator observers (an SDK
/// constraint), so the shell cannot attach its [ZuraffaRouteObserver] to a
/// navigator it does not own. To audit routes in a router application, add the
/// observer to your delegate's own navigator:
///
/// ```dart
/// final kit = SkinContractKit();
/// ZuraffaApp.router(
///   routerConfig: myRouterConfig,          // go_router / custom delegate
///   auditBus: kit.bus,
///   // in your delegate's navigator: observers: [kit.observer],
/// );
/// ```
///
/// Supplying navigator-path parameters together with a router configuration is
/// a compile-time error (they are not parameters here); asserting at least one
/// router input guards against an empty configuration (FR-005).
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
  this.showViolationChrome = true,
  this.auditBus,
  this.contractEnabled = true,
}) : assert(
       routeInformationProvider != null ||
           routeInformationParser != null ||
           routerDelegate != null ||
           backButtonDispatcher != null ||
           routerConfig != null,
       'ZuraffaApp.router requires a router configuration: pass routerConfig '
       'or routeInformationProvider/routeInformationParser/routerDelegate.',
     );
```

Field declarations (added to `ZuraffaApp`):

```dart
final RouteInformationProvider? routeInformationProvider;
final RouteInformationParser<Object>? routeInformationParser;
final RouterDelegate<Object>? routerDelegate;
final BackButtonDispatcher? backButtonDispatcher;
final RouterConfig<Object>? routerConfig;
```

Build change in `_ZuraffaAppState.build`: when `routerConfig != null` (or any
router input is present) construct `ShadApp.router(...)` forwarding the five
inputs and the same shared params + builder chain; otherwise the existing
`ShadApp(...)` home path, byte-for-byte unchanged (FR-006).

## `materialTheme()` snack bar block

Added to the `ThemeData(...)` construction in `lib/src/app.dart`:

```dart
snackBarTheme: SnackBarThemeData(
  backgroundColor: themeData.colorScheme.primary,
  contentTextStyle: TextStyle(
    color: themeData.colorScheme.primaryForeground,
  ),
  actionTextColor: themeData.colorScheme.primaryForeground,
  closeIconColor: themeData.colorScheme.primaryForeground,
),
```

## Acceptance test surface (what each test exercises)

| Test (new) | Asserts |
|---|---|
| `router path renders the router's initial route` | `ZuraffaApp.router(routerConfig: …)` renders the delegate's first page |
| `router path mounts the scaffold messenger` | `ScaffoldMessenger.of(context)` inside a route returns a messenger; `showSnackBar` works |
| `messenger survives a route push` | messenger still resolvable from the pushed route |
| `router + home is structurally impossible` | `home:` is not a parameter of `.router` (compile-time; documented) |
| `router path keeps the violation chrome` | bus report → banner visible over the routed page |
| `router path keeps the user builder` | `builder:` hook result renders |
| `empty router input asserts` | constructing `.router()` with all five null throws the named assert |
| `snack bar uses the shell's colours` | `SnackBar` background = `colorScheme.primary`, text = `primaryForeground` |
| `snack bar follows dark theme` | same mapping under dark `ZfaThemeData` |
| `materialThemeBuilder overrides snack bar` | consumer builder's colours win |

## Behaviour preservation (regression guards)

- Entire existing suite passes unmodified (SC-005) — especially
  `test/identified/zuraffa_app_test.dart` (home path) and
  `test/src/components/item_test.dart` (56 ShadItem tests).
- Alias coverage: `test/identified/zfa_alias_coverage_test.dart` keeps the
  `ZfaItem*` surface pinned.
