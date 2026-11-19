# Bug Verification: ZuraffaApp provides a ScaffoldMessenger under the app shell

- **Slug**: shadapp-missing-scaffoldmessenger
- **Tested**: 2026-09-18
- **Assessment**: ./assessment.md
- **Fix**: ./fix.md
- **Result**: verified
- **TDD verification**: ./tdd/verification.md — gate `pass`, mutation score 1.0000

## Summary

The reported failure no longer reproduces: `ScaffoldMessenger.of(context)`
resolves under `ZuraffaApp` for the home route and pushed routes, and
`showSnackBar` renders its content. All four TDD behaviors were red-certified
and then green; the mutation audit passed with 8/8 mutants killed; no
regressions appeared beyond the six pre-existing `ShadSheet` golden failures.

## Checks Performed

| Check | Command / Action | Result | Notes |
|-------|------------------|--------|-------|
| Reproduction (pre-fix) | `flutter test test/tdd/.../a1_test.dart` before the shell fix | fail (expected) | threw `debugCheckHasScaffoldMessenger` at `subject_a1` — the issue's exact symptom |
| Reproduction (post-fix) | same test after the fix | pass | resolves `ScaffoldMessengerState`, mounted |
| New / updated tests | `flutter test test/tdd/shadapp-missing-scaffoldmessenger/` | pass | 4 passed (A1–A4) |
| TDD receipt preflight | part of the audit | pass | 30 receipts validated; 4 audited subjects |
| TDD audit (mutation) | `zfa tdd verify --feature shadapp-missing-scaffoldmessenger --runner flutter` | pass | gate `pass`; 8 killed / 0 survived / 0 timed out; score 1.0000; restoration verified; evidence bound to the audited subject hashes |
| Regression suite | `flutter test` (full suite, during the run's re-proofs) | pass with tolerated pre-existing red | red only on the 6 pre-existing `ShadSheet` golden failures (unchanged from baseline, zfa #922) |
| Lint / format | `flutter analyze lib/tdd test/tdd lib/src/identified/app/zuraffa_app.dart`; `dart format lib/tdd test/tdd` | pass | no issues; formatting clean |

## Output Excerpts

- Audit verdict: `gate: pass · killed: 8 · survived: 0 · timed_out: 0 ·
  mutation_score: 1.0000 · restoration_verified: true` (373s mutation run).
- Target tests: `00:22 +3: All tests passed!` (A1/A3/A4) and `+1: All tests
  passed!` (A2).
- Pre-fix reproduction: `debugCheckHasScaffoldMessenger ... ScaffoldMessenger.of
  (scaffold.dart:158) — subject_a1 (a1_subject.dart:38)`.

## Residual Risks

- The engine's phase-2 refactor and `done` transition are blocked by
  arrrrny/zuraffa#1709 (`zfa build` refuses this package's `build.yaml`); the
  refactor's substantive passes (format/analyze) were run by hand and are clean.
- The audit noted the acceptance tests carry no `scenario-assertions` finder-kind
  headers (`kinds: not traced`) — informational, not a gate; the assertions are
  hand-written per behavior.
- Verification ran on macOS / Flutter 3.47.x; the six pre-existing golden
  failures are environment-dependent and unchanged by this fix.

## Recommendation

Verified end-to-end on the `zuraffa_ui` side. Close
`arrrrny/zuraffa_browser#168` once this fix is released and feature 116's
workaround (the explicit `ScaffoldMessenger` wrap plus the comment in
`lib/src/markdown/ui/markdown_export_feedback.dart`) is removed in that repo.
