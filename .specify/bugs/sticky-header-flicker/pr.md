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
