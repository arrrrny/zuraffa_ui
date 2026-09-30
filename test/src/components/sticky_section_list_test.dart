import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/zfa.dart';

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

  group('ShadStickySectionList ad-section flicker (sticky-header-flicker)', () {
    // Sections: A (3 items), AD (headerless ad placeholder, 1 tall item),
    // B (6 items). B gets enough items for its inline header to be able to
    // reach the viewport top.
    List<ShadListSection> buildAdSections() => [
      ShadListSection(
        header: const Text('Section A'),
        items: [
          for (var j = 0; j < 3; j++)
            SizedBox(height: 80, child: Text('ad-item a$j')),
        ],
      ),
      const ShadListSection(
        header: SizedBox.shrink(),
        items: [
          SizedBox(
            height: 320,
            child: Center(child: Text('Sponsored')),
          ),
        ],
      ),
      ShadListSection(
        header: const Text('Section B'),
        items: [
          for (var j = 0; j < 6; j++)
            SizedBox(height: 80, child: Text('ad-item b$j')),
        ],
      ),
    ];

    Widget adHarness({
      ValueChanged<int>? onSectionChanged,
      ScrollController? controller,
    }) {
      return ShadApp(
        home: SizedBox(
          height: 400,
          child: ShadStickySectionList(
            sections: buildAdSections(),
            onSectionChanged: onSectionChanged,
            controller: controller,
          ),
        ),
      );
    }

    /// Compresses [values] into runs of consecutive duplicates.
    List<double> runs(List<double> values) {
      final result = <double>[];
      for (final v in values) {
        if (result.isEmpty || result.last != v) result.add(v);
      }
      return result;
    }

    testWidgets(
      'no flicker past a headerless ad section (monotonic transitions)',
      (tester) async {
        final changes = <int>[];
        final controller = ScrollController();
        addTearDown(controller.dispose);
        await tester.pumpWidget(
          adHarness(
            onSectionChanged: changes.add,
            controller: controller,
          ),
        );
        await tester.pumpAndSettle();

        // Micro-scroll down through the ad and into section B.
        final maxExtent = controller.position.maxScrollExtent;
        while (controller.offset < maxExtent) {
          controller.jumpTo(
            (controller.offset + 20).clamp(0.0, maxExtent),
          );
          await tester.pump();
        }

        // Transitions must be strictly increasing on the way down and must end
        // on section B (index 2). Flapping like [1, 0, 1, ...] is the flicker.
        final downPass = List<int>.from(changes);
        for (var i = 1; i < downPass.length; i++) {
          expect(
            downPass[i],
            greaterThan(downPass[i - 1]),
            reason: 'down-pass transitions flapped: $downPass',
          );
        }
        expect(downPass.last, 2, reason: 'down-pass transitions: $downPass');

        // Micro-scroll back up: strictly decreasing, ending on section A.
        changes.clear();
        while (controller.offset > 0) {
          controller.jumpTo((controller.offset - 20).clamp(0.0, maxExtent));
          await tester.pump();
        }
        for (var i = 1; i < changes.length; i++) {
          expect(
            changes[i],
            lessThan(changes[i - 1]),
            reason: 'up-pass transitions flapped: $changes',
          );
        }
        expect(changes.last, 0, reason: 'up-pass transitions: $changes');
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets('sticky bar size does not oscillate across the ad boundary', (
      tester,
    ) async {
      // A trailing section C realizes the oscillation branch: when the empty
      // ad bar makes B's header ineligible, the closest-header rule jumps to
      // C and the bar regrows, which re-eligibilizes B — looping.
      final sections = [
        ...buildAdSections(),
        ShadListSection(
          header: const Text('Section C'),
          items: [
            for (var j = 0; j < 3; j++)
              SizedBox(height: 80, child: Text('ad-item c$j')),
          ],
        ),
      ];
      final controller = ScrollController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        ShadApp(
          home: SizedBox(
            height: 400,
            child: ShadStickySectionList(
              sections: sections,
              controller: controller,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // The list sits directly below the sticky bar, so its y-offset tracks
      // the bar height. The oscillation window is only as wide as the height
      // difference between the empty ad bar and a text bar, so sweep that
      // zone at 1px resolution: locate B's inline header, then step through
      // its crossing of the viewport top pixel by pixel.
      final listTops = <double>[];
      final maxExtent = controller.position.maxScrollExtent;

      Future<void> stepTo(double offset) async {
        controller.jumpTo(offset.clamp(0.0, maxExtent));
        await tester.pump();
        listTops.add(tester.getTopLeft(find.byType(ListView)).dy);
      }

      final listViewTop = tester.getTopLeft(find.byType(ListView)).dy;
      // B's header is not built at offset 0 (lazy list): walk forward until
      // it mounts, then anchor the 1px sweep on its crossing.
      while (!tester.any(find.text('Section B'))) {
        await stepTo(controller.offset + 100);
      }
      final bHeaderTop = tester.getTopLeft(find.text('Section B')).dy;
      final bCrossing = controller.offset + (bHeaderTop - listViewTop);

      while (controller.offset < bCrossing - 40) {
        await stepTo(controller.offset + 20);
      }
      for (var s = controller.offset; s <= bCrossing + 80; s += 1) {
        await stepTo(s);
      }
      while (controller.offset < maxExtent) {
        await stepTo(controller.offset + 20);
      }

      // At most three bar heights may occur: section A's, the empty ad
      // section's, and the text sections' shared height — in that order,
      // once each. Alternation beyond that is the flicker loop.
      expect(
        runs(listTops).length,
        lessThanOrEqualTo(3),
        reason: 'bar height oscillated: ${runs(listTops)}',
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets(
      'switches title when the incoming header reaches the viewport top',
      (tester) async {
        final controller = ScrollController();
        addTearDown(controller.dispose);
        await tester.pumpWidget(adHarness(controller: controller));
        await tester.pumpAndSettle();

        // Locate B's inline header (walk forward — the lazy list does not
        // build it at offset 0) and jump so it sits exactly at the top of the
        // list viewport.
        while (!tester.any(find.text('Section B'))) {
          controller.jumpTo(controller.offset + 100);
          await tester.pump();
        }
        final listViewTop = tester.getTopLeft(find.byType(ListView)).dy;
        final bHeaderTop = tester.getTopLeft(find.text('Section B')).dy;
        final crossingOffset = controller.offset + (bHeaderTop - listViewTop);

        // While B's header is still below the viewport top, its title appears
        // only inline (once) — the pinned bar still belongs to the previous
        // section, never to B.
        controller.jumpTo(crossingOffset - 60);
        await tester.pump();
        expect(
          find.text('Section B'),
          findsOneWidget,
          reason: 'B must not take the bar before its header reaches the top',
        );

        // At the top: B's title is pinned in the bar AND rendered inline
        // (two occurrences). The bar must never fall back to an empty
        // placeholder at this moment.
        controller.jumpTo(crossingOffset);
        await tester.pump();
        expect(
          find.text('Section B'),
          findsNWidgets(2),
          reason: 'B header reached the viewport top: bar must pin B',
        );
        expect(find.text('Section A'), findsNothing);
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets('stays on the first section before any header crosses', (
      tester,
    ) async {
      final changes = <int>[];
      await tester.pumpWidget(adHarness(onSectionChanged: changes.add));
      await tester.pumpAndSettle();

      expect(changes, isEmpty);
      expect(find.text('Section A'), findsWidgets);
      expect(tester.takeException(), isNull);
    });
  });
}
