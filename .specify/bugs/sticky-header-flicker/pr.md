# Bug Fix PR: Sticky header flicker past headerless ad sections

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
