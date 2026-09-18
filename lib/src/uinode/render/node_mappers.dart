import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:zuraffa_ui/src/components/badge.dart';
import 'package:zuraffa_ui/src/components/button.dart';
import 'package:zuraffa_ui/src/components/card.dart';
import 'package:zuraffa_ui/src/components/checkbox.dart';
import 'package:zuraffa_ui/src/components/dialog.dart';
import 'package:zuraffa_ui/src/components/input.dart';
import 'package:zuraffa_ui/src/components/popover.dart';
import 'package:zuraffa_ui/src/components/progress.dart';
import 'package:zuraffa_ui/src/components/radio.dart';
import 'package:zuraffa_ui/src/components/select.dart';
import 'package:zuraffa_ui/src/components/separator.dart';
import 'package:zuraffa_ui/src/components/sheet.dart';
import 'package:zuraffa_ui/src/components/switch.dart';
import 'package:zuraffa_ui/src/components/tabs.dart';
import 'package:zuraffa_ui/src/components/toast.dart';
import 'package:zuraffa_ui/src/components/tooltip.dart';
import 'package:zuraffa_ui/src/theme/theme.dart';

import 'package:zuraffa_ui/src/uinode/nodes/props.dart';

// One mapper per node kind (spec 1100 FR-10). Each mirrors the component's
// canonical usage from docs/src/content/docs/Components and resolves every
// style prop through the ambient ShadTheme (FR-5) — no raw colors exist in
// this file on purpose (FR-16).

/// `widgetType: button`.
class ShadButtonMapper extends StatelessWidget {
  const ShadButtonMapper({
    super.key,
    required this.label,
    required this.variant,
    required this.size,
    required this.onPressed,
  });

  final String? label;
  final String? variant;
  final String? size;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final child = Text(label ?? '');
    final sizeEnum = switch (size) {
      'sm' => ShadButtonSize.sm,
      'lg' => ShadButtonSize.lg,
      _ => ShadButtonSize.regular,
    };
    return switch (variant) {
      'secondary' => ShadButton.secondary(
        onPressed: onPressed,
        size: sizeEnum,
        child: child,
      ),
      'destructive' => ShadButton.destructive(
        onPressed: onPressed,
        size: sizeEnum,
        child: child,
      ),
      'outline' => ShadButton.outline(
        onPressed: onPressed,
        size: sizeEnum,
        child: child,
      ),
      'ghost' => ShadButton.ghost(
        onPressed: onPressed,
        size: sizeEnum,
        child: child,
      ),
      'link' => ShadButton.link(
        onPressed: onPressed,
        size: sizeEnum,
        child: child,
      ),
      _ => ShadButton(onPressed: onPressed, size: sizeEnum, child: child),
    };
  }
}

/// `widgetType: badge`.
class ShadBadgeMapper extends StatelessWidget {
  const ShadBadgeMapper({super.key, required this.label, this.variant});

  final String label;
  final String? variant;

  @override
  Widget build(BuildContext context) {
    final child = Text(label);
    return switch (variant) {
      'secondary' => ShadBadge.secondary(child: child),
      'destructive' => ShadBadge.destructive(child: child),
      'outline' => ShadBadge.outline(child: child),
      _ => ShadBadge(child: child),
    };
  }
}

/// `widgetType: text`.
class ShadTextMapper extends StatelessWidget {
  const ShadTextMapper({
    super.key,
    required this.text,
    this.style,
    this.align,
  });

  final String text;
  final String? style;
  final String? align;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final base = switch (style) {
      'h1' => theme.textTheme.h1,
      'h2' => theme.textTheme.h2,
      'h3' => theme.textTheme.h3,
      'h4' => theme.textTheme.h4,
      'muted' => theme.textTheme.muted,
      'small' => theme.textTheme.small,
      'large' => theme.textTheme.large,
      'bold' => theme.textTheme.p.copyWith(fontWeight: FontWeight.bold),
      _ => theme.textTheme.p,
    };
    final alignment = switch (align) {
      'center' => TextAlign.center,
      'end' => TextAlign.end,
      'justify' => TextAlign.justify,
      'left' => TextAlign.left,
      'right' => TextAlign.right,
      _ => TextAlign.start,
    };
    return Text(text, style: base, textAlign: alignment);
  }
}

/// `widgetType: card`.
class ShadCardMapper extends StatelessWidget {
  const ShadCardMapper({
    super.key,
    required this.title,
    required this.description,
    required this.content,
    required this.header,
    required this.footer,
  });

  final String? title;
  final String? description;
  final List<Widget> content;
  final Widget? header;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      title: title == null ? null : Text(title!),
      description: description == null ? null : Text(description!),
      footer: footer == null
          ? null
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Expanded(child: footer!)],
            ),
      child: Column(children: content),
    );
  }
}

/// `widgetType: cardHeader` (standalone usage).
class ShadCardHeaderMapper extends StatelessWidget {
  const ShadCardHeaderMapper({super.key, this.title, this.description});

  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ShadTextMapper(text: title!, style: 'h3'),
        if (description != null)
          ShadTextMapper(text: description!, style: 'muted'),
      ],
    );
  }
}

/// `widgetType: cardFooter` (standalone usage).
class ShadCardFooterMapper extends StatelessWidget {
  const ShadCardFooterMapper({super.key, required this.content});

  final List<Widget> content;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: content);
  }
}

/// `widgetType: progress`.
class ShadProgressMapper extends StatelessWidget {
  const ShadProgressMapper({super.key, required this.value});

  final double? value;

  @override
  Widget build(BuildContext context) => ShadProgress(value: value);
}

/// `widgetType: separator`.
class ShadSeparatorMapper extends StatelessWidget {
  const ShadSeparatorMapper({super.key, required this.orientation});

  final String? orientation;

  @override
  Widget build(BuildContext context) => orientation == 'vertical'
      ? const ShadSeparator.vertical()
      : const ShadSeparator.horizontal();
}

/// `widgetType: input`.
class ShadInputMapper extends StatelessWidget {
  const ShadInputMapper({
    super.key,
    required this.initial,
    required this.placeholder,
    required this.label,
    required this.helper,
    required this.errorText,
    required this.enabled,
    required this.obscure,
    required this.keyboard,
    required this.onChanged,
    required this.onSubmit,
  });

  final String? initial;
  final String? placeholder;
  final String? label;
  final String? helper;
  final String? errorText;
  final bool? enabled;
  final bool? obscure;
  final String? keyboard;
  final ValueChanged<String> onChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final input = ShadInput(
      initialValue: initial,
      placeholder: placeholder == null ? null : Text(placeholder!),
      obscureText: obscure ?? false,
      readOnly: enabled == false,
      keyboardType: switch (keyboard) {
        'number' => TextInputType.number,
        'phone' => TextInputType.phone,
        'emailAddress' => TextInputType.emailAddress,
        'url' => TextInputType.url,
        'multiline' => TextInputType.multiline,
        _ => TextInputType.text,
      },
      onChanged: onChanged,
      onSubmitted: (_) => onSubmit(),
    );
    return _fieldChrome(context, label, helper, errorText, input);
  }
}

/// Shared label / helper / error chrome for field-like nodes.
Widget _fieldChrome(
  BuildContext context,
  String? label,
  String? helper,
  String? errorText,
  Widget field,
) {
  if (label == null && helper == null && errorText == null) return field;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (label != null) ShadTextMapper(text: label, style: 'p'),
      field,
      if (errorText != null)
        ShadTextMapper(text: errorText, style: 'small')
      else if (helper != null)
        ShadTextMapper(text: helper, style: 'muted'),
    ],
  );
}

/// `widgetType: select`.
class ShadSelectMapper extends StatefulWidget {
  const ShadSelectMapper({
    super.key,
    required this.initial,
    required this.placeholder,
    required this.label,
    required this.enabled,
    required this.options,
    required this.onChanged,
  });

  final String? initial;
  final String? placeholder;
  final String? label;
  final bool? enabled;
  final Map<String, String> options;
  final ValueChanged<String> onChanged;

  @override
  State<ShadSelectMapper> createState() => _ShadSelectMapperState();
}

class _ShadSelectMapperState extends State<ShadSelectMapper> {
  late String? _value = widget.initial;

  @override
  Widget build(BuildContext context) {
    final select = ShadSelect<String>(
      initialValue: _value,
      enabled: widget.enabled ?? true,
      placeholder: widget.placeholder == null
          ? null
          : Text(widget.placeholder!),
      options: [
        for (final entry in widget.options.entries)
          ShadOption(value: entry.key, child: Text(entry.value)),
      ],
      selectedOptionBuilder: (context, value) =>
          Text(widget.options[value] ?? value),
      onChanged: (v) {
        if (v == null) return;
        setState(() => _value = v);
        widget.onChanged(v);
      },
    );
    return _fieldChrome(
      context,
      widget.label,
      null,
      null,
      select,
    );
  }
}

/// `widgetType: checkbox`.
class ShadCheckboxMapper extends StatefulWidget {
  const ShadCheckboxMapper({
    super.key,
    required this.initial,
    required this.label,
    required this.enabled,
    required this.onChanged,
  });

  final bool initial;
  final String? label;
  final bool? enabled;
  final ValueChanged<bool> onChanged;

  @override
  State<ShadCheckboxMapper> createState() => _ShadCheckboxMapperState();
}

class _ShadCheckboxMapperState extends State<ShadCheckboxMapper> {
  late bool _value = widget.initial;

  @override
  Widget build(BuildContext context) {
    return ShadCheckbox(
      value: _value,
      enabled: widget.enabled ?? true,
      label: widget.label == null ? null : Text(widget.label!),
      onChanged: (v) {
        setState(() => _value = v);
        widget.onChanged(v);
      },
    );
  }
}

/// `widgetType: switch`.
class ShadSwitchMapper extends StatefulWidget {
  const ShadSwitchMapper({
    super.key,
    required this.initial,
    required this.label,
    required this.enabled,
    required this.onChanged,
  });

  final bool initial;
  final String? label;
  final bool? enabled;
  final ValueChanged<bool> onChanged;

  @override
  State<ShadSwitchMapper> createState() => _ShadSwitchMapperState();
}

class _ShadSwitchMapperState extends State<ShadSwitchMapper> {
  late bool _value = widget.initial;

  @override
  Widget build(BuildContext context) {
    return ShadSwitch(
      value: _value,
      enabled: widget.enabled ?? true,
      label: widget.label == null ? null : Text(widget.label!),
      onChanged: (v) {
        setState(() => _value = v);
        widget.onChanged(v);
      },
    );
  }
}

/// `widgetType: radioGroup`.
class ShadRadioGroupMapper extends StatelessWidget {
  const ShadRadioGroupMapper({
    super.key,
    required this.initial,
    required this.options,
    required this.onChanged,
  });

  final String? initial;
  final Map<String, String> options;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return ShadRadioGroup<String>(
      initialValue: initial,
      onChanged: onChanged,
      items: [
        for (final entry in options.entries)
          ShadRadio(
            value: entry.key,
            label: Text(entry.value),
          ),
      ],
    );
  }
}

/// `widgetType: formItem`.
class ShadFormItemMapper extends StatelessWidget {
  const ShadFormItemMapper({
    super.key,
    required this.label,
    required this.helper,
    required this.errorText,
    required this.required_,
    required this.field,
  });

  final String label;
  final String? helper;
  final String? errorText;
  final bool? required_;
  final Widget field;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadTextMapper(
          text: required_ ?? false ? '$label *' : label,
          style: 'p',
        ),
        field,
        if (errorText != null)
          ShadTextMapper(text: errorText!, style: 'small')
        else if (helper != null)
          ShadTextMapper(text: helper!, style: 'muted'),
      ],
    );
  }
}

/// `widgetType: tabs`.
class ShadTabsMapper extends StatelessWidget {
  const ShadTabsMapper({
    super.key,
    required this.initial,
    required this.tabs,
    required this.paneContents,
    required this.onChanged,
  });

  final String? initial;
  final Map<String, String> tabs;
  final Map<String, List<Widget>> paneContents;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return ShadTabs<String>(
      value: initial,
      onChanged: onChanged,
      tabs: [
        for (final entry in tabs.entries)
          ShadTab(
            value: entry.key,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: paneContents[entry.key] ?? const [],
            ),
            child: Text(entry.value),
          ),
      ],
    );
  }
}

/// `widgetType: tooltip`.
class ShadTooltipMapper extends StatelessWidget {
  const ShadTooltipMapper({
    super.key,
    required this.message,
    required this.child,
  });

  final String message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShadTooltip(
      builder: (context) => Text(message),
      child: child,
    );
  }
}

/// Which native overlay a [ShadOverlayTriggerMapper] opens.
enum ShadOverlayKind { sheet, dialog, popover }

/// `widgetType: sheet | dialog | popover` — renders the trigger and opens
/// the native overlay on tap. `open: true` auto-opens once on mount.
class ShadOverlayTriggerMapper extends StatefulWidget {
  const ShadOverlayTriggerMapper({
    super.key,
    required this.kind,
    required this.side,
    required this.title,
    required this.description,
    required this.actions,
    required this.content,
    required this.trigger,
    required this.onOpen,
    required this.autoOpen,
    required this.stateKey,
  });

  final ShadOverlayKind kind;
  final String? side;
  final String? title;
  final String? description;
  final List<Widget> actions;
  final List<Widget> content;
  final Widget? trigger;
  final VoidCallback onOpen;
  final bool autoOpen;
  final String stateKey;

  @override
  State<ShadOverlayTriggerMapper> createState() =>
      _ShadOverlayTriggerMapperState();
}

class _ShadOverlayTriggerMapperState extends State<ShadOverlayTriggerMapper> {
  final ShadPopoverController _popoverController = ShadPopoverController();

  @override
  void initState() {
    super.initState();
    if (widget.autoOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _open());
    }
  }

  @override
  void dispose() {
    _popoverController.dispose();
    super.dispose();
  }

  Future<void> _open() async {
    widget.onOpen();
    switch (widget.kind) {
      case ShadOverlayKind.sheet:
        await showShadSheet<void>(
          context: context,
          side: switch (widget.side) {
            'top' => ShadSheetSide.top,
            'left' => ShadSheetSide.left,
            'right' => ShadSheetSide.right,
            _ => ShadSheetSide.bottom,
          },
          builder: (context) => ShadSheet(
            title: widget.title == null ? null : Text(widget.title!),
            description: widget.description == null
                ? null
                : Text(widget.description!),
            child: Column(children: widget.content),
          ),
        );
      case ShadOverlayKind.dialog:
        await showShadDialog<void>(
          context: context,
          builder: (context) => ShadDialog(
            title: widget.title == null ? null : Text(widget.title!),
            description: widget.description == null
                ? null
                : Text(widget.description!),
            actions: widget.actions,
            child: Column(children: widget.content),
          ),
        );
      case ShadOverlayKind.popover:
        _popoverController.toggle();
    }
  }

  @override
  Widget build(BuildContext context) {
    final trigger = widget.trigger;
    // A Listener, not a GestureDetector: the trigger may itself contain
    // gesture competitors (engine buttons), and the open affordance must
    // not lose the arena to them.
    Widget wrap(Widget child) =>
        Listener(onPointerUp: (_) => _open(), child: child);
    if (widget.kind == ShadOverlayKind.popover) {
      return ShadPopover(
        controller: _popoverController,
        popover: (context) => Column(children: widget.content),
        child: trigger == null ? const SizedBox.shrink() : wrap(trigger),
      );
    }
    if (trigger == null) {
      // No trigger: render nothing — the overlay is host/action-driven.
      return const SizedBox.shrink();
    }
    return wrap(trigger);
  }
}

/// `widgetType: toast` — renders the toast card inline; overlay
/// presentation through the host's ShadToaster is the host's choice.
class ShadToastMapper extends StatelessWidget {
  const ShadToastMapper({
    super.key,
    required this.title,
    required this.description,
    required this.variant,
  });

  final String title;
  final String? description;
  final String? variant;

  @override
  Widget build(BuildContext context) {
    // The engine `ShadToast` carries primary|destructive only; the other
    // wire variants (success/warning/info) have no engine equivalent yet
    // and fall back to primary — do not assume they are wired through.
    // `action` is intentionally not mapped: overlay presentation through
    // the host's ShadToaster is the host's choice (see the class doc).
    return ShadToast.raw(
      variant: variant == 'destructive'
          ? ShadToastVariant.destructive
          : ShadToastVariant.primary,
      title: Text(title),
      description: description == null ? null : Text(description!),
    );
  }
}

// ── structural primitives ──────────────────────────────────────────────

MainAxisAlignment _mainAxis(String? v) => switch (v) {
  'end' => MainAxisAlignment.end,
  'center' => MainAxisAlignment.center,
  'spaceBetween' => MainAxisAlignment.spaceBetween,
  'spaceAround' => MainAxisAlignment.spaceAround,
  'spaceEvenly' => MainAxisAlignment.spaceEvenly,
  _ => MainAxisAlignment.start,
};

CrossAxisAlignment _crossAxis(String? v) => switch (v) {
  'end' => CrossAxisAlignment.end,
  'center' => CrossAxisAlignment.center,
  'stretch' => CrossAxisAlignment.stretch,
  'baseline' => CrossAxisAlignment.baseline,
  _ => CrossAxisAlignment.start,
};

/// `widgetType: row`.
class ShadRowMapper extends StatelessWidget {
  const ShadRowMapper({
    super.key,
    required this.children,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
    required this.gap,
  });

  final List<Widget> children;
  final String? mainAxisAlignment;
  final String? crossAxisAlignment;
  final double? gap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: _mainAxis(mainAxisAlignment),
      crossAxisAlignment: _crossAxis(crossAxisAlignment),
      children: _withGap(children, gap),
    );
  }
}

/// `widgetType: column`.
class ShadColumnMapper extends StatelessWidget {
  const ShadColumnMapper({
    super.key,
    required this.children,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.gap,
  });

  final List<Widget> children;
  final String? mainAxisAlignment;
  final String? crossAxisAlignment;
  final double? gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: _mainAxis(mainAxisAlignment),
      crossAxisAlignment: _crossAxis(crossAxisAlignment),
      children: _withGap(children, gap),
    );
  }
}

List<Widget> _withGap(List<Widget> children, double? gap) {
  if (gap == null || children.length < 2) return children;
  final spacer = SizedBox(width: gap, height: gap);
  return [
    for (var i = 0; i < children.length; i++) ...[
      if (i > 0) spacer,
      children[i],
    ],
  ];
}

/// `widgetType: stack`.
class ShadStackMapper extends StatelessWidget {
  const ShadStackMapper({
    super.key,
    required this.children,
    required this.alignment,
  });

  final List<Widget> children;
  final String? alignment;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: switch (alignment) {
        'topLeft' => AlignmentDirectional.topStart,
        'topCenter' => AlignmentDirectional.topCenter,
        'topRight' => AlignmentDirectional.topEnd,
        'centerLeft' => AlignmentDirectional.centerStart,
        'centerRight' => AlignmentDirectional.centerEnd,
        'bottomLeft' => AlignmentDirectional.bottomStart,
        'bottomCenter' => AlignmentDirectional.bottomCenter,
        'bottomRight' => AlignmentDirectional.bottomEnd,
        _ => AlignmentDirectional.center,
      },
      children: children,
    );
  }
}

/// `widgetType: padding`.
class ShadPaddingMapper extends StatelessWidget {
  const ShadPaddingMapper({super.key, required this.padding, this.child});

  final PaddingSpec padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final spec = padding.all != null
        ? EdgeInsets.all(padding.all!)
        : EdgeInsets.fromLTRB(
            padding.left,
            padding.top,
            padding.right,
            padding.bottom,
          );
    return Padding(padding: spec, child: child);
  }
}

/// `widgetType: expanded`.
class ShadExpandedMapper extends StatelessWidget {
  const ShadExpandedMapper({super.key, this.flex, required this.child});

  final int? flex;
  final Widget child;

  @override
  Widget build(BuildContext context) => Expanded(flex: flex ?? 1, child: child);
}

/// `widgetType: sizedBox`.
class ShadSizedBoxMapper extends StatelessWidget {
  const ShadSizedBoxMapper({super.key, this.width, this.height, this.child});

  final double? width;
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) =>
      SizedBox(width: width, height: height, child: child);
}

/// `widgetType: listView`.
class ShadListViewMapper extends StatelessWidget {
  const ShadListViewMapper({
    super.key,
    required this.children,
    required this.spacing,
    required this.shrinkWrap,
    required this.reverse,
  });

  final List<Widget> children;
  final double? spacing;
  final bool? shrinkWrap;
  final bool? reverse;

  @override
  Widget build(BuildContext context) {
    if (spacing == null) {
      return ListView(
        shrinkWrap: shrinkWrap ?? false,
        reverse: reverse ?? false,
        children: children,
      );
    }
    return ListView.separated(
      shrinkWrap: shrinkWrap ?? false,
      reverse: reverse ?? false,
      itemBuilder: (context, index) => children[index],
      separatorBuilder: (context, index) => SizedBox(height: spacing),
      itemCount: children.length,
    );
  }
}

/// `widgetType: image`.
class ShadImageMapper extends StatelessWidget {
  const ShadImageMapper({
    super.key,
    required this.src,
    required this.fit,
    required this.width,
    required this.height,
    required this.alt,
  });

  final String src;
  final String? fit;
  final double? width;
  final double? height;
  final String? alt;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      src,
      width: width,
      height: height,
      fit: switch (fit) {
        'contain' => BoxFit.contain,
        'fill' => BoxFit.fill,
        'fitWidth' => BoxFit.fitWidth,
        'fitHeight' => BoxFit.fitHeight,
        'none' => BoxFit.none,
        'scaleDown' => BoxFit.scaleDown,
        _ => BoxFit.cover,
      },
      semanticLabel: alt,
      errorBuilder: (context, error, stackTrace) => SizedBox(
        width: width ?? 100,
        height: height ?? 100,
        child: const ColoredBox(color: Color(0x11000000)),
      ),
    );
  }
}

/// `widgetType: icon`.
class ShadIconMapper extends StatelessWidget {
  const ShadIconMapper({
    super.key,
    required this.name,
    required this.size,
    required this.style,
  });

  final String name;
  final double? size;
  final String? style;

  @override
  Widget build(BuildContext context) {
    final scheme = ShadTheme.of(context).colorScheme;
    return Icon(
      resolveLucideIcon(name),
      size: size,
      color: switch (style) {
        'destructive' => scheme.destructive,
        'primary' => scheme.primary,
        'secondary' => scheme.secondary,
        'muted' => scheme.mutedForeground,
        'card' => scheme.cardForeground,
        'accent' => scheme.accentForeground,
        _ => scheme.foreground,
      },
    );
  }
}

/// Resolves a wire icon name (kebab or snake case) to the Lucide glyph.
/// Unknown names fall back to `circleAlert` and never throw.
IconData resolveLucideIcon(String name) {
  // lowerCamel: the first word stays lowercase so 'chevron-right' becomes
  // 'chevronRight' — the exact key shape of `_lucideByCamel`.
  final parts = name.split(RegExp('[-_]'));
  final camel = parts.isEmpty || parts.first.isEmpty
      ? ''
      : parts.first +
            parts
                .skip(1)
                .map(
                  (part) => part.isEmpty
                      ? ''
                      : part[0].toUpperCase() + part.substring(1),
                )
                .join();
  return _lucideByCamel[camel] ?? LucideIcons.circleAlert;
}

/// Curated subset of the Lucide vocabulary (kebab-to-camel wire names).
/// Extending it is additive; unknown names fall back to `circleAlert` and
/// never throw.
final Map<String, IconData> _lucideByCamel = _buildLucideMap();

Map<String, IconData> _buildLucideMap() => {
  'plus': LucideIcons.plus,
  'minus': LucideIcons.minus,
  'check': LucideIcons.check,
  'x': LucideIcons.x,
  'search': LucideIcons.search,
  'settings': LucideIcons.settings,
  'user': LucideIcons.user,
  'users': LucideIcons.users,
  'home': LucideIcons.home,
  'menu': LucideIcons.menu,
  'chevronRight': LucideIcons.chevronRight,
  'chevronLeft': LucideIcons.chevronLeft,
  'chevronDown': LucideIcons.chevronDown,
  'chevronUp': LucideIcons.chevronUp,
  'circleAlert': LucideIcons.circleAlert,
  'circleCheck': LucideIcons.circleCheck,
  'info': LucideIcons.info,
  'trash': LucideIcons.trash,
  'pencil': LucideIcons.pencil,
  'download': LucideIcons.download,
  'upload': LucideIcons.upload,
  'star': LucideIcons.star,
  'heart': LucideIcons.heart,
  'bell': LucideIcons.bell,
  'calendar': LucideIcons.calendar,
  'clock': LucideIcons.clock,
  'mail': LucideIcons.mail,
  'phone': LucideIcons.phone,
  'image': LucideIcons.image,
  'camera': LucideIcons.camera,
  'arrowRight': LucideIcons.arrowRight,
  'arrowLeft': LucideIcons.arrowLeft,
  'arrowUp': LucideIcons.arrowUp,
  'arrowDown': LucideIcons.arrowDown,
  'logOut': LucideIcons.logOut,
  'filter': LucideIcons.filter,
  'eye': LucideIcons.eye,
  'eyeOff': LucideIcons.eyeOff,
  'lock': LucideIcons.lock,
  'copy': LucideIcons.copy,
  'share': LucideIcons.share,
  'play': LucideIcons.play,
  'pause': LucideIcons.pause,
  'loaderCircle': LucideIcons.loaderCircle,
};

/// Debug placeholder for `UnknownNode` (FR-9): visible, labeled, and
/// impossible to confuse with real content.
class ShadUnknownPlaceholderMapper extends StatelessWidget {
  const ShadUnknownPlaceholderMapper({super.key, required this.widgetType});

  final String widgetType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x33000000)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text('unknown widget: $widgetType'),
    );
  }
}
