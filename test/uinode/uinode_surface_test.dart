import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/uinode.dart';

// A4: the v1 vocabulary is exactly the documented 27 node kinds
// (+ option/header/footer/pane value kinds) — additions and removals are
// contract changes and must land here.

void main() {
  test('the certified v1 widgetType vocabulary is complete', () {
    expect(
      ShadNodeParser().supportedWidgetTypes,
      equals(
        <String>{
          // components (spec 1100 FR-1)
          'button', 'badge', 'text', 'card', 'cardHeader', 'cardFooter',
          'input', 'select', 'selectOption', 'checkbox', 'switch',
          'radioGroup', 'radioOption', 'formItem', 'tabs', 'tab', 'tabPane',
          'progress', 'separator', 'tooltip', 'sheet', 'dialog', 'popover',
          'toast',
          // structural primitives (FR-2)
          'row', 'column', 'stack', 'padding', 'expanded', 'sizedBox',
          'listView', 'image', 'icon',
        },
      ),
    );
  });

  test('the public barrels surface the contract names', () {
    // Compile-time surface check: these resolves prove the contract names
    // are exported from package:zuraffa_ui/uinode.dart.
    const names = [
      ShadNodeParser,
      UiActionRegistry,
      UiTreeTooLarge,
      UiVersionError,
      UiParseError,
      UiNodeEvent,
    ];
    expect(names, isNotEmpty);
  });
}
