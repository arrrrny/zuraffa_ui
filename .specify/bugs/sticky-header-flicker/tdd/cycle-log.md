# Cycle Log: Sticky header flicker past a headerless ad section

Append only. Newest last. Every entry's `red` block is the evidence that the test
existed and failed before the implementation.

## Baseline

- suite: `flutter test` -> 396 passed, 0 failed, ~6 skipped
- commit: `eaece98`
- recorded: cycle 0, before any change

## Cycle 1: A1 monotonic transitions past a headerless ad section

- test: `test/src/components/sticky_section_list_test.dart::no flicker past a
  headerless ad section (monotonic transitions)` (new)
- red: `flutter test test/src/components/sticky_section_list_test.dart`
  -> `Expected: <2> Actual: <1>` — transitions stopped at the empty ad
  section and never reached B on the down-pass
- green: `lib/src/components/sticky_section_list.dart` `_updateCurrentSection`
  rewritten — headers measured against the list viewport (GlobalKey anchor)
  and active section = last crossed index (ascending scan, no `idx - 1`).
  File -> 7 passed
- refactor: test descriptions reformatted for the 80-char lint; suite re-run
  green
- suite: `flutter test` -> 400 passed, 0 failed

## Cycle 2: A2 sticky bar size does not oscillate across the ad boundary

- test: `...::sticky bar size does not oscillate across the ad boundary`
  (new; 1px sweep through the boundary zone after a trailing section C was
  added to the harness to realize the loop branch)
- red: same file run -> `Expected: a value less than or equal to <3>
  Actual: <17>` with `bar height oscillated: [46.0, 32.0, 46.0, 32.0, ...]`
  — the bar alternated heights every pixel step: the reported flicker,
  captured directly
- green: same fix as cycle 1 (viewport-relative measurement removes the
  bar-height feedback). File -> 7 passed
- refactor: none
- suite: `flutter test` -> 400 passed, 0 failed

## Cycle 3: A3 title switches when the incoming header reaches the viewport top

- test: `...::switches title when the incoming header reaches the viewport
  top` (new)
- red: pinned bar never showed B at the crossing (B title count stayed at 1 —
  the inline header only — because the bar fell back to the empty ad header)
- green: same fix as cycle 1. File -> 7 passed
- refactor: harness walk-forward added to mount B's header before locating it
  (lazy list); assertions unchanged
- suite: `flutter test` -> 400 passed, 0 failed

## Cycle 4: A4 existing semantics preserved

- test: pre-existing tests in the same file (pinning, onSectionChanged,
  external controller) — unchanged
- red: n/a (regression guard)
- green: all 3 pass after the fix; full suite 400 passed, 0 failed (goldens
  untouched)
- refactor: none

## Notes and deviations

- U2 (`stays on the first section before any header crosses`) is a BASELINE
  guard: green before and after the fix by design.
- U1 is pinned by A3's test, U3 by A1's reverse (up-scroll) pass, U4 jointly
  with A2 (no separate observable beyond those probes).
- Two initial harness mistakes were corrected without touching assertions'
  intent: `tester.topLeft` -> `tester.getTopLeft` (compile error), and lazy
  list mounting (walk forward before `getTopLeft(find.text('Section B'))`).
- First A2 draft (20px steps, 3 sections) stayed green on unfixed code — it
  stepped over the ~14px oscillation window; strengthened to a 1px sweep with
  a trailing section C before any fix landed, which exposed the loop
  ([46, 32] x 8+ alternations).
