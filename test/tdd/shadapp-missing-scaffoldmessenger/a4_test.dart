// zfa:tdd: A4:hand — hand step completed before first red certification
// (issue #1411)
//
// Hand-completed acceptance test for A4 (AC-4, issue
// arrrrny/zuraffa_browser#168): the ScaffoldMessenger fix must not disturb the
// shell's existing wiring — the user's builder, the violation chrome, the
// route-contract observer and ShadToaster/ShadSonner stay mounted above the
// navigator.

import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/tdd/shadapp-missing-scaffoldmessenger/a4_subject.dart'
    as subject;

void main() {
  group('A4 (AC-4)', () {
    testWidgets(
      "A4 — the user's builder output, the violation chrome, the "
      'route-contract observer and `ShadToaster`/`ShadSonner` all remain '
      'mounted above the navigator.',
      (tester) async {
        final evidence = await subject.subject_a4(tester);

        // The observable outcome (issue #1488): every piece of the shell's
        // wiring is still mounted above the navigator — asserted outside the
        // guard.
        expect(evidence.userBuilderAboveNavigator, isTrue);
        expect(evidence.chromeAboveNavigator, isTrue);
        expect(evidence.toasterAboveNavigator, isTrue);
        expect(evidence.sonnerAboveNavigator, isTrue);
        expect(
          evidence.contractObserverReported,
          isTrue,
          reason:
              'an unnamed push must still be reported by the '
              'route-contract observer',
        );
        expect(
          evidence.userObserverNotified,
          isTrue,
          reason: 'user navigator observers must stay merged',
        );
      },
    );
  });
}
