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

    testWidgets('pinned header stays below the top safe area inset', (
      tester,
    ) async {
      // Full-height sheets on iOS reach the status bar: the ambient top
      // padding (clock/notch inset) must clear the pinned title.
      await tester.pumpWidget(
        ShadApp(
          home: MediaQuery(
            data: const MediaQueryData(padding: EdgeInsets.only(top: 47)),
            child: SizedBox(
              height: 400,
              child: ShadStickySectionList(sections: buildSections()),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Bar top + 47 inset + the default headerPadding top (20).
      final titleTop = tester.getTopLeft(find.text('Section 0').first).dy;
      expect(titleTop, 67, reason: 'title must clear the top safe area');
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
        // Seven items: B's inline header must be able to REACH the viewport
        // top within maxScrollExtent. On the default test surface (600px tall
        // — the SizedBox below does not constrain it) six items cap the
        // scroll range just short of B's crossing, so the bar could only ever
        // show B via the premature indices.first flip.
        items: [
          for (var j = 0; j < 7; j++)
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

    /// Walks forward until [match] is mounted or the step budget runs out.
    /// Never clamps against `maxScrollExtent`: SliverList only *estimates*
    /// it until mixed-height children build, and the estimate can clamp the
    /// walk short of the target.
    Future<void> walkForward(
      WidgetTester tester,
      ScrollController controller,
      bool Function() match,
    ) async {
      for (var i = 0; i < 100 && !match(); i++) {
        controller.jumpTo(controller.offset + 100);
        await tester.pump();
      }
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

        // Micro-scroll down through the ad and into section B. Re-read the
        // extent every step: SliverList's estimate grows as children build.
        for (var i = 0; i < 200; i++) {
          final maxExtent = controller.position.maxScrollExtent;
          if (controller.offset >= maxExtent) break;
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
        for (var i = 0; i < 200 && controller.offset > 0; i++) {
          controller.jumpTo(
            (controller.offset - 20).clamp(0.0, double.infinity),
          );
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
      // Short sections keep several inline headers mounted past their
      // crossing (within the cache extent) — that is the geometry where a
      // Column-relative measurement closes the shrink/regrow feedback loop:
      // the empty ad bar makes B's header ineligible, another section takes
      // over, the bar regrows and B becomes eligible again, looping. A
      // trailing section C keeps the rule from falling off the end of the
      // list.
      final sections = [
        ShadListSection(
          header: const Text('Section A'),
          items: [
            for (var j = 0; j < 2; j++)
              SizedBox(height: 60, child: Text('ad-item a$j')),
          ],
        ),
        const ShadListSection(
          header: SizedBox.shrink(),
          items: [
            SizedBox(height: 100, child: Center(child: Text('Sponsored'))),
          ],
        ),
        ShadListSection(
          header: const Text('Section B'),
          items: [
            for (var j = 0; j < 4; j++)
              SizedBox(height: 60, child: Text('ad-item b$j')),
          ],
        ),
        ShadListSection(
          header: const Text('Section C'),
          items: [
            for (var j = 0; j < 2; j++)
              SizedBox(height: 60, child: Text('ad-item c$j')),
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

      Future<void> stepTo(double offset) async {
        controller.jumpTo(offset);
        await tester.pump();
        listTops.add(tester.getTopLeft(find.byType(ListView)).dy);
      }

      // B's header is not built at offset 0 (lazy list): walk forward until
      // it mounts, then anchor the 1px sweep on its crossing.
      await walkForward(
        tester,
        controller,
        () => tester.any(find.text('Section B')),
      );
      final listViewTop = tester.getTopLeft(find.byType(ListView)).dy;
      final bHeaderTop = tester.getTopLeft(find.text('Section B').last).dy;
      final bCrossing = controller.offset + (bHeaderTop - listViewTop);

      for (var i = 0; i < 100 && controller.offset < bCrossing - 40; i++) {
        await stepTo(controller.offset + 20);
      }
      for (var s = controller.offset; s <= bCrossing + 80; s += 1) {
        await stepTo(s);
      }
      for (var i = 0; i < 100; i++) {
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

    /// Counts occurrences of [title] that are actually painted — excludes
    /// any wrapped in an `Opacity(0)` (the active section's inline header is
    /// kept for layout size but made invisible).
    int visibleTitleCount(WidgetTester tester, String title) {
      var count = 0;
      for (final element in find.text(title).evaluate()) {
        var invisible = false;
        element.visitAncestorElements((ancestor) {
          final widget = ancestor.widget;
          if (widget is Opacity && widget.opacity == 0.0) {
            invisible = true;
          }
          return !invisible;
        });
        if (!invisible) count++;
      }
      return count;
    }

    testWidgets(
      'switches title when the incoming header reaches the viewport top',
      (tester) async {
        final controller = ScrollController();
        addTearDown(controller.dispose);
        await tester.pumpWidget(adHarness(controller: controller));
        await tester.pumpAndSettle();

        // Locate B's inline header (walk forward — the lazy list does not
        // build it at offset 0) and jump so it sits exactly at the top of
        // the list viewport.
        await walkForward(
          tester,
          controller,
          () => tester.any(find.text('Section B')),
        );
        final listViewTop = tester.getTopLeft(find.byType(ListView)).dy;
        final bHeaderTop = tester.getTopLeft(find.text('Section B')).dy;
        final crossingOffset = controller.offset + (bHeaderTop - listViewTop);

        // While B's header is still below the viewport top, its title appears
        // only inline (once) — the pinned bar still belongs to the previous
        // section, never to B.
        controller.jumpTo(crossingOffset - 60);
        await tester.pump();
        expect(
          visibleTitleCount(tester, 'Section B'),
          1,
          reason: 'B must not take the bar before its header reaches the top',
        );

        // At the top: B's title is pinned in the bar AND rendered inline
        // (two occurrences). The bar must never fall back to an empty
        // placeholder at this moment. Land the header top exactly on the
        // viewport top: fractional text metrics make the first estimate
        // land a fraction off, and the inclusive boundary is the contract.
        var offset = crossingOffset;
        for (var i = 0; i < 4; i++) {
          controller.jumpTo(offset);
          await tester.pump();
          // The inline header is .last once B also appears in the bar.
          final dy =
              tester
                  .getTopLeft(
                    find.text('Section B').last,
                  )
                  .dy -
              tester.getTopLeft(find.byType(ListView)).dy;
          if (dy == 0.0) break;
          offset += dy;
        }
        // The post-frame evaluation runs within the pump above; pump once
        // more so the pinned bar it scheduled is actually built.
        await tester.pump();
        expect(
          find.text('Section B'),
          findsNWidgets(2),
          reason:
              'B header reached the viewport top: bar must pin B (bar + '
              'inline header still in the tree for layout)',
        );
        // The title must be VISIBLE exactly once: the active section's
        // inline header goes transparent so the title never shows twice
        // while it scrolls out.
        expect(
          visibleTitleCount(tester, 'Section B'),
          1,
          reason: 'the title must not display twice during the transition',
        );
        expect(find.text('Section A'), findsNothing);
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'pins the section at the top even when a zero-height header crosses '
      'with it',
      (tester) async {
        // A headerless ad section with no items and zero inline padding has
        // zero extent: its header crosses the viewport top at exactly the
        // same offset as the next section's header. The active section is
        // the LAST one whose header crossed (the real listing), never the
        // first mounted one — and the tie must not flip with map order.
        final sections = [
          for (var i = 0; i < 2; i++)
            ShadListSection(
              header: Text('Short $i'),
              items: [SizedBox(height: 60, child: Text('short item $i'))],
            ),
          const ShadListSection(header: SizedBox.shrink(), items: []),
          const ShadListSection(
            header: Text('Short 2'),
            items: [SizedBox(height: 60, child: Text('short item 2'))],
          ),
          ShadListSection(
            header: const Text('Short 3'),
            items: [
              // Enough trailing content for Short 2's header to be able to
              // reach the viewport top at all.
              for (var j = 0; j < 6; j++)
                SizedBox(height: 60, child: Text('short tail $j')),
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
                inlineHeaderPadding: EdgeInsets.zero,
                controller: controller,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Land Short 2's header (and the zero-height ad header with it)
        // exactly at the viewport top. The walk is budgeted; the correction
        // targets the inline header (.last once the bar also shows it) and
        // never clamps against the unreliable extent estimate.
        await walkForward(
          tester,
          controller,
          () => tester.any(find.text('Short 2')),
        );
        var offset =
            controller.offset +
            (tester.getTopLeft(find.text('Short 2').last).dy -
                tester.getTopLeft(find.byType(ListView)).dy);
        for (var i = 0; i < 4; i++) {
          controller.jumpTo(offset);
          await tester.pump();
          // The inline header is .last once Short 2 also appears in the bar.
          final dy =
              tester
                  .getTopLeft(
                    find.text('Short 2').last,
                  )
                  .dy -
              tester.getTopLeft(find.byType(ListView)).dy;
          if (dy == 0.0) break;
          offset += dy;
        }
        // The post-frame evaluation runs within the pump above; pump once
        // more so the pinned bar it scheduled is actually built.
        await tester.pump();
        expect(
          find.text('Short 2'),
          findsNWidgets(2),
          reason:
              'Short 2 header is at the top: the bar must pin Short 2, not '
              'the empty header that crossed with it',
        );
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

    testWidgets(
      'keeps the first section pinned deep inside it after its header is '
      'recycled out of the cache extent',
      (tester) async {
        // A first section far taller than the default cache extent (250px):
        // scrolled into its middle, its inline header has been disposed by
        // the lazy list and the only mounted header is section B's, still
        // below the top. The bar must keep section A — not flip to B up to
        // viewport + cacheExtent early.
        final sections = [
          ShadListSection(
            header: const Text('Section A'),
            items: [
              for (var j = 0; j < 10; j++)
                SizedBox(height: 80, child: Text('tall item $j')),
            ],
          ),
          ShadListSection(
            header: const Text('Section B'),
            items: [
              for (var j = 0; j < 3; j++)
                SizedBox(height: 80, child: Text('tail item $j')),
            ],
          ),
        ];
        final changes = <int>[];
        final controller = ScrollController();
        addTearDown(controller.dispose);
        await tester.pumpWidget(
          ShadApp(
            home: SizedBox(
              height: 400,
              child: ShadStickySectionList(
                sections: sections,
                onSectionChanged: changes.add,
                controller: controller,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Mid-section: A's header sits ~500px above the viewport top, well
        // past the cache extent, so only B's header remains mounted.
        controller.jumpTo(500);
        await tester.pump();
        // The post-frame evaluation runs within the pump above; pump once
        // more so the pinned bar it scheduled is actually built.
        await tester.pump();

        expect(
          find.text('Section A'),
          findsOneWidget,
          reason: 'A is still the active section: the bar must pin A',
        );
        expect(
          find.text('Section B'),
          findsOneWidget,
          reason: 'B must not take the bar before its header reaches the top',
        );
        expect(changes, isEmpty);
        expect(tester.takeException(), isNull);
      },
    );
  });
}
