import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/shad.dart';

void main() {
  group('ShadStickySectionList', () {
    List<ShadListSection> buildSections() => [
      for (var i = 0; i < 3; i++)
        ShadListSection(
          header: Text('Section $i'),
          items: [
            for (var j = 0; j < 5; j++)
              SizedBox(height: 80, child: Text('item $i.$j')),
          ],
        ),
    ];

    Widget harness({ValueChanged<int>? onSectionChanged}) {
      return ShadApp(
        home: SizedBox(
          height: 400,
          child: ShadStickySectionList(
            sections: buildSections(),
            onSectionChanged: onSectionChanged,
          ),
        ),
      );
    }

    testWidgets('pins the first section header above the list', (tester) async {
      await tester.pumpWidget(harness());
      await tester.pumpAndSettle();

      // The active section's inline header is suppressed in favour of the
      // pinned one, so its label is rendered exactly once.
      expect(find.text('Section 0'), findsOneWidget);
      // A section further down keeps its inline header.
      expect(find.text('Section 1'), findsOneWidget);
      expect(find.text('item 0.0'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('reports and pins the active section as the list scrolls', (
      tester,
    ) async {
      final changes = <int>[];
      await tester.pumpWidget(harness(onSectionChanged: changes.add));
      await tester.pumpAndSettle();
      expect(changes, isEmpty);

      await tester.drag(
        find.byType(ShadStickySectionList),
        const Offset(0, -600),
      );
      await tester.pumpAndSettle();

      expect(changes, isNotEmpty);
      expect(changes.last, greaterThan(0));
      expect(find.text('Section ${changes.last}'), findsWidgets);
      expect(tester.takeException(), isNull);
    });

    testWidgets('uses the caller scroll controller', (tester) async {
      final controller = ScrollController();
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        ShadApp(
          home: SizedBox(
            height: 400,
            child: ShadStickySectionList(
              sections: buildSections(),
              controller: controller,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(controller.hasClients, isTrue);
      await tester.drag(
        find.byType(ShadStickySectionList),
        const Offset(0, -600),
      );
      await tester.pumpAndSettle();

      expect(controller.offset, greaterThan(0));
      expect(tester.takeException(), isNull);
    });
  });
}
