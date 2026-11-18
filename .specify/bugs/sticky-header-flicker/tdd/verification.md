# TDD Verification: sticky-header-flicker

**Verdict: PASS_WITH_GAPS.** The discipline holds: every behavior's test was
proven red before the code that satisfies it (red outputs recorded verbatim in
the cycle log), every acceptance criterion reaches a test through the real
widget surface, and three deliberate mutants targeting the fix's core decisions
(first-crossed vs last-crossed, Column-relative vs viewport-relative
measurement, inclusive vs exclusive boundary) are all caught. The gaps are
declared below, the largest being same-session authorship and deliberate
mutants instead of exhaustive mutation testing.

Audited at `6c7018c`. Evidence sources read: `tdd/cycle-log.md`,
`git log`/`git show` over `eaece98..6c7018c`, and every test and source file
re-read from disk at its audited state.

**Independence disclosure:** the auditor is the session that wrote the tests.
Per the rubric's cold-context rule this is a declared limitation, not a pass by
default.

## Test-first evidence

| Behavior | Class | Evidence |
| --- | --- | --- |
| A1 monotonic transitions past the ad | `LIKELY` | Cycle 1 records the red command and output (`Expected: <2> Actual: <1>`); git history has tests and fix in one commit (`28a14a8`), so ordering is corroborated by the log only |
| A2 no bar-size oscillation | `LIKELY` | Cycle 2 red recorded (`Actual: <17>`, `[46, 32] × 8+`); same-commit history |
| A3 exact switch point | `LIKELY` | Cycle 3 red recorded (B title count stayed 1); same-commit history |
| A4 existing semantics | `NOT_APPLICABLE` | Regression guard: pre-existing tests, unchanged |
| U1 last-crossed rule | `LIKELY` | Pinned by A3's test |
| U2 first-section baseline | `NOT_APPLICABLE` | Characterization guard, green by definition |
| U3 order-independent tie | `LIKELY` | Pinned by U5's tie test (cycle 5) |
| U4 viewport-relative measurement | `LIKELY` | Pinned by A2 (the M2 mutant fails it) |
| U5 zero-height tie | `LIKELY` | Written during remediation; red demonstrated via mutant M1 (test fails under first-crossed), green against the fix |

The history is squashed per behavior (tests + fix in the same commit), so the
cycle log is the only ordering witness — classified `LIKELY`, not `PROVEN`, and
noted rather than inferred as compliance.

## Test quality (rubric)

- Tests assert user-visible behavior: pinned title occurrences
  (`findsNWidgets(2)`), bar geometry via the list's y-offset, and
  `onSectionChanged` sequences. No doubles, no internals.
- Boundaries covered: exact dy = 0 landing (A3, U5), 60px-below non-switch
  (A3), 1px sweep through the ±80px zone (A2), monotonic down AND up passes
  (A1).
- Determinism: `jumpTo` + explicit `pump` (no real timers); walk loops are
  budget-bounded; nothing depends on `maxScrollExtent` estimates (documented
  in the cycle log after the estimate bit us mid-development).

## Mutation results

Deliberate mutants (repo precedent from `specs/1099`; no mutation XML config
exists for `mutation_test` in this repo):

| Mutant | Change | Caught by |
| --- | --- | --- |
| M1 | first-crossed selection (`??=`) | U5 zero-height tie test (`Expected: exactly 2, Found 1`) |
| M2 | Column-relative measurement | A2 oscillation test (`bar height oscillated: [46.0, 32.0, ...]`) |
| M3 | exclusive boundary (`dy < 0`) | U5 exact-landing tie test |

All three initially SURVIVED against the first test batch; the remediation
round (cycle 5) strengthened the tests until each was killed, and cycle 6
fixed the second real defect the strengthened test exposed (stale pre-layout
evaluation → moved to a deduped post-frame callback). Source was restored and
the full suite re-run green after every mutant.

## Acceptance-criteria coverage

- AC-1 → A1 (+U3, U5) ✓
- AC-2 → A2 (+U4) ✓
- AC-3 → A3 (+U1, U5) ✓
- AC-4 → A4 (existing suite, full run) ✓

## Gaps

1. Same-session authorship (declared above).
2. Deliberate mutants, not exhaustive mutation testing.
3. Real-gesture momentum scrolling not exercised (programmatic 1px sweeps
   instead); fractional device-pixel ratios not covered.

mutation_score: null # deliberate mutants used (3/3 killed after remediation)
mutants_survived: 0
suite: 401 passed, 0 failed, ~37s
