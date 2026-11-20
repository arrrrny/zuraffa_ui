// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/zfa.dart';

// ShadApp's implicit localizations chain must serve the SDK's
// MaterialLocalizations, not only material_ui's same-named fork type: the SDK
// widgets a consumer mixes into the shell (AppBar, Scaffold, tooltip and
// semantic-label lookups) resolve MaterialLocalizations from
// package:flutter/material.dart, and those lookups can never be satisfied by
// the fork type.
void main() {
  testWidgets('serves the SDK MaterialLocalizations under ShadApp', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ShadApp(home: SizedBox.expand()),
    );
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(SizedBox));

    expect(
      Localizations.of<MaterialLocalizations>(context, MaterialLocalizations),
      isNotNull,
    );
  });

  testWidgets('an SDK AppBar builds inside ShadApp', (tester) async {
    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('probe')),
          body: const SizedBox.expand(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(AppBar), findsOneWidget);
  });
}
