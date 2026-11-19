# Data Model: 1101 App Shell Router Support and Row Primitive

**Date**: 2026-11-19

No persistent entities — this is a pure UI package. The "data" here is the new
API surface and the theme derivation.

## New API surface

### `ZuraffaApp.router` (5 new fields + 1 constructor)

| Field | Type | Default | Notes |
|---|---|---|---|
| `routeInformationProvider` | `RouteInformationProvider?` | null | forwarded to `ShadApp.router` |
| `routeInformationParser` | `RouteInformationParser<Object>?` | null | forwarded; must be non-null iff provider is (SDK assert) |
| `routerDelegate` | `RouterDelegate<Object>?` | null | forwarded; consumer owns their navigator + observers |
| `backButtonDispatcher` | `BackButtonDispatcher?` | null | forwarded |
| `routerConfig` | `RouterConfig<Object>?` | null | forwarded; shorthand for the four above |

Constructor contract:

- At least one of the five router inputs must be non-null, else the wrapped
  `ShadApp.router` would fall back to a null-delegate router and crash. Guard:
  assert with a clear message (name the conflict per FR-005 pattern).
- Navigator-path params (`home`, `routes`, `initialRoute`, `navigatorKey`,
  `onGenerateRoute`, `onUnknownRoute`, `navigatorObservers`) are **not**
  parameters on `.router` — supplying a home widget together with router config
  is structurally impossible (FR-005 satisfied by construction, plus the assert
  documents the rule).
- All shared params stay: `title`, `theme`, `darkTheme`, `themeMode`, `locale`,
  `supportedLocales`, `debugShowCheckedModeBanner`, `builder`,
  `showViolationChrome`, `auditBus`, `contractEnabled`.

Type parameter note: `ShadApp.router` types its router inputs as
`RouterConfig<Object>` / `RouterDelegate<Object>`; the shell mirrors that so any
consumer delegate (go_router, NavGo, custom) forwards unchanged.

### `SnackBarThemeData` derivation (no new type)

Derived inside `materialTheme()` from the resolved `ShadColorScheme`:

```text
backgroundColor  ← colorScheme.primary
contentTextStyle ← TextStyle(color: colorScheme.primaryForeground)
actionTextColor  ← colorScheme.primaryForeground
closeIconColor   ← colorScheme.primaryForeground
```

Override precedence: `widget.materialThemeBuilder(context, mTheme)` receives the
derived theme and its return value is used — consumer wins (FR-018).

## Existing surface (unchanged, release-gated)

`ShadItem` family — see research.md R4 for the full inventory. No field or
behaviour changes; the release makes them installable.

## State transitions

None new. The violation chrome already handles bus-empty → bus-nonempty →
cleared; the router path reuses the identical `_ZuraffaAppState` build (only the
`ShadApp` constructor differs).

## Invariants

- **INV-1**: every `ZuraffaApp` construction path (home or router) mounts
  `ScaffoldMessenger` above the navigator/router.
- **INV-2**: the violation chrome wraps the user's builder result on both paths.
- **INV-3**: one audit bus per shell (created lazily or passed in) shared by the
  chrome; on the router path the route observer is NOT auto-attached (SDK
  constraint, research R2) — consumer attaches `SkinContractKit().observer` to
  their own navigator.
- **INV-4**: `materialTheme()` output always honours consumer
  `materialThemeBuilder` as the final override.
