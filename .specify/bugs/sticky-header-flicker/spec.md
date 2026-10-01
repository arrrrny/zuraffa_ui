# Bug Spec: Sticky header flickers when scrolling past a headerless ad section

- **Slug**: sticky-header-flicker
- **Source**: ./assessment.md
- **Verdict**: valid
- **Severity**: medium

## Problem

`ShadStickySectionList` flickers rapidly when a section without a real header
(e.g. an ad placeholder) sits between normal listing sections and the user
scrolls past it. Exactly when the next listing section's sticky title should
take over, the pinned title alternates every frame.

## Root Cause (from assessment)

1. Inline header positions are measured with `localToGlobal(ancestor: Column)`
   — the sticky-bar band above the list viewport counts as "below the top".
2. Active section is derived via `closestHeaderIndex = idx - 1`, so a header
   in that band activates its predecessor (the headerless ad section).
3. The ad section's empty header shrinks the sticky bar → the list origin
   shifts → header dy values shift → the active section flips back → bar
   regrows → loop. Layout feedback oscillation = flicker.
4. Tie-breaking depends on map insertion order (non-deterministic while
   scrolling).

## Required Behavior (acceptance criteria)

- **AC1 — Ad-section transition is clean and single-step.** Given sections
  `A`, `AD` (empty header + one tall ad item), `B`, scrolling down past the
  ad changes the active section monotonically; the sticky title never
  alternates between two sections across consecutive scroll frames, and it
  ends at `B` once B's inline header reaches the top of the scroll area.
- **AC2 — No layout oscillation.** While micro-scrolling across the
  A→AD→B boundary, the sticky bar's rendered size must not alternate
  (shrink/regrow) frame-to-frame; each frame's size change is a step in one
  direction at most per section change, never a repeating A/B flip loop.
- **AC3 — Correct switch point.** The sticky title shows section `s` exactly
  when the viewport top is at or below the top of section `s`'s inline header
  (i.e. when the next section's header top reaches the top of the scroll
  area, the title switches — not one sticky-bar-height later).
- **AC4 — Existing semantics preserved.** Pinning of the first section's
  header, `onSectionChanged` callbacks (zero-based index, fired only on
  change), external `ScrollController` support, and all existing tests keep
  working unchanged.

## Failing-Test Scenario (reproduction)

Widget test harness: `ShadApp` → `SizedBox(height: 400)` →
`ShadStickySectionList(sections: [A (3 items × 80px, header Text('Section A')),
AD (header: SizedBox.shrink(), one 320px ad item), B (3 items × 80px, header
Text('Section B'))])`, with `onSectionChanged` recording indices.

Scroll in small steps (e.g. `tester.drag(find.byType(ShadStickySectionList),
Offset(0, -40))` + pump, repeated) from the top through the ad and into B.

Expected (fails today): the recorded `onSectionChanged` sequence is
monotonic (no repeated flips like `[0, 1, 0, 1, ...]` or `[1, 2, 1, 2, ...]`)
and the sticky bar's height does not oscillate across consecutive frames near
the boundary.

## Out of Scope

- Public API changes (no new flags on `ShadListSection`).
- Animating the sticky title switch (component documents instant switching).
- In-section ad items (ads placed between items of one section do not involve
  section headers).
