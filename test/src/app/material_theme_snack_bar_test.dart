import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:zuraffa_ui/zuraffa_ui.dart';

// materialTheme() snack bar derivation (spec 1101, FR-016..018):
// the ThemeData the shell hands Material-layer widgets must style snack bars
// from the shell's own colour scheme, follow light/dark switching, and lose to
// a consumer's materialThemeBuilder override.
//
// The ThemeData under test is the one built inside ShadApp's materialTheme();
// it is observable through the Material context of a running shell.

void main() {
  ThemeData themeOf(WidgetTester tester) {
    final context = tester.element(find.byType(Scaffold).first);
    return Theme.of(context);
  }

  Color snackBarBackground(WidgetTester tester) =>
      themeOf(tester).snackBarTheme.backgroundColor!;

  Color snackBarText(WidgetTester tester) =>
      themeOf(tester).snackBarTheme.contentTextStyle!.color!;

  testWidgets('snack bar uses the shell colours in light mode', (tester) async {
    late Color expectedBackground;
    late Color expectedText;

    await tester.pumpWidget(
      ZuraffaApp(
        theme: ZfaThemeData(brightness: Brightness.light),
        home: Builder(
          builder: (context) {
            final scheme = ZfaTheme.of(context).colorScheme;
            expectedBackground = scheme.primary;
            expectedText = scheme.primaryForeground;
            return const Scaffold(body: Text('snack light'));
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      snackBarBackground(tester),
      expectedBackground,
      reason: 'FR-016: snack bar background derives from the shell scheme',
    );
    expect(snackBarText(tester), expectedText);
    // The M3 default would be inverseSurface (near-black); the shell primary
    // is the accent, so the two must differ for the test to mean anything.
    expect(
      snackBarBackground(tester),
      isNot(const Color(0xFF02081A)),
      reason: 'the M3 near-black default must be gone',
    );
  });

  testWidgets('snack bar follows dark theme', (tester) async {
    late Color expectedBackground;
    late Color expectedText;

    await tester.pumpWidget(
      ZuraffaApp(
        theme: ZfaThemeData(brightness: Brightness.dark),
        home: Builder(
          builder: (context) {
            final scheme = ZfaTheme.of(context).colorScheme;
            expectedBackground = scheme.primary;
            expectedText = scheme.primaryForeground;
            return const Scaffold(body: Text('snack dark'));
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      snackBarBackground(tester),
      expectedBackground,
      reason: 'FR-017: snack bar colours follow the dark scheme',
    );
    expect(snackBarText(tester), expectedText);
  });

  testWidgets('consumer materialThemeBuilder override wins', (tester) async {
    const overrideColor = Color(0xFF123456);

    await tester.pumpWidget(
      ZuraffaApp(
        home: const Scaffold(body: Text('snack override')),
        materialThemeBuilder: (context, theme) => theme.copyWith(
          snackBarTheme: theme.snackBarTheme.copyWith(
            backgroundColor: overrideColor,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      snackBarBackground(tester),
      overrideColor,
      reason: 'FR-018: the consumer override must take precedence',
    );
  });
}
