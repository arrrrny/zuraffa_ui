# Research: 1101 App Shell Router Support and Row Primitive

**Date**: 2026-11-19 | **Branch**: `1101-app-shell-router-rows`

## R1 — `ShadApp.router` exists and is complete

File: `lib/src/app.dart` (post material_ui migration, commit `f7c112b`).

- `const ShadApp.router({...})` at line ~66 accepts: `routeInformationProvider`,
  `routeInformationParser`, `routerDelegate`, `backButtonDispatcher`,
  `routerConfig`, plus the shared surface (`theme`, `darkTheme`, `themeMode`,
  `builder`, `title`, `onGenerateTitle`, `onNavigationNotification`, `color`,
  `locale`, localization params, `shortcuts`, `actions`, `restorationScopeId`,
  `scrollBehavior`, `themeCurve`, `materialThemeBuilder`, `backgroundColor`).
- The router branch of `_buildApp` renders `WidgetsApp.router` under
  `AnimatedTheme(data: materialTheme(context))` with `builder: _builder` — the
  same `ShadAppBuilder` chain the home path uses.
- `usesRouter` is computed as
  `routeInformationProvider != null || routeInformationParser != null ||
  routerDelegate != null || routerConfig != null` (line ~428).
- Nulling initializers enforce mutual exclusion of the navigator params on the
  router constructor.

**Conclusion**: `ZuraffaApp.router` only needs to accept the same five router
inputs (FR-002) and forward them. Everything else is already there.

## R2 — `RouterConfig` carries no observers (decisive constraint)

File: Flutter SDK `packages/flutter/lib/src/widgets/router.dart`.

- `class RouterConfig<T>` (line 135) has exactly four fields:
  `routeInformationProvider`, `routeInformationParser`, `routerDelegate`,
  `backButtonDispatcher`. No observer list.
- `Router.withConfig` forwards exactly those four to a `Router`.
- `Navigator.observers` is `final List<NavigatorObserver>` (`navigator.dart:1709`)
  — it cannot be patched after construction, and the shell never constructs the
  navigator on the router path: the consumer's `routerDelegate` does.

**Consequence for FR-004**: on the router path the shell cannot inject
`ZuraffaRouteObserver` into a navigator it does not own. What survives
automatically:

- the `ScaffoldMessenger` mount (builder chain — above the router),
- the violation chrome (builder chain — above the router),
- the audit bus (created/received by the shell state),
- the user's `builder` hook.

What the consumer must add for route-push auditing: their delegate's navigator
takes `SkinContractKit().observer` or `ZuraffaRouteObserver(bus: …)` in its
`observers:` list. This is documented in the constructor doc comment — the same
pattern Flutter itself uses (`NavigatorObserver` is opt-in on plain `Navigator`
too). Wrapping the consumer's `RouterConfig` to fish out their navigator was
**rejected**: `routerDelegate` is an interface, not a concrete class, so a
wrapper cannot reach the inner navigator without casting, and it would violate
FR-002 ("same router inputs the underlying app accepts").

## R3 — `materialTheme()` has no `snackBarTheme`

File: `lib/src/app.dart:505`.

The built `ThemeData` sets: `fontFamily`, `colorScheme` (from
`ShadColorScheme`: primary/secondary/error/surface + on*), `scaffoldBackgroundColor`,
`brightness`, `dividerTheme`, `textSelectionTheme`, `iconTheme`,
`scrollbarTheme`. **No `snackBarTheme`** — Material's M3 default renders snack
bars on `inverseSurface`, which resolves to a near-black slab (`#02081A` in the
slate scheme) regardless of the shell theme.

Colour mapping (from the existing `ColorScheme` derivation in the same method):

| `SnackBarThemeData` field | Source |
|---|---|
| `backgroundColor` | `colorScheme.primary` (accent like the shadcn toaster) |
| `contentTextStyle` | `colorScheme.primaryForeground` |
| `actionTextColor` | `colorScheme.primaryForeground` |
| `closeIconColor` | `colorScheme.primaryForeground` |
| `behavior` | leave default (consumer decides floating/fixed) |
| `elevation` | leave default |
| `shape` | leave default (roundness stays Material's own) |

`widget.materialThemeBuilder` runs **after** the base `ThemeData` is built
(`lib/src/app.dart:550-553`), so a consumer passing `materialThemeBuilder` wins
over the new default by construction — FR-018 needs no extra plumbing.

Light/dark: `materialTheme()` is called on every rebuild with the active
`ShadThemeData` (`theme(context)` resolves `themeMode` against `theme` /
`darkTheme`), so both derivations follow switching automatically — FR-017.

## R4 — `ShadItem` is shipped in source, unreleased

Files (all present post-rebase, commit `026787a` "feat(item): add ShadItem and
its related components (#705) (#725)"):

- `lib/src/components/item.dart` — 1371 lines. `ShadItem` with variants
  `primary|outline|muted` (`ShadItemVariant`), sizes `regular|sm`
  (`ShadItemSize`), named ctors `.outline`/`.muted`/`.raw`; companions
  `ShadItemMedia` (+ `.icon`/`.image`/`.raw`, media variant enum),
  `ShadItemContent`, `ShadItemTitle`, `ShadItemDescription`, `ShadItemActions`,
  `ShadItemHeader`, `ShadItemFooter`, `ShadItemGroup`, `ShadItemSeparator`.
  Custom `_RenderShadItemRow` layout (boxy-free render row with slots).
- `lib/src/theme/components/item.dart` + `.g.theme.dart` — `ShadItemTheme` with
  `_$ShadItemTheme` mixin (theme_extensions_builder merge support).
- `lib/src/identified/mapping/zfa_engine_aliases.dart:568-580` — all 14 aliases:
  `ZfaItem`, `ZfaItemTheme`, `ZfaItemVariant`, `ZfaItemSize`,
  `ZfaItemMediaVariant`, `ZfaItemMedia`, `ZfaItemContent`, `ZfaItemTitle`,
  `ZfaItemDescription`, `ZfaItemActions`, `ZfaItemHeader`, `ZfaItemFooter`,
  `ZfaItemGroup`, `ZfaItemSeparator`.
- `test/src/components/item_test.dart` — 56 tests incl. goldens
  (`item.png`, `item_muted_sm.png`).
- Exported from the package barrel (`lib/shadcn_ui.dart` exports item).

Material-free check: the component tree contains no `Material` ancestor
requirement; hover/press use its own render object + `MouseRegion`. The
`ListTile` assertion failure mode the consumer hit (`ListTile` inside a
`DecoratedBox`-backgrounded surface) is exactly what `ShadItem` replaces.

**Conclusion**: FR-007–FR-015 are satisfied by existing code. Work = verification
tests already exist (56); nothing new to build except confirming they run green
post-rebase and the aliases resolve (alias coverage test exists:
`test/identified/zfa_alias_coverage_test.dart`).

## R5 — version convention

- `pubspec.yaml`: `version: 7.5.0` (mono-version fleet alignment; the 0.6x
  CHANGELOG entries above 7.5.0 are upstream-heritage entries from the fork
  sync, both versioning streams coexist in the file).
- Fleet rule: the whole zuraffa family ships one version together. The user's
  stated fleet target: **7.6.0 with zorphy 2.5.0**.
- New surface area (`ZuraffaApp.router`, snackBar theming, first release carrying
  ShadItem) ⇒ minor bump ⇒ **7.6.0**. No breaking changes to the home-path
  constructor.

## Misfire-rule note

No misfire encountered during research. If the TDD loop hits a zuraffa-related
failure, the rule in `AGENTS.md` applies: stop, report to `arrrrny/zuraffa`
GitHub, continue with a workaround, comment the workaround with the issue link.
