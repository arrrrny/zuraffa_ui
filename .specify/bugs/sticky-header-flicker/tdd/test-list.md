# Test List: Sticky header flicker past a headerless ad section

```yaml
---
feature: sticky-header-flicker
loop: outside-in
profile: .specify/memory/tdd-profile.md
spec_criteria: 4
planned_at: eaece98
updated_at: 28a14a8
suite_baseline: green
---
```

## Outer loop: acceptance behaviors

One per acceptance criterion in `spec.md`. Each stays red until the component
behaves correctly end to end through its real widget surface.

| id  | behavior                                                                                                                     | traces | kind    | state   | test                                                                                |
| --- | ---------------------------------------------------------------------------------------------------------------------------- | ------ | ------- | ------- | ----------------------------------------------------------------------------------- |
| A1  | Scrolling past a headerless ad section changes the active section monotonically (no A↔AD or AD↔B flapping) and lands on B     | AC-1   | example | DONE    | `test/src/components/sticky_section_list_test.dart::no flicker past a headerless ad section (monotonic transitions)` |
| A2  | Across the A→AD→B boundary frames the sticky bar's rendered size never alternates (no shrink/regrow loop)                     | AC-2   | example | DONE    | `test/src/components/sticky_section_list_test.dart::sticky bar size does not oscillate across the ad boundary`       |
| A3  | The sticky title shows section B exactly when B's inline header top reaches the top of the scroll area (not one bar later)     | AC-3   | example | DONE    | `test/src/components/sticky_section_list_test.dart::switches title when the incoming header reaches the viewport top` |
| A4  | Existing semantics preserved: first section pinned at top, onSectionChanged fires only on change, external controller drives   | AC-4   | example | DONE    | existing tests in `test/src/components/sticky_section_list_test.dart` (full suite)  |

## Inner loop: unit behaviors

### `lib/src/components/sticky_section_list.dart` (`_updateCurrentSection`)

| id  | behavior                                                                                                   | traces   | kind    | state   | test                                                                                          |
| --- | ---------------------------------------------------------------------------------------------------------- | -------- | ------- | ------- | --------------------------------------------------------------------------------------------- |
| U1  | Active section is the greatest mounted header index whose top is at/above the viewport top (deterministic ascending scan, direct rule — no `idx - 1` indirection) | AC-3     | example | DONE    | `test/src/components/sticky_section_list_test.dart::unit: picks the last header that crossed the viewport top` |
| U2  | When no inline header has crossed the viewport top, the first mounted section stays active                 | AC-4     | example | BASELINE | `test/src/components/sticky_section_list_test.dart::unit: stays on the first section before any header crosses` |
| U3  | Selection is independent of `_mountedHeaders` insertion order (zero-height headers tied at the same dy cannot flip the winner) | AC-1     | example | DONE    | `test/src/components/sticky_section_list_test.dart::unit: tied zero-height headers cannot flip the active section` |
| U4  | Header dy measurement is taken in list-viewport coordinates, so it is unaffected by sticky-bar height changes | AC-2     | example | DONE    | covered jointly with A2 (no widget-observable difference beyond A2's bar-size probe)          |
| U5  | When a zero-height header crosses the top simultaneously with the next header, the real section wins the bar (last-crossed, order-independent tie) | AC-1, AC-3 | example | DONE | `test/src/components/sticky_section_list_test.dart::pins the section at the top even when a zero-height header crosses with it` |

## Invariants and edge cases still to place

- Two adjacent headerless sections must not produce interleaved transitions
  (covered by U3's tied-headers geometry, extended to 2 ad sections if the
  single-ad case passes).
- Scrolling back up re-crosses boundaries in reverse monotonically (symmetry
  of the direct rule; assert in A1's up-scroll pass).

## Out of scope

- Animated title transitions: component documents instant switching.
- Public API for hiding ad sections from `onSectionChanged`: follow-up if
  requested; corrected rule already removes the flicker.
- Ads placed between items inside one section: no section header involved.

## Verification commands

Copied verbatim from `.specify/memory/tdd-profile.md`:

- Single test: `flutter test {file} --plain-name "{name}"`
- Full suite: `flutter test`
- Acceptance: `flutter test {file}`
- Approval: flutter test (matchesGoldenFile)
