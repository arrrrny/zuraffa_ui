import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/zuraffa_ui.dart';

// ZuraffaApp behavior: the route-contract observer is mounted by default, the
// violation chrome is visible by default (and disableable), the shared audit
// bus drives both, and the user's builder/observers survive the wrap.
//
// On the shadcn_ui substrate this file does not compile: no ZuraffaApp, no
// ZfaAuditBus, no ZfaContractViolation.

void main() {
  group('route contract observer', () {
    testWidgets('pushing a route without contract identity reports a violation '
        'and shows the chrome', (tester) async {
      await tester.pumpWidget(
        ZuraffaApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ZfaButton(
                child: const Text('go anonymous'),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const Scaffold(body: Text('anon route')),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('go anonymous'));
      await tester.pumpAndSettle();

      expect(find.text('anon route'), findsOneWidget);
      expect(
        find.textContaining('Zfa contract violation'),
        findsWidgets,
        reason:
            'an unnamed route push must surface the '
            'violation chrome by default',
      );
    });

    testWidgets('pushing a route with a contract name is clean', (
      tester,
    ) async {
      await tester.pumpWidget(
        ZuraffaApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ZfaButton(
                child: const Text('go named'),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    settings: const RouteSettings(name: 'zfa.detail'),
                    builder: (_) => const Scaffold(body: Text('named route')),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('go named'));
      await tester.pumpAndSettle();

      expect(find.text('named route'), findsOneWidget);
      expect(
        find.textContaining('Zfa contract violation'),
        findsNothing,
        reason: 'a route with contract identity must not violate',
      );
    });
  });

  group('violation chrome', () {
    testWidgets('reports on the shared bus become visible', (tester) async {
      final bus = ZfaAuditBus();
      await tester.pumpWidget(
        ZuraffaApp(
          auditBus: bus,
          home: const Scaffold(body: Text('home content')),
        ),
      );
      expect(find.text('home content'), findsOneWidget);
      expect(find.textContaining('Zfa contract violation'), findsNothing);

      bus.report(
        ZfaContractViolation(
          code: 'route.unidentified',
          message: 'Route pushed without contract identity',
        ),
      );
      await tester.pump();
      expect(find.textContaining('Zfa contract violation'), findsWidgets);
      expect(
        find.textContaining('Route pushed without contract identity'),
        findsWidgets,
      );

      bus.clear();
      await tester.pump();
      expect(find.textContaining('Zfa contract violation'), findsNothing);
      expect(
        find.text('home content'),
        findsOneWidget,
        reason: 'the navigator beneath the chrome must stay intact',
      );
    });

    testWidgets('chrome can be disabled while the observer keeps recording', (
      tester,
    ) async {
      final bus = ZfaAuditBus();
      await tester.pumpWidget(
        ZuraffaApp(
          auditBus: bus,
          showViolationChrome: false,
          home: const Scaffold(body: Text('chrome off')),
        ),
      );
      bus.report(
        ZfaContractViolation(
          code: 'route.unidentified',
          message: 'invisible violation',
        ),
      );
      await tester.pump();
      expect(
        find.textContaining('Zfa contract violation'),
        findsNothing,
        reason: 'showViolationChrome: false must hide the banner',
      );
      expect(
        bus.violations,
        hasLength(1),
        reason: 'the audit bus still records when chrome is off',
      );
    });
  });

  group('wraps ShadApp', () {
    testWidgets('mounts the theme so ZfaTheme.of resolves', (tester) async {
      await tester.pumpWidget(
        const ZuraffaApp(
          home: Scaffold(body: Text('themed home')),
        ),
      );
      expect(find.text('themed home'), findsOneWidget);
    });

    testWidgets('user builder is preserved inside the chrome', (tester) async {
      await tester.pumpWidget(
        ZuraffaApp(
          home: const Scaffold(body: Text('home beneath builder')),
          builder: (context, child) => const Text('user builder ran'),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('user builder ran'), findsOneWidget);
    });

    testWidgets('user navigator observers are merged with the contract one', (
      tester,
    ) async {
      final seen = <String>[];
      await tester.pumpWidget(
        ZuraffaApp(
          navigatorObservers: [
            _RecordingObserver(onPush: seen.add),
          ],
          home: Scaffold(
            body: Builder(
              builder: (context) => ZfaButton(
                child: const Text('observed push'),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    settings: const RouteSettings(name: 'zfa.observed'),
                    builder: (_) => const Scaffold(body: Text('target')),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('observed push'));
      await tester.pumpAndSettle();
      expect(seen, contains('zfa.observed'));
    });
  });
}

class _RecordingObserver extends NavigatorObserver {
  _RecordingObserver({required this.onPush});
  final void Function(String name) onPush;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onPush(route.settings.name ?? '<unnamed>');
  }
}
