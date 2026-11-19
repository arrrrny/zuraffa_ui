import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
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

  group('router shell', () {
    // A minimal RouterDelegate/RouterConfig pair: one page that can push a
    // second page through its own navigator, so the tests exercise routing
    // without a router dependency.
    ({RouterConfig<Object> config, _ProbeNavigatorDelegate delegate})
    routerFixture() {
      final delegate = _ProbeNavigatorDelegate();
      final config = RouterConfig<Object>(
        routerDelegate: delegate,
        backButtonDispatcher: RootBackButtonDispatcher(),
      );
      return (config: config, delegate: delegate);
    }

    testWidgets("renders the delegate's initial route", (tester) async {
      final fixture = routerFixture();
      final config = fixture.config;
      final delegate = fixture.delegate;
      await tester.pumpWidget(
        ZuraffaApp.router(routerConfig: config, title: 'router app'),
      );
      await tester.pumpAndSettle();

      expect(find.text('router page one'), findsOneWidget);
      expect(delegate.buildCount, greaterThan(0));
    });

    testWidgets('scaffold messenger resolves inside a route and showSnackBar '
        'succeeds', (tester) async {
      final config = routerFixture().config;
      await tester.pumpWidget(
        ZuraffaApp.router(routerConfig: config),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('show snackbar'));
      await tester.pumpAndSettle();

      expect(
        find.text('routed snackbar'),
        findsOneWidget,
        reason: 'FR-003: a widget in any route must resolve a messenger',
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('messenger still resolvable after a route push', (
      tester,
    ) async {
      final config = routerFixture().config;
      await tester.pumpWidget(
        ZuraffaApp.router(routerConfig: config),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('push page two'));
      await tester.pumpAndSettle();
      expect(find.text('router page two'), findsOneWidget);

      await tester.tap(find.text('show snackbar on two'));
      await tester.pumpAndSettle();

      expect(find.text('routed snackbar'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('violation chrome overlays a routed page on a bus report', (
      tester,
    ) async {
      final bus = ZfaAuditBus();
      final config = routerFixture().config;
      await tester.pumpWidget(
        ZuraffaApp.router(routerConfig: config, auditBus: bus),
      );
      await tester.pumpAndSettle();
      expect(find.text('router page one'), findsOneWidget);
      expect(find.textContaining('Zfa contract violation'), findsNothing);

      bus.report(
        ZfaContractViolation(
          code: 'route.unidentified',
          message: 'router-path violation',
        ),
      );
      await tester.pump();

      expect(
        find.textContaining('Zfa contract violation'),
        findsWidgets,
        reason: 'FR-004: chrome must survive the router construction path',
      );
    });

    testWidgets('user builder hook runs on the router path', (tester) async {
      final config = routerFixture().config;
      await tester.pumpWidget(
        ZuraffaApp.router(
          routerConfig: config,
          builder: (context, child) => const Text('user builder ran'),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('user builder ran'),
        findsOneWidget,
        reason: 'FR-004: the consumer builder hook must be preserved',
      );
    });

    testWidgets('constructing .router() with all five inputs null asserts', (
      tester,
    ) async {
      // The constructor assert fires at runtime (debug mode); a non-const
      // invocation throws inside the test body where we can observe it.
      // The assert is an AssertionError by contract; catching it here is the
      // point of the test, so the lint is silenced deliberately.
      Object? thrown;
      try {
        ZuraffaApp.router();
        fail('expected the router-config assert to throw');
      } on Object catch (error) {
        thrown = error;
      }
      expect(
        thrown,
        isA<AssertionError>().having(
          (e) => e.message,
          'message',
          contains('ZuraffaApp.router requires a router delegate'),
        ),
        reason: 'FR-005: the message must name the conflict',
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('a dispatcher-only configuration is rejected by the assert', (
      tester,
    ) async {
      // ShadApp routes only on routerDelegate/routerConfig; a
      // backButtonDispatcher (or provider/parser pair) alone would fall into
      // its navigator path with nulled home/navigatorObservers and crash on
      // the null check. The shell asserts instead of letting that through
      // (FR-005: reject the combination clearly).
      Object? thrown;
      try {
        ZuraffaApp.router(backButtonDispatcher: RootBackButtonDispatcher());
        fail('expected the router-config assert to throw');
      } on Object catch (error) {
        thrown = error;
      }
      expect(
        thrown,
        isA<AssertionError>().having(
          (e) => e.message,
          'message',
          contains('ZuraffaApp.router requires a router delegate'),
        ),
        reason: 'FR-005: partial router input sets are rejected by name, '
            'not by an opaque null check downstream',
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('home path still mounts messenger and chrome after the '
        'constructor split', (tester) async {
      await tester.pumpWidget(
        ZuraffaApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ZfaButton(
                child: const Text('home snackbar'),
                onPressed: () =>
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('home-path snackbar')),
                    ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('home snackbar'));
      await tester.pumpAndSettle();

      expect(find.text('home-path snackbar'), findsOneWidget);
      expect(tester.takeException(), isNull);
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

/// A minimal router delegate owning one navigator with two pages, so the
/// router-shell tests exercise real routing without a router dependency.
class _ProbeNavigatorDelegate extends RouterDelegate<Object>
    with ChangeNotifier {
  int buildCount = 0;
  late final List<_ProbePage> pages = [_ProbePage.one(this)];

  @override
  Object get currentConfiguration => pages.length;

  @override
  Widget build(BuildContext context) {
    buildCount++;
    return Navigator(
      pages: List.of(pages),
      onDidRemovePage: _onDidRemovePage,
    );
  }

  void _onDidRemovePage(Page<Object?> page) {
    pages.remove(page);
    notifyListeners();
  }

  void pushPageTwo() {
    pages.add(_ProbePage.two(this));
    notifyListeners();
  }

  @override
  Future<void> setNewRoutePath(Object configuration) async {}

  @override
  Future<bool> popRoute() async => false;
}

class _ProbePage extends Page<void> {
  const _ProbePage.one(this.delegate)
      : super(name: 'zfa.router.one', key: const ValueKey('one'));
  const _ProbePage.two(this.delegate)
      : super(name: 'zfa.router.two', key: const ValueKey('two'));

  final _ProbeNavigatorDelegate delegate;

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute<void>(
      settings: this,
      builder: (context) => switch (this) {
        _ProbePage() when key == const ValueKey('one') => Scaffold(
            body: Column(
              children: [
                const Text('router page one'),
                Builder(
                  builder: (context) => ZfaButton(
                    child: const Text('show snackbar'),
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('routed snackbar')),
                    ),
                  ),
                ),
                Builder(
                  builder: (context) => ZfaButton(
                    onPressed: delegate.pushPageTwo,
                    child: const Text('push page two'),
                  ),
                ),
              ],
            ),
          ),
        _ => Scaffold(
            body: Column(
              children: [
                const Text('router page two'),
                Builder(
                  builder: (context) => ZfaButton(
                    child: const Text('show snackbar on two'),
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('routed snackbar')),
                    ),
                  ),
                ),
              ],
            ),
          ),
      },
    );
  }
}
