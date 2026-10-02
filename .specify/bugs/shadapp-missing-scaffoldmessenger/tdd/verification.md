# TDD Verification — feature `shadapp-missing-scaffoldmessenger`

Generated fresh by `zfa tdd verify --feature shadapp-missing-scaffoldmessenger`.

## Gate

- gate: `pass`

## Mutation buckets (FR-014)

- killed: 8
- survived: 0
- timed_out: 0

## Behavior scope (FR-018)

- `A1` — traces: `AC-1`
- `A3` — traces: `AC-3`
- `A4` — traces: `AC-4`
- `A2` — traces: `AC-2`

## Behavior kinds (issue #1376)

- presence: 0
- absence: 0
- route-outcome: 0
- enabled-state: 0
- sequence: 0

- `A1` — not traced: no scenario-assertions header in test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart
- `A3` — not traced: no scenario-assertions header in test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart
- `A4` — not traced: no scenario-assertions header in test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart
- `A2` — not traced: no scenario-assertions header in test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart

## Restoration (FR-021)

- restoration_verified: true
- restoration_scope_count: 4
- restoration_scope (subjects only, never tests):
  - `/Users/arrrrny/Developer/zuraffa_ui/lib/tdd/shadapp-missing-scaffoldmessenger/a1_subject.dart`
  - `/Users/arrrrny/Developer/zuraffa_ui/lib/tdd/shadapp-missing-scaffoldmessenger/a2_subject.dart`
  - `/Users/arrrrny/Developer/zuraffa_ui/lib/tdd/shadapp-missing-scaffoldmessenger/a3_subject.dart`
  - `/Users/arrrrny/Developer/zuraffa_ui/lib/tdd/shadapp-missing-scaffoldmessenger/a4_subject.dart`

## Repro diagnostics (FR-020, non-sensitive)

- runner_command: `dart run mutation_test`
- exit_code: 0
- elapsed_seconds: 373
- report_path: `/Users/arrrrny/Developer/zuraffa_ui/.dart_tool/zfa/tdd-verify-report/mutation-test-report.md`
- preflight_scope_ran (bug #924, per-behavior):
  - `test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart`
  - `test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart`
  - `test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart`
  - `test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart`

## Mutation run

- mutation_was_run: true
- mutation_score: 1.0000

## Evidence binding (bug #837)

- spec_hash: 31a4d229ddb17bafdd2bc9eb0e5d492b1a5d147550190ca0cbbc5abd60be04af
- subject_hash: `/Users/arrrrny/Developer/zuraffa_ui/lib/tdd/shadapp-missing-scaffoldmessenger/a1_subject.dart` 49f65e9592591e0eeb5a4d2507e69e82e41e44e25df729c2c0342db4449e1cb3
- subject_hash: `/Users/arrrrny/Developer/zuraffa_ui/lib/tdd/shadapp-missing-scaffoldmessenger/a2_subject.dart` 2991fb09f30b5af76ce883c19b0e01b2006049dc6d3e0f415e7236c668e0a04d
- subject_hash: `/Users/arrrrny/Developer/zuraffa_ui/lib/tdd/shadapp-missing-scaffoldmessenger/a3_subject.dart` e8e513934593092cbcdde0bcff02fa0115ff47a4e10e65e0592b7337ee077a76
- subject_hash: `/Users/arrrrny/Developer/zuraffa_ui/lib/tdd/shadapp-missing-scaffoldmessenger/a4_subject.dart` 8c5375cf88342b8f65bb815cb8f3cbb4ee37bebac0c3b728733cff25e4dcf1ca
