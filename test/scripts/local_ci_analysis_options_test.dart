import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guards the fix for arrrrny/zuraffa_ui#38:
///
/// `flutter analyze` (the workflow's `Install and analyze` step) upgrades an
/// `analysis_options.yaml` that lacks the build/platform excludes, printing
/// `Upgrading analysis_options.yaml to exclude build and platform
/// directories.` On a fresh CI checkout there is no `build/` directory, so
/// the auto-upgrade never fires there; locally it rewrites e.g.
/// `playground/analysis_options.yaml` in the operator's working tree — the
/// same local-gate-vs-CI mutation class #34 fixed for `pubspec.lock`, one
/// filename wider. The run's snapshot/restore must cover this file too.
void main() {
  group('local_ci analysis_options.yaml protection (#38)', () {
    /// A one-job workflow whose step overwrites an `analysis_options.yaml` —
    /// the same shape `flutter-test.yaml` runs, with `printf` standing in for
    /// `flutter analyze`'s auto-upgrade.
    Future<Directory> sandboxWithWorkflow(String stepsYaml) async {
      final sandbox = await Directory.systemTemp.createTemp('issue38_ci_');
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
      // selects it for `push` — `--workflow` is avoided on purpose (it
      // currently crashes with UnboundLocalError, arrrrny/zuraffa_ui#37).
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

    test(
      'a mutated analysis_options.yaml is restored when the run ends',
      () async {
        final sandbox = await sandboxWithWorkflow(r'''
      - name: Install and analyze
        run: |
          printf 'analyzer:\n  exclude:\n    - build/**\n    - web/**\n' > analysis_options.yaml
''');
        File(
          '${sandbox.path}/analysis_options.yaml',
        ).writeAsStringSync(
          'analyzer:\n  errors:\n    deprecated_member_use: ignore\n',
        );

        final (code, output) = await runLocalCi(sandbox);

        expect(code, 0, reason: output);
        expect(
          File('${sandbox.path}/analysis_options.yaml').readAsStringSync(),
          'analyzer:\n  errors:\n    deprecated_member_use: ignore\n',
          reason:
              'local_ci must restore analysis_options.yaml after the run — the '
              'file flutter analyze auto-upgraded to add build/ excludes '
              'otherwise poisons the working tree (#38, the #34 class)',
        );
      },
    );

    test('a nested playground/analysis_options.yaml a step mutated is '
        'restored when the run ends', () async {
      final sandbox = await sandboxWithWorkflow(r'''
      - name: Install and analyze
        run: |
          printf 'analyzer:\n  exclude:\n    - build/**\n    - web/**\n' > playground/analysis_options.yaml
''');
      Directory('${sandbox.path}/playground').createSync();
      File(
        '${sandbox.path}/playground/analysis_options.yaml',
      ).writeAsStringSync(
        'analyzer:\n  errors:\n    deprecated_member_use: ignore\n',
      );

      final (code, output) = await runLocalCi(sandbox);

      expect(code, 0, reason: output);
      expect(
        File(
          '${sandbox.path}/playground/analysis_options.yaml',
        ).readAsStringSync(),
        'analyzer:\n  errors:\n    deprecated_member_use: ignore\n',
        reason:
            'the #38 repro is playground/analysis_options.yaml rewritten under '
            'the operator — the snapshot/restore must reach nested '
            'analysis_options.yaml files, not just the root one',
      );
    });

    test(
      'an analysis_options.yaml a step created is gone after the run',
      () async {
        final sandbox = await sandboxWithWorkflow(r'''
      - name: Install and analyze
        run: |
          printf 'analyzer:\n  exclude:\n    - build/**\n' > analysis_options.yaml
''');

        final (code, output) = await runLocalCi(sandbox);

        expect(code, 0, reason: output);
        expect(
          File('${sandbox.path}/analysis_options.yaml').existsSync(),
          isFalse,
          reason:
              'no analysis_options.yaml existed before the run — one a step '
              'created must not survive it either',
        );
      },
    );
  });
}
