import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/zfa.dart';

// A2 / SC-3: the fixture trees render to matching goldens on the
// golden-generation platform (Linux CI).
//
// The goldens are Linux-rendered artifacts; macOS draws the engine's
// handle/shadow slightly differently (~0.2% pixel drift), so comparisons
// run only on Linux — the same policy as the sheet expandable goldens
// (issue #7, research D7). Regenerate ONLY on Linux:
//   flutter test test/uinode/golden_test.dart --update-goldens

final bool _isGoldenPlatform = Platform.isLinux;

Widget _harness(Widget child, Size size) => ShadApp(
  home: Scaffold(
    body: Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: child,
      ),
    ),
  ),
);

void main() {
  final fixtureDir = Directory('test/uinode/fixtures');
  final fixtures =
      fixtureDir
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.json'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));

  test('there are at least 20 fixture trees (SC-3)', () {
    expect(fixtures.length, greaterThanOrEqualTo(20));
  });

  for (final fixture in fixtures) {
    final name = fixture.uri.pathSegments.last.replaceAll('.json', '');
    if (!_isGoldenPlatform) {
      // Goldens are Linux-rendered (#7); on other platforms we only verify
      // each fixture parses and renders without throwing.
      testWidgets('render-only (no golden compare): $name', (tester) async {
        final tree = ShadNodeParser().parse(fixture.readAsStringSync());
        tester.view.physicalSize = const Size(420, 320);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await tester.pumpWidget(
          _harness(
            SingleChildScrollView(
              key: ValueKey<String>(name),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ShadNodeRenderer(tree: tree),
              ),
            ),
            const Size(420, 320),
          ),
        );
        await tester.pump();
        expect(tester.takeException(), isNull);
      });
      continue;
    }
    testWidgets('golden: $name', (tester) async {
      final tree = ShadNodeParser().parse(fixture.readAsStringSync());
      final key = ValueKey<String>(name);

      // Deterministic view: fixed logical size, dpr 1.
      tester.view.physicalSize = const Size(420, 320);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        _harness(
          SingleChildScrollView(
            key: key,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ShadNodeRenderer(tree: tree),
            ),
          ),
          const Size(420, 320),
        ),
      );
      await tester.pump();

      await expectLater(
        find.byKey(key),
        matchesGoldenFile('goldens/$name.png'),
      );
    });
  }
}
