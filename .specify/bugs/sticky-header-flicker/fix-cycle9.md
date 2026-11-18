# Bug Fix: Sticky header flicker past a headerless ad section (reopened — zik_zak still flickers)

- **Slug**: sticky-header-flicker
- **Fixed**: 2026-10-12
- **Assessment**: ./assessment.md
- **Previous cycle**: ./fix-pr28.md (PR #28, merged 2026-10-01)
- **Status**: applied (remediation pre-existing on master; this cycle pins the
  shipped consumer geometry and identifies the release gap)
- **TDD artifacts**: ./tdd/test-list.md, ./tdd/cycle-log.md (cycle 9)

## Summary

The user verified PR #28 in the example app, then saw the same transition
still flickering in the zik_zak app: the first listing title after the ad
flickers at the sticky bar "until the scroll completes exactly the
sticky-title height, then it sticks". This is **not a code gap**: zik_zak
pins hosted `zuraffa_ui ^0.3.0`, and the `0.3.0` tag (2026-09-18, `2ffb5ac`)
predates the entire PR #28 merge (2026-10-01) — `git tag --contains 28a14a8`
is empty and pub.dev's latest is still 0.3.0. The app runs the **pre-fix**
component, where the oscillation band is exactly one bar-height of scroll —
the user's "sticky title height". The missing half of the story is the
release, not the code.

## Changes

| File | Change | Notes |
|------|--------|-------|
| `test/src/components/sticky_section_list_test.dart` | added test | `zik_zak geometry: zero paddings + headerless ad never flicker the pinned title` — the app's exact geometry: `headerPadding: EdgeInsets.zero`, `inlineHeaderPadding: EdgeInsets.zero`, ad header `SizedBox.shrink()`. Answers the assessment's open question on the ad header widget. |
| `.specify/bugs/sticky-header-flicker/spec.md` | modified | reopened-report section + AC5 (zero-padding consumer geometry) |
| `.specify/bugs/sticky-header-flicker/tdd/cycle-log.md` | appended | cycle 9 (diagnosis + red/green evidence) |
| `.specify/bugs/sticky-header-flicker/fix.md` | replaced | this report; the PR #28 report is archived as `fix-pr28.md` |

No production code changed: the remediation already landed on master via
`28a14a8` (viewport-anchored measurement), `6c7018c` (post-frame evaluation),
`19ec8a5` (safe-area bar) and `47dc435` (no duplicate title), all inside
PR #28.

## Red/Green Evidence

- **Red (0.3.0 code — what zik_zak runs):** with the 0.3.0
  `sticky_section_list.dart` checked out in place, the new test fails:
  `bar origin oscillated on zik_zak geometry: [14.0, 0.0] × 17` across a
  1px sweep of the ad boundary — the original feedback loop, reproduced
  under the app's exact zero-padding geometry.
- **Green (master):** same test passes — bar origins ≤ 3, `onSectionChanged`
  monotonic ending at index 2, and `visibleTitleCount('Listing 1') == 1` at
  the crossing (no duplicate title).

## Tests Added or Updated

- `test/src/components/sticky_section_list_test.dart::zik_zak geometry: zero
  paddings + headerless ad never flicker the pinned title` — pins AC1/AC2/
  AC3 for the exact zik_zak feed geometry.

## Local Verification

- `flutter test --concurrency=2 test/src/components/sticky_section_list_test.dart`
  → 11 passed (10 pre-existing + 1 new)
- `flutter test --concurrency=2` (full suite) → 408 passed / 0 failed
- `flutter analyze` → no issues found
- `dart format` applied to the test file

## Deviations from Assessment

The assessment's remediation was already applied (PR #28). The reopened
report's root cause turned out to be release/version skew, which the
assessment could not have known. The component code needs no further change
for the zik_zak geometry.

## Follow-ups

- **Ship the fix**: publish `0.3.1` per `PUBLISH.md` (master is 29 commits
  ahead of the `0.3.0` tag; the changelog must cover the sticky-list fixes,
  the upstream sync, and the fleet-guard CI changes). Then bump zik_zak from
  `^0.3.0` to `^0.3.1` — the app's flicker disappears with no app-side code
  change.
- Optional API follow-up from PR #28: an opt-out flag so headerless sections
  never become the active section (`onSectionChanged` still fires once for
  the ad section today).
