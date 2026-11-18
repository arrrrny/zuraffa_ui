# Contract: UINode public API + JSON wire format

Phase 1 output. This is the cross-repo contract (zuraffa, zuraffa_agent
consume these names/shapes). Changes here are breaking changes.

## Dart API (package:zuraffa_ui/uinode.dart, re-exported by zfa.dart)

```dart
// Tree + nodes (Zorphy entities; $-prefixed abstracts are generated away)
abstract class $$ShadNode { String get widgetType; String? get id; }
// concrete: ButtonNode, BadgeNode, TextNode, CardNode, CardHeaderNode,
// CardFooterNode, InputNode, SelectNode, SelectOptionNode, CheckboxNode,
// SwitchNode, RadioGroupNode, RadioOptionNode, FormItemNode, TabsNode,
// TabNode, TabPaneNode, ProgressNode, SeparatorNode, TooltipNode,
// SheetNode, DialogNode, PopoverNode, ToastNode, RowNode, ColumnNode,
// StackNode, PaddingNode, ExpandedNode, SizedBoxNode, ListViewNode,
// ImageNode, IconNode, UnknownNode

class ShadNodeTree { int get schemaVersion; $$ShadNode get root; }

// Parse / validate / emit
class ShadNodeParser {
  ShadNodeParser({this.maxDepth = 32, this.maxNodes = 500,
      this.maxTextLength = 10000, this.currentSchemaVersion = 1});
  ShadNodeTree parse(Object? json);            // Map (decoded) or JSON String
  ShadNodeTree parseTree(ShadNodeTree tree);   // validate an already-built tree
  UiParseReport validate(Object? json);        // never builds widgets
}

class UiParseReport { bool get ok; List<UiParseException> get errors; }

// Canonical, byte-stable emission (fixed key order, compact)
String canonicalJson(ShadNodeTree tree);

// Actions
typedef UiActionHandler = void Function(String name, Map<String, dynamic> args);
class UiActionRegistry {
  UiActionRegistry({Map<String, UiActionHandler> handlers = const {},
      this.onUnknownAction, this.onHandlerError});
  void register(String name, UiActionHandler handler);
  void unregister(String name);
  void dispatch(String name, Map<String, dynamic> args); // never throws
}

// Render
class ShadNodeRenderer extends StatelessWidget {
  const ShadNodeRenderer({super.key, required this.tree, required this.actions,
      this.debugFallbacks = true}); // release hosts pass false → omit+event
}

// Typed errors / events
sealed class UiParseException implements Exception { String get path; }
class UiTreeTooLarge extends UiParseException { UiCapKind get cap; }
class UiVersionError extends UiParseException { int get found; }
class UiParseError extends UiParseException { UiParseErrorKind get kind; }
enum UiCapKind { depth, nodes, textLength }
enum UiParseErrorKind { schema, enumValue, arity, colorRejected, malformed }
class UiNodeEvent { String get kind; String? get path; } // unknown-node omission etc.
```

## JSON wire format (v1)

```json
{
  "schemaVersion": 1,
  "root": {
    "widgetType": "card",
    "title": "Sign in",
    "content": [
      { "widgetType": "text", "text": "Welcome back", "style": "h2" },
      { "widgetType": "input", "placeholder": "Email", "id": "email" },
      {
        "widgetType": "button",
        "label": "Continue",
        "variant": "primary",
        "action": { "action": "submit_selection", "args": { "form": "signin" } }
      }
    ]
  }
}
```

- Discriminator: `widgetType` at each node object (Zorphy reads/writes
  `__typename`; the parser translates `widgetType` ↔ `__typename` so the
  wire stays agent-friendly).
- Unknown `widgetType` → `UnknownNode{widgetType, raw}` (preserved through
  round-trip; render fallback per FR-9).
- Keys: emitted canonically in schema order —
  envelope `schemaVersion,root`; per node `widgetType,id,…props…,children`
  (exact order table lives next to the canonical writer and is covered by a
  golden-file test of the canonical form).
- Styling: token names only (`"destructive"`, `"mutedForeground"`, `"card"`,
  `"h2"`, size/radius scale names). Raw colors rejected.
- Actions: `{action, args}` per FR-6.

## Compatibility

- `schemaVersion` major > runtime major → `UiVersionError` (typed, never a
  crash); minor additions must round-trip via `UnknownNode`.
- The 27 node types in v1 are the certified vocabulary; additions are minor
  bumps, removals/renames are major bumps.
