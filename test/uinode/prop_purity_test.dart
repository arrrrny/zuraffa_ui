import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/uinode.dart';

// U20 / FR-16: no node prop accepts a raw color, and the parser rejects
// color-shaped style values with UiParseErrorKind.colorRejected.

void main() {
  test('node entities carry no Color-typed props (source gate)', () {
    // The generated node sources are the authority on the prop surface:
    // scan them for color types. The renderer is allowed to resolve theme
    // colors; nodes/ and tree/ are not.
    final dirs = [
      'lib/src/uinode/nodes',
      'lib/src/uinode/tree',
    ];
    final offenders = <String>[];
    for (final dir in dirs) {
      for (final file in Directory(dir).listSync(recursive: true)) {
        if (file is! File || !file.path.endsWith('.dart')) continue;
        final source = file.readAsStringSync();
        if (RegExp(r'\b(Color|ColorSwatch)\b').hasMatch(source)) {
          offenders.add(file.path);
        }
      }
    }
    expect(offenders, isEmpty,
        reason: 'node/tree layers must stay color-free (FR-16)');
  });

  test('parser rejects hex colors in token props', () {
    expect(
      () => ShadNodeParser().parse(const {
        'root': {
          'widgetType': 'text',
          'text': 'hi',
          'style': '#FF0000',
        },
      }),
      throwsA(
        isA<UiParseError>().having(
          (e) => e.kind,
          'kind',
          UiParseErrorKind.colorRejected,
        ),
      ),
    );
  });

  test('parser rejects rgb() and 0x colors in token props', () {
    for (final raw in ['rgb(255, 0, 0)', '0xFFFF0000']) {
      expect(
        () => ShadNodeParser().parse({
          'root': {
            'widgetType': 'icon',
            'name': 'plus',
            'style': raw,
          },
        }),
        throwsA(isA<UiParseError>()),
        reason: '$raw must be rejected',
      );
    }
  });
}
