import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/uinode.dart';

// U9: serializing the same tree twice yields identical bytes; keys follow
// the documented schema order.
// U10: the contract example round-trips to a byte-exact canonical form.

void main() {
  test('U9: serializing twice yields identical bytes', () {
    final tree = ShadNodeParser().parse(const {
      'root': {
        'widgetType': 'card',
        'title': 'Sign in',
        'content': [
          {'widgetType': 'text', 'text': 'Welcome back', 'style': 'h2'},
          {'widgetType': 'button', 'label': 'Continue'},
        ],
      },
    });
    final first = canonicalJson(tree);
    final second = canonicalJson(tree);
    expect(first, equals(second));
  });

  test('U9: canonical output uses the documented key order', () {
    final tree = ShadNodeParser().parse(const {
      'root': {
        'widgetType': 'button',
        'size': 'lg',
        'label': 'Go',
        'id': 'go-btn',
      },
    });
    // Envelope keys first (schemaVersion, root); node keys in schema order
    // (widgetType, id, …props…).
    expect(
      canonicalJson(tree),
      '{"schemaVersion":1,"root":{"widgetType":"button","id":"go-btn",'
      '"label":"Go","size":"lg"}}',
    );
  });

  test('U10: the contracts/uinode-api.md example is byte-exact', () {
    const example = {
      'schemaVersion': 1,
      'root': {
        'widgetType': 'card',
        'title': 'Sign in',
        'content': [
          {'widgetType': 'text', 'text': 'Welcome back', 'style': 'h2'},
          {'widgetType': 'input', 'placeholder': 'Email', 'id': 'email'},
          {
            'widgetType': 'button',
            'label': 'Continue',
            'variant': 'primary',
            'action': {
              'action': 'submit_selection',
              'args': {'form': 'signin'},
            },
          },
        ],
      },
    };
    final tree = ShadNodeParser().parse(example);
    expect(
      canonicalJson(tree),
      '{"schemaVersion":1,"root":{"widgetType":"card","title":"Sign in",'
      '"content":['
      '{"widgetType":"text","text":"Welcome back","style":"h2"},'
      '{"widgetType":"input","id":"email","placeholder":"Email"},'
      '{"widgetType":"button","label":"Continue","variant":"primary",'
      '"action":{"action":"submit_selection","args":{"form":"signin"}}}'
      ']}}',
    );
  });
}
