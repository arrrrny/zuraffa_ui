import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guards the fix for arrrrny/zuraffa_ui#71:
///
/// The fleet hard rule forbids `flutter clean` (and the `pub cache clean`
/// variants) on shared dev machines — the caches they destroy take 20–30
/// minutes to rebuild, and on app repos `flutter clean` also nukes
/// SPM-managed iOS dependencies. The workflow's literal `Clean` step
/// (`run: flutter clean`) must therefore be SKIPPED by the local gate with
/// the reason printed — mapped like the `apt-get` steps — never executed.
void main() {
  group('local_ci forbidden clean steps (#71)', () {
    Future<(int, String)> runLocalCi(
      Directory sandbox,
      String stepsYaml,
    ) async {
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
      // A run step needs the sandbox to exist as its working directory.
      File('${sandbox.path}/.gitignore').writeAsStringSync('');
      final script = File('scripts/local_ci.sh').absolute.path;
      final result = await Process.run(
        'bash',
        <String>[script, '--event', 'push'],
        workingDirectory: sandbox.path,
        environment: {
          ...Platform.environment,
          'LOCAL_CI_ROOT': sandbox.path,
        },
      );
      return (result.exitCode, '${result.stdout}${result.stderr}');
    }

    for (final cmd in <String>[
      'flutter clean',
      'dart pub cache clean',
      // The tolerated `sudo` prefix and trailing flags are still the
      // destructive act; a leading env assignment is skipped over exactly
      // like the shell would.
      'sudo flutter clean',
      'flutter clean --verbose',
      'CI=true flutter clean',
    ]) {
      test('an `run: $cmd` step is skipped, never executed', () async {
        final sandbox = await Directory.systemTemp.createTemp('issue71_ci_');
        addTearDown(() => sandbox.delete(recursive: true));
        final (code, output) = await runLocalCi(sandbox, '''
      - name: Clean
        run: $cmd
''');
        expect(output, contains('SKIP'), reason: output);
        expect(output, contains('forbidden locally'), reason: output);
        expect(output, contains('Clean'), reason: output);
      });
    }

    test('a `run: git clean -fdx` step is NOT skipped — the guard never widens',
        () async {
      final sandbox = await Directory.systemTemp.createTemp('issue71_ci_');
      addTearDown(() => sandbox.delete(recursive: true));
      final (code, output) = await runLocalCi(sandbox, '''
      - name: Clean
        run: git clean -fdx
''');
      // The negative control: the command carries the word `clean`, but its
      // command head is `git clean` — a regex widened to catch unrelated
      // clean words would SKIP this step and fail here loudly.
      expect(output, isNot(contains('forbidden locally')), reason: output);
      // The step EXECUTED: `git clean` fails in the sandbox (not a git
      // repository), and a failed run step is the one shape a skip can
      // never produce.
      expect(code, isNot(0), reason: output);
    });
  });
}
