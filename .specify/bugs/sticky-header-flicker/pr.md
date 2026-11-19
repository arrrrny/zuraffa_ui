# Bug Fix PRs: Sticky header flicker past headerless ad sections

## Cycle 1 — PR #28

- **Slug**: sticky-header-flicker
- **Opened**: 2026-09-30
- **PR**: 28
- **URL**: https://github.com/arrrrny/zuraffa_ui/pull/28
- **Branch**: fix/sticky-header-flicker
- **Issue**: n/a (bug triaged locally; no GitHub issue filed)

Fixes ShadStickySectionList flicker when scrolling past a headerless (ad)
section: viewport-anchored measurement + deterministic last-crossed selection
+ post-frame evaluation, with 5 new widget tests and a standalone example
repro sheet.

## Cycle 2 — PR #31 (reopened: zik_zak still flickers)

- **Slug**: sticky-header-flicker
- **Opened**: 2026-10-12
- **PR**: 31
- **URL**: https://github.com/arrrrny/zuraffa_ui/pull/31
- **Branch**: fix/sticky-header-flicker-2
- **Issue**: n/a (reopened from the user's in-app report; diagnosis = version
  skew — zik_zak runs hosted 0.3.0, which predates #28)

Pins the zik_zak feed geometry (zero paddings, `SizedBox.shrink()` ad
header) with a regression test — red against the 0.3.0 code, green on
master. Ships the reopen artifacts; the user-visible resolution is the
0.3.1 publish plus the zik_zak bump.

## Cycle 3 — PR #33 (`sticky` opt-out flag)

- **Slug**: sticky-header-flicker
- **Opened**: 2026-10-12
- **PR**: 33
- **URL**: https://github.com/arrrrny/zuraffa_ui/pull/33
- **Branch**: feat/sticky-inactive-sections
- **Issue**: n/a (local bug workflow; follow-up from PRs #28/#31)

Adds `ShadListSection.sticky` (default `true`): a `sticky: false` ad section
never becomes the active section — the bar keeps the previous title across
its band and `onSectionChanged` skips it. Cycle 10 red/green evidence in
`tdd/cycle-log.md`; report in `fix.md`.
