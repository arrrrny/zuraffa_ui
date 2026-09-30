# Bug Fix: Sticky header flicker past a headerless ad section

- **Slug**: sticky-header-flicker
- **Fixed**: 2026-09-30
- **Assessment**: ./assessment.md
- **Status**: applied
- **TDD artifacts**: ./tdd/test-list.md, ./tdd/cycle-log.md

## Summary

`ShadStickySectionList` measured inline header positions against the whole
Column (sticky bar included) and derived the active section indirectly via
"closest header below the top − 1", which let a headerless ad section take
the pinned bar and its shorter empty header shift the measurements back — a
layout feedback loop that flickered the header exactly when the next listing's
title was due. Headers are now measured in list-viewport coordinates and the
active section is the last section whose inline header reached the viewport
top (deterministic ascending scan).

## Changes

| File | Change | Notes |
|------|--------|-------|
| `lib/src/components/sticky_section_list.dart` | modified | `_updateCurrentSection` rewritten: `GlobalKey`-anchored viewport measurement + direct "last crossed" rule (no `idx - 1`, no map-order dependence); `ListView` wrapped in `KeyedSubtree` |
| `test/src/components/sticky_section_list_test.dart` | added tests | 4 new widget tests (see below); existing 3 untouched |
| `example/lib/pages/sticky_section_list.dart` | modified | standalone repro: "Open Feed with Ads (flicker repro)" sheet — ad placeholder section with empty header between product sections |

## Diff Highlights

```dart
// Before: Column-relative measurement + indirect idx-1 mapping
final offsetInList = headerBox.localToGlobal(Offset.zero, ancestor: listBox);
if (offsetInList.dy >= 0 && ...) {
  closestHeaderIndex = idx < 1 ? 0 : idx - 1;   // ad section becomes active
}

// After: viewport-relative measurement + direct last-crossed rule
final dy = headerBox.localToGlobal(Offset.zero, ancestor: listBox).dy;
if (dy <= 0) lastCrossedIndex = idx;            // section owns the top itself
```

In viewport coordinates header offsets are independent of the sticky bar's
height, so the shrink → shift → flip → regrow loop cannot close; in
list-relative terms the switch point also moves to where iOS puts it (the
moment the incoming header reaches the top of the scroll area, not one
bar-height after it disappeared behind the bar).

## Tests Added or Updated

- `no flicker past a headerless ad section (monotonic transitions)` —
  micro-scroll down then up across A→AD→B: `onSectionChanged` must be strictly
  monotonic per direction and end at B (down) / A (up)
- `sticky bar size does not oscillate across the ad boundary` — 1px sweep
  through the boundary zone with a trailing section C: the bar height sequence
  (read from the list's y-offset) must have ≤ 3 runs; red evidence was
  `[46.0, 32.0, 46.0, 32.0, ...]` (17 runs)
- `switches title when the incoming header reaches the viewport top` — at the
  crossing offset B's title appears both inline and pinned (2 occurrences);
  60px before the top it is inline-only
- `stays on the first section before any header crosses` — baseline guard

## Local Verification

- `flutter test test/src/components/sticky_section_list_test.dart` → 7 passed
  (3 pre-existing + 4 new)
- `flutter test` (full suite) → 400 passed, 0 failed, ~6 skipped (baseline was
  396; goldens untouched)
- `flutter analyze` on the three changed files → No issues found
- `dart format` applied to changed files

## Deviations from Assessment

- None in mechanism. One test-design note: the first A2 draft (20px steps,
  3 sections) did not reproduce the loop on unfixed code — it stepped over the
  ~14px oscillation window and hit the "stuck on the empty bar" branch (which
  A1 captures). A2 was strengthened to a 1px sweep with a trailing section C
  before any fix landed, which exposed the true flicker loop. The assessment's
  proposed GlobalKey/viewport approach and direct selection rule were applied
  as written.

## Follow-ups

- `onSectionChanged` now fires for the ad section while its (empty) band is at
  the top — correct, but apps that want ad sections fully invisible to
  callbacks can add an opt-out flag on `ShadListSection` later.
- The headerless section still renders a 24px padded inline strip inside the
  list (existing behavior for every section header); suppressing it for empty
  headers would be a separate polish task.
