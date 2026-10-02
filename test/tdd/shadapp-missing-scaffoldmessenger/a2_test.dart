// zfa:tdd: A2:hand — hand step completed before first red certification
// (issue #1411)
//
// Hand-completed acceptance test for A2 (AC-2, issue
// arrrrny/zuraffa_browser#168): a widget under the shell shows a SnackBar
// through ScaffoldMessenger and its content renders in the tree.

import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/tdd/shadapp-missing-scaffoldmessenger/a2_subject.dart'
    as subject;

void main() {
  group('A2 (AC-2)', () {
    testWidgets(
      "A2 — the SnackBar's content renders in the widget tree.",
      (tester) async {
        final evidence = await subject.subject_a2(tester);

        // The observable outcome (issue #1488): the SnackBar actually
        // rendered through the shell's messenger — asserted outside the
        // guard.
        expect(
          evidence.messengerResolved,
          isTrue,
          reason: 'the shell must provide the ScaffoldMessenger',
        );
        expect(
          evidence.snackbarRendered,
          isTrue,
          reason: 'the SnackBar content must render in the widget tree',
        );
      },
    );
  });
}
