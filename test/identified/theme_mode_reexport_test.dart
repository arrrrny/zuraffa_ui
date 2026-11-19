// Regression for arrrrny/zuraffa#2110.
//
// zuraffa_ui 7.6.0 adopted shadcn_ui 0.60.0's breaking
// `package:flutter/material.dart` -> standalone `material_ui` migration in a
// MINOR release, so `ShadApp.themeMode` / `ZuraffaApp.themeMode` now take
// material_ui's `ThemeMode` — a nominally distinct type from the Flutter SDK's
// `ThemeMode`. A consumer that imports `package:flutter/material.dart` for
// `ThemeMode` and passes it to the shell fails to compile:
//
//   The argument type 'ThemeMode/*1*/' can't be assigned to the parameter
//   type 'ThemeMode/*2*/?'.
//
// The fix (issue #2110, option 1): re-export `ThemeMode` from the package
// barrel so a consumer takes the family's type from the zuraffa_ui import and
// never holds two distinct `ThemeMode` symbols. This test proves the barrel
// exports a `ThemeMode` that `ZuraffaApp` accepts.

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' show Scaffold;
import 'package:zuraffa_ui/zuraffa_ui.dart';

void main() {
  test('the barrel exports ThemeMode and ZuraffaApp accepts it', () {
    // `ThemeMode` resolves through the zuraffa_ui barrel here (no SDK
    // material import). If the barrel does not re-export it this file fails
    // to compile — the red phase of this regression.
    const app = ZuraffaApp(themeMode: ThemeMode.dark, home: Scaffold());
    expect(app.themeMode, ThemeMode.dark);
  });

  test('the barrel ThemeMode round-trips through ZuraffaApp', () {
    const app = ZuraffaApp(themeMode: ThemeMode.light, home: Scaffold());
    expect(app.themeMode, ThemeMode.light);
    expect(ThemeMode.system, isNotNull);
  });
}
