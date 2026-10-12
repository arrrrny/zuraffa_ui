# Quickstart: 1100-uinode-system

Validation guide — prove the feature end-to-end after implementation.

## Prerequisites

- Flutter stable + Dart 3.11+ (`flutter --version`)
- Deps synced: `flutter pub get`
- Codegen up to date after editing any node: `dart run build_runner build --delete-conflicting-outputs`

## 1. Round-trip + canonical serialization (SC-2)

```bash
flutter test test/uinode/nodes test/uinode/canonical_json_test.dart
```

Expected: every node type round-trips `tree → canonical JSON → tree` with
node equality and byte-identical canonical output; the generated variations
(seed-stable) all pass.

## 2. Parse caps, versions, unknown types (SC-4 part 1)

```bash
flutter test test/uinode/parser_test.dart
```

Expected: oversized trees fail with `UiTreeTooLarge` naming the cap and
path; newer major version → `UiVersionError`; unknown `widgetType` parses
to `UnknownNode` and survives a round-trip; raw colors rejected.

## 3. Actions (SC-4 part 2)

```bash
flutter test test/uinode/actions_test.dart
```

Expected: resolved handler invoked with args; unknown action and throwing
handler surface through the registry callbacks; no exception escapes.

## 4. Rendering + lifted state (US1/US2)

```bash
flutter test test/uinode/renderer_base_test.dart test/uinode/renderer_form_test.dart
```

Expected: fixture trees map to the expected engine widgets; toggling a
checkbox/switch or selecting a tab updates renderer-scoped state; two
renderers of the same tree hold independent state.

## 5. Golden fixtures (SC-3)

```bash
flutter test test/uinode/golden_test.dart
```

Expected on Linux CI: ≥20 fixture goldens match. On macOS the suite skips
platform-sensitive comparisons (repo precedent #7) — verify with
`flutter test test/uinode/golden_test.dart` reporting `+N ~M`.

Regenerate goldens **only on Linux**:
`flutter test test/uinode/golden_test.dart --update-goldens`

## 6. Full gate

```bash
flutter analyze && flutter test
```

Expected: zero analysis issues, whole suite green (with the documented
platform skips).

## End-to-end smoke (host view)

```dart
import 'package:zuraffa_ui/uinode.dart';

final tree = ShadNodeParser().parse(jsonDecode(sample));
runApp(ZuraffaApp(home: Scaffold(body: ShadNodeRenderer(
  tree: tree,
  actions: UiActionRegistry(handlers: {
    'submit_selection': (name, args) => debugPrint('$name $args'),
  }, onUnknownAction: (name) => debugPrint('unknown: $name')),
))));
```

A card with a text, an input, and a working button — zero host-side JSON
handling.
