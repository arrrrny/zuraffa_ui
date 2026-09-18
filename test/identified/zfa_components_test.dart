import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/zfa.dart';

// Identification tests: every certified Zfa component answers the typed
// contract protocol (contractId + contractEnabled) and renders the Shad engine
// widget beneath it. On the shadcn_ui substrate this file does not compile:
// `Error: Couldn't find declaration for 'ZfaButton'` (and friends) — that is
// the red the pilot's duck-typed auditor probes were working around.

Widget wrap(Widget child) {
  return ZuraffaApp(
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('ZfaButton', () {
    testWidgets('contract: id zfa.button, enabled by default, disableable', (
      tester,
    ) async {
      const button = ZfaButton();
      expect(button.contractId, 'zfa.button');
      expect(button.contractEnabled, isTrue);

      const off = ZfaButton(contractEnabled: false);
      expect(off.contractEnabled, isFalse);
    });

    testWidgets('forwards onPressed and taps reach the handler', (
      tester,
    ) async {
      var pressed = 0;
      await tester.pumpWidget(
        wrap(
          ZfaButton(
            onPressed: () => pressed++,
            child: const Text('certified button'),
          ),
        ),
      );
      await tester.tap(find.text('certified button'));
      await tester.pump();
      expect(pressed, 1);
    });

    testWidgets('renders the ShadButton engine widget beneath it', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(const ZfaButton(child: Text('engine beneath'))),
      );
      expect(find.byType(ShadButton), findsOneWidget);
      expect(find.byType(ZfaButton), findsOneWidget);
      expect(find.text('engine beneath'), findsOneWidget);
    });
  });

  group('ZfaInput', () {
    testWidgets('contract: id zfa.input', (tester) async {
      const input = ZfaInput();
      expect(input.contractId, 'zfa.input');
      expect(input.contractEnabled, isTrue);
      expect(const ZfaInput(contractEnabled: false).contractEnabled, isFalse);
    });

    testWidgets('forwards controller and onChanged; typing notifies', (
      tester,
    ) async {
      final controller = TextEditingController();
      var changed = '';
      await tester.pumpWidget(
        wrap(
          ZfaInput(
            controller: controller,
            onChanged: (value) => changed = value,
            placeholder: 'type here',
          ),
        ),
      );
      expect(find.text('type here'), findsOneWidget);
      await tester.enterText(find.byType(ZfaInput), 'skin lane');
      expect(controller.text, 'skin lane');
      expect(changed, 'skin lane');
    });
  });

  group('ZfaCard', () {
    testWidgets('contract: id zfa.card, renders title/description/child', (
      tester,
    ) async {
      const card = ZfaCard();
      expect(card.contractId, 'zfa.card');
      expect(card.contractEnabled, isTrue);

      await tester.pumpWidget(
        wrap(
          const ZfaCard(
            title: Text('card title'),
            description: Text('card description'),
            child: Text('card body'),
          ),
        ),
      );
      expect(find.byType(ShadCard), findsOneWidget);
      expect(find.text('card title'), findsOneWidget);
      expect(find.text('card description'), findsOneWidget);
      expect(find.text('card body'), findsOneWidget);
    });
  });

  group('ZfaSheet', () {
    testWidgets('contract: id zfa.sheet', (tester) async {
      const sheet = ZfaSheet();
      expect(sheet.contractId, 'zfa.sheet');
      expect(sheet.contractEnabled, isTrue);
    });

    testWidgets('show wraps showShadSheet and renders the sheet', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          ZfaButton(
            child: const Text('open sheet'),
            onPressed: () => ZfaSheet.show<void>(
              tester.element(find.byType(ZfaButton)),
              title: const Text('sheet title'),
              child: const Text('sheet body'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open sheet'));
      await tester.pumpAndSettle();
      expect(find.text('sheet title'), findsOneWidget);
      expect(find.text('sheet body'), findsOneWidget);
    });
  });

  group('ZfaDialog', () {
    testWidgets('contract: id zfa.dialog', (tester) async {
      const dialog = ZfaDialog();
      expect(dialog.contractId, 'zfa.dialog');
      expect(dialog.contractEnabled, isTrue);
    });

    testWidgets('show wraps showShadDialog and renders the dialog', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrap(
          ZfaButton(
            child: const Text('open dialog'),
            onPressed: () => ZfaDialog.show<void>(
              tester.element(find.byType(ZfaButton)),
              title: const Text('dialog title'),
              child: const Text('dialog body'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open dialog'));
      await tester.pumpAndSettle();
      expect(find.text('dialog title'), findsOneWidget);
      expect(find.text('dialog body'), findsOneWidget);
    });
  });

  group('ZfaToaster', () {
    testWidgets('contract: id zfa.toaster, toasts shown through it appear', (
      tester,
    ) async {
      const toaster = ZfaToaster(child: SizedBox());
      expect(toaster.contractId, 'zfa.toaster');
      expect(toaster.contractEnabled, isTrue);

      await tester.pumpWidget(
        ZuraffaApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ZfaButton(
                child: const Text('fire toast'),
                onPressed: () => ShadToaster.of(context).show(
                  const ShadToast(title: Text('zfa toast fired')),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('fire toast'));
      // The toast auto-dismisses after 5s (kDefaultToastDuration), so we pump a
      // fixed slice instead of settling through the dismissal.
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.text('zfa toast fired'), findsOneWidget);
      await tester.pump(const Duration(seconds: 6));
      await tester.pump(const Duration(milliseconds: 400));
      expect(
        find.text('zfa toast fired'),
        findsNothing,
        reason: 'the toaster must honor the default toast duration',
      );
    });
  });

  group('ZuraffaApp', () {
    testWidgets('is itself an identified contract element', (tester) async {
      const app = ZuraffaApp();
      expect(app.contractId, 'zfa.app');
      expect(app.contractEnabled, isTrue);
    });
  });
}
