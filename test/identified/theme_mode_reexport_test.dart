// Regression for arrrrny/zuraffa#2110.
//
// zuraffa_ui 7.6.0 adopted shadcn_ui 0.60.0's breaking
// `package:flutter/material.dart` -> standalone `material_ui` migration in a
// MINOR release, so `ZuraffaApp.themeMode` now takes material_ui's `ThemeMode`
// — a nominally distinct type from the Flutter SDK's `ThemeMode`. A consumer
// that imports the SDK's `ThemeMode` and passes it to the shell fails to
// compile:
//
//   The argument type 'ThemeMode/*1*/' can't be assigned to the parameter
//   type 'ThemeMode/*2*/?'.
//
// The fix (issue #2110, option 1): re-export `ThemeMode` from the package
// barrel so a consumer takes the family's type from the zuraffa_ui import and
// never holds two distinct `ThemeMode` symbols. This file names the enum ONLY
// through `package:zuraffa_ui/zuraffa_ui.dart` — importing material_ui or the
// SDK material here would resolve `ThemeMode` from that import instead and
// defeat the guard, so neither is imported.

import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/zuraffa_ui.dart';

void main() {
  group('the zuraffa_ui barrel exports its ThemeMode', () {
    test('a ThemeMode value is accepted from the barrel alone', () {
      // `ThemeMode` resolves only through the zuraffa_ui barrel above. If the
      // barrel does not re-export it this file fails to compile — the red
      // phase of this regression.
      const app = ZuraffaApp(themeMode: ThemeMode.dark);
      expect(app, isA<ZuraffaApp>());
      expect(app.themeMode, ThemeMode.dark);
    });

    test('the enum carries the three modes the shell switches on', () {
      // Containment, not an exact ordered list: the claim is that the barrel's
      // enum carries these modes, not that material_ui's upstream enum shape
      // is frozen — an upstream release must not turn this suite red.
      expect(
        ThemeMode.values,
        containsAll(<ThemeMode>[
          ThemeMode.system,
          ThemeMode.light,
          ThemeMode.dark,
        ]),
      );
    });
  });
}
