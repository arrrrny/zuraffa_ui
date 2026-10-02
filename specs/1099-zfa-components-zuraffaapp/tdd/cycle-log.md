# Cycle Log: zuraffa_ui — identified Zfa components + ZuraffaApp

Append only. Newest last. Every entry's `red` block is the evidence that the test
existed and failed before the code that satisfies it.

## Baseline

- suite: `flutter test` -> `All tests passed!` (+333, 1m 11s) at fork SHA `afc9569`
- analyze: `flutter analyze` -> 146 issues found (144 error-level, all in the
  `playground/` sub-project; `lib/` and `test/` clean) at fork SHA `afc9569`
- recorded: cycle 0, before any change
- note: the clone's pubspec has no `dependency_overrides` section (the spec's
  deletion step is a no-op; verified by grep). `flutter pub get` resolved the
  package and `example/` against published versions.

## Cycle 1: A1-A4 + U1-U16 the whole test list, red on the shadcn_ui substrate

- test: `test/identified/barrel_surface_test.dart` (new, acceptance),
  `test/identified/zfa_components_test.dart` (new),
  `test/identified/zuraffa_app_test.dart` (new),
  `test/identified/skin_contract_kit_test.dart` (new),
  `test/identified/zfa_theme_test.dart` (new) — 36 test cases, the full
  behavior list
- red: `flutter test test/identified/` -> compilation failure (exit 255):
  `Error: Couldn't resolve the package 'zuraffa_ui' in
  'package:zuraffa_ui/zuraffa_ui.dart'`, then per-declaration errors
  (`Type 'ZfaContract' not found`, `Method not found: 'ZfaAuditBus'`,
  `Undefined name 'SkinContractKit'`, ...). 192 unique error lines captured
  verbatim. The red is compile-level: the package resolves as `shadcn_ui` and
  no certified declaration exists.
- green: not attempted. This is the outer loop opening; it stays red until the
  repackage and the identified layer land. State left `RED` deliberately.
- commit: `bd9182b` (tests + spec docs only, no implementation)

## Cycle 2: repackage rename — engine carried over, identified layer still red

- change: pubspec `name: zuraffa_ui` / `version: 0.1.0`;
  `git mv lib/shadcn_ui.dart lib/shad.dart`; 783
  `package:shadcn_ui/` -> `package:zuraffa_ui/` URIs rewritten across 266
  files (lib, test, example, playground, cli, scripts, docs, skills)
- red (still): `flutter test test/identified/` ->
  `Error: Error when reading 'lib/zuraffa_ui.dart': No such file or
  directory` + `Error: 'ZfaButton' isn't a type` (package resolves, the
  certified vocabulary does not exist yet)
- green (carried over): `flutter test test/src` -> `All tests passed!`
  (+333) — the fork's engine tests keep running inside the renamed package
  (C1)
- commit: `68df566` (repackage only, identified layer not yet written)

## Cycle 3: the identified layer — all behaviors green

- change: `lib/src/identified/` (contract kit, six Zfa components, ZuraffaApp
  + violation chrome, theme aliases) + `lib/zuraffa_ui.dart` barrel +
  CHANGELOG 0.1.0 entry + README re-badge
- red (assertion-level, observed during the cycle):
  `skin_contract_kit_test.dart::parses the pilot zfa: key convention` ->
  `Expected: 'zfa.button' Actual: 'button' Which: is different ... Differ at
  offset 0` — the zfa-key convention implementation returned the bare element
  name instead of the certified id
- green (fix): `SkinContractKit.contractIdOf` now maps the bare element name
  to its certified id (`button` -> `zfa.button`, fully-qualified names pass
  through). Also fixed in the same cycle, in the tests themselves:
  `const ZfaContractViolation(...)` on a non-const constructor, and
  `tester.state(...)` on a StatelessWidget (replaced with
  `tester.element(...)`) — test bugs, not behavior changes
- green: `flutter test` -> `All tests passed!` (+369: 333 carried over + 36
  identified)
- commit: `ac43d9d`

## Cycle 4: hardening — format, lint, analyzer baseline

- change: `dart format .` (7 files reformatted, committed; re-run -> 0
  changed), `dart fix --apply` (61 automated fixes in 41 files:
  always_use_package_imports, directives_ordering caused by the package
  rename, sort_child_properties_last, const constructors, tearoffs), manual
  lint fixes in the identified layer (contractId fields -> getters, late
  observer, doc references de-bracketed, spurious doc-reference imports
  removed — including a barrel self-import `dart fix` had introduced)
- green: `flutter test` -> `All tests passed!` (+369) after formatting and
  fixes
- analyze: 146 issues = exactly the pre-existing baseline (144 playground
  errors; zero in `lib/` + `test/`; zero in the identified layer)
- commit: `e3e1784`

## Cycle 5: verification audit

- change: `tdd/verification.md` written from cold context; deliberate mutants
  executed on five high-risk behaviors (each restored, suite re-run green);
  coverage collected for the identified layer
- commit: (this commit)
