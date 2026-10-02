import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

// Zorphy's written `$$X` abstracts are codegen-only seams: zorphy generates
// the sealed `X` from them, so the sealed type is the public surface and the
// only thing that needs a `Zfa*` alias. Aliasing the written abstract instead
// emits a `$$Zfa*` name — a shape the brand-map gate rejects — which made the
// generator and its gate mutually unsatisfiable (issue #24).
//
// The real engine on master declares no `$$X` seam (the UINode layer that
// declares `$$ShadNode` ships separately), so this test runs the actual
// generator script against a minimal fixture engine to pin the agreement.
void main() {
  test(r'generate_zfa_aliases skips zorphy $$ written abstracts', () {
    final fixture = Directory.systemTemp.createTempSync('issue-24-seam-');
    addTearDown(() => fixture.deleteSync(recursive: true));
    Directory('${fixture.path}/lib/src').createSync(recursive: true);
    File(
      '${fixture.path}/lib/zfa.dart',
    ).writeAsStringSync('''
export 'src/engine.dart';
''');
    File(
      '${fixture.path}/lib/src/engine.dart',
    ).writeAsStringSync(r'''
// The zorphy written abstract — a codegen-only seam, never public surface.
abstract class $$ShadNode {}

// The sealed union zorphy generates from it — the public type.
sealed class ShadNode {}
''');

    final result = Process.runSync('dart', [
      '${Directory.current.path}/scripts/generate_zfa_aliases.dart',
    ], workingDirectory: fixture.path);
    expect(
      result.exitCode,
      0,
      reason: 'generator failed on the fixture: ${result.stderr}',
    );

    final mapping = File(
      '${fixture.path}/lib/src/identified/mapping/'
      'zfa_engine_aliases.dart',
    ).readAsStringSync();
    final emitted = mapping
        .split('\n')
        .where((line) => line.contains(r'$$'))
        .join('; ');
    expect(
      emitted,
      isEmpty,
      reason:
          r'the written `$$X` abstract is a codegen seam — the map must '
          r'alias the generated sealed `X` only, never emit a `$$Zfa*` '
          'shape (issue #24). Got: $emitted',
    );
    expect(mapping, contains('typedef ZfaNode = ShadNode;'));
  });
}
