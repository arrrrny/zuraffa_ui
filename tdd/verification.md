# TDD Verification: sync — upstream merge conflicts require manual resolution (#27)

**Verdict: PASS** (with declared gaps, all below). The chore is a fork–upstream
merge resolution, so the discipline here is *symptom-first*: the reported
conflict was reproduced verbatim from the sync workflow's own commands (red
evidence), resolved per the fork policy, and the merged tree is proven by the
repo's own drift guards plus the full CI suite — all green on the exact commit
that carries this file. Two deliberate mutants confirm the guards that make
future syncs safe actually fire.

Audited at `17ab743` (merge `270fed6` + regenerated hashes). Toolchain:
Flutter 3.47.6 stable / Dart 3.13.5 (satisfies `sdk >=3.11.0`,
`flutter >=3.41.0`).

**Independence disclosure:** the auditor is the session that performed the
merge. Per the rubric's cold-context rule this is a declared limitation, not a
pass by default. All evidence below was captured in this session from the
actual commands shown.

## Symptom-first evidence (the "red")

Reproduced with the workflow's exact merge step
(`git switch -c repro upstream/main && git merge origin/master --no-ff`)
before touching anything:

```
Auto-merging CHANGELOG.md
CONFLICT (content): Merge conflict in CHANGELOG.md
Auto-merging pubspec.yaml
CONFLICT (content): Merge conflict in pubspec.yaml
Automatic merge failed; fix conflicts and then commit the result.
merge rc=1
```

`git diff --name-only --diff-filter=U` → exactly `CHANGELOG.md`,
`pubspec.yaml` — matching issue #27's two conflicted files. Merge aborted,
branch deleted (housekeeping).

## Resolution evidence (the "green")

| Criterion (issue #27) | Evidence | Status |
| --- | --- | --- |
| Resolve in favour of fork + upstream change | `270fed6` merge commit, parents `a6e7688` (upstream/main) + `b375a23` (origin/master). `pubspec.yaml` keeps the fork identity block (precedent: sync PR #18 / `74b2e96`); `CHANGELOG.md` keeps fork entries on top and inserts upstream's new `0.57.1` entry above `0.57.0` | PROVEN |
| Engine keeps upstream spelling | `lib/src/**` engine files merged mechanically; no `Shad*`→`Zfa*` renames in the diff | PROVEN |
| Regenerate the brand map | `dart run scripts/generate_zfa_aliases.dart` → "256 aliases from 120 engine libraries"; `git diff` on the map = empty (no drift) | PROVEN |
| Follow merged tree (CLI hashes) | `.github/scripts/generate_hashes.sh` → `cli/hashes.json` 233 lines updated, committed as `17ab743` (the sync job's own commit shape) | PROVEN |
| Fork-owned files + markers survive | `.github/FORK_OWNED_FILES` guard script run post-merge: every path exists, every marker matches | PROVEN |
| Suite green | `flutter analyze` → **No issues found**; `flutter test test/identified/` → **50/50**; `flutter test test/src/components/form_test.dart` (neighbour of the merge-touched `lib/src/components/form/field.dart`) → **14/14**; full `flutter test` → **412/412** | PROVEN |
| Next scheduled sync is a no-op | Not directly runnable pre-merge: after this PR merges, upstream `a6e7688` will be an ancestor of `master`, so the workflow's up-to-date check short-circuits. Structural consequence of the merge parents; verified by construction | NOT PROVABLE PRE-MERGE |

## Test-first evidence

| Behavior | Class | Evidence |
| --- | --- | --- |
| Guard tests (alias coverage, barrel surface, contract kit) | `NOT_APPLICABLE` | Chore-type spec: no new behavior introduced, no new tests required. The guards are pre-existing and were run against the merged tree, not written alongside it |
| Conflict reproduction | `LIKELY` | Symptom red recorded verbatim above; same-session, not committed as a test (a merge conflict is not a unit-testable behavior) |

## Mutation results

Deliberate mutants (repo precedent from `specs/1099` and PR #28's audit; the
`mutation_test` package was not run against changed files because the
**conflict-resolved** files (`CHANGELOG.md`, `pubspec.yaml`) and the
regenerated `cli/hashes.json` are non-Dart. This PR does carry `.dart`
changes, but they arrive pre-verified via the upstream merge —
`lib/src/components/form/field.dart` (+18/−2) and
`test/src/components/form_test.dart` (+40), the upstream 0.57.1 unique-field-id
fix, upstream commit `ff2d140` (#709) — and `form_test.dart` was additionally
run locally here (14/14, suite-green row above)):

| Mutant | Change | Caught by |
| --- | --- | --- |
| M1 | Dropped `typedef ZfaBreakpoint = ShadBreakpoint;` from the generated brand map | `zfa_alias_coverage_test.dart` red: "Zfa brand map aliases every public Shad* type the engine exports" — then green after restore |
| M2 | Renamed `pubspec.yaml` package to `shadcn_ui` | `FORK_OWNED_FILES` guardrail red: "pubspec.yaml missing marker 'name: zuraffa_ui'" |

Both mutants killed; tree restored to audited state (`git diff --quiet`
verified after each restore).

## Declared gaps

1. **Raw `dart analyze` tool crash (pre-existing, environment).** The bare
   `dart analyze` binary aborts inside its analyzer-plugin setup
   (`~/.dartServer/.plugin_manager/...`, `dart pub upgrade` exitCode 1 while
   resolving `analysis_server_plugin`/`analyzer_plugin`). Cache purge did not
   help; it is a Dart-SDK/plugin toolchain mismatch in this sandbox, not repo
   code (the merge changes no analysis options). Worked around with
   `flutter analyze` — the exact command `.github/workflows/flutter-test.yaml`
   runs in CI — which reports **No issues found**. Per AGENTS.md misfire rule:
   reported here, workaround documented.
2. **Formatting** checked with `dart format --output=none --set-exit-if-changed .`
   → "Formatted 415 files (0 changed)": idempotent, so running the bare
   `dart format .` would produce no diff. No formatting churn to commit.
3. **Full-suite CI parity**: this session ran the same commands as
   `.github/workflows/flutter-test.yaml` (pub get in root/cli/playground,
   analyze, full test). CI will re-run them on the PR; the merge-to-master
   push is expected to be verified there.
4. **No remediation tasks**: gate passed; `tasks.md` untouched (none exist for
   a chore spec).

## Verdict rationale

Every check the issue prescribes was executed for real in this session and
passed on the audited commit: conflict reproduced → resolved per policy →
brand map regenerated with zero drift → guards green → analyze green → full
suite 412/412 → both drift-guard mutants killed. The only unprovable item
(next-sync no-op) is structurally guaranteed by the merge parents and marked
as such rather than claimed.
