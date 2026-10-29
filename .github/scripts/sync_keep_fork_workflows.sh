#!/usr/bin/env bash
#
# Keep the fork's own `.github/workflows/**` when the sync job holds no
# `workflows`-capable credential.
#
# A GitHub App job token (`github.token`) is not allowed to create or update
# workflow files, and the restriction is evaluated on every commit in the
# pushed range — so a clean upstream merge that bumps an action version inside
# `.github/workflows/**` can never be pushed by the default token:
#
#   ! [remote rejected] master -> master (refusing to allow a GitHub App to
#     create or update workflow `.github/workflows/auto-add-app.yml` without
#     `workflows` permission)
#
# That is issue #54: the sync only succeeds on days when upstream happens to
# touch no workflow file. With `SYNC_PAT` set the job pushes upstream's CI
# files as-is and this script is a no-op. Without it, the merge keeps the
# fork's own workflow files (this fork pins every action by SHA and its
# dependabot manages those bumps), so the rest of the upstream work still
# lands instead of the whole sync failing.
#
# Invariants this script maintains (all covered by the node test beside it):
#   - HEAD stays a merge commit with both parents (history stays a sync merge).
#   - `git diff BASE_SHA..HEAD -- .github/workflows` is empty, so no pushed
#     commit carries a workflow change.
#   - Everything outside `.github/workflows/**` keeps upstream's content.
#
# The amend is required, not cosmetic: leaving the fork's files as a follow-up
# commit would still push the merge commit that contains upstream's workflow
# edits, and GitHub rejects the push on that commit alone.

set -euo pipefail

BASE_SHA="${BASE_SHA:-}"
if [ -z "$BASE_SHA" ]; then
  echo "::error::BASE_SHA (the pre-merge master sha) is required" >&2
  exit 1
fi

if [ "$(git rev-parse --is-shallow-repository)" = "true" ]; then
  echo "::error::a shallow clone cannot diff against BASE_SHA ($BASE_SHA)" >&2
  exit 1
fi

emit_output() {
  if [ -n "${GITHUB_OUTPUT:-}" ]; then
    printf '%s\n' "$1" >> "$GITHUB_OUTPUT"
  fi
}

# A workflows-capable credential is present: upstream's CI files are pushable,
# so there is nothing to work around.
if [ -n "${SYNC_PAT:-}" ]; then
  echo "SYNC_PAT is set — keeping upstream's workflow files"
  emit_output "excluded=false"
  exit 0
fi

CHANGED="$(git diff --name-only "$BASE_SHA" HEAD -- .github/workflows || true)"
if [ -z "$CHANGED" ]; then
  echo "The merge touches no .github/workflows path — nothing to exclude"
  emit_output "excluded=false"
  exit 0
fi

echo "The merge changes workflow files the job token cannot push:"
printf '%s\n' "$CHANGED" | while IFS= read -r path; do
  [ -n "$path" ] && echo "  - $path"
done

# Modified/deleted/renamed paths go back to the pre-merge (fork) content.
if git ls-tree -r --name-only "$BASE_SHA" -- .github/workflows | grep -q .; then
  git checkout "$BASE_SHA" -- .github/workflows
else
  # The fork had no workflows at BASE (never true here, but stay total).
  git rm -r -q -f -- .github/workflows
fi

# Paths upstream introduced do not exist at BASE, so checkout leaves them: the
# sync must not add a workflow file either.
ADDED="$(git diff --name-only --diff-filter=A "$BASE_SHA" -- .github/workflows || true)"
if [ -n "$ADDED" ]; then
  printf '%s\n' "$ADDED" | while IFS= read -r path; do
    [ -n "$path" ] && git rm -q -f -- "$path"
  done
fi

REMAINING="$(git diff --name-only "$BASE_SHA" -- .github/workflows || true)"
if [ -n "$REMAINING" ]; then
  echo "::error::could not restore the fork's workflow files:" >&2
  printf '%s\n' "$REMAINING" >&2
  exit 1
fi

git commit -q --amend --no-edit

if [ -n "${GITHUB_STEP_SUMMARY:-}" ]; then
  {
    echo "### Sync kept the fork's own workflow files"
    echo
    echo '`SYNC_PAT` is not set, so the job token cannot push `.github/workflows/**`.'
    echo 'Upstream changed the files below; the fork keeps its own copies (it pins'
    echo 'every action by SHA and its dependabot manages those bumps). Everything'
    echo 'else from upstream landed unchanged.'
    echo
    printf '%s\n' "$CHANGED" | while IFS= read -r path; do
      [ -n "$path" ] && echo "- \`$path\`"
    done
    echo
    echo 'Set the `SYNC_PAT` secret (a token with the `workflow` scope) to let the'
    echo 'sync apply upstream'"'"'s workflow edits again.'
  } >> "$GITHUB_STEP_SUMMARY"
fi

echo "::notice::kept the fork's workflow files (no SYNC_PAT); upstream CI edits skipped"
emit_output "excluded=true"
{
  emit_output "skipped<<EOF"
  emit_output "$CHANGED"
  emit_output "EOF"
}
