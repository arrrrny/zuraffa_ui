# Bug Assessment: Sticky header flickers when scrolling past a headerless ad section in ShadStickySectionList

- **Slug**: sticky-header-flicker
- **Created**: 2026-09-30
- **Source**: pasted text
- **Verdict**: valid
- **Severity**: medium

## Report (verbatim or summarized)

User report (paraphrased from conversation, originally observed in the
`Developer/zik_zak` app): the listing sheet uses an iOS-style sticky title —
as you scroll, the sliding section title replaces the sheet title/header. The
list mixes normal listings with randomly placed **ad placeholders that are not
listings and have no sticky title**. After an ad placeholder is scrolled past,
exactly when the sticky title is about to be placed for the next listing, the
screen **flickers rapidly**. User hypotheses: (a) the ad placeholder has no
sticky title to replace, (b) a pixel-calculation issue. User asked for a
standalone reproduction on the sticky sheet example in this repo.

## Symptom

When a `ShadStickySectionList` contains a section without a real header (an ad
placeholder section between listing sections), scrolling past the ad makes the
pinned sticky header flicker rapidly (rapidly alternating title/height) right
at the moment the next listing section's inline header approaches the top of
the viewport. Expected: the sticky title transitions cleanly from the previous
listing's title to the next listing's title, in one step, when the next
section's header reaches the top of the scroll area.

## Reproduction

1. Build a `ShadSheet(scrollable: false)` containing a `ShadStickySectionList`
   with sections: `A` (several items), `AD` (header: `SizedBox.shrink()` /
   empty, one tall ad item), `B` (several items).
2. Open the sheet and scroll down through section A past the ad.
3. Observe the sticky title bar while B's inline header is a few pixels below
   the viewport top and sliding up: the title/bar height alternates every
   frame (flicker) until B's header has fully passed.

Reproduction on the standalone example (to be added during fix):
`example/lib/pages/sticky_section_list.dart` gains a "feed with ads" sheet so
the flicker can be driven by hand, and widget tests drive the same geometry
programmatically.

## Suspected Code Paths

- `lib/src/components/sticky_section_list.dart:206-231` —
  `_updateCurrentSection()` measures each inline header with
  `headerBox.localToGlobal(Offset.zero, ancestor: listBox)` where `listBox` is
  the **Column** render object (the state's `context.findRenderObject()`), not
  the ListView viewport. The `dy >= 0` test therefore treats headers hidden in
  the sticky-bar band (between the column top and the list's visible top) as
  still "below the top".
- `lib/src/components/sticky_section_list.dart:227-231` — active section is
  derived indirectly via `closestHeaderIndex = idx - 1` from the "closest
  header at/below the top", so while the next section's header B sits inside
  that band, the active section becomes B's predecessor (the ad section).
- `lib/src/components/sticky_section_list.dart:149` / `209` — candidates come
  from `_mountedHeaders` (insertion-ordered map) with a strict `<` comparison;
  ties (e.g. a zero-height ad header exactly tied with the next header) are
  resolved by insertion order, which churns as headers mount/unmount during
  scrolling — non-deterministic winner frame-to-frame.
- `lib/src/components/sticky_section_list.dart:287-296` — the sticky header is
  a Column sibling above the `Expanded(ListView)`, so any change of the active
  section's header height resizes the bar and shifts the list origin — the
  feedback path that turns the above into oscillation.
- `example/lib/pages/sticky_section_list.dart` — existing standalone sticky
  sheet demo (uses `ShadStickySectionList` inside `ShadSheet`); the
  ad-placeholder repro belongs here.
- `test/src/components/sticky_section_list_test.dart` — existing tests; no
  coverage for headerless/ad sections or transition stability.

## Root Cause Hypothesis

Confidence: **high** (mechanism fully derived from the code; matches the
reported trigger precisely — flicker starts exactly when the next listing's
sticky title is due, i.e. when B's inline header is within one sticky-bar
height of the viewport top).

The flicker is a layout feedback loop:

1. B's header is above the list's visible top but still within the sticky-bar
   band (column-relative `dy` in `(0, stickyHeaderHeight)`), because positions
   are measured from the Column instead of the list viewport.
2. The `idx - 1` rule then makes the ad section active; the ad section's empty
   header shrinks the sticky bar by δ.
3. Shrinking the bar moves the list origin up by δ, so every header's
   column-relative `dy` drops by δ; B's `dy` crosses below 0 and is excluded.
4. The next candidate header makes B active again; the bar regains its height,
   `dy` rises by δ, B re-enters the band, and the ad section becomes active
   again. Steps 2–4 repeat every frame → rapid flicker.

Two contributing defects remain even without the loop: the switch point is one
sticky-bar height too late (measured against the Column top instead of the
list viewport top), and tie-breaking depends on map insertion order, which is
non-deterministic while scrolling. The user's hypothesis (a) is essentially
correct: the ad section has no real header to show, so activating it collapses
the bar and feeds the oscillation; hypothesis (b) is also on the mark — the
pixel reference frame for "top" is wrong.

## Proposed Remediation

**Preferred** — make the measurement frame and the selection rule correct;
the oscillation then disappears structurally:

1. Measure inline headers relative to the **ListView viewport**, not the
   Column. Give the list (or a wrapper around it) a `GlobalKey`, and use that
   render box as the `ancestor` for `localToGlobal`. In list coordinates,
   header positions depend only on scroll offset and content layout — they are
   unaffected by sticky-bar height changes, so the feedback loop in steps 2–4
   above cannot close.
2. Replace the "closest header below the top + `idx - 1`" rule with a direct,
   deterministic rule: iterate the mounted header indices in **ascending
   order** (sort the keys of `_mountedHeaders`); the active section is the
   greatest index whose header top is at or above the viewport top
   (`dy <= 0`). If no header has crossed the top, fall back to the smallest
   mounted index (list at its top → section 0), then to the current index.
   This removes map-order dependence, removes the `idx - 1` indirection, and
   makes the title switch exactly when the incoming section's header reaches
   the top of the scroll area — for headerless ad sections the empty title can
   no longer linger for a sticky-bar-height of scroll.

**Alternatives**:

- Keep column-relative measurement but subtract the sticky header's current
  height — smaller diff, but keeps a derived value that must stay in sync with
  layout; the GlobalKey/viewport approach is more robust.
- Add API so headerless sections can never become active (e.g. an optional
  flag on `ShadListSection`). Rejected for now: API growth, and the corrected
  selection rule already prevents the observed flicker; can be a follow-up if
  users want ad sections fully invisible to `onSectionChanged`.

**Files likely to change**:

- `lib/src/components/sticky_section_list.dart`
- `test/src/components/sticky_section_list_test.dart`
- `example/lib/pages/sticky_section_list.dart` (standalone ad repro demo)

**Tests to add or update**:

- Ad-placeholder regression: sections `A`, `AD` (empty header + one tall ad
  item), `B`; micro-scroll across the A→AD→B boundary in small steps;
  `onSectionChanged` must fire a monotonic sequence (no A→AD→A or AD↔B
  flapping) and end at B.
- Transition stability: across the boundary frames, the sticky bar's rendered
  size must not alternate frame-to-frame (no height oscillation).
- Switch point: when B's inline header top reaches the list viewport top, the
  sticky title must already show B (not A, not the empty ad title).
- Existing tests (pinning, `onSectionChanged`, external controller) keep
  passing.

## Risks & Considerations

- Behavior change: the sticky title now switches when the incoming header
  reaches the list top (previously one bar-height later, after it fully
  disappeared). This matches the documented intent ("switches exactly when a
  section's header reaches the top of the scroll area") and iOS behavior, but
  is a visible timing change.
- `GlobalKey` on the list wrapper adds one widget; ensure it does not disturb
  the existing render-object lookups or tests that find the ListView.
- Golden fixtures: any goldens capturing mid-transition states may need
  regeneration if they pinned the old (late) switch point.
- No public API change planned; `onSectionChanged` semantics unchanged
  (monotonic during single-direction scrolls).

## Open Questions

- [NEEDS CLARIFICATION: exact widget the zik_zak ad placeholder uses for its
  section header (empty SizedBox vs. zero-height container) — the fix covers
  both, but the standalone demo assumes `SizedBox.shrink()` with default
  inline-header padding, which still occupies the inline padding height.]
- [NEEDS CLARIFICATION: whether zik_zak also inserts ads *within* a section's
  items (between listings) — that case does not involve section headers and is
  not expected to flicker; if it does, reopen with that geometry.]
