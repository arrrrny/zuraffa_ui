// zfa:tdd: A4:hand — hand step completed before first red certification
// (issue #1411)
//
// Hand-implemented scenario runner for behavior A4 (AC-4): mounts the shell
// with a user builder and a user navigator observer, pushes an unnamed route,
// and collects the wiring evidence the test asserts on — every piece must
// remain mounted above the navigator.
// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/shad.dart' show ShadSonner, ShadToaster;
import 'package:zuraffa_ui/zuraffa_ui.dart';

/// The wiring evidence collected by the A4 scenario.
class A4Evidence {
  /// Creates the evidence record.
  const A4Evidence({
    required this.userBuilderAboveNavigator,
    required this.chromeAboveNavigator,
    required this.toasterAboveNavigator,
    required this.sonnerAboveNavigator,
    required this.contractObserverReported,
    required this.userObserverNotified,
  });

  /// The user builder's output is mounted above the navigator.
  final bool userBuilderAboveNavigator;

  /// The violation chrome is mounted above the navigator.
  final bool chromeAboveNavigator;

  /// The engine's `ShadToaster` is mounted above the navigator.
  final bool toasterAboveNavigator;

  /// The engine's `ShadSonner` is mounted above the navigator.
  final bool sonnerAboveNavigator;

  /// An unnamed push was reported by the route-contract observer.
  final bool contractObserverReported;

  /// The user's own navigator observer saw the push (merged observers).
  final bool userObserverNotified;
}

/// Runs the A4 scenario and returns the collected [A4Evidence].
Future<A4Evidence> subject_a4(WidgetTester tester) async {
  final bus = ZfaAuditBus();
  final userObserverSaw = <String>[];
  await tester.pumpWidget(
    ZuraffaApp(
      auditBus: bus,
      builder: (context, child) => KeyedSubtree(
        key: const Key('user-builder'),
        child: child ?? const SizedBox.shrink(),
      ),
      navigatorObservers: [_PushRecordingObserver(userObserverSaw.add)],
      home: Scaffold(
        body: Builder(
          builder: (context) => ZfaButton(
            child: const Text('push unnamed route'),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const Scaffold(body: Text('unnamed route')),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('push unnamed route'));
  await tester.pumpAndSettle();

  final navigator = find.byType(Navigator);
  bool aboveNavigator(Finder finder) =>
      find.ancestor(of: navigator, matching: finder).evaluate().isNotEmpty;

  return A4Evidence(
    userBuilderAboveNavigator: aboveNavigator(
      find.byKey(const Key('user-builder')),
    ),
    chromeAboveNavigator: aboveNavigator(find.byType(ZfaViolationChrome)),
    toasterAboveNavigator: aboveNavigator(find.byType(ShadToaster)),
    sonnerAboveNavigator: aboveNavigator(find.byType(ShadSonner)),
    contractObserverReported: bus.violations.isNotEmpty,
    userObserverNotified: userObserverSaw.contains('<unnamed>'),
  );
}

class _PushRecordingObserver extends NavigatorObserver {
  _PushRecordingObserver(this.onPush);

  final void Function(String name) onPush;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onPush(route.settings.name ?? '<unnamed>');
  }
}
