// zfa:tdd: A3:hand — hand step completed before first red certification
// (issue #1411)
//
// Hand-implemented scenario runner for behavior A3 (AC-3): pushes a route
// onto the shell's navigator and resolves its ScaffoldMessenger from the
// pushed route — the condition reported in arrrrny/zuraffa_browser#168.
// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/src/identified/app/zuraffa_app.dart';
import 'package:zuraffa_ui/src/identified/components/zfa_button.dart';

/// Runs the A3 scenario and returns the [ScaffoldMessengerState] resolved
/// from the pushed route's context.
///
/// Resolution happens synchronously inside the route's build, exactly where a
/// real widget would call `ScaffoldMessenger.of(context)`.
Future<ScaffoldMessengerState> subject_a3(WidgetTester tester) async {
  late ScaffoldMessengerState messenger;
  await tester.pumpWidget(
    ZuraffaApp(
      showViolationChrome: false,
      home: Scaffold(
        body: Builder(
          builder: (context) => ZfaButton(
            child: const Text('open probe route'),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                settings: const RouteSettings(name: 'zfa.probe'),
                builder: (routeContext) {
                  messenger = ScaffoldMessenger.of(routeContext);
                  return const Scaffold(body: Text('probe route'));
                },
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open probe route'));
  await tester.pumpAndSettle();
  return messenger;
}
