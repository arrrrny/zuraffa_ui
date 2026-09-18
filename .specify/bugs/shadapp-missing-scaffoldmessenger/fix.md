# Bug Fix: ZuraffaApp provides a ScaffoldMessenger under the app shell

- **Slug**: shadapp-missing-scaffoldmessenger
- **Fixed**: 2026-09-18
- **Assessment**: ./assessment.md
- **Status**: applied
- **TDD artifacts**: ./tdd/test-list.md, ./tdd/cycle-log.md (verification.md is
  written by the audit step)

## Summary

`ZuraffaApp` now wraps its navigator subtree in a `ScaffoldMessenger`, so
`ScaffoldMessenger.of(context)` resolves for every widget mounted under the
shell — the home route, pushed routes — and SnackBars render. This is the
condition reported in `arrrrny/zuraffa_browser#168`, which blocked feature 116's
export-flow snackbar.

## Changes

| File | Change | Notes |
|------|--------|-------|
| `lib/src/identified/app/zuraffa_app.dart` | modified | mounts `ScaffoldMessenger` above the navigator inside the `ShadApp.builder`; class docs updated |
| `.specify/memory/tdd-profile.md` | modified | repaired to zfa's readable shape: quoted command templates, closing `---` for the frontmatter, `single` moved into `verified`, `mutation` recorded |
| `pubspec.yaml` | modified | adds the `mutation_test` dev dependency — the audit lane's tool (zfa's `tdd verify` fix line) |
| `build.yaml` | modified (comment only) | documents the zfa#1709 workaround where `zfa build` points |
| `lib/tdd/shadapp-missing-scaffoldmessenger/a1_subject.dart` | added | scenario runner: resolves the messenger from a home-route probe |
| `lib/tdd/shadapp-missing-scaffoldmessenger/a2_subject.dart` | added | scenario runner: shows a SnackBar, drains its timer, reports rendering |
| `lib/tdd/shadapp-missing-scaffoldmessenger/a3_subject.dart` | added | scenario runner: resolves the messenger from a pushed route |
| `lib/tdd/shadapp-missing-scaffoldmessenger/a4_subject.dart` | added | scenario runner: collects wiring-preservation evidence |
| `test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart` … `a4_test.dart` | generated + hand-completed | real outcome assertions outside the guard (zfa #1488), `<id>:hand` attestations (zfa #1411) |
| `.specify/bugs/shadapp-missing-scaffoldmessenger/spec.md` | added | bug spec: 4 acceptance scenarios; A2 declared acceptance lane (see Deviations) |

## Diff Highlights

```dart
// lib/src/identified/app/zuraffa_app.dart — _ZuraffaAppState.build
builder: (context, child) {
  final inner = widget.builder?.call(context, child) ?? child;
  return ScaffoldMessenger(
    child: ZfaViolationChrome(
      bus: _bus,
      enabled: widget.showViolationChrome,
      child: inner ?? const SizedBox.shrink(),
    ),
  );
},
```

## Tests Added or Updated

- `test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart` — a widget under
  `ZuraffaApp`'s home route resolves a `ScaffoldMessengerState` (A1, AC-1).
- `test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart` — `showSnackBar`
  through the shell renders its content (A2, AC-2).
- `test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart` — a widget on a
  pushed route resolves the shell's messenger (A3, AC-3).
- `test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart` — user builder,
  violation chrome, route-contract observer, `ShadToaster`/`ShadSonner` remain
  mounted above the navigator; user observers stay merged (A4, AC-4).

## Local Verification

- `flutter test test/tdd/shadapp-missing-scaffoldmessenger/` → 4 passed.
- Fresh-checkout reproduction of the original failure (A1 subject before the
  fix): `ScaffoldMessenger.of` threw `debugCheckHasScaffoldMessenger` at
  `subject_a1` — the issue's exact failure.
- `flutter analyze lib/tdd test/tdd lib/src/identified/app/zuraffa_app.dart` →
  `No issues found!`
- `dart format lib/tdd test/tdd` → no changes.
- Cycle log: red certified for A1 (assertionFailure, UnimplementedError), A3,
  A4, A2; green evidence re-bound to the final subject shapes (`verify-red
  --re-certify`, zfa #1162).
- Suite baseline note: full-suite re-proofs ran red only on the 6 pre-existing
  `ShadSheet` golden failures, tolerated by the engine as pre-existing (zfa
  #922); no regression.
- `zfa tdd verify --feature shadapp-missing-scaffoldmessenger --runner flutter`
  → gate `pass`, mutation score 1.0000 (8 killed / 0 survived / 0 timed out,
  restoration verified). Report: `./tdd/verification.md`.

## Deviations from Assessment

- The assessment was fetch-seeded (`likely valid, needs reproduction`); the bugs'
  TDD spec refined its scenarios into four acceptance behaviors (A1–A4).
- **Mutation lane enabled**: the audit lane requires `mutation_test` (zfa's fix
  line); the profile previously declared no mutation tool and prescribed the
  deliberate-mutant fallback. `mutation_test` 1.8.1 was added as a dev
  dependency and the profile's `mutation` key/notes updated to match — the audit
  gate now runs and passes.
- **A2 lane re-declared**: the planner classified `showSnackBar` under the
  widget lane, but that lane refuses inside `zuraffa_ui` itself — it boots a
  `ZuraffaApp` shell through a `zuraffa_ui` dependency a package cannot declare
  on itself (zfa #938, the "zuraffa_ui gate"). A2 is now declared
  `**Type**: acceptance`; that lane is the engine's `testWidgets`-pair lane and
  fits the scenario exactly.
- **Phase-2 refactor could not complete**: `zfa tdd refactor`'s build pass runs
  `zfa build`, which refuses this package's `build.yaml` ("does not register the
  zorphy builder") even though the package has zero `@Zorphy` entities —
  dead-ending the run with no opt-out. Reported as arrrrny/zuraffa#1709; its
  substantive passes (`dart format`, analyze) were run by hand and are clean.
  Behavior-level evidence (red → green per behavior) is complete in the cycle
  log; only the run's `done` transition is blocked by the upstream issue.

## Follow-ups

- arrrrny/zuraffa#1709 — let `zfa tdd refactor` no-op its build pass for
  projects without zuraffa code generation.
- `arrrrny/zuraffa_browser#168` — once this lands, remove feature 116's
  workaround (the explicit `ScaffoldMessenger` wrap in the test and the comment
  in `lib/src/markdown/ui/markdown_export_feedback.dart`).
- Optional (not needed for this bug): expose a `scaffoldMessengerKey` on
  `ZuraffaApp` for `MaterialApp` API parity.
