# Bug Verification: Sticky header flicker past a headerless ad section (reopened cycle)

- **Slug**: sticky-header-flicker
- **Tested**: 2026-10-12
- **Assessment**: ./assessment.md
- **Fix**: ./fix.md (previous cycle: ./fix-pr28.md)
- **Result**: verified
- **TDD verification**: ./tdd/verification.md (PR #28 audit); cycle 9 evidence
  in ./tdd/cycle-log.md

## Summary

The reopened report — "the first listing title after the ad still flickers
in zik_zak" — was reproduced as red evidence against the exact code zik_zak
runs (the `0.3.0` tag's component file) under the app's exact geometry, and
is green on master. Root cause: version skew. zik_zak pins hosted
`zuraffa_ui ^0.3.0`; that tag predates PR #28 entirely, so the app runs the
pre-fix component. Master contains every fix; nothing was missing in the
code. The user-visible resolution is the 0.3.1 release plus the zik_zak
version bump — no app-side code change.

## Checks Performed

- Red proof: `git checkout 0.3.0 -- lib/src/components/sticky_section_list.dart`
  → new test fails with `bar origin oscillated: [14.0, 0.0] × 17` (the
  original loop, one-bar-height oscillation band) → master file restored.
- Green on master: new test passes — ≤ 3 bar origins across a 1px sweep,
  monotonic `onSectionChanged` down to index 2, exactly one visible title at
  the crossing.
- Regression suite: `flutter test --concurrency=2 test/src/components/sticky_section_list_test.dart`
  → 11 passed.
- Full suite: `flutter test --concurrency=2` → 408 passed / 0 failed.
- `flutter analyze` → no issues found.

## Environment

- macOS local run (fleet guard: `--concurrency=2`); goldens all green in
  this run.
- pub.dev state at verification time: latest = 0.3.0 (no release contains
  the fix).

## Remaining Manual Step (user)

Publish `0.3.1` per `PUBLISH.md` and bump zik_zak to `^0.3.1`; the flicker
in the app disappears on the next `flutter pub get` there.
