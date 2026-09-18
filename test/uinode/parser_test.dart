import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/uinode.dart';

// U6: caps — depth > 32, nodes > 500, text > max → UiTreeTooLarge naming
// cap and path.
// U7: version policy — newer major fails, missing accepted as current.
// U8: validate() reports ok/errors without building widgets.

UiTreeTooLarge catchTooLarge(Object? json) {
  try {
    ShadNodeParser().parse(json);
  } on UiTreeTooLarge catch (e) {
    return e;
  }
  fail('expected UiTreeTooLarge');
}

void main() {
  group('U6: composition caps', () {
    test('depth 33 fails with the depth cap and path', () {
      Map<String, dynamic> nest(int depth) {
        var node = <String, dynamic>{
          'widgetType': 'text',
          'text': 'bottom',
        };
        for (var i = 0; i < depth; i++) {
          node = {
            'widgetType': 'padding',
            'padding': {'all': 1},
            'child': node,
          };
        }
        return node;
      }

      // root + 32 paddings below it = depth 33 → over the cap.
      final err = catchTooLarge({'root': nest(33)});
      expect(err.cap, UiCapKind.depth);
      expect(err.path, isNotNull);
    });

    test('depth 32 is inside the cap', () {
      Map<String, dynamic> nest(int depth) {
        var node = <String, dynamic>{
          'widgetType': 'text',
          'text': 'bottom',
        };
        for (var i = 0; i < depth; i++) {
          node = {
            'widgetType': 'padding',
            'padding': {'all': 1},
            'child': node,
          };
        }
        return node;
      }

      final tree = ShadNodeParser().parse({'root': nest(32)});
      expect(tree.root.widgetType, 'padding');
    });

    test('501 nodes fail with the node cap', () {
      final children = List.generate(
        500,
        (i) => <String, dynamic>{'widgetType': 'text', 'text': 't$i'},
      );
      final err = catchTooLarge({
        'root': {
          'widgetType': 'column',
          'children': [
            const {'widgetType': 'text', 'text': 'over the edge'},
            ...children,
          ],
        },
      });
      expect(err.cap, UiCapKind.nodes);
    });

    test('oversized text fails with the text cap', () {
      final err = catchTooLarge({
        'root': {'widgetType': 'text', 'text': 'x' * 10001},
      });
      expect(err.cap, UiCapKind.textLength);
    });

    test('per-parser cap overrides work', () {
      final parser = ShadNodeParser(maxTextLength: 10);
      expect(
        () => parser.parse({
          'root': {'widgetType': 'text', 'text': 'x' * 11},
        }),
        throwsA(isA<UiTreeTooLarge>()),
      );
    });

    test('depth counts through trigger chains too', () {
      // sizedBox.child / card.header / *.trigger used to pass depth
      // through unchanged, letting chains blow past the cap.
      Map<String, dynamic> nest(int depth) {
        var node = <String, dynamic>{
          'widgetType': 'text',
          'text': 'bottom',
        };
        for (var i = 0; i < depth; i++) {
          node = {
            'widgetType': 'sheet',
            'trigger': node,
          };
        }
        return node;
      }

      final err = catchTooLarge({'root': nest(33)});
      expect(err.cap, UiCapKind.depth);
    });
  });

  group('U7: schema version policy', () {
    test('newer major version fails with UiVersionError', () {
      expect(
        () => ShadNodeParser().parse({
          'schemaVersion': 2,
          'root': {'widgetType': 'text', 'text': 'hi'},
        }),
        throwsA(
          isA<UiVersionError>()
              .having((e) => e.found, 'found', 2)
              .having((e) => e.supported, 'supported', 1),
        ),
      );
    });

    test('current version parses', () {
      final tree = ShadNodeParser().parse({
        'schemaVersion': 1,
        'root': {'widgetType': 'text', 'text': 'hi'},
      });
      expect(tree.schemaVersion, 1);
    });
  });

  group('U8: validation-only mode', () {
    test('valid tree reports ok without widgets', () {
      final report = ShadNodeParser().validate(const {
        'root': {
          'widgetType': 'column',
          'children': [
            {'widgetType': 'text', 'text': 'hi'},
          ],
        },
      });
      expect(report.ok, isTrue);
      expect(report.errors, isEmpty);
    });

    test('invalid tree lists every typed error without widgets', () {
      final report = ShadNodeParser().validate(const {
        'root': {
          'widgetType': 'column',
          'children': [
            {'widgetType': 'text', 'text': 'ok'},
            {'widgetType': 'badge', 'label': 'new', 'variant': 'mega'},
            {'widgetType': 'text', 'text': 'fine', 'style': '#ff0000'},
          ],
        },
      });
      expect(report.ok, isFalse);
      expect(report.errors, hasLength(2));
      expect(
        report.errors.every((e) => e is UiParseError),
        isTrue,
      );
      expect(
        report.errors.any(
          (e) => (e as UiParseError).kind == UiParseErrorKind.enumValue,
        ),
        reason: 'variant mega is an enum miss',
        isTrue,
      );
    });

    test('prop maps (padding, action) are not decoded as nodes', () {
      // The multi-error walk used to descend into every Map and report
      // spurious "widgetType" errors at <path>/padding, <path>/action, …
      final wire = {
        'root': {
          'widgetType': 'padding',
          'padding': {'all': 16},
          'child': {
            'widgetType': 'input',
            'label': 'Email',
            'action': {
              'action': 'submit',
              'args': {'source': 'keyboard'},
            },
          },
        },
      };
      ShadNodeParser().parse(wire); // parse accepts it…
      final report = ShadNodeParser().validate(wire);
      expect(report.ok, isTrue, reason: report.errors.join('\n'));
      expect(report.errors, isEmpty);
    });

    test('dialog actions must all be button nodes', () {
      // A non-button used to be parsed fine and then silently dropped.
      expect(
        () => ShadNodeParser().parse({
          'root': {
            'widgetType': 'dialog',
            'title': 'Confirm',
            'actions': [
              {'widgetType': 'button', 'label': 'OK'},
              {'widgetType': 'text', 'text': 'stray'},
            ],
          },
        }),
        throwsA(
          isA<UiParseError>()
              .having(
                (e) => e.path,
                'path',
                'root/actions[1]',
              )
              .having(
                (e) => e.message,
                'message',
                contains('must be button nodes'),
              ),
        ),
      );
    });
  });
}
