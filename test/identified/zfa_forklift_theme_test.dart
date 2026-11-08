import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/zuraffa_ui.dart';

// Skin-lane Forklift theme tests: skins build the theme through
// ZfaForkliftTheme and read brand tokens through ZfaForkliftPalette,
// never a Shad name.

void main() {
  group('ZfaForkliftTheme', () {
    test('dark() is a dark ZfaThemeData on the icon background', () {
      final theme = ZfaForkliftTheme.dark();
      expect(theme.brightness, Brightness.dark);
      expect(theme.colorScheme.background, const Color(0xFF27272B));
      expect(theme.colorScheme.primary, ZfaForkliftPalette.orange);
      expect(theme.colorScheme.secondary, ZfaForkliftPalette.purple);
      expect(theme.colorScheme.accent, ZfaForkliftPalette.tan);
    });

    test('light() is a light ZfaThemeData', () {
      final theme = ZfaForkliftTheme.light();
      expect(theme.brightness, Brightness.light);
      expect(theme.colorScheme.foreground, const Color(0xFF27272B));
    });

    test('ZfaForkliftPalette exposes the icon brand tokens', () {
      expect(ZfaForkliftPalette.background, const Color(0xFF27272B));
      expect(ZfaForkliftPalette.purple, const Color(0xFF7662BD));
      expect(ZfaForkliftPalette.orange, const Color(0xFFFFA538));
      expect(ZfaForkliftPalette.tan, const Color(0xFFDEA861));
    });

    testWidgets('ZfaForkliftTheme.dark() mounts through ZuraffaApp', (
      tester,
    ) async {
      Color? resolvedBackground;
      await tester.pumpWidget(
        ZuraffaApp(
          theme: ZfaForkliftTheme.dark(),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                resolvedBackground = ZfaTheme.of(context).colorScheme.background;
                return const Text('forklift probe');
              },
            ),
          ),
        ),
      );
      expect(find.text('forklift probe'), findsOneWidget);
      expect(resolvedBackground, const Color(0xFF27272B));
    });
  });
}
