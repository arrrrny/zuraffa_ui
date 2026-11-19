# TDD Test List: 1101 App Shell Router Support and Row Primitive

Derived from `spec.md` acceptance scenarios + `contracts/api.md` test surface.
Every behavior traces to a spec FR. Profile: `.specify/memory/tdd-profile.md`
(`flutter test` runner; suite baseline green; concurrency 2).

## Acceptance behaviors (outer)

| ID | Behavior (name) | Test file / location | FR trace |
|---|---|---|---|
| A1 | Router path renders the delegate's initial route | `test/identified/zuraffa_app_test.dart` → group `router shell` | FR-001, FR-002 |
| A2 | Scaffold messenger resolves inside a route and showSnackBar succeeds | same group | FR-003 |
| A3 | Messenger still resolvable after a route push | same group | FR-003 |
| A4 | Violation chrome overlays a routed page on a bus report | same group | FR-004 |
| A5 | User builder hook runs on the router path | same group | FR-004 |
| A6 | Empty router input throws the named assert | same group | FR-005 |
| A7 | Home path unchanged: messenger + chrome still mounted | same group, new test | FR-006 |
| A8 | Snack bar uses the shell's colours (light) | `test/src/app/material_theme_snack_bar_test.dart` | FR-016 |
| A9 | Snack bar follows dark theme | same file | FR-017 |
| A10 | Consumer materialThemeBuilder override wins | same file | FR-018 |
| A11 | ShadItem in a background-painting surface: zero framework errors, tap fires | `test/src/components/item_test.dart` (extend if absent) | FR-007, SC-002 |
| A12 | All ZfaItem* aliases resolve | `test/identified/zfa_alias_coverage_test.dart` (existing — verification) | FR-015 |

## Unit behaviors (inner)

| ID | Behavior (name) | Trace |
|---|---|---|
| U1 | `ZuraffaApp.router` forwards all five router inputs to `ShadApp.router` | FR-002 (asserted via A1 render + routing behaviour) |
| U2 | Router input presence check: any-of-five selects the router path; none selects home path | FR-001/FR-006 (covered via A1/A6/A7) |

Note: A1–A12 are widget-level behaviors; the implementation is two construction
branches + one theme block, so unit granularity collapses into the acceptance
tests. No separate unit files warranted (complexity tracking: simplicity rule).

## Characterization (existing, verification only)

| ID | Behavior | Evidence |
|---|---|---|
| C1 | 56 ShadItem tests green post-rebase (hover/press/disabled/variants/theme-merge/sizes) | `test/src/components/item_test.dart` run in cycle-log |
| C2 | Existing zuraffa_app_test home-path groups stay green unmodified | same run |

## Coverage-to-existing tests

- A12, C1, C2: already covered by existing tests (verification runs).
- A11: partially covered — item_test has hover/press/tap tests but likely not the
  DecoratedBox-background scenario; add one test (T011).
- A1–A10: new tests (T004, T005, T008).

## Loop order

1. A6 → A1 → A2 → A3 → A4 → A5 → A7 (router story, one file)
2. A8 → A9 → A10 (snackbar story, one file)
3. A11 (item guarantee) → A12/C1/C2 verification runs

Each behavior: write test → prove RED for the right reason → smallest
implementation → GREEN → refactor → log evidence in `tdd/cycle-log.md`.
