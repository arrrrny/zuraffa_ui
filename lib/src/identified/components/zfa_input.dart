import 'package:flutter/widgets.dart';

import 'package:zuraffa_ui/src/components/input.dart';
import 'package:zuraffa_ui/src/identified/contract/skin_contract_kit.dart';

/// The certified text input of the skin lane.
///
/// Wraps [ShadInput] with the typed contract protocol
/// (`contractId == 'zfa.input'`, [contractEnabled]).
///
/// ```dart
/// ZfaInput(
///   controller: email,
///   placeholder: const Text('you@skin.lane'),
///   onChanged: audit,
/// )
/// ```
class ZfaInput extends StatelessWidget with ZfaContract {
  /// Creates a certified text input.
  const ZfaInput({
    super.key,
    this.controller,
    this.initialValue,
    this.placeholder,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.autofocus = false,
    this.focusNode,
    this.padding,
    this.leading,
    this.contractEnabled = true,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// The initial text, used when no [controller] is provided.
  final String? initialValue;

  /// The placeholder shown when the input is empty — a widget, mirroring
  /// [ShadInput.placeholder].
  final Widget? placeholder;

  /// Called when the text changes.
  final ValueChanged<String>? onChanged;

  /// Called when the user submits the input.
  final ValueChanged<String>? onSubmitted;

  /// Whether the input is enabled.
  final bool enabled;

  /// Whether the input is read only.
  final bool readOnly;

  /// Whether to hide the text being edited.
  final bool obscureText;

  /// The keyboard type for the input.
  final TextInputType? keyboardType;

  /// The maximum number of lines the input can display.
  ///
  /// Defaults to `1` (a single-line field), mirroring [ShadInput.maxLines].
  /// Set to `null` or a value greater than `1` for a multiline field.
  final int? maxLines;

  /// The minimum number of lines the input should display.
  ///
  /// Defaults to `null`; must be less than or equal to [maxLines]. Mirrors
  /// [ShadInput.minLines].
  final int? minLines;

  /// Whether the input autofocuses.
  final bool autofocus;

  /// The focus node of the input.
  final FocusNode? focusNode;

  /// The padding around the input's content.
  final EdgeInsetsGeometry? padding;

  /// The widget displayed before the input's text.
  final Widget? leading;

  @override
  String get contractId => 'zfa.input';

  @override
  final bool contractEnabled;

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: controller,
      initialValue: initialValue,
      placeholder: placeholder,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      enabled: enabled,
      readOnly: readOnly,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      autofocus: autofocus,
      focusNode: focusNode,
      padding: padding,
      leading: leading,
    );
  }
}
