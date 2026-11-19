# Handoff — PR #14: ScaffoldMessenger fix + TDD lane CI (zuraffa_ui)

## 0. Resume from

None — this is the first handoff in `zuraffa_ui/handoffs/` (folder created by this session).

## 1. Session Gist

Started from GitHub issue `arrrrny/zuraffa_browser#168` ("ZuraffaApp/ShadApp provides no ScaffoldMessenger"). Fetched it into the bug workflow (`.specify/bugs/shadapp-missing-scaffoldmessenger/`), then ran the full `/skill:bug-whole` lifecycle in `zuraffa_ui` with zfa v6.3.0 TDD: synthesized a bug spec (4 acceptance scenarios), drove plan → red certification → hand-completed the acceptance subjects → green certification per behavior, mutation audit **pass** (8 killed / 0 survived), wrapped `ZuraffaApp` in a `ScaffoldMessenger`, wrote fix/test reports, and opened **PR #14**. A review bot then pushed a `.pubignore` commit (`64a94f0`); CI failed on `check-imports` (material + barrel imports in `lib/tdd` subjects). A surgical fix was applied and pushed (`7948b29`); CI run `35321511703` is green on check-imports + build-runner, with **Flutter test still in progress** as of this handoff.

## 2. Current State — Where We Are

- **Repo**: `/Users/arrrrny/Developer/zuraffa_ui` · branch `fix/shadapp-missing-scaffoldmessenger` · HEAD **`7948b29`** (pushed to origin) · remote `git@github.com:arrrrny/zuraffa_ui.git` · default branch `master` (public).
- **PR**: https://github.com/arrrrny/zuraffa_ui/pull/14 — open, not merged. Branch commits (newest first): `7948b29` (CI import fix) → `64a94f0` (review-bot: keep TDD lane out of the published package) → `ba59d36` (PR records) → `44a4664` (the actual fix) → `87b194f` ("specd", base).
- **Working tree**: clean except untracked `.zfa/` (machine-local zfa receipts; intentionally uncommitted).
- **CI (run `35321511703` on `7948b29`)**: `check-imports` ✅ success, `build-runner` ✅ success, `Flutter test` 🔄 in progress. Previous run `35317803118` (on `64a94f0`) failed only at `check-imports`.
- **Engine state**: `.specify/bugs/shadapp-missing-scaffoldmessenger/tdd/` — `cycle-log.md` (red→green per behavior), `verification.md` (gate `pass`, mutation 1.0000), `run-state.json` (A1/A2/A3/A4 = `green`), plus artifacts/journal/provenance files. The `zfa tdd run` machine itself is **stuck at `A1:refactor`** because of zfa#1709 (see GOTCHAs) — the run's `done` transition was never reached, but all four behaviors are green by receipt.
- **`feature.json`**: `.specify/feature.json` does **not** exist (removed after the cycle; it did not exist before, do not recreate it for feature work).
- **Fix substance**: `lib/src/identified/app/zuraffa_app.dart` wraps the builder chain in `ScaffoldMessenger`; tests at `lib/tdd/shadapp-missing-scaffoldmessenger/a{1..4}_subject.dart` + `test/tdd/shadapp-missing-scaffoldmessenger/a{1..4}_test.dart`; docs/records under the bug folder. Also: `.specify/memory/tdd-profile.md` repaired, `pubspec.yaml` gains `mutation_test` (dev), `build.yaml` carries the zfa#1709 workaround comment, `.github/workflows/check-imports.yaml` exempts `lib/tdd` from the Material ban.

## 3. The Threads — What's In Flight

- **A. PR #14 CI** — `Flutter test` job in progress (run 35321511703). NEXT: `gh run view 35321511703 --repo arrrrny/zuraffa_ui --json jobs --jq '.jobs[] | "\(.name): \(.status) \(.conclusion // "-")"'`. If it fails: pull the failing job log, find the real failure, fix **only** that (user's rule: never run the full suite locally — run the single failing test file).
- **B. PR review/merge** — user action. The `zuraffa-review[bot]` may re-review after `7948b29`. NEXT: when green, tell the user it's ready; do not merge unless asked.
- **C. Browser-side cleanup** (separate repo `arrrrny/zuraffa_browser`) — once this fix is released/bumped: remove feature 116's workaround (explicit `ScaffoldMessenger` wrap in its widget test + comment in `lib/src/markdown/ui/markdown_export_feedback.dart`) and close `arrrrny/zuraffa_browser#168`.
- **D. zfa#1709** — filed this session (`arrrrny/zuraffa`): `zfa tdd refactor`'s build pass (`zfa build`) hard-fails on this package's `build.yaml` (no zorphy builder, 0 `@Zorphy` entities) with no opt-out. NEXT: nothing until upstream reacts; if fixed, re-run `zfa tdd run` so the refactor phase can finish.
- **E. TDD re-binding (optional, meticulous)** — the CI import fix (`7948b29`) changed subject file hashes, so `verification.md`'s recorded `subject_hash` values are one revision older than the current files (behavior unchanged). NEXT if wanted: for each id, `zfa tdd verify-red <id> --feature shadapp-missing-scaffoldmessenger --re-certify --timeout 10` then `zfa tdd make <id> --feature shadapp-missing-scaffoldmessenger --born-green --timeout 10`; finish with `zfa tdd verify --feature shadapp-missing-scaffoldmessenger --runner flutter --timeout 40`.
- **F. `.zfa/` untracked** — decide whether to add `.zfa/` to `.gitignore` (receipts are machine-local).

## 4. Credentials & Access

- **No new credentials were created or used this session; nothing secret is stored here.** All GitHub operations ran through the user's pre-authenticated `gh` CLI (login `arrrrny`) and the SSH remote `git@github.com:arrrrny/zuraffa_ui.git`.
- **zfa**: `/Users/arrrrny/.local/bin/zfa` (v6.3.0). No token needed.
- **MANDATORY gh note**: `gh repo set-default --view` for this directory is **`nank1ro/flutter-shadcn-ui`** (the fork parent). Always pass `--repo arrrrny/zuraffa_ui` explicitly to `gh` commands here (see GOTCHA 1).
- User timezone UTC+3; machine is a loaded Intel Mac (see GOTCHA 12).

## 5. GOTCHAS — hard-won lessons (CRITICAL)

1. **`gh pr create` targets the fork parent.** Without `--repo`, it failed with `GraphQL: ... No commits between nank1ro:master and arrrrny:fix/...`. Cause: `gh repo set-default` for this dir = `nank1ro/flutter-shadcn-ui`. Fix: always `gh pr create --repo arrrrny/zuraffa_ui --base master ...` (and `--repo` on other gh commands).
2. **zfa profile format.** `verify-red`/`make` stopped: `no 'single' command template found ... Add a 'single:' key to the Keys (machine-readable) block or a '- Single test:' bullet`. Cause: `.specify/memory/tdd-profile.md` used the legacy spec-kit frontmatter shape, **unterminated** (no closing `---`) with unquoted multi-word commands (zfa #681, #726 — closed, needs the delimited/quoted form). Fix applied: quoted values, closing `---`, `single` added to `verified`, `mutation` key set now that the tool exists.
3. **Acceptance-lane `make` refuses guard-only tests** (`VACUOUS-GREEN`, zfa #1488/#1512). Sanctioned hand-delta recipe per behavior: keep the guard-red certification (verify-red ran on the generated guard test), then (a) write real assertions **outside the guard** in `test/tdd/<slug>/aN_test.dart`, (b) implement the scenario runner in `lib/tdd/<slug>/aN_subject.dart` (subjects may take a `WidgetTester`), (c) add the exact header `// zfa:tdd: AN:hand — hand step completed before first red certification (issue #1411)` to both files, (d) `zfa tdd make AN --feature <slug> --born-green --timeout 10` → `outcome=skipped`, green evidence appended.
4. **The widget lane cannot run inside `zuraffa_ui` itself** (zfa #938): `zfa tdd gen A2` refused with `pubspec.yaml does not declare zuraffa_ui — widget-lane behaviors boot a ZuraffaApp shell`. Fix: edit the scenario's `**Type**: widget` marker to `**Type**: acceptance` in `.specify/bugs/<slug>/spec.md`, re-run `zfa tdd plan <dir> --strict-routing`, then gen works (acceptance lane = testWidgets pair).
5. **`zfa tdd make`'s internal target-test deadline defaults to 2 min** and under load returns `make: ... outcome=runner-error` with `re-run with a larger --timeout`. Always pass `--timeout 10` (or more) to `make`/`verify-red`.
6. **`zfa tdd run` phase-2 refactor dead-ends** (zfa#1709): `zfa tdd refactor`'s fixed pass registry always runs `zfa build`, which refuses this repo's `build.yaml` (`build.yaml exists but does not register the zorphy builder`; 0 entities). Result: `result=runner-error stopped_at=A1:refactor` every resume. Workaround: `build.yaml` comment explains it; run `dart format` + `flutter analyze` by hand; behavior evidence is complete in `cycle-log.md`. **Do NOT delete `build.yaml`** (it configures `theme_extensions_builder` + the slang legacy builder).
7. **Mutation gate needs the tool installed**: `zfa tdd verify` → `gate: not_assessed` (`Could not find package mutation_test`) regardless of the profile's old `mutation: null`. Fix: `dart pub add dev:mutation_test` (1.8.1), then `zfa tdd verify --feature <slug> --runner flutter --timeout 40` → `gate: pass`, 8 killed / 0 survived, ~373s. Report at `.dart_tool/zfa/tdd-verify-report/mutation-test-report.md`.
8. **Subject drift after editing subjects** → `make` refuses `subject-drift`. Fix: `zfa tdd verify-red AN --feature <slug> --re-certify --timeout 10`, then `zfa tdd make AN ... --born-green` (#1162).
9. **`check-imports` CI rules** (`.github/workflows/check-imports.yaml`): bans `material.dart`/`cupertino.dart` under `lib/` except `EXCLUDED_FILES` (now: `lib/src/app.dart`, `lib/src/identified/app/zuraffa_app.dart`, `lib/tdd` — the last added this session, precedent `76a226e`), and bans `import.*zuraffa_ui/(shad|zuraffa_ui)\.dart` under `lib/` with **no exemptions** — internal code must use granular `package:zuraffa_ui/src/...` imports (that's how `lib/tdd/*_subject.dart` import `ZuraffaApp`, `ZfaButton`, `ZfaAuditBus`, `ShadToaster`, `ShadSonner` now). It is a `needs:` gate: when it fails, job `Flutter test` shows **skipped**, so a "skipped" test job usually means the import check failed, not a test problem. Reproduce locally by re-running the workflow's grep block verbatim (see §6).
10. **Local macOS baseline is red on 6 `ShadSheet` expandable goldens** (0.17–0.25% drift); `ubuntu-latest` CI passes all 375. Don't chase them; zfa tolerates them as pre-existing (#922).
11. **Stale `.git/index.lock`**: appeared mid-session (another tool created it at 01:27, no holder). Verify with `lsof .git/index.lock` (empty ⇒ stale), then `rm .git/index.lock` and retry. Never delete it without the lsof check.
12. **Machine load**: another agent session (`zcode` CLI, session `sess_8b2d15cf-0f1c-4a67-a50e-c2337875faa9`) was running heavy Flutter builds in a different repo (`zikzak_inappwebview`); flutter baselines ballooned from ~71s to ~10 min, and test runs to 30–60s+. Timeouts may be load, not bugs.
13. `zfa tdd status <dir>` shows `engine ❌ 0/3 ... 17 violations` — that reflects the unfinished phase-2 refactor (#1709), not broken behaviors; `run-state.json` has A1–A4 green.
14. `lib/tdd` subjects import `flutter_test` (dev dep) → `depend_on_referenced_packages`; they carry `// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names` on purpose. `.pubignore` keeps `lib/tdd` + `test/tdd` out of the published package (bot commit `64a94f0`).
15. **User rule**: never run the full test suite locally (old/slow machine). Run only the failing test file / targeted paths.

## 6. Tools & Conventions We Built

- **Bug workflow**: `/speckit-bug-fetch <issue-url>` → `.specify/bugs/<slug>/` (issue.md, assessment.md); `/skill:bug-whole slug=<slug>` chains `speckit-bug-fix` → `speckit-bug-test` → `speckit-bug-pr` (TDD mode is on by default; bug config absent ⇒ `tdd_enabled: true`). Artifacts added by the cycle: `spec.md`, `fix.md`, `test.md`, `pr.md`, `pr-body.md`, `tdd/`.
- **zfa commands used** (with `--feature shadapp-missing-scaffoldmessenger`): `zfa tdd plan <dir> [--strict-routing|--migrate-spec]` · `gen A2` · `verify-red <id> [--re-certify] --timeout 10` · `make <id> --born-green --timeout 10` · `run <dir>` · `verify --runner flutter --timeout 40` · `status <dir>` · `doctor <dir>`.
- **Local mirror of the CI import check** (run from repo root to reproduce `check-imports`): the exact block is in `.github/workflows/check-imports.yaml`; it greps `lib/` for `import.*material\.dart`, `import.*cupertino\.dart` (both filtered by `EXCLUDED_FILES` = `lib/src/app.dart`, `lib/src/identified/app/zuraffa_app.dart`, `lib/tdd`) and `import.*zuraffa_ui/(shad|zuraffa_ui)\.dart` (unfiltered), then exits 1 on any hit.
- **CI introspection**: `gh run list --repo arrrrny/zuraffa_ui --branch fix/shadapp-missing-scaffoldmessenger --limit 2 --json databaseId,status,url,headSha` · `gh run view <id> --repo arrrrny/zuraffa_ui --json jobs --jq '.jobs[] | "\(.name): \(.status) \(.conclusion // "-")"'` · full log: `gh run view --job <job-id> --repo arrrrny/zuraffa_ui --log > /tmp/ci_log.txt` (grep the tail; there is no `##[group]❌` marker in this workflow — read the log directly).
- **Commit message style** on this branch: conventional prefix + a body naming what/why/precedent (`fix(14): satisfy the import check in the TDD lane`, `Precedent: 76a226e`).

## 7. What To Do Next (ordered)

1. Check the CI run: `gh run view 35321511703 --repo arrrrny/zuraffa_ui --json jobs --jq '.jobs[] | "\(.name): \(.status) \(.conclusion // "-")"'` — expect `check-imports` ✅, `build-runner` ✅, and settle `Flutter test`.
2. If `Flutter test` failed: read that job's log (`gh run view --job <job-id> --repo arrrrny/zuraffa_ui --log`), identify the single real failure, apply the minimal fix (check for precedent with `git log -S`), verify by running **only** the failing test file, commit + push to `fix/shadapp-missing-scaffoldmessenger`.
3. If everything is green: report "PR #14 is green and ready to merge" to the user (do not merge unless asked).
4. After the user merges/releases: handle thread C (remove the `zuraffa_browser` feature-116 workaround, close `arrrrny/zuraffa_browser#168`) in that repo.
5. Optional/decisions: thread E (re-bind TDD hashes after the import-only change) and thread F (`.zfa/` gitignore) — ask the user which they want.

## 8. Open Questions / Decisions Pending

- Re-bind `verification.md` hashes after `7948b29`'s import-only subject edits? (Cheap-ish, ~10 min; behavior unchanged; not yet done.)
- Should the `zuraffa-review[bot]`'s `.pubignore` approach be mirrored for future TDD lanes (i.e. is the lane a permanent convention)? The bot's wording and the check exemption assume yes.
- zfa#1709: do we wait for upstream before relying on `zfa tdd run`'s `done` transition in this repo again?
- Status of the concurrent `zcode` session (other repo) — don't assume the machine is idle when timing tests.
