# Bug Fix: Sticky header flicker past a headerless ad section (cycle 10 — `sticky` opt-out flag)

- **Slug**: sticky-header-flicker
- **Fixed**: 2026-10-12
- **Assessment**: ./assessment.md
- **Previous cycles**: ./fix-pr28.md (PR #28), ./fix-cycle9.md (version-skew
  diagnosis + 0.3.1 release)
- **Status**: applied
- **TDD artifacts**: ./tdd/test-list.md, ./tdd/cycle-log.md (cycle 10)

## Summary

Implements the optional API follow-up recorded at the end of cycle 9: an
opt-out flag so headerless ad sections never become the active section at
all. Before this cycle the bar no longer flickered, but `onSectionChanged`
still fired once for the ad section (index 1) as its header crossed the
viewport top — the callback consumer saw a section the UI never visibly
pinned.

`ShadListSection` gains `sticky` (default `true`). A `sticky: false` section
is excluded from active-section tracking entirely:

- the pinned bar keeps the previous sticky section's title across the ad
  band (it never collapses to the empty header),
- `onSectionChanged` skips the section entirely (A → B directly),
- the section's inline header stays visible as it scrolls past (deliberately
  NOT hidden — it still reads as content passing by).

The default keeps every existing consumer byte-for-byte compatible.

## Changes

| File | Change | Notes |
|------|--------|-------|
| `lib/src/components/sticky_section_list.dart` | modified | `ShadListSection.sticky` field + constructor param (default `true`); `_updateCurrentSection()` filters mounted headers by `isSticky(idx)`, the `indices.first - 1` fallback walks backward to the nearest sticky section, new `_firstStickyIndex()` helper; `if (active == null) return;` guards the degenerate all-opted-out case. |
| `test/src/components/sticky_section_list_test.dart` | added test | `sticky: false ad section never takes the bar or fires onSectionChanged` — A / ad(`sticky: false`) / B; 1px sweep + bar content + up-pass. |
| `.specify/bugs/sticky-header-flicker/tdd/cycle-log.md` | appended | cycle 10 (design decision + red/green evidence) |
| `.specify/bugs/sticky-header-flicker/fix.md` | replaced | this report; cycle-9 report archived as `fix-cycle9.md` |

## Red/Green Evidence

- **Red:** new test against the pre-flag code: `Expected: a value less than
  or equal to <2>, Actual: <3>` — the empty ad bar still appeared as a
  third list origin during the sweep, and `changes` included the ad index.
- **Green:** same test passes after the flag: ≤ 2 bar origins, `changes ==
  [2]` (A → B directly, ad skipped), bar keeps 'Section A' over the ad band,
  up-pass ends `changes == [0]`.

Two intermediate reds while authoring (both test-side, fixed in place):
a Dart flow-analysis promotion error (`int? active` not promoted inside the
`setState` closure → `final resolvedActive` local), and a stale
`find.text('Sponsored')` lookup after the sweep recycled the ad widget (the
ad crossing is now captured while the widget is still mounted).

## Tests Added or Updated

- `test/src/components/sticky_section_list_test.dart::sticky: false ad
  section never takes the bar or fires onSectionChanged` — pins the opt-out
  contract: ≤ 2 bar origins across the sweep, `onSectionChanged == [2]` down
  / `[0]` up, bar content over the ad band.

## Local Verification

- `flutter test --concurrency=2 test/src/components/sticky_section_list_test.dart`
  → 12 passed (11 pre-existing + 1 new)
- `flutter test --concurrency=2` (full suite) → 505 passed / 0 failed
  (6 skipped, pre-existing)
- `flutter analyze` → no issues found
- `dart format` applied to both files

## Deviations from Assessment

None. This cycle implements the follow-up note only; the assessment and
prior cycles' diagnoses stand unchanged.

## Follow-ups

- The flag is a public API addition — it needs a release (0.3.2) before
  zik_zak can adopt it; consumers that want the ad skipped in
  `onSectionChanged` set `sticky: false` on the ad section.
- Degenerate input (EVERY section `sticky: false`) is guarded but untested:
  `_firstStickyIndex()` returns null, `_updateCurrentSection` returns early,
  and the bar keeps section 0.
