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
      // Slice the section instead of matching to end-of-input: Dart's RegExp is
      // ECMAScript-flavoured, where `\z` is a literal `z`, not an anchor — so a
      // `(?=^## |\z)` terminator never matched and the 7.6.0 section only
      // resolved because another `## ` heading happened to follow it.
      final start = RegExp(
        r'^## 7\.6\.0[^\n]*$',
        multiLine: true,
      ).firstMatch(changelog);

      expect(
        start,
        isNotNull,
        reason: 'CHANGELOG.md must have a 7.6.0 section',
      );
      final rest = changelog.substring(start!.end);
      final next = RegExp('^## ', multiLine: true).firstMatch(rest);
      final body = next == null ? rest : rest.substring(0, next.start);

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
