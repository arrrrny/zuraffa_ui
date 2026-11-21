# Tasks: App Shell Router Support and In-Theme Row Primitive

**Input**: Design documents from `/specs/1101-app-shell-router-rows/`
**Prerequisites**: plan.md ✅, spec.md ✅, research.md ✅, data-model.md ✅, contracts/api.md ✅

**Tests**: REQUIRED — spec FR-021 mandates failing-if-removed coverage for the
router shell and the row surface; TDD behaviors are additionally tracked in
`tdd/test-list.md` and driven by `/skill:speckit-tdd-run`.

**Organization**: Tasks grouped by user story. Behavior-marked tasks (⚙) run in
the red-green-refactor loop BEFORE `/skill:speckit-implement`; unmarked tasks are
implement-phase work.

## Phase 1: Setup (no code — environment verification)

- [x] T001 Branch `1101-app-shell-router-rows` exists and is rebased onto
      origin/master `b3f80d5` (includes ShadItem + material_ui migration)
- [x] T002 `flutter pub get` resolves cleanly after the rebase
- [x] T003 [P] Baseline suite state confirmed green before any change
      (`flutter test --concurrency=2` — SC-005 guard)

## Phase 2: User Story 1 — Router-based app adopts the certified shell (P1) 🎯 MVP

**Goal**: `ZuraffaApp.router` forwards the five router inputs to `ShadApp.router`
and mounts messenger + chrome exactly like the home path.

**Independent Test**: mount the shell with a `RouterConfig`-equivalent delegate in
a widget test; resolve `ScaffoldMessenger.of` from a route; show a snackbar.

### Tests for User Story 1 ⚙ (write FIRST, prove RED)

- [x] T004 ⚙ [US1] RED: router-path widget tests in
      `test/identified/zuraffa_app_test.dart` (new `router shell` group):
      (a) renders the delegate's initial route; (b) `ScaffoldMessenger.of`
      resolves inside a route and `showSnackBar` succeeds; (c) messenger still
      resolvable after a route push; (d) violation chrome still overlays a routed
      page on a bus report; (e) user `builder` hook still runs; (f) constructing
      `.router()` with all five inputs null throws the named assert.
- [x] T005 ⚙ [US1] RED: home-path regression guard — extend
      `test/identified/zuraffa_app_test.dart` with a test that `ZuraffaApp(home:…)`
      still mounts messenger + chrome after the constructor split (guards FR-006).

### Implementation for User Story 1

- [x] T006 [US1] Add the five router fields + `ZuraffaApp.router` constructor
      (assert naming the conflict, doc comment with `SkinContractKit().observer`
      delegation pattern) in `lib/src/identified/app/zuraffa_app.dart` (depends on T004, T005)
- [x] T007 [US1] `_ZuraffaAppState.build` picks `ShadApp.router(...)` when any
      router input is present, forwarding the five inputs + shared params +
      identical builder chain; home path byte-for-byte unchanged
      (depends on T006)

**Checkpoint**: router app boots under the shell with messenger + chrome; home
path suite untouched and green.

## Phase 3: User Story 3 — Notification banners match the app theme (P2)

**Goal**: `materialTheme()` derives `snackBarTheme` from the shell colour scheme;
consumer override wins.

### Tests for User Story 3 ⚙

- [x] T008 ⚙ [US3] RED: `test/src/app/material_theme_snack_bar_test.dart`:
      (a) light theme → snackbar background == `colorScheme.primary`, text ==
      `primaryForeground`; (b) dark theme → same mapping from dark scheme;
      (c) consumer `materialThemeBuilder` override wins.

### Implementation for User Story 3

- [x] T009 [US3] Add the `snackBarTheme` block to the `ThemeData` construction in
      `materialTheme()` (`lib/src/app.dart`, per contracts/api.md mapping table)
      (depends on T008)

**Checkpoint**: snack bars themed in light + dark; override precedence proven.

## Phase 4: User Story 2 & 4 — Row primitive verification (P1)

**Goal**: prove `ShadItem` satisfies FR-007–FR-015 post-rebase and confirm the
release will carry it; no new component code expected.

### Verification tests for User Story 2 & 4 ⚙

- [x] T010 ⚙ [US2/US4] Run `flutter test --concurrency=2
      test/src/components/item_test.dart` (56 tests) — all green post-rebase;
      record in cycle-log. If any fails: misfire rule (stop → report →
      workaround → comment).
- [x] T011 ⚙ [US2/US4] Material-free guarantee test: a `ShadItem` inside a
      `DecoratedBox` surface with a background colour produces zero framework
      errors and its tap callback fires (regression guard for the exact consumer
      failure mode; add to `test/src/components/item_test.dart` if absent).
- [x] T012 ⚙ [US2/US4] Alias resolution check:
      `flutter test --concurrency=2 test/identified/zfa_alias_coverage_test.dart`
      green — every `ZfaItem*` alias resolves (FR-015).

## Phase 5: Polish & Release (no behavior markers)

- [x] T013 Bump `pubspec.yaml` to `version: 7.6.0` (delivered in PR #73)
- [x] T014 CHANGELOG 7.6.0 entry: router-capable shell, snackbar theming,
      ShadItem first release (FR-019, FR-020) (delivered in PR #73)
- [x] T015 Lockfile dependency-bump rule: `rm pubspec.lock && flutter pub get`,
      align declared constraints to resolution, `dart pub outdated` → file chore
      issue for held-back upgrades (AGENTS.md dependency-bump rule)
      (delivered in PR #73; held-back upgrades filed as #72)
- [x] T016 Full gate: `flutter analyze` + full suite + `./scripts/local_ci.sh`
      (quickstart.md "Full gate before PR") (delivered in PR #73; local_ci.sh
      flutter-clean hazard filed as #71)
- [x] T017 Push branch, open PR, hand to the forklift pool (never hand-merge)
      (this PR)

## Dependencies & Execution Order

- T004/T005 (RED) → T006 → T007: router story strictly sequential.
- T008 (RED) → T009: snackbar story sequential; **independent of Phase 2**
  (different file) — can interleave but keep its own red→green cycle.
- T010–T012: verification only; can run anytime after rebase (they should pass
  immediately — if T010–T012 are green at RED time they are recorded as
  verification evidence, not loop behaviors; T011 is the only one expected to
  need new test code).
- T013–T017: after all behaviors DONE + implement phase complete.

## Parallel Opportunities

- T004/T005 and T008 touch different files — their RED states can be authored
  in parallel, but each drives its own green cycle.
- T010/T011/T012 are independent.
- T013/T014 independent of each other, both before T015–T017.

## Implementation Strategy

- MVP = Phase 2 (router shell) — the blocking defect for every router consumer.
- Phases 3–4 follow; Phase 5 is release mechanics (the gating factor for
  consumer reachability per US4).
- Misfire rule active throughout: any zuraffa-related failure → stop, report to
  `arrrrny/zuraffa`, workaround with issue-linked comment.

## Notes

- ⚙ marks behavior tasks → `tdd/test-list.md` behaviors (red-green-refactor
  evidence in `tdd/cycle-log.md`).
- All `flutter test` runs carry `--concurrency=2` (fleet guard).
- Commit after each logical group; the forklift pool owns the PR.
