// zfa:tdd: A1:hand — hand step completed before first red certification
// (issue #1411)
//
// Hand-implemented scenario runner for behavior A1 (AC-1): mounts the app
// shell and resolves its ScaffoldMessenger from a widget mounted in the home
// route — the condition reported in arrrrny/zuraffa_browser#168.
// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/src/identified/app/zuraffa_app.dart';

/// Runs the A1 scenario and returns the resolved [ScaffoldMessengerState].
///
/// Resolution happens synchronously inside the probe's build, exactly where a
/// real widget would call `ScaffoldMessenger.of(context)`.
Future<ScaffoldMessengerState> subject_a1(WidgetTester tester) async {
  late ScaffoldMessengerState messenger;
  await tester.pumpWidget(
    ZuraffaApp(
      showViolationChrome: false,
      home: Scaffold(
        body: Builder(
          builder: (context) {
            messenger = ScaffoldMessenger.of(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );
  return messenger;
}
