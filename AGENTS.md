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
