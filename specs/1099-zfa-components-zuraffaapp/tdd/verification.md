---
feature: 1099-zfa-components-zuraffaapp
verdict: PASS_WITH_GAPS
standard: .specify/extensions/tdd/templates/tdd-test-quality-rubric.md # rubric graded against
verified_at: e3e1784 # short SHA audited
behaviors: 21
proven: 21
likely: 0
test_after: 0
no_test: 0
high_smells: 0
criteria_total: 8
criteria_covered: 8
mutation_score: null # no Dart mutation tool in this environment; deliberate mutants used
mutants_survived: 0 # 5 deliberate mutants on 5 behaviors, all caught, all restored
suite: 369 passed, 0 failed, 1m13s
---

# TDD Verification: zuraffa_ui — identified Zfa components + ZuraffaApp

**Verdict: PASS_WITH_GAPS.** The discipline holds: every behavior in the test
list was committed as a failing test before the code that satisfies it, git
history corroborates the order, no carried-over assertion was weakened, every
acceptance criterion reaches a test through the real entry point, and all five
deliberate mutants were caught. The gaps are listed individually below — the
largest being that mutation strength was measured on a 5-behavior sample, not
exhaustively, and that this audit was run by the same session that wrote the
tests.

Audited from cold context at `e3e1784`. All three evidence sources were read:
`tdd/cycle-log.md`, `git log --stat` over `afc9569..e3e1784`, and every test and
source file the branch touched, re-read at their audited state.

**Independence disclosure:** the auditor is the session that wrote the tests.
Every file was re-read from disk rather than from memory, but per the rubric's
"read cold" rule this is a declared limitation, not a pass by default.

## Test-first evidence

The whole behavior list landed as one red batch (`bd9182b`, tests + spec docs
only), then the repackage (`68df566`), then the identified layer (`ac43d9d`).
The red for cycles 1 and 2 is compile-level — the package did not resolve, then
the barrel did not exist — which is genuine red for "the behavior does not
exist", recorded verbatim in the cycle log (192 unique error lines). One
assertion-level red was observed and recorded during cycle 3 (the zfa-key
convention, expected `zfa.button` vs actual `button`).

| Behavior | Class  | Evidence                                                                  |
| -------- | ------ | ------------------------------------------------------------------------- |
| A1       | PROVEN | cycle 1 red recorded; `bd9182b` adds the test before any source change    |
| A2       | PROVEN | cycle 1 red recorded; same ordering evidence                              |
| A3       | PROVEN | cycle 1 red recorded; same ordering evidence                              |
| A4       | PROVEN | cycle 1 red recorded; same ordering evidence                              |
| U1–U9    | PROVEN | cycle 1 red recorded (batch, compile-level); `bd9182b` precedes `ac43d9d` |
| U10      | PROVEN | cycle 1 red recorded; M1/M4 mutants confirm the tests bite                |
| U11      | PROVEN | cycle 1 red recorded; M2 mutant confirms the tests bite                   |
| U12      | PROVEN | cycle 1 red recorded; history shows test before source                    |
| U13–U15  | PROVEN | cycle 1 red recorded; M3 mutant confirms the tests bite                   |
| U16      | PROVEN | cycle 1 red recorded; identity assertions on the engine type              |
| C1       | NOT_APPLICABLE | characterization baseline: 333 engine tests green at `afc9569`, green at `e3e1784` after the rename |

**Carried-over tests:** the branch diff over `test/src` touches import URIs
(`package:shadcn_ui/` → `package:zuraffa_ui/`) and `dart format` reflow only.
Removed `expect(` lines: 5, all re-indentations of the same assertion in
`select_test.dart` (predicate and matcher unchanged). Zero skips added, zero
assertions loosened, zero thresholds changed.

## Findings

| #   | Severity | Finding                                                                                                                               | Evidence                                        |
| --- | -------- | ------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------- |
| 1   | MED      | `ZfaToaster contract: ... toasts shown through it appear` exercises the toaster `ShadApp` mounts internally, not `ZfaToaster.build` — the wrapper's build line is unreached (1/4 lines covered) while the test's name claims "through it" | `test/identified/zfa_components_test.dart:164` + coverage `zfa_toaster.dart: 25%` |
| 2   | LOW      | `skin_contract_kit.dart` at 88% (28/32): the `didReplace` reporting branch and `ZfaContractViolation.toString` are uncovered            | `coverage/lcov.info`, `skin_contract_kit.dart`  |
| 3   | LOW      | `zuraffa_app.dart` at 98% (51/52): the no-ambient-Directionality fallback in the violation banner is uncovered                        | `coverage/lcov.info`, `zuraffa_app.dart`        |
| 4   | LOW      | This audit was not independent: the session that wrote the tests graded them (files re-read cold, disclosed)                          | rubric "read cold" rule, this file's disclosure |

## Mutation results

No Dart mutation tool exists in this environment (see
`.specify/memory/tdd-profile.md`), so the deliberate-mutant procedure was used:
one small change, run the behavior's test, restore exactly, re-run the full
suite to confirm green — after every single mutant. Five high-risk behaviors
were sampled out of 21; the sample is not exhaustive.

| Mutant                                                                                  | Behavior | Survived | Judgment                                                    |
| --------------------------------------------------------------------------------------- | -------- | -------- | ----------------------------------------------------------- |
| `zuraffa_app.dart` dropped the contract observer from `navigatorObservers`              | U10      | No       | Caught by the unnamed-push chrome test                      |
| `zuraffa_app.dart` chrome guard always returns the child (banner never shows)           | U11      | No       | Caught by two chrome tests                                  |
| `skin_contract_kit.dart` `contractIdOf` returned the bare element name                  | U15      | No       | Caught by the key-convention test                           |
| `skin_contract_kit.dart` route name hard-coded to null (named routes violate too)       | U10, U14 | No       | Caught by six tests, including the named-route-clean ones   |
| `zfa_button.dart` forwarded `onPressed: null` instead of the handler                    | U2       | No       | Caught by the tap-forwarding test                           |

Every mutant was restored with `git checkout -- <file>` and the full suite
re-ran green (`+369`) after each restore; the working tree contains no mutant.

## Traceability

| Criterion | Tests                        | End to end |
| --------- | ---------------------------- | ---------- |
| AC-1      | A1 (pubspec, lib layout, hygiene scan) | Yes — reads the real files and compiles the real package |
| AC-2      | A2, A4, U3, U6               | Yes — barrel source scan + compile + widget-tree asserts |
| AC-3      | U1–U9, U13–U15, M3, M5       | Yes — typed getters on real instances, mutation-checked |
| AC-4      | U10–U12, M1, M2, M4          | Yes — real `Navigator` pushes through `ZuraffaApp`       |
| AC-5      | U16                          | Yes — `ZuraffaApp` pump, alias identity vs engine type   |
| AC-6      | A1                           | Yes — CHANGELOG content assert                           |
| AC-7      | C1                           | Yes — full suite green after the rename                  |
| AC-8      | the 36 identified tests      | Yes — they are the criterion                             |

Untested criteria: none. Tests tracing to nothing: none — every test maps to a
listed behavior.

## What was not audited

- Mutation strength beyond the 5-behavior deliberate sample (21 behaviors
  total); no mutation tool score.
- `example/` and `playground/` sub-projects were import-rewritten but not
  built or tested (playground carries 144 pre-existing analyzer errors at
  baseline; unresolved deps, out of this feature's scope).
- The zik_zak consumer flip and `zfa make --skin` import generation — out of
  scope by spec (the skin lane repo owns them).
- Engine internals beneath the identified layer: covered only by the
  carried-over suite, not re-audited behavior by behavior.
- Coverage for engine files was not collected; coverage was scoped to
  `lib/src/identified/` and the barrel.
