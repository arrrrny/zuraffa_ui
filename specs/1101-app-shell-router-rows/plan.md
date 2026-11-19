# Implementation Plan: App Shell Router Support and In-Theme Row Primitive

**Branch**: `1101-app-shell-router-rows` | **Date**: 2026-11-19 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `/specs/1101-app-shell-router-rows/spec.md`

## Summary

Three package-level gaps, three fixes, one release:

1. **`ZuraffaApp.router`** — a second constructor on the certified app shell that
   forwards the router inputs the wrapped `ShadApp.router` already accepts, and
   mounts the same `ScaffoldMessenger` + violation chrome on the builder hook the
   home path uses today.
2. **`snackBarTheme` in `materialTheme()`** — Material snack bars currently render
   with the M3 default (near-black `#02081A`); they must derive from the shell's
   own colour scheme and follow light/dark switching.
3. **Ship `ShadItem`** — the Material-free row primitive is complete in source
   (component, theme, 56 tests, all `ZfaItem*` aliases) but unreleased; the release
   carries it to consumers. Verification only, no new code expected.

Release: minor bump **7.5.0 → 7.6.0** (new surface area, no consumer call changes).

## Technical Context

**Language/Version**: Dart >=3.11.0, Flutter >=3.47 (material_ui/cupertino_ui era)

**Primary Dependencies**: `material_ui` ^1.11.1 (Material widgets/theme),
`cupertino_ui` ^1.1.7, `flutter` SDK widgets (`WidgetsApp.router`, `RouterConfig`)

**Storage**: N/A (pure UI package)

**Testing**: `flutter test --concurrency=2` (fleet guard); widget tests in
`test/identified/` and `test/src/components/`; mutation via `dart run mutation_test`

**Target Platform**: Pure Dart/Flutter package (all Flutter targets)

**Project Type**: library (published to a private registry, consumed fleet-wide)

**Performance Goals**: N/A — no hot paths touched; theme construction is
build-time only

**Constraints**: test concurrency capped at 2 (shared host); every capability
needs a test that fails if the capability is removed (SC-006); existing suite
must stay green unmodified (SC-005)

**Scale/Scope**: 2 source files changed (`lib/src/identified/app/zuraffa_app.dart`,
`lib/src/app.dart`), 1 test file extended, changelog + pubspec release edits

## Constitution Check

The repo constitution (`.specify/memory/constitution.md`) is an unfilled template —
no repo-specific gates. The fleet-level rules that bind this work:

| Rule | Status |
|------|--------|
| Fix it once, at the package level | ✅ This spec IS the package-level fix (consumer workarounds stay out) |
| Misfire rule (stop, report, workaround, comment) | ✅ Acknowledged for the TDD loop |
| Test concurrency = 2 | ✅ All `flutter test` runs pass `--concurrency=2` |
| Fork surface preserved (`.github/FORK_OWNED_FILES`) | ✅ No engine file is renamed; additions only |
| PR through the forklift pool, never hand-merged | ✅ Final step |

## Research Findings (Phase 0)

See [research.md](./research.md) for the full notes. Decisive facts:

- **R1 — `ShadApp.router` exists and is complete** (`lib/src/app.dart:66`): accepts
  `routeInformationProvider`, `routeInformationParser`, `routerDelegate`,
  `backButtonDispatcher`, `routerConfig`, `builder`, and renders through
  `WidgetsApp.router` under `AnimatedTheme`. The shell only needs to forward and
  keep its own builder chain.
- **R2 — `RouterConfig` carries no observers** (SDK `router.dart:135`): the class
  has exactly four fields (provider, parser, delegate, backButtonDispatcher), and
  `Navigator.observers` is final. **Consequence**: on the router path the shell
  cannot inject `ZuraffaRouteObserver` into a navigator it does not own. The audit
  **bus + violation chrome remain fully functional** (they live above the router,
  on the builder chain). Route-push auditing for router apps = the consumer adds
  `SkinContractKit().observer` (or `ZuraffaRouteObserver(bus: …)`) to their own
  delegate's navigator observers — documented, not improvised. FR-004 is
  satisfied as *infrastructure preservation* (bus, chrome, builder); the spec's
  Key Entities already scope the router path to "carries the router inputs … and
  mounts the messenger".
- **R3 — `materialTheme()` has no `snackBarTheme`** (`lib/src/app.dart:505`): the
  built `ThemeData` sets divider/selection/icon/scrollbar themes but nothing for
  snack bars, so M3 defaults leak through (`inverseSurface` near-black).
  `widget.materialThemeBuilder` runs last, so consumer overrides win by
  construction (FR-018).
- **R4 — `ShadItem` is shipped in source, unreleased**: `lib/src/components/item.dart`
  (1371 lines: `ShadItem` with `primary/outline/muted` × `regular/sm` + named
  constructors, `ShadItemMedia`, `ShadItemContent`, `ShadItemTitle`,
  `ShadItemDescription`, `ShadItemActions`, `ShadItemHeader`, `ShadItemFooter`,
  `ShadItemGroup`, `ShadItemSeparator`), theme at
  `lib/src/theme/components/item.dart` with `_$ShadItemTheme` merge support, 56
  tests in `test/src/components/item_test.dart`, all 14 `ZfaItem*` aliases in
  `lib/src/identified/mapping/zfa_engine_aliases.dart:568-580`, golden fixtures
  committed. FR-007–FR-015 verification = run the existing tests + surface audit.
- **R5 — version convention**: mono-version fleet alignment; 7.5.0 is current on
  this repo's pubspec while the CHANGELOG mixes 0.6x entries (upstream heritage)
  and 7.x fleet entries. New surface area ⇒ minor bump ⇒ **7.6.0** (matches the
  user's stated fleet target 7.6.0 with zorphy 2.5.0).

## Data Model (Phase 1)

See [data-model.md](./data-model.md). No persistent entities. New API surface:

- `ZuraffaApp.router` constructor + 5 new fields (`routeInformationProvider`,
  `routeInformationParser`, `routerDelegate`, `backButtonDispatcher`,
  `routerConfig`)
- `SnackBarThemeData` derivation inside `materialTheme()`
- 0 new components (ShadItem ships as-is)

## Contracts (Phase 1)

See [contracts/](./contracts/api.md) for the exact Dart signatures and the
snack-bar colour mapping table.

## Project Structure

### Documentation (this feature)

```text
specs/1101-app-shell-router-rows/
├── plan.md              # This file
├── research.md          # Phase 0 findings (R1–R5)
├── data-model.md        # Phase 1 API surface
├── quickstart.md        # Phase 1 verification workflow
├── contracts/api.md     # Phase 1 Dart signatures
├── checklists/requirements.md  # Spec quality gate (16/16)
├── tdd/test-list.md     # Phase: /speckit-tdd-plan output
├── tdd/cycle-log.md     # Phase: /speckit-tdd-run evidence
├── tdd/verification.md  # Phase: /speckit-tdd-verify verdict
└── tasks.md             # Phase: /speckit-tasks output
```

### Source Code (repository root)

```text
lib/
├── src/
│   ├── app.dart                                    # + snackBarTheme in materialTheme()
│   └── identified/
│       └── app/zuraffa_app.dart                    # + ZuraffaApp.router constructor & fields
├── zuraffa_ui.dart                                 # unchanged (already exports zuraffa_app.dart)
└── zfa.dart                                        # unchanged (engine surface)
test/
├── identified/
│   └── zuraffa_app_test.dart                       # + router-path group
└── src/
    ├── app/material_theme_snack_bar_test.dart      # + snackBarTheme derivation tests
    └── components/item_test.dart                   # existing 56 (verification only)
CHANGELOG.md                                        # + 7.6.0 entry
pubspec.yaml                                        # version: 7.6.0
```

**Structure Decision**: two-file source change plus two test files; release edits
(pubspec + CHANGELOG) complete the feature. No new directories, no engine-file
renames.

## Complexity Tracking

No constitution violations. The only notable complexity — router-path observer
limitation — is an SDK constraint, not an introduced one; handled by documented
delegation (R2) rather than by wrapping the consumer's `RouterConfig` (rejected:
wrapping a user-owned delegate to fish out its navigator is fragile and breaks
the "same inputs as ShadApp" requirement FR-002 demands).
