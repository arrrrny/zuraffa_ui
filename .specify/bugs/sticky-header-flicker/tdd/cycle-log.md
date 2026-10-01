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

## Cycle 5: U5 zero-height header tie — mutation remediation

- trigger: deliberate-mutant audit (verify fallback). Three mutants were run
  against the first fix; ALL THREE initially survived:
  - M1 first-crossed selection — masked by tall sections scrolling fully out
    of the cache extent before the distinction could show
  - M2 Column-relative measurement — masked the same way: the ad header was
    destroyed before the oscillation zone arrived, so the feedback loop could
    not close
  - M3 exclusive boundary (`dy < 0`) — unobservable because fractional text
    metrics never landed the header exactly at dy = 0
- test: `...::pins the section at the top even when a zero-height header
  crosses with it` (new) + A2 harness rebuilt with short sections and a 1px
  sweep + A3 exact-landing correction loop (targets the inline header, sign-
  corrected `offset += dy`)
- red (mutants after strengthening): M1 -> zero-height tie test fails
  (`Expected: exactly 2 ... Found 1`); M2 -> A2 fails
  (`bar height oscillated: [46.0, 32.0, ...]`); M3 -> zero-height tie test
  fails. All three now caught.
- green: strengthened tests pass against the real fix. Suite -> 401 passed,
  0 failed
- refactor: n/a
- commit: `6c7018c`

## Cycle 6: component hardening — post-frame evaluation (found by the U5 test)

- finding: the strengthened U5 harness exposed a SECOND real defect: the
  active-section evaluation ran synchronously in the scroll notification,
  i.e. before the frame that lays out the scrolled content. A single program
  matic jump left the pinned title stale (bar showed the previous section
  while the next header sat exactly at the viewport top); nothing re
  evaluated after layout changed the mounted-header set.
- fix: `lib/src/components/sticky_section_list.dart` — evaluation moved to a
  deduped post-frame callback (`_schedulePostFrameCheck`), armed on scroll,
  header mount, init, and after each section change. Every decision now uses
  the positions the user actually sees.
- green: strengthened tests pass; suite -> 401 passed, 0 failed
- refactor: none
- commit: `6c7018c`

## Notes and deviations (remediation round)

- Test-harness pitfalls hit and fixed during remediation (documented for the
  audit): `maxScrollExtent` in mixed-height builder lists is an average-based
  ESTIMATE that can be far below the real extent (observed 100 vs ~420) —
  clamping test walks against it spins or short-circuits; the walk/correction
  loops are now budget-bounded and never clamp against it. `getTopLeft` on a
  text that appears in both the bar and the list needs `.last` (inline). The
  post-frame evaluation schedules a rebuild, so assertions need one extra
  pump after landing exactly at the top.

## Cycle 7: follow-up — pinned header clears the top safe area

- request: the pinned bar overlapped the iOS status bar clock/notch on
  full-height sheets.
- test: `...::pinned header stays below the top safe area inset` —
  MediaQuery top padding 47 → red: title top 20.0 (under the clock), expected
  67.
- green: `build()` adds `MediaQuery.paddingOf(context).top` INSIDE the bar's
  padding, so the title clears the inset while the bar's background/border
  still extend behind the status bar; no-op below an AppBar (inset already
  consumed). Suite -> 402 passed, 0 failed.
- measurement note: the viewport-relative tracking is unaffected (the list
  origin moves with the taller bar, header dy values are list-relative).
- commit: (safe-area commit, next SHA)

## Cycle 8: follow-up — no duplicate title during the transition

- request: after the corrected switch point, the active section's inline
  header is still on screen right below the bar at the moment it takes over,
  so the title painted twice for the header's own height of scrolling.
- test: A3 extended with `visibleTitleCount` (paint-level count — excludes
  `Opacity(0)`): exactly one visible 'Section B' at the crossing. Red:
  `Actual: <2>`.
- green: `_InlineSectionHeader` gains `active` — when its section is the
  pinned one, the inline header renders a transparent background with the
  title at `Opacity(0)`, KEEPING its exact size so the content never jumps
  (collapsing it would lurch the list by a header height at every
  transition). Section 0's zero-height suppression unchanged.
- green: suite -> 403 passed, 0 failed.

