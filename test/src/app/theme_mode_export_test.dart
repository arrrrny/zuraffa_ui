import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/zfa.dart';

// Issue #78: the engine takes `material_ui`'s own `ThemeMode` (material_ui
// re-declares the enum instead of re-exporting the framework one), so an app
// that imports the engine barrel can name the type it must pass with no direct
// material_ui dependency.
//
// The framework enum is deliberately NOT imported here: importing both would
// reintroduce the ambiguity the issue reports, and the point is that the
// barrel alone is enough. Importing material_ui directly would defeat the same
// purpose, so this file names the enum only through `zfa.dart`.

void main() {
  group('the engine exports its ThemeMode', () {
    test('a ThemeMode value is accepted from the barrel alone', () {
      const mode = ThemeMode.dark;
      expect(const ShadApp(themeMode: mode), isA<ShadApp>());
      expect(const ZuraffaApp(themeMode: mode), isA<ZuraffaApp>());
    });

    test('the enum carries the three modes the engine switches on', () {
      expect(
        ThemeMode.values,
        const [ThemeMode.system, ThemeMode.light, ThemeMode.dark],
      );
    });
  });
}
