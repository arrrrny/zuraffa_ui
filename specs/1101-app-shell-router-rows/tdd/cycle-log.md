# TDD Cycle Log: 1101 App Shell Router Support and Row Primitive

Baseline (pre-loop): suite green at `b3f80d5` (origin/master HEAD) —
`tdd-profile.md` suite_baseline: green, suite_seconds: 71. Loop started
2026-11-19.

<!-- Append one entry per behavior: RED evidence → GREEN evidence. -->

## 2026-11-19 — Router shell behaviors (A1–A7)

**RED** — Command: `flutter test --concurrency=2 test/identified/zuraffa_app_test.dart`
- Expected: compile errors (capability missing).
- Actual: `Error: Member not found: 'ZuraffaApp.router'` ×5 (test lines
  174/194/215/239/261) — the file fails to load because the router constructor
  does not exist; all home-path groups in the same file still compile. RED for
  the right reason.
- Date: 2026-11-19

## A1–A7 GREEN (router shell)

- Command: `flutter test --concurrency=2 test/identified/zuraffa_app_test.dart`
- Result: **+14 All tests passed!** — 7 new router-shell tests (render,
  messenger, push, chrome, builder, assert, home-path guard) + the 7
  pre-existing home-path tests, unmodified.
- Implementation: `ZuraffaApp.router` ctor (5 forwarded inputs, FR-005 assert
  with named message, delegation doc), `usesRouter` branch in
  `_ZuraffaAppState.build` forwarding to `ShadApp.router` with the identical
  messenger+chrome builder chain.
- Fix during green: `materialThemeBuilder` field type is the inline
  `ThemeData Function(BuildContext, ThemeData)` signature (no exported typedef);
  `ZuraffaApp` now also forwards it on both construction paths (FR-018 surface).
- Date: 2026-11-19

## A8–A10 RED (snack bar theme)

- Command: `flutter test --concurrency=2 test/src/app/material_theme_snack_bar_test.dart`
- Expected: light/dark derivation tests fail; override test passes.
- Actual: `+1 -2` — "snack bar uses the shell colours in light mode" and
  "snack bar follows dark theme" FAILED; "consumer materialThemeBuilder override
  wins" passed (it passed because the override test is written against
  `copyWith`, which succeeds regardless of the base theme — it becomes
  meaningful once the derivation lands). RED for the right reason: no
  `snackBarTheme` in `materialTheme()`.
- Date: 2026-11-19

## A8/A9/A10 GREEN (snack bar theme)

- Command: `flutter test --concurrency=2 test/src/app/material_theme_snack_bar_test.dart`
- Result: **All tests passed! (+3)** — light derivation (A8/FR-016), dark
  switching (A9/FR-017), consumer override precedence (A10/FR-018).
- Implementation: `snackBarTheme: SnackBarThemeData(backgroundColor: primary,
  contentTextStyle: TextStyle(color: primaryForeground), actionTextColor:
  primaryForeground, closeIconColor: primaryForeground)` in `materialTheme()`
  (`lib/src/app.dart:542`); `materialThemeBuilder` still runs last, so the
  override wins by construction.
- Date: 2026-11-19

## A11 GREEN (material-free row guarantee)

- Command: `flutter test --concurrency=2 test/src/components/item_test.dart`
- Result: **All tests passed! (+56, ~2 skipped)** — the new
  `ShadItem inside a background-painting DecoratedBox surface` test asserts zero
  framework exceptions and that the tap callback fires, directly guarding the
  consumer failure mode (SC-002).
- Note: the two item goldens fail on macOS — they are Linux-rendered fixtures
  (same policy as `sheet_test.dart`'s `skipExpandableGoldens`). Verified failing
  on a clean tree (`git stash` probe), then gated with
  `skip: !Platform.isLinux` and the reason comment; CI (Linux) still exercises
  them.
- Date: 2026-11-19

## A12/C1/C2 verification runs

- Alias coverage: `flutter test --concurrency=2 test/identified/zfa_alias_coverage_test.dart`
  → green (all `ZfaItem*` aliases resolve — FR-015).
- Existing home-path suite unmodified and green (C2) — recorded in the A1–A7
  GREEN entry (+14 includes the 7 pre-existing tests).
- Date: 2026-11-19

