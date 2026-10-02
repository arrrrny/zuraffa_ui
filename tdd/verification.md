# TDD Verification: sync — upstream merge conflicts require manual resolution (#27)

**Verdict: PASS** (declared gaps listed below). The chore is a fork–upstream
merge resolution, so the discipline here is *symptom-first*: the reported
conflict was reproduced verbatim with the sync workflow's own commands (red
evidence), the merged tree on PR #29 was audited per the fork-upstream-sync
policy, and every guard the policy depends on was exercised — including
deliberate mutants that prove the guards fire.

Audited at `315af26` (merge `270fed6` + regenerated hashes `17ab743` + docs
`7307b9b` + review-comment fixes `315af26`). The `315af26` delta is CI
workflow comment/permission-structure edits (`build-runner.yml`,
`flutter-test.yaml`) plus verification prose — no runtime code — and the
guard, analyze, and format checks were re-run on it. Toolchain: Flutter
3.47.6 stable / Dart 3.13.5 (satisfies `sdk >=3.11.0`, `flutter >=3.41.0`),
Linux x64 sandbox.

**Independence disclosure:** this audit was executed by a *different session*
than the one that performed the merge (cold-context audit of PR #29's head).
It supersedes the authoring session's own `verification.md` for the same
feature; every command below was actually run in the auditing session, and
the red evidence below is a fresh reproduction, not a copy.

## Symptom-first evidence (the "red")

Reproduced with the workflow's exact merge step
(`git switch -c repro/s27 upstream/main && git merge origin/master --no-ff`)
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
branch deleted (housekeeping). Note: `upstream/main` has advanced to
`a6e7688` since the issue recorded `ff2d1400`; `ff2d1400` is an ancestor of
`a6e7688`, so the reproduction covers the reported state.

## Resolution evidence (the "green")

| Criterion (issue #27) | Evidence | Status |
| --- | --- | --- |
| Resolve in favour of fork + upstream change | `270fed6` merge commit, parents `a6e7688` (upstream/main) + `b375a23` (origin/master). `pubspec.yaml` merge result is byte-identical to master's fork identity block (`name: zuraffa_ui`, fork description/topics/repository); `CHANGELOG.md` keeps fork entries on top and inserts upstream's new `0.57.1` entry above `0.57.0` | PROVEN |
| Engine keeps upstream spelling | `lib/src/**` engine files merged mechanically; no `Shad*`→`Zfa*` renames in the master…head diff; the PR does carry `.dart` changes, but they arrive pre-verified via the upstream merge — `lib/src/components/form/field.dart` and `test/src/components/form_test.dart`, the upstream 0.57.1 unique-field-id fix (`ff2d140`, #709) — and `form_test.dart` was additionally run here (14/14, see suite row) | PROVEN |
| Regenerate the brand map | `dart run scripts/generate_zfa_aliases.dart` → "256 aliases from 120 engine libraries"; `git status` on the map after regen = empty (zero drift — the committed map is current for upstream `a6e7688`) | PROVEN |
| Follow merged tree (CLI hashes) | `.github/scripts/generate_hashes.sh` rerun: regenerated `cli/hashes.json` is content-identical to the committed one (pure key reorder — the script's unsorted `find` is filesystem-order-dependent; compared with `jq -S` normalization) | PROVEN |
| Fork-owned files + markers survive | Guard replicated 1:1 from `sync-upstream.yml`'s "Verify fork-owned file markers" step over `.github/FORK_OWNED_FILES`: 16 entries, every path exists, every marker matches | PROVEN |
| Suite green | `flutter analyze` → **No issues found** (after CI-parity `pub get` in root, `cli/`, `playground/`; re-run green on `315af26`); `flutter test test/identified/` → **50/50**; `flutter test test/src/components/form_test.dart` (neighbour of the upstream-touched `lib/src/components/form/field.dart`) → **14/14**; full `flutter test` → **412/412** | PROVEN |
| Formatting clean | `dart format --output=none --set-exit-if-changed .` → 415 files, **0 changed**, rc=0 (re-run on `315af26`) | PROVEN |
| Next scheduled sync is a no-op | Not directly runnable pre-merge: after this PR merges, upstream `a6e7688` becomes an ancestor of `master`, so the workflow's up-to-date check short-circuits. Structural consequence of the merge parents; verified by construction | NOT PROVABLE PRE-MERGE |

## Test-first evidence

| Behavior | Class | Evidence |
| --- | --- | --- |
| Guard tests (alias coverage, barrel surface, contract kit) | `NOT_APPLICABLE` | Chore-type spec: no new behavior introduced, no new tests required. The pre-existing guards were run against the merged tree, not written alongside it |
| Conflict reproduction | `LIKELY` | Symptom red recorded verbatim above; same-session reproduction, not committed as a test (a merge conflict is not a unit-testable behavior) |

## Mutation results

Deliberate mutants executed in the auditing session against the merged tree
(repo precedent from `specs/1099` and PR #28's audit). Each mutant was fully
reverted after its run; the tree is clean at audit time.

| Mutant | Change | Killer | Result |
| --- | --- | --- | --- |
| A | Replace the `name: zuraffa_ui` survival marker in `pubspec.yaml` | Fork-owned marker guard (`FORK_OWNED_GUARD=FAIL: pubspec.yaml (missing marker: name: zuraffa_ui)`) | KILLED |
| B1 | Delete map line 13 (header comment text) | — (no behavioral change; invalid mutant, discarded) | INVALID |
| B2 | Delete `typedef ZfaState = ShadState;` (real alias) from `lib/src/identified/mapping/zfa_engine_aliases.dart` | `test/identified/zfa_alias_coverage_test.dart` fails: "Zfa brand map aliases every public Shad* type the engine exports" | KILLED |

Interpretation: the two guards that make future syncs safe — the fork-owned
marker check and the alias coverage drift test — demonstrably fire on real
regressions of the kind this merge could have introduced.

## Acceptance-criteria coverage

- **Conflicts resolved by hand per policy** → merge `270fed6` audited file by
  file (see Resolution evidence).
- **Brand map regenerated** → regen ran idempotent; zero drift.
- **Verify (`flutter analyze && flutter test test/identified/`)** → both green,
  plus full suite and neighbour suite for regression confidence.
- **PR referencing the issue** → PR #29 (`fix(27): sync: upstream merge
  conflicts require manual resolution`) targets `master` from
  `fix/27-sync-upstream-merge-conflicts-require-manual-resolution`, body
  closes #27. One PR per issue; no duplicate PRs opened.

## Gate verdict

**PASS.** No remediation tasks required. The single gap — proving the next
scheduled sync run is a no-op — is structurally impossible before merge and
discharges automatically once #29 lands.
