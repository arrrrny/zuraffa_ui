# Bug Verification: Sticky header flicker past a headerless ad section

- **Slug**: sticky-header-flicker
- **Tested**: 2026-09-30
- **Assessment**: ./assessment.md
- **Fix**: ./fix.md
- **Result**: verified
- **TDD verification**: ./tdd/verification.md

## Summary

The flicker no longer reproduces: the sticky bar stays size-stable through the
ad boundary (the mutation audit's own red evidence `[46.0, 32.0, ...] × 8+`
alternations is now a single-step transition), transitions are monotonic down
and up, and the title switches exactly when the incoming header reaches the
viewport top. The audit also surfaced and fixed a second, related defect
(stale evaluation against the previous frame's layout). No regressions: full
suite 401 passed / 0 failed, goldens untouched.

## Checks Performed

| Check | Command / Action | Result | Notes |
|-------|------------------|--------|-------|
| Reproduction (post-fix) | widget-level equivalent of the assessment repro: `sticky bar size does not oscillate across the ad boundary` (1px sweep across the boundary) | pass | ≤ 3 bar-height runs; pre-fix red was 17 runs of [46, 32] alternation |
| New / updated tests | `flutter test test/src/components/sticky_section_list_test.dart` | pass | 8 passed (3 pre-existing + 5 new) |
| Deliberate mutants (M1 first-crossed / M2 Column-relative / M3 exclusive boundary) | apply mutant → run suite → restore | pass (all killed) | each mutant failed exactly the test that pins its behavior; source restored and verified clean after each |
| Regression suite | `flutter test` | pass | 401 passed, 0 failed, ~6 skipped (baseline 396; +5 new tests) |
| Lint / type-check | `flutter analyze` (changed files) | pass | No issues found; `dart format` applied |

## Output Excerpts

- Pre-fix red (A1): `Expected: <2> Actual: <1>` — transitions stuck on the
  empty ad section, never reaching the next listing.
- Pre-fix red (A2): `Expected: a value less than or equal to <3> Actual: <17>`
  with `bar height oscillated: [46.0, 32.0, 46.0, 32.0, ...]` — the reported
  flicker captured directly.
- Post-fix: `00:02 +8: All tests passed!` (component file) and
  `00:37 +401 ~6: All tests passed!` (full suite).

## Residual Risks

- The audit was run by the same session that wrote the tests (declared
  limitation per the rubric); all files were re-read from disk and mutants
  were run cold against the final suite.
- Mutation strength was measured with deliberate mutants (repo precedent),
  not exhaustive mutation testing — no mutation XML config exists in this
  repo for `mutation_test`.
- `onSectionChanged` still fires for the headerless ad section while its band
  is at the top (one callback, no flapping) — correct but noted; an opt-out
  flag could be a follow-up.
- Real-device scrolling (momentum, fractional pixel offsets) is covered
  indirectly via 1px programmatic sweeps, not via live gesture tests.

## Recommendation

Close the bug — verified end-to-end at the widget level, with the original
reproduction geometry captured as a red→green regression test and three
targeted mutants proving the tests' strength. Merge the fix branch PR.
