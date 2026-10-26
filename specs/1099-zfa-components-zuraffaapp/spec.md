# Feature Specification: zuraffa_ui — identified Zfa components + ZuraffaApp

**Feature Branch**: `1099-zfa-components-zuraffaapp`

**Created**: 2026-09-05

**Status**: Approved (updated 2026-09-18: the raw engine library moved
`lib/shad.dart` → `lib/zfa.dart` and every public engine name gained a `Zfa*`
alias — see PR #15, `AGENTS.md` "Fork upstream sync policy", and
`lib/src/identified/mapping/zfa_engine_aliases.dart`. The body below records the
2026-09-05 design as it was approved.)

**Input**: GitHub issue #1099 (spec context supplied by the SPEC 1099 harness; the
GitHub issue record itself returns 404 on `arrrrny/zuraffa-ui` at the time of this
work, so the harness text is authoritative).

## User Scenarios & Testing

### User Story 1 - Skin developer flips to zuraffa_ui (Priority: P1)

A skin developer working in the zik_zak skin lane swaps their dependency from
`shadcn_ui` to `zuraffa_ui` and imports only `package:zuraffa_ui/zuraffa_ui.dart`.
Everything the skin needs — the app shell, the certified component vocabulary, the
theme — is available under Zfa* names, and nothing downstream ever imports
`package:shadcn_ui/...` again.

**Why this priority**: The end-to-end repackage is the core directive. The fork
(arrrrny/zuraffa-ui, package `shadcn_ui` 0.56.3, fork of
`nank1ro/flutter-shadcn-ui`) is the substrate to repackage, not a dependency to
reference.

### User Story 2 - Runtime auditor asks a component who it is (Priority: P1)

A runtime contract auditor, an xray deck, or a slice manifest walks the widget tree
and asks any certified component "which contract element are you?" — without
grepping source, without duck-typed `try/on NoSuchMethodError` probes on
`.onPressed`. Every Zfa component answers through a typed protocol:
`String get contractId` and `bool get contractEnabled`.

**Why this priority**: Identification is the reason this package exists. The 006
pilot's auditor kit worked around the absence of this protocol; those workarounds
are the symptoms this package removes.

### User Story 3 - Skin gets coherent app wiring by default (Priority: P2)

A skin mounts `ZuraffaApp` instead of `ShadApp`. The route-contract observer, the
audit bus, and the violation chrome are mounted by default in one place, so the
~30 lines of manual observer + violation-banner wiring from the 006 pilot's
`main_skin.dart` disappear.

**Why this priority**: ShadApp accepts `navigatorObservers`/`builder` but nothing
forces a Zuraffa skin to mount the skin-contract route observer or violation
surface. ZuraffaApp makes coherent wiring the default.

### User Story 4 - Upstream sync stays mechanical (Priority: P2)

The package maintainer merges upstream `nank1ro/flutter-shadcn-ui` changes into
the engine (`lib/src/` minus `lib/src/identified/`) mechanically. The identified
Zfa layer lives in `lib/src/identified/`, which upstream never touches, so merges
can never conflict with it. Each repackage records the base fork SHA + upstream
version in the CHANGELOG, and `zuraffa_ui` owns its own semver timeline (0.1.0+).

**Why this priority**: The anti-corruption layer is only worth its cost if daily
upstream sync does not drift into the certified vocabulary.

## What Changes

- `pubspec.yaml`: package renamed `shadcn_ui` → `zuraffa_ui`, version reset to
  `0.1.0` (own timeline, independent of shadcn 0.5x.x).
- `lib/shadcn_ui.dart` → `lib/shad.dart`: the raw Shad* engine library (internal
  escape hatch, NOT the package barrel). Content unchanged (relative exports).
- `lib/zuraffa_ui.dart`: NEW package barrel — exports only `ZuraffaApp`, Zfa
  components, `ZfaTheme`/`ZfaThemeData` aliases, and the contract kit types.
- `lib/src/identified/`: NEW isolated layer — `app/zuraffa_app.dart`,
  `components/zfa_button.dart`, `zfa_input.dart`, `zfa_card.dart`, `zfa_sheet.dart`,
  `zfa_toaster.dart`, `zfa_dialog.dart`, `theme/zfa_theme.dart`,
  `contract/skin_contract_kit.dart` (promoted from the 006 pilot, #1102).
- All `package:shadcn_ui/...` imports repo-wide (lib/, test/, example/,
  playground/) rewritten to `package:zuraffa_ui/...`.
- `CHANGELOG.md`: records base fork SHA `afc9569` + upstream version.
- Tests carry over (import rewrite) and extend: identification tests
  (contractId/contractEnabled on every Zfa component) + contract-kit tests.

## Acceptance Criteria *(mandatory)*

- **AC-1**: The package is named `zuraffa_ui` at version `0.1.0`; zero
  `package:shadcn_ui/...` imports remain in the repo; the raw engine library is
  `lib/shad.dart` and the package barrel is `lib/zuraffa_ui.dart`.
- **AC-2**: The package barrel exports the identified surface only — `ZuraffaApp`,
  Zfa components, `ZfaTheme`/`ZfaThemeData`, contract kit types. No raw `Shad*`
  symbol is exported from the barrel.
- **AC-3**: Every Zfa component implements the typed contract protocol:
  `String get contractId` (stable id, e.g. `zfa.button`) and
  `bool get contractEnabled` (default `true`, constructible to `false`).
- **AC-4**: `ZuraffaApp` wraps `ShadApp` and mounts the route-contract observer and
  the violation chrome by default; the chrome is disableable; the audit bus is
  shared between observer and chrome; pushing a route without contract identity
  (no `RouteSettings.name`) reports a violation that becomes visible chrome.
- **AC-5**: `ZfaTheme.of(context)` resolves the mounted `ShadTheme` (skins never
  type a Shad name for theming) and `ZfaThemeData` aliases the engine theme data.
- **AC-6**: `CHANGELOG.md` records the base fork SHA and the upstream version for
  this repackage.
- **AC-7**: The fork's component tests keep running inside the repo — the carried
  over suite stays green (baseline: 333 tests passing at fork SHA `afc9569`).
- **AC-8**: Identification tests and contract-kit tests exist in
  `test/identified/` and pass.

## Risk & Mitigation *(optional)*

- **Golden tests**: the engine suite contains golden-file tests. They passed at
  baseline in this environment; the repackage must not alter rendering. Mitigation:
  the identified layer only composes existing engine widgets; goldens are re-run
  after the rename.
- **Analyzer baseline**: `flutter analyze` reports 144 pre-existing errors, all
  confined to the `playground/` sub-project (unresolved deps). The package itself
  (`lib/`, `test/`) is clean at baseline and must remain clean — no new issues.
- **Upstream merge surface**: renaming `lib/shadcn_ui.dart` → `lib/shad.dart` is a
  one-time `git mv`; future upstream barrel edits merge via rename detection. The
  identified layer is additive-only.

## Out of Scope

- Migrating the zik_zak consumer repo itself (one-time import rewrite happens in
  the zik_zak lane, not here).
- Identifying the full component catalog (accordion, select, table, ...). This
  spec certifies the named six + the app shell; the rest stay reachable via
  `lib/shad.dart` until a later spec identifies them.
- Publishing to pub.dev.
