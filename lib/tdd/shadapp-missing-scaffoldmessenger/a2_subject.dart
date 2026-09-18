// zfa:tdd: A2:hand — hand step completed before first red certification
// (issue #1411)
//
// Hand-implemented scenario runner for behavior A2 (AC-2): mounts the app
// shell, shows a SnackBar through ScaffoldMessenger.of(context) from a widget
// inside a Scaffold, and reports what the tree rendered — the export-flow
// scenario reported in arrrrny/zuraffa_browser#168.
// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/src/identified/app/zuraffa_app.dart';
import 'package:zuraffa_ui/src/identified/components/zfa_button.dart';

/// The rendering evidence collected by the A2 scenario.
class A2Evidence {
  /// Creates the evidence record.
  const A2Evidence({
    required this.messengerResolved,
    required this.snackbarRendered,
  });

  /// Whether `ScaffoldMessenger.of` resolved for the tapping widget.
  final bool messengerResolved;

  /// Whether the SnackBar's content was found in the widget tree.
  final bool snackbarRendered;
}

/// Runs the A2 scenario: taps a widget that shows a SnackBar through the
/// shell's messenger, drains the SnackBar's auto-hide timer, and returns the
/// rendering [A2Evidence].
Future<A2Evidence> subject_a2(WidgetTester tester) async {
  var messengerResolved = false;
  await tester.pumpWidget(
    ZuraffaApp(
      showViolationChrome: false,
      home: Scaffold(
        body: Builder(
          builder: (context) => ZfaButton(
            child: const Text('save'),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Saved')));
              messengerResolved = true;
            },
          ),
        ),
      ),
    ),
  );

  await tester.tap(find.text('save'));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
  final rendered = find.text('Saved').evaluate().isNotEmpty;

  // Drain the SnackBar's display timer and exit animation so the test does
  // not end with a pending timer.
  await tester.pump(const Duration(seconds: 5));
  await tester.pump(const Duration(milliseconds: 300));

  return A2Evidence(
    messengerResolved: messengerResolved,
    snackbarRendered: rendered,
  );
}
