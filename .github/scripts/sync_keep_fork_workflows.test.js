'use strict';

// Tests for `.github/scripts/sync_keep_fork_workflows.sh` — the guard that
// keeps the fork's own `.github/workflows/**` when the sync job holds no
// `workflows`-capable credential (issue #54: the daily sync died on
// "refusing to allow a GitHub App to create or update workflow").
//
// Run with: node --test .github/scripts

const test = require('node:test');
const assert = require('node:assert');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { execFileSync, spawnSync } = require('node:child_process');

const SCRIPT = path.join(__dirname, 'sync_keep_fork_workflows.sh');

function git(cwd, args) {
  return execFileSync('git', args, { cwd, encoding: 'utf8' }).trim();
}

function write(cwd, file, contents) {
  const full = path.join(cwd, file);
  fs.mkdirSync(path.dirname(full), { recursive: true });
  fs.writeFileSync(full, contents);
}

// Builds a throwaway repo shaped like the sync job's working tree:
//   base (fork's master)  <- merge commit -> HEAD
//                          ^ upstream/main
// `workflowEdits` lists what upstream changed under .github/workflows.
function makeRepo(t, { workflowEdits = {}, otherEdits = {} } = {}) {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'sync-fork-workflows-'));
  t.after(() => fs.rmSync(dir, { recursive: true, force: true }));

  git(dir, ['init', '-q', '-b', 'master']);
  git(dir, ['config', 'user.name', 'Test']);
  git(dir, ['config', 'user.email', 'test@example.com']);
  git(dir, ['config', 'commit.gpgsign', 'false']);

  write(dir, '.github/workflows/check-imports.yaml', 'name: fork gate\n');
  write(dir, '.github/workflows/publish.yaml', 'name: fork publish\n');
  write(dir, 'README.md', 'fork readme\n');
  git(dir, ['add', '-A']);
  git(dir, ['commit', '-q', '-m', 'base']);
  const base = git(dir, ['rev-parse', 'HEAD']);

  // The fork keeps diverging (changelog, brand map) — this is what makes the
  // upstream merge a merge commit instead of a fast-forward.
  git(dir, ['checkout', '-q', '-b', 'upstream']);
  for (const [file, contents] of Object.entries(workflowEdits)) {
    if (contents === null) {
      fs.rmSync(path.join(dir, file));
    } else {
      write(dir, file, contents);
    }
  }
  for (const [file, contents] of Object.entries(otherEdits)) {
    write(dir, file, contents);
  }
  git(dir, ['add', '-A']);
  git(dir, ['commit', '-q', '-m', 'upstream work']);

  git(dir, ['checkout', '-q', 'master']);
  write(dir, 'CHANGELOG.md', 'fork-only changelog\n');
  git(dir, ['add', '-A']);
  git(dir, ['commit', '-q', '-m', 'fork commit']);

  git(dir, ['merge', '--no-ff', '--no-edit', '-q', 'upstream']);
  return { dir, base };
}

function runScript(dir, base, env = {}) {
  const outputPath = path.join(dir, '.github-output');
  const summaryPath = path.join(dir, '.github-summary');
  fs.writeFileSync(outputPath, '');
  fs.writeFileSync(summaryPath, '');
  const result = spawnSync('bash', [SCRIPT], {
    cwd: dir,
    encoding: 'utf8',
    env: {
      ...process.env,
      BASE_SHA: base,
      GITHUB_OUTPUT: outputPath,
      GITHUB_STEP_SUMMARY: summaryPath,
      SYNC_PAT: '',
      ...env,
    },
  });
  return {
    status: result.status,
    stdout: result.stdout,
    stderr: result.stderr,
    output: fs.readFileSync(outputPath, 'utf8'),
    summary: fs.readFileSync(summaryPath, 'utf8'),
  };
}

test('without SYNC_PAT the merge keeps the fork workflows and drops upstream workflow edits', (t) => {
  const { dir, base } = makeRepo(t, {
    workflowEdits: {
      '.github/workflows/check-imports.yaml': 'name: upstream gate\n',
      '.github/workflows/upstream-only.yaml': 'name: upstream only\n',
    },
    otherEdits: { 'README.md': 'upstream readme\n' },
  });

  const run = runScript(dir, base);

  assert.strictEqual(run.status, 0, run.stderr);
  // The pushed range carries no workflow change at all: this is the whole
  // point — a token without `workflows` permission can push it.
  assert.strictEqual(
    git(dir, ['diff', '--name-only', base, 'HEAD', '--', '.github/workflows']),
    '',
  );
  // Fork content survives, upstream's non-workflow work still lands.
  assert.strictEqual(
    git(dir, ['show', 'HEAD:.github/workflows/check-imports.yaml']),
    'name: fork gate',
  );
  assert.strictEqual(git(dir, ['show', 'HEAD:README.md']), 'upstream readme');
  assert.strictEqual(git(dir, ['show', 'HEAD:CHANGELOG.md']), 'fork-only changelog');
  // Upstream's new workflow is not introduced either.
  assert.strictEqual(git(dir, ['ls-tree', '--name-only', 'HEAD', '.github/workflows/']),
    '.github/workflows/check-imports.yaml\n.github/workflows/publish.yaml');
  // Still one merge commit with both parents (history stays a sync merge).
  assert.strictEqual(git(dir, ['rev-list', '--parents', '-n', '1', 'HEAD']).split(' ').length, 3);

  assert.match(run.output, /excluded=true/);
  assert.match(run.output, /\.github\/workflows\/check-imports\.yaml/);
  assert.match(run.output, /\.github\/workflows\/upstream-only\.yaml/);
  assert.match(run.summary, /check-imports\.yaml/);
});

test('with SYNC_PAT the guard is a no-op and upstream workflow edits land', (t) => {
  const { dir, base } = makeRepo(t, {
    workflowEdits: { '.github/workflows/check-imports.yaml': 'name: upstream gate\n' },
    otherEdits: { 'README.md': 'upstream readme\n' },
  });

  const run = runScript(dir, base, { SYNC_PAT: 'ghp_example' });

  assert.strictEqual(run.status, 0, run.stderr);
  assert.strictEqual(
    git(dir, ['show', 'HEAD:.github/workflows/check-imports.yaml']),
    'name: upstream gate',
  );
  assert.match(run.output, /excluded=false/);
});

test('a merge that touches no workflow file is left untouched', (t) => {
  const { dir, base } = makeRepo(t, { otherEdits: { 'README.md': 'upstream readme\n' } });
  const before = git(dir, ['rev-parse', 'HEAD']);

  const run = runScript(dir, base);

  assert.strictEqual(run.status, 0, run.stderr);
  assert.strictEqual(git(dir, ['rev-parse', 'HEAD']), before);
  assert.match(run.output, /excluded=false/);
});

test('a deleted upstream workflow is restored from the fork', (t) => {
  const { dir, base } = makeRepo(t, {
    workflowEdits: { '.github/workflows/publish.yaml': null },
    otherEdits: { 'README.md': 'upstream readme\n' },
  });

  const run = runScript(dir, base);

  assert.strictEqual(run.status, 0, run.stderr);
  assert.strictEqual(
    git(dir, ['show', 'HEAD:.github/workflows/publish.yaml']),
    'name: fork publish',
  );
  assert.strictEqual(
    git(dir, ['diff', '--name-only', base, 'HEAD', '--', '.github/workflows']),
    '',
  );
});
