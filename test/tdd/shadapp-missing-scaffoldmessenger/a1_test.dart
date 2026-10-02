// zfa:tdd: A1:hand — hand step completed before first red certification
// (issue #1411)
//
// Hand-completed acceptance test for A1 (AC-1, issue
// arrrrny/zuraffa_browser#168): a widget mounted under the app shell resolves
// a ScaffoldMessengerState — no "No ScaffoldMessenger widget found" throw.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/tdd/shadapp-missing-scaffoldmessenger/a1_subject.dart'
    as subject;

void main() {
  group('A1 (AC-1)', () {
    testWidgets(
      'A1 — it resolves a `ScaffoldMessengerState` without throwing.',
      (tester) async {
        final messenger = await subject.subject_a1(tester);

        // The observable outcome (issue #1488): the messenger resolved from a
        // widget mounted under the shell — asserted outside the guard.
        expect(messenger, isA<ScaffoldMessengerState>());
        expect(messenger.mounted, isTrue);
      },
    );
  });
}
