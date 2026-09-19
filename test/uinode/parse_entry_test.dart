import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/uinode.dart';

// U3: `parse` accepts a JSON string or a decoded map and yields a
// `ShadNodeTree`.
// U4: schema violations fail with `UiParseError` naming the node path.
// U5: unknown `widgetType` parses to `UnknownNode`; siblings unaffected.

void main() {
  const sample = <String, dynamic>{
    'schemaVersion': 1,
    'root': {
      'widgetType': 'column',
      'children': [
        {'widgetType': 'text', 'text': 'Welcome', 'style': 'h2'},
        {'widgetType': 'button', 'label': 'Continue'},
      ],
    },
  };

  group('U3: parse entry accepts string or map', () {
    test('parses a decoded map into a tree', () {
      final tree = ShadNodeParser().parse(sample);
      expect(tree.schemaVersion, 1);
      expect(tree.root.widgetType, 'column');
      final column = tree.root as ColumnNode;
      expect(column.children, hasLength(2));
    });

    test('parses an encoded JSON string into the same tree', () {
      final parser = ShadNodeParser();
      final fromMap = parser.parse(sample);
      final fromString = parser.parse(
        '{"schemaVersion":1,"root":{"widgetType":"column","children":'
        '[{"widgetType":"text","text":"Welcome","style":"h2"},'
        '{"widgetType":"button","label":"Continue"}]}}',
      );
      expect(fromString, equals(fromMap));
    });

    test('missing schemaVersion defaults to the current version', () {
      final tree = ShadNodeParser().parse({
        'root': {'widgetType': 'text', 'text': 'hi'},
      });
      expect(tree.schemaVersion, ShadNodeTree.currentSchemaVersion);
    });
  });

  group('U4: schema violations name the path', () {
    test('unknown key on a node', () {
      const bad = <String, dynamic>{
        'root': {
          'widgetType': 'text',
          'text': 'hi',
          'colo': 'red',
        },
      };
      final err = catchParse(bad);
      expect(err.kind, UiParseErrorKind.schema);
      expect(err.path, contains('root'));
    });

    test('wrong prop type', () {
      const bad = <String, dynamic>{
        'root': {
          'widgetType': 'text',
          'text': 42,
        },
      };
      final err = catchParse(bad);
      expect(err.kind, UiParseErrorKind.schema);
    });

    test('bad enum value', () {
      const bad = <String, dynamic>{
        'root': {
          'widgetType': 'badge',
          'label': 'new',
          'variant': 'mega',
        },
      };
      final err = catchParse(bad);
      expect(err.kind, UiParseErrorKind.enumValue);
    });

    test('missing required child (arity)', () {
      const bad = <String, dynamic>{
        'root': {
          'widgetType': 'padding',
          'padding': {'all': 8},
        },
      };
      final err = catchParse(bad);
      expect(err.kind, UiParseErrorKind.arity);
    });

    test('malformed payload (root missing)', () {
      const bad = <String, dynamic>{'schemaVersion': 1};
      final err = catchParse(bad);
      expect(err.kind, UiParseErrorKind.arity);
    });

    test('malformed payload (not JSON)', () {
      final parser = ShadNodeParser();
      expect(
        () => parser.parse('not json {'),
        throwsA(isA<UiParseError>()),
      );
      expect(() => parser.parse(42), throwsA(isA<UiParseError>()));
    });
  });

  group('U5: unknown widget types are tolerated', () {
    test('unknown node parses to UnknownNode with raw preserved', () {
      const tree = <String, dynamic>{
        'root': {
          'widgetType': 'column',
          'children': [
            {
              'widgetType': 'hologram',
              'intensity': 11,
              'id': 'holo-1',
            },
            {'widgetType': 'text', 'text': 'still here'},
          ],
        },
      };
      final parsed = ShadNodeParser().parse(tree);
      final column = parsed.root as ColumnNode;
      expect(column.children, hasLength(2));

      final unknown = column.children.first as UnknownNode;
      expect(unknown.widgetType, 'hologram');
      expect(unknown.id, 'holo-1');
      expect(unknown.raw['intensity'], 11);
      expect(unknown.raw['widgetType'], 'hologram');

      final sibling = column.children.last as TextNode;
      expect(sibling.text, 'still here');
    });
  });
}

/// Runs [json] through the parser and returns the [UiParseError] it throws.
UiParseError catchParse(Object? json) {
  try {
    ShadNodeParser().parse(json);
  } on UiParseError catch (e) {
    return e;
  }
  fail('expected UiParseError');
}
