import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guards the two fixes for arrrrny/zuraffa_ui#34:
///
/// 1. `scripts/local_ci.sh` must not let a workflow step's `pubspec.lock`
///    mutation survive the run. CI throws its throwaway checkout away; here
///    the mutation lands in the operator's working tree, and because
///    `pubspec.lock` is gitignored it cannot be restored with git — the next
///    `flutter test` then fails to load every file that imports
///    `package:platform`.
/// 2. `flutter pub downgrade` (the workflow's min-deps check) must never
///    resolve `platform` to 3.0.0 — that release references
///    `io.Platform.packageRoot`, removed from the Dart SDK, so nothing whose
///    import graph reaches `package:platform` compiles.
void main() {
  group('local_ci pubspec.lock protection (#34)', () {
    /// A one-job workflow whose `Downgrade dependencies` step overwrites the
    /// lockfile — the same shape `flutter-test.yaml` runs, with `printf`
    /// standing in for `flutter pub downgrade`.
    Future<Directory> sandboxWithWorkflow(String stepsYaml) async {
      final sandbox = await Directory.systemTemp.createTemp('issue34_ci_');
      addTearDown(() => sandbox.delete(recursive: true));
      Directory(
        '${sandbox.path}/.github/workflows',
      ).createSync(recursive: true);
      File('${sandbox.path}/.github/workflows/poison.yaml').writeAsStringSync(
        '''
name: Poison
on: push
jobs:
  poison:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
$stepsYaml''',
      );
      return sandbox;
    }

    Future<(int, String)> runLocalCi(Directory sandbox) async {
      // The sandbox holds exactly one workflow, so the script's auto-pick
      // selects it for `push` — `--workflow` is avoided on purpose: it
      // currently crashes with UnboundLocalError (arrrrny/zuraffa_ui#37).
      final script = File('scripts/local_ci.sh').absolute.path;
      final result = await Process.run(
        'bash',
        <String>[
          script,
          '--event',
          'push',
        ],
        workingDirectory: sandbox.path,
        environment: {
          ...Platform.environment,
          'LOCAL_CI_ROOT': sandbox.path,
        },
      );
      return (result.exitCode, '${result.stdout}${result.stderr}');
    }

    test('a lockfile a step mutated is restored when the run ends', () async {
      final sandbox = await sandboxWithWorkflow(r'''
      - name: Downgrade dependencies
        run: |
          printf 'min-resolution\n' > pubspec.lock
''');
      File('${sandbox.path}/pubspec.lock').writeAsStringSync('original\n');

      final (code, output) = await runLocalCi(sandbox);

      expect(code, 0, reason: output);
      expect(
        File('${sandbox.path}/pubspec.lock').readAsStringSync(),
        'original\n',
        reason:
            'local_ci must restore pubspec.lock after the run — the '
            'gitignored lockfile a downgrade step mutated otherwise poisons '
            'the next flutter test (#34)',
      );
    });

    test('a lockfile a step created is gone after the run', () async {
      final sandbox = await sandboxWithWorkflow(r'''
      - name: Downgrade dependencies
        run: |
          printf 'min-resolution\n' > pubspec.lock
''');

      final (code, output) = await runLocalCi(sandbox);

      expect(code, 0, reason: output);
      expect(
        File('${sandbox.path}/pubspec.lock').existsSync(),
        isFalse,
        reason:
            'no pubspec.lock existed before the run — one a step created '
            'must not survive it either',
      );
    });

    test('later steps see the mutated lockfile mid-run, as in CI', () async {
      final sandbox = await sandboxWithWorkflow(r'''
      - name: Downgrade dependencies
        run: |
          printf 'min-resolution\n' > pubspec.lock
      - name: Use the downgraded lock
        run: |
          grep -q 'min-resolution' pubspec.lock
''');

      final (code, output) = await runLocalCi(sandbox);

      expect(code, 0, reason: output);
    });
  });

  group('pub downgrade floor (#34)', () {
    String? lockedPlatformVersion(String lock) {
      final match = RegExp(r'^  platform:$', multiLine: true).firstMatch(lock);
      if (match == null) {
        return null;
      }
      final next = RegExp(
        '^  [^ ]',
        multiLine: true,
      ).allMatches(lock, match.end).toList();
      final body = lock.substring(
        match.end,
        next.isEmpty ? lock.length : next.first.start,
      );
      return RegExp('version: "([^"]+)"').firstMatch(body)?.group(1);
    }

    test('flutter pub downgrade cannot resolve platform below 3.2.0', () async {
      final sandbox = await Directory.systemTemp.createTemp('issue34_floor_');
      addTearDown(() => sandbox.delete(recursive: true));
      await File('pubspec.yaml').copy('${sandbox.path}/pubspec.yaml');

      final result = await Process.run(
        'flutter',
        ['pub', 'downgrade'],
        workingDirectory: sandbox.path,
        environment: {...Platform.environment},
      );
      final output = '${result.stdout}${result.stderr}';
      expect(result.exitCode, 0, reason: output);

      final lock = File('${sandbox.path}/pubspec.lock').readAsStringSync();
      final version = lockedPlatformVersion(lock);
      expect(version, isNotNull, reason: 'platform missing from lock\n$output');
      final parts = version!
          .split('.')
          .map((s) => int.tryParse(s) ?? 0)
          .toList();
      final compilesOnCurrentSdk =
          parts[0] > 3 ||
          (parts[0] == 3 && (parts.length < 2 || parts[1] >= 2));
      expect(
        compilesOnCurrentSdk,
        isTrue,
        reason:
            'pub downgrade locked platform $version — versions below 3.2.0 '
            'reference io.Platform.packageRoot, removed from the Dart SDK, so '
            'the min-deps resolution must exclude them via a '
            'dependency_overrides floor (#34)',
      );
    }, timeout: const Timeout(Duration(minutes: 5)));
  });
}
