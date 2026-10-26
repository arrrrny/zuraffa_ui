// zfa:tdd: A3:hand — hand step completed before first red certification
// (issue #1411)
//
// Hand-completed acceptance test for A3 (AC-3, issue
// arrrrny/zuraffa_browser#168): a widget on a route pushed onto the shell's
// navigator resolves the shell's ScaffoldMessenger — no "No ScaffoldMessenger
// widget found" throw.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/tdd/shadapp-missing-scaffoldmessenger/a3_subject.dart'
    as subject;

void main() {
  group('A3 (AC-3)', () {
    testWidgets(
      "A3 — it resolves the shell's messenger without throwing.",
      (tester) async {
        final messenger = await subject.subject_a3(tester);

        // The observable outcome (issue #1488): the messenger resolved from
        // the pushed route — asserted outside the guard.
        expect(messenger, isA<ScaffoldMessengerState>());
        expect(messenger.mounted, isTrue);
      },
    );
  });
}
