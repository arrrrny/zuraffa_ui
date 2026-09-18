import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/zuraffa_ui.dart';

// Contract-kit tests: the audit bus, the route observer, the typed contract
// mixin, and the SkinContractKit facade with the pilot's `zfa:` key
// convention. On the shadcn_ui substrate this file does not compile.

void main() {
  group('bus', () {
    test('reports, exposes unmodifiable history, notifies, clears', () {
      final bus = ZfaAuditBus();
      var notifications = 0;
      bus.addListener(() => notifications++);

      expect(bus.violations, isEmpty);

      bus.report(
        ZfaContractViolation(
          code: 'route.unidentified',
          message: 'Route pushed without contract identity',
        ),
      );
      expect(bus.violations, hasLength(1));
      expect(bus.violations.first.code, 'route.unidentified');
      expect(
        bus.violations.first.message,
        'Route pushed without contract identity',
      );
      expect(bus.violations.first.timestamp, isNotNull);
      expect(notifications, 1);

      expect(
        () => bus.violations.add(
          ZfaContractViolation(code: 'x', message: 'y'),
        ),
        throwsUnsupportedError,
        reason: 'the violation history must be unmodifiable',
      );

      bus.clear();
      expect(bus.violations, isEmpty);
      expect(notifications, 2);
    });
  });

  group('route observer', () {
    test('reports unnamed pushes as unidentified routes', () {
      final bus = ZfaAuditBus();
      final observer = ZuraffaRouteObserver(bus: bus);

      observer.didPush(
        MaterialPageRoute<void>(builder: (_) => const SizedBox()),
        null,
      );

      expect(bus.violations, hasLength(1));
      expect(bus.violations.first.code, 'route.unidentified');
    });

    test('named pushes are clean', () {
      final bus = ZfaAuditBus();
      final observer = ZuraffaRouteObserver(bus: bus);

      observer.didPush(
        MaterialPageRoute<void>(
          settings: const RouteSettings(name: 'zfa.detail'),
          builder: (_) => const SizedBox(),
        ),
        null,
      );

      expect(bus.violations, isEmpty);
    });

    test('works without a bus attached (no crash)', () {
      final observer = ZuraffaRouteObserver();
      observer.didPush(
        MaterialPageRoute<void>(builder: (_) => const SizedBox()),
        null,
      );
    });
  });

  group('kit registry and keys', () {
    test('certified ids cover the identified vocabulary', () {
      expect(
        SkinContractKit.certifiedIds,
        containsAll(<String>[
          'zfa.app',
          'zfa.button',
          'zfa.input',
          'zfa.card',
          'zfa.sheet',
          'zfa.dialog',
          'zfa.toaster',
        ]),
      );
    });

    test('parses the pilot zfa: key convention', () {
      expect(
        SkinContractKit.contractIdOf(const ValueKey<String>('zfa:button')),
        'zfa.button',
      );
      expect(
        SkinContractKit.contractIdOf(
          const ValueKey<String>('zfa:button#login'),
        ),
        'zfa.button',
        reason: 'fragment after # is per-instance, not part of the id',
      );
      expect(
        SkinContractKit.contractIdOf(const ValueKey<String>('other:1')),
        isNull,
      );
      expect(SkinContractKit.contractIdOf(null), isNull);
    });

    test('kit owns a bus and an observer wired to that bus', () {
      final kit = SkinContractKit();
      expect(kit.bus, isNotNull);
      expect(kit.observer.bus, same(kit.bus));

      kit.observer.didPush(
        MaterialPageRoute<void>(builder: (_) => const SizedBox()),
        null,
      );
      expect(kit.bus.violations, hasLength(1));
    });
  });

  group('typed contract mixin', () {
    test('any widget can adopt the protocol', () {
      const probe = _Probe();
      expect(probe.contractId, 'zfa.probe');
      expect(probe.contractEnabled, isTrue);
    });
  });
}

class _Probe extends StatelessWidget with ZfaContract {
  const _Probe();

  @override
  String get contractId => 'zfa.probe';

  @override
  bool get contractEnabled => true;

  @override
  Widget build(BuildContext context) => const SizedBox();
}
