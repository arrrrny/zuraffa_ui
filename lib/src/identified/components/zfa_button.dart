import 'package:flutter/widgets.dart';

import 'package:zuraffa_ui/src/components/button.dart';
import 'package:zuraffa_ui/src/identified/contract/skin_contract_kit.dart';
import 'package:zuraffa_ui/src/identified/mapping/zfa_engine_aliases.dart';

/// The certified button of the skin lane.
///
/// Wraps [ShadButton] with the typed contract protocol
/// (`contractId == 'zfa.button'`, [contractEnabled]). The pilot auditor's
/// duck-typed `.onPressed` probe becomes a typed read.
///
/// Each engine variant has its Zfa counterpart, so a skin never spells an
/// engine name:
///
/// ```dart
/// ZfaButton(
///   onPressed: submit,
///   child: const Text('Continue'),
/// )
///
/// ZfaButton.outline(
///   onPressed: cancel,
///   child: const Text('Cancel'),
/// )
/// ```
class ZfaButton extends StatelessWidget with ZfaContract {
  /// Creates a certified button in the [ZfaButtonVariant.primary] variant.
  const ZfaButton({
    super.key,
    this.onPressed,
    this.child,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.width,
    this.height,
    this.mainAxisAlignment,
    this.contractEnabled = true,
  }) : variant = ZfaButtonVariant.primary;

  /// Creates a certified button with a specified [variant], mirroring
  /// [ShadButton.raw].
  const ZfaButton.raw({
    super.key,
    required this.variant,
    this.onPressed,
    this.child,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.width,
    this.height,
    this.mainAxisAlignment,
    this.contractEnabled = true,
  });

  /// Creates a certified [ZfaButtonVariant.destructive] button.
  const ZfaButton.destructive({
    super.key,
    this.onPressed,
    this.child,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.width,
    this.height,
    this.mainAxisAlignment,
    this.contractEnabled = true,
  }) : variant = ZfaButtonVariant.destructive;

  /// Creates a certified [ZfaButtonVariant.outline] button.
  const ZfaButton.outline({
    super.key,
    this.onPressed,
    this.child,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.width,
    this.height,
    this.mainAxisAlignment,
    this.contractEnabled = true,
  }) : variant = ZfaButtonVariant.outline;

  /// Creates a certified [ZfaButtonVariant.secondary] button.
  const ZfaButton.secondary({
    super.key,
    this.onPressed,
    this.child,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.width,
    this.height,
    this.mainAxisAlignment,
    this.contractEnabled = true,
  }) : variant = ZfaButtonVariant.secondary;

  /// Creates a certified [ZfaButtonVariant.ghost] button.
  const ZfaButton.ghost({
    super.key,
    this.onPressed,
    this.child,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.width,
    this.height,
    this.mainAxisAlignment,
    this.contractEnabled = true,
  }) : variant = ZfaButtonVariant.ghost;

  /// Creates a certified [ZfaButtonVariant.link] button, which requires a
  /// [child] like [ShadButton.link].
  const ZfaButton.link({
    super.key,
    this.onPressed,
    required this.child,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.width,
    this.height,
    this.mainAxisAlignment,
    this.contractEnabled = true,
  }) : variant = ZfaButtonVariant.link;

  /// The engine variant the button renders with.
  final ZfaButtonVariant variant;

  /// {@template ZfaButton.onPressed}
  /// Called when the button is tapped.
  /// {@endtemplate}
  final VoidCallback? onPressed;

  /// The main content of the button.
  final Widget? child;

  /// The widget displayed before [child].
  final Widget? leading;

  /// The widget displayed after [child].
  final Widget? trailing;

  /// Whether the button is enabled.
  final bool enabled;

  /// Whether the button autofocuses.
  final bool autofocus;

  /// The focus node of the button.
  final FocusNode? focusNode;

  /// The fixed width of the button.
  final double? width;

  /// The fixed height of the button.
  final double? height;

  /// How the button's content is aligned along its main axis.
  final MainAxisAlignment? mainAxisAlignment;

  @override
  String get contractId => 'zfa.button';

  @override
  final bool contractEnabled;

  @override
  Widget build(BuildContext context) {
    return ShadButton.raw(
      variant: variant,
      onPressed: onPressed,
      leading: leading,
      trailing: trailing,
      enabled: enabled,
      autofocus: autofocus,
      focusNode: focusNode,
      width: width,
      height: height,
      mainAxisAlignment: mainAxisAlignment,
      child: child,
    );
  }
}
