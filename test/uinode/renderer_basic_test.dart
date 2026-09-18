import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/zfa.dart';

// U12: basic components map to engine widgets with token-resolved styling.
// U13: a theme-token restyle changes the render with zero tree edits.

ShadNodeTree _tree(Map<String, dynamic> root) =>
    ShadNodeParser().parse({'root': root});

Widget _harness(
  ShadNodeTree tree, {
  ShadThemeData? theme,
}) {
  final body = SingleChildScrollView(child: ShadNodeRenderer(tree: tree));
  return ShadApp(
    home: theme == null
        ? Scaffold(body: body)
        : ShadTheme(
            data: theme,
            child: Scaffold(body: body),
          ),
  );
}

void main() {
  testWidgets('text resolves style tokens from the ambient theme', (
    tester,
  ) async {
    final tree = _tree({
      'widgetType': 'text',
      'text': 'Heading',
      'style': 'h1',
    });
    await tester.pumpWidget(
      _harness(
        tree,
        theme: ShadThemeData(
          textTheme: ShadTextTheme(h1: TextStyle(fontSize: 33)),
        ),
      ),
    );
    final text = tester.widget<Text>(find.byType(Text).first);
    expect(text.style!.fontSize, 33);
  });

  testWidgets('badge maps to the engine badge variant', (tester) async {
    final tree = _tree({
      'widgetType': 'badge',
      'label': 'new',
      'variant': 'secondary',
    });
    await tester.pumpWidget(_harness(tree));
    final badge = tester.widget<ShadBadge>(find.byType(ShadBadge));
    expect(badge.variant, ShadBadgeVariant.secondary);
  });

  testWidgets('button maps variant and size', (tester) async {
    final tree = _tree({
      'widgetType': 'button',
      'label': 'Go',
      'variant': 'destructive',
      'size': 'lg',
    });
    await tester.pumpWidget(_harness(tree));
    final button = tester.widget<ShadButton>(find.byType(ShadButton).first);
    expect(button.variant, ShadButtonVariant.destructive);
    expect(button.size, ShadButtonSize.lg);
  });

  testWidgets('card maps title, description and content', (tester) async {
    final tree = _tree({
      'widgetType': 'card',
      'title': 'Sign in',
      'description': 'Welcome back',
      'content': [
        {'widgetType': 'text', 'text': 'body'},
      ],
    });
    await tester.pumpWidget(_harness(tree));
    expect(find.byType(ShadCard), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('body'), findsOneWidget);
  });

  testWidgets('progress maps its value', (tester) async {
    final tree = _tree({
      'widgetType': 'progress',
      'value': 0.42,
    });
    await tester.pumpWidget(_harness(tree));
    expect(tester.widget<ShadProgress>(find.byType(ShadProgress)).value, 0.42);
  });

  testWidgets('separator maps orientation', (tester) async {
    final tree = _tree({
      'widgetType': 'sizedBox',
      'height': 50,
      'child': {
        'widgetType': 'separator',
        'orientation': 'vertical',
      },
    });
    await tester.pumpWidget(_harness(tree));
    expect(
      tester.widget<ShadSeparator>(find.byType(ShadSeparator)).variant,
      ShadSeparatorVariant.vertical,
    );
  });

  testWidgets('icon resolves Lucide wire names', (tester) async {
    final tree = _tree({
      'widgetType': 'icon',
      'name': 'plus',
      'size': 24,
    });
    await tester.pumpWidget(_harness(tree));
    final icon = tester.widget<Icon>(find.byType(Icon).first);
    expect(icon.size, 24);
    expect(icon.color, isNotNull);
  });

  testWidgets('image with unreachable src degrades to a placeholder box', (
    tester,
  ) async {
    final tree = _tree({
      'widgetType': 'image',
      'src': 'https://invalid.invalid/a.png',
      'width': 50,
      'height': 50,
      'alt': 'a placeholder',
    });
    await tester.pumpWidget(_harness(tree));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('U13: token restyle changes the render without tree edits', (
    tester,
  ) async {
    final tree = _tree({
      'widgetType': 'text',
      'text': 'Styled',
      'style': 'h1',
    });
    // h1 resolves to a theme font size; restyle via theme and compare.
    await tester.pumpWidget(_harness(tree));
    final fontSizeBefore = tester
        .widget<Text>(find.byType(Text).first)
        .style!
        .fontSize;
    await tester.pumpWidget(
      _harness(
        tree,
        theme: ShadThemeData(
          textTheme: ShadTextTheme(h1: TextStyle(fontSize: 99)),
        ),
      ),
    );
    final fontSizeAfter = tester
        .widget<Text>(find.byType(Text).first)
        .style!
        .fontSize;
    expect(fontSizeBefore, isNot(fontSizeAfter));
  });
}
