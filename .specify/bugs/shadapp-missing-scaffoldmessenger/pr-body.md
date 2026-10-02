Fixes the condition reported in arrrrny/zuraffa_browser#168 — `ZuraffaApp` provided no `ScaffoldMessenger`, so snackbars threw under the shell.

## Summary

`ZuraffaApp` delegated to the vendored `ShadApp`, which mounts `ShadToaster`/`ShadSonner` but never inserts a `ScaffoldMessenger` — the widget `MaterialApp` normally inserts above its navigator. Any widget under the shell threw `No ScaffoldMessenger widget found` on `ScaffoldMessenger.of(...)`, so features could not surface feedback through snackbars (first hit: feature 116's export flow in `zuraffa_browser`). `ZuraffaApp` now wraps its navigator subtree in a `ScaffoldMessenger`, covering the home route and pushed routes.

## Changes

| File | Change | Notes |
|------|--------|-------|
| `lib/src/identified/app/zuraffa_app.dart` | modified | mounts `ScaffoldMessenger` above the navigator in the builder chain; class docs updated |
| `lib/tdd/shadapp-missing-scaffoldmessenger/*_subject.dart` | added | TDD scenario runners (home-route resolution, snackbar rendering, pushed-route resolution, wiring preservation) |
| `test/tdd/shadapp-missing-scaffoldmessenger/*_test.dart` | added | 4 hand-completed acceptance tests (A1–A4) |
| `.specify/bugs/shadapp-missing-scaffoldmessenger/` | added | bug record: spec, issue, fix report, verification report, cycle log, run artifacts |
| `.specify/memory/tdd-profile.md` | modified | repaired to the readable profile shape (quoted commands, closed frontmatter, verified keys, `mutation` recorded) |
| `pubspec.yaml` | modified | adds the `mutation_test` dev dependency — the audit lane's tool |
| `build.yaml` | modified (comment only) | documents the `zfa build` workaround for arrrrny/zuraffa#1709 |

## Verification

- `flutter test test/tdd/shadapp-missing-scaffoldmessenger/` → 4 passed.
- `zfa tdd verify --feature shadapp-missing-scaffoldmessenger --runner flutter` → gate `pass`, mutation score 1.0000 (8 killed / 0 survived / 0 timed out), restoration verified.
- `flutter analyze lib/tdd test/tdd lib/src/identified/app/zuraffa_app.dart` → no issues; `dart format` clean.
- Pre-fix reproduction: `debugCheckHasScaffoldMessenger` thrown at `ScaffoldMessenger.of` — the issue's exact symptom.

## Notes

- The TDD run's phase-2 refactor is blocked upstream by arrrrny/zuraffa#1709 (`zfa build` refuses a non-zorphy `build.yaml`); the refactor's substantive passes were run manually and the behavior-level red→green evidence is complete in the cycle log.
- A2 was re-declared as an acceptance behavior: the widget lane refuses inside `zuraffa_ui` itself (self-dependency gate, zfa #938).
- Assessment: `.specify/bugs/shadapp-missing-scaffoldmessenger/assessment.md`
- Verification report: `.specify/bugs/shadapp-missing-scaffoldmessenger/test.md`

Fixes https://github.com/arrrrny/zuraffa_browser/issues/168
