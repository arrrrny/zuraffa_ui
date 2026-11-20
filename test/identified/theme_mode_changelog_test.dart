import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

// Issue #78 asked for the breaking change to be documented: `ShadApp.themeMode`
// (and `ZuraffaApp.themeMode`) takes material_ui's `ThemeMode`, a different
// type from the framework's same-named enum. The changelog is the only place
// that mapping is stated for a consumer, so it is asserted rather than left to
// memory.

void main() {
  test(
    'the changelog documents the themeMode type move in the 7.6.0 section',
    () {
      final changelog = File('CHANGELOG.md').readAsStringSync();
      final section = RegExp(
        r'^## 7\.6\.0[^\n]*\n(?<body>.*?)(?=^## |\z)',
        multiLine: true,
        dotAll: true,
      ).firstMatch(changelog);

      expect(
        section,
        isNotNull,
        reason: 'CHANGELOG.md must have a 7.6.0 section',
      );
      final body = section!.namedGroup('body')!;

      expect(
        body,
        contains('ThemeMode'),
        reason: 'the 7.6.0 section must name the type that moved',
      );
      expect(
        body,
        contains('material_ui'),
        reason: 'the 7.6.0 section must name the package the type comes from',
      );
    },
  );
}
