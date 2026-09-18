import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/zfa.dart';

// Theme alias tests: skins type ZfaTheme/ZfaThemeData and never a Shad name.
// The engine import exists only to prove the alias IS the engine type (the
// anti-corruption layer pins the name, not a copy of the type).
//
// On the shadcn_ui substrate this file does not compile.

void main() {
  group('aliases', () {
    testWidgets('ZfaTheme.of resolves the mounted ShadTheme', (tester) async {
      ShadThemeData? resolvedFromZfa;
      ShadThemeData? resolvedFromEngine;
      Brightness? brightness;
      await tester.pumpWidget(
        ZuraffaApp(
          theme: ZfaThemeData(brightness: Brightness.dark),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                resolvedFromZfa = ZfaTheme.of(context);
                resolvedFromEngine = ShadTheme.of(context);
                brightness = ZfaTheme.of(context).brightness;
                return const Text('theme probe');
              },
            ),
          ),
        ),
      );
      expect(find.text('theme probe'), findsOneWidget);
      expect(resolvedFromZfa, isNotNull);
      expect(resolvedFromEngine, isNotNull);
      expect(
        identical(resolvedFromZfa, resolvedFromEngine),
        isTrue,
        reason: 'ZfaTheme.of and ShadTheme.of resolve the same data',
      );
      expect(brightness, Brightness.dark);
    });

    testWidgets('ZfaThemeData constructs through the alias', (tester) async {
      // ShadThemeData exposes a factory (not const), so the alias is invoked
      // without const - the certified construction path for skins.
      final dark = ZfaThemeData(brightness: Brightness.dark);
      final light = ZfaThemeData();
      expect(dark.brightness, Brightness.dark);
      expect(light.brightness, Brightness.light);
      expect(
        dark,
        isA<ShadThemeData>(),
        reason: 'the alias is the engine type, not a copy',
      );
    });
  });
}
