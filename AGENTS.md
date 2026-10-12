# Agent Guidelines for zuraffa_ui

## ZURAFFA MISFIRE RULE (HARD, NON-NEGOTIABLE — HARDCODED TOP RULE)

**On ANY misfire (test failure, compilation error, runtime crash, unexpected output) related to zuraffa:**

1. **STOP IMMEDIATELY** on the first misfire.
2. **Report the issue** to zuraffa GitHub (`arrrrny/zuraffa`) with: the command that failed, expected vs actual output, and root cause.
3. **Continue with a workaround** to make the task pass (e.g., skip the failing test, use an alternative approach, or mock the failing component).
4. **Add a comment** in the code explaining the workaround applied and linking to the zuraffa GitHub issue.

**On ANY misfire related to the repo itself (not zuraffa):**

1. **STOP IMMEDIATELY** on the first misfire.
2. **Report the issue** to the repo's GitHub with full details.
3. **Continue with a workaround** to make the task pass.
4. **Add a comment** in the code explaining the workaround applied.

This rule takes precedence over all other rules. Never skip a misfire or rationalize it away.

## Fork upstream sync policy

Upstream is `nank1ro/flutter-shadcn-ui` (`main`); the fork tracks it with
`.github/workflows/sync-upstream.yml` (daily 03:00 UTC + manual dispatch).

1. **Never auto-resolve a conflict in favour of upstream.** On any conflict the
   sync aborts, opens a `sync`-labelled issue and fails. Resolve by hand on a
   `sync/fork-sync-resolution` branch, preserving the fork surface, then merge
   with a PR.
2. **The fork surface is enumerated in `.github/FORK_OWNED_FILES`**
   (`path :: survival marker`). A clean merge that drops one of those paths or
   markers fails the sync and opens an issue.
3. **The engine keeps upstream `Shad*` spelling.** `lib/zfa.dart` and the
   generated brand map (`lib/src/identified/mapping/zfa_engine_aliases.dart`)
   carry the `Zfa*` alias for every engine name; after any upstream merge run
   `dart run scripts/generate_zfa_aliases.dart` (the sync job does this itself).
   `test/identified/zfa_alias_coverage_test.dart` fails on drift.
4. Never rename engine symbols to `Zfa*`: the identified layer exists so
   upstream merges stay mechanical (spec 1099).

<!-- local-ci:begin -->
## Running CI locally — `scripts/local_ci.sh`

GitHub Actions is billing-blocked on our private repos: every workflow run ends in
~3s with **zero steps executed**, so a red check here means nothing. Run the same
gate locally instead:

```bash
./scripts/local_ci.sh              # every job of the pull_request workflow
./scripts/local_ci.sh --plan       # print every step that would run, run nothing
./scripts/local_ci.sh --list       # workflows, triggers and jobs in this repo
./scripts/local_ci.sh --job <id>   # one job only
./scripts/local_ci.sh --event push # simulate the push-triggered workflow
./scripts/local_ci.sh --keep-going # do not stop at the first failure
./scripts/local_ci.sh -v           # echo each command before running it
```

It reads `.github/workflows/*` at run time and executes that workflow's jobs and
steps in order, so it cannot drift from CI — it is not a second copy of the gate.
Edit the workflow and the local run changes with it. Exit 0 means every executed
step passed.

What it cannot reproduce, and prints on startup instead of guessing:

- **Linux.** CI runs `ubuntu-latest`; this runs on macOS. The step set is the
  same, the platform is not. `sudo apt-get install` steps are mapped to a local
  presence probe rather than silently passed.
- **GitHub context.** A step needing `${{ secrets.* }}`, `${{ inputs.* }}`,
  `${{ vars.* }}`, `${{ steps.* }}` or `${{ github.event.* }}` is SKIPPED with the
  reason printed, never run with a guessed value.
- **`uses:` actions** are not executed. Toolchain setups (`setup-dart`,
  `setup-node`, `flutter-action`, `rust-toolchain`, …) become a version assertion
  against the local tool; checkout/cache/artifact are noted as no-ops; anything
  else is skipped by name. A Windows-runner job is skipped outright.
- **`container:`** jobs run on the host toolchain, not in the declared image.
- **`continue-on-error: true`** steps are advisory locally, exactly as in CI.
- **Local-only checkout state.** CI checks out the committed tree; this checkout
  also has gitignored and untracked paths, which whole-tree commands (e.g.
  `dart analyze .`) see. A step that fails naming only such paths is reported as
  a LOCAL-ONLY failure, not as a CI failure — pass `--strict` to count it anyway.
  A step that would `git clone` over a sibling checkout that already exists here
  is skipped; `--allow-outside-clone` forces it.
- **Downgrade steps mutate the lockfile (workaround for arrrrny/zuraffa_ui#34).**
  `flutter-test.yaml`'s `Downgrade dependencies` step (`flutter pub downgrade`)
  runs in the working tree here, and the gitignored `pubspec.lock` keeps the
  minimum versions after `local_ci` exits — `platform 3.0.0` no longer compiles
  on current Dart (`Member not found: 'packageRoot'`), so 23 test files fail to
  load on the next `flutter test`. Workaround applied: `flutter pub upgrade
  platform` (→ 3.2.0) restores a compiling resolution; re-run it after any
  `local_ci` run that executed the downgrade step. Details: #34.

Canonical copy: `arrrrny/forklift` → `scripts/local_ci.sh` (reference:
`docs/forklift-scripts.md`).
<!-- local-ci:end -->



## Test concurrency (fleet guard)

Cap test concurrency at **2** — one un-capped `flutter test` fan starved the
shared host's services once (load 260; arrrrrny/forklift#176).

There is **no config-file knob for `flutter test`**: it ignores
`dart_test.yaml` entirely (its only test-config file is
`flutter_test_config.dart`, an execution hook), so the flag is the only
lever — and it must be passed every time:

```sh
flutter test --concurrency=2
dart test -j 2
```

CI carries the same flags in `.github/workflows`. Never raise the number on a
host that also runs the forklift pool.
