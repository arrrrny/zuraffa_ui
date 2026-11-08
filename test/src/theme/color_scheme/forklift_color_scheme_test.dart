import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/src/theme/color_scheme/base.dart';
import 'package:zuraffa_ui/src/theme/color_scheme/forklift.dart';

void main() {
  group('ShadForkliftColorScheme', () {
    test('dark background is the app icon background #27272B', () {
      const scheme = ShadForkliftColorScheme.dark();
      expect(scheme.background, const Color(0xFF27272B));
      expect(scheme.background, ShadForkliftPalette.background);
    });

    test('dark primary is the brand orange', () {
      const scheme = ShadForkliftColorScheme.dark();
      expect(scheme.primary, ShadForkliftPalette.orange);
      expect(scheme.primaryForeground, ShadForkliftPalette.background);
    });

    test('dark secondary is the brand purple', () {
      const scheme = ShadForkliftColorScheme.dark();
      expect(scheme.secondary, ShadForkliftPalette.purple);
      expect(scheme.selection, ShadForkliftPalette.purpleDeep);
    });

    test('light foreground is the app icon background', () {
      const scheme = ShadForkliftColorScheme.light();
      expect(scheme.foreground, const Color(0xFF27272B));
    });

    test('both variants expose the brand tokens in custom', () {
      const light = ShadForkliftColorScheme.light();
      const dark = ShadForkliftColorScheme.dark();
      for (final scheme in [light, dark]) {
        expect(scheme.custom['brandOrange'], ShadForkliftPalette.orange);
        expect(scheme.custom['brandPurple'], ShadForkliftPalette.purple);
        expect(scheme.custom['brandTan'], ShadForkliftPalette.tan);
      }
    });

    test('fromName resolves forklift for both brightnesses', () {
      expect(
        ShadColorScheme.fromName('forklift', brightness: Brightness.light),
        isA<ShadForkliftColorScheme>(),
      );
      expect(
        ShadColorScheme.fromName('forklift', brightness: Brightness.dark),
        isA<ShadForkliftColorScheme>(),
      );
      expect(
        ShadColorScheme.fromName('forklift', brightness: Brightness.dark)
            .background,
        const Color(0xFF27272B),
      );
    });
  });
}
