# TDD Verification — 1100-uinode-system

**Audit mode**: fallback (LLM-guided) — `zfa` v6.3.0 present but the project
is not zuraffa-wired (no `.zfa.json`), so `zfa tdd verify` cannot register
behavior artifacts; its receipt-driven mutation phase reports
`not_assessed (no behavior artifacts registered)` and was supplemented by a
deliberate-mutant pass (the 1099 precedent).

**Verdict: PASS_WITH_GAPS** (gap 1 closed on CI — remaining gaps are
infrastructure-only)

## Gate summary

| Check | Result |
|---|---|
| Suite state (cold) | `flutter test` → **+485 ~6 all passed** (89 uinode tests + 22 golden render-only on macOS + 374 carried over; ~6 platform skips are the sheet-golden policy from #7) |
| Static analysis | `flutter analyze` → 0 issues on every branch-touched file (167 remaining are pre-existing in `playground/`+`lib/pages/` on untouched files) |
| Test-first evidence | cycle-log records a red (compile- or assertion-level) for every behavior before its implementation; zfa-delegated red-capture unavailable in fallback mode |
| Red-phase honesty | two loop-driven regressions caught and fixed honestly: depth-cap double increment (probe: nest(30) threw at hop 17) and validation duplicate/wrong-path reports |
| Test smells | no `skip` abuse (only the documented Linux-golden policy), no sleeps, no test-only production flags, deterministic seeds (research D9), finders scoped to renderer-owned subtrees |
| Acceptance coverage | A1→SC-2, A2→SC-3, A3→SC-4, A4→SC-1, A5→SC-5 all DONE (A2 compare pending Linux CI — see gaps) |
| Codegen discipline | build_runner clean; generated `.zorphy.dart` committed; CI build-runner workflow regenerates + verifies |

## Mutation audit — deliberate mutants (tool infra not wired)

`mutation_test` 1.8.1 is in dev_dependencies, but the receipt-driven runner
requires `.zfa.json` behavior registration (fallback mode). 5 hand-written
mutants over the layer's core logic, each run against its owning test file:

| Mutant | Mutation | Result |
|---|---|---|
| M1 | canonical writer emits keys in reverse schema order | **KILLED** (canonical_json_test) |
| M2 | depth cap `> maxDepth` → `> maxDepth + 5` | **KILLED** (parser_test) |
| M3 | schema-version gate deleted (`if (false)`) | **KILLED** (parser_test) |
| M4 | unknown action swallowed (callback dropped) | **KILLED** (actions_test) |
| M5 | handler-try/catch removed (errors escape) | **KILLED** (actions_test) |

5 killed / 0 survived. Restoration verified after each mutant
(`git checkout --` + suite re-run green).

## Gaps (why not full PASS)

1. ~~A2 golden compares execute on Linux CI only~~ **CLOSED**: CI run
   35376918127 passed all 498 tests including the 22 golden comparisons
   (goldens regenerated in a Flutter-3.47.4 Linux environment matching
   CI; a container-version mismatch initially caused a 0.06% drift on
   06-card, diagnosed and fixed by pinning to CI's exact SDK).
2. **Mutation score is deliberate-mutant-based, not tool-driven** — the
   receipt/behavior-artifact registration (`zfa` init) is not wired for
   this repo; when it is, re-run `zfa tdd verify` for a tool-computed
   score.
3. **Two misfires filed per the AGENTS.md rule**: arrrrny/zuraffa#1717
   (zorphy sealed-base cross-library limitation → single-library nodes)
   and arrrrny/zuraffa_ui#24 (alias generator vs gates on `$$` seams —
   fixed on this branch, issue kept for the record).

## Coverage map (acceptance → behaviors)

| AC | Behaviors | Evidence |
|---|---|---|
| SC-1 / A4 | U1, surface test, coverage-audit.md | `uinode_surface_test` pins the v1 vocabulary; audit lists every public family covered or excluded with tier+reason |
| SC-2 / A1 | U1–U10, round-trip gen suite | 34 kinds × 3 seeded variations, byte-stable |
| SC-3 / A2 | U11–U15, golden_test | 21 fixtures render clean (macOS); compare pending Linux CI; token-restyle covered by U13 |
| SC-4 / A3 | U6, U7, U16–U19 | caps/version/unknown-node/action-containment all typed-outcome tested |
| SC-5 / A5 | U20, analyzer | source gate + color rejections; 0 analyze issues on branch surface |

---

## Raw receipt from `zfa tdd verify` (pre-supplement)

# TDD Verification — feature `1100-uinode-system`

Generated fresh by `zfa tdd verify --feature 1100-uinode-system`.

## Gate

- gate: `not_assessed`
- not_assessed_reason: no behavior artifacts registered

## Mutation buckets (FR-014)

- killed: 0
- survived: 0
- timed_out: 0

## Behavior scope (FR-018)

- (no behavior artifacts in scope)

## Restoration (FR-021)

- restoration_verified: true
- restoration_scope_count: 0

## Repro diagnostics (FR-020, non-sensitive)


## Mutation run

- mutation_was_run: false
