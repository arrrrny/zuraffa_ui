import 'package:flutter/material.dart';

import 'package:zuraffa_ui/src/components/dialog.dart';
import 'package:zuraffa_ui/src/identified/contract/skin_contract_kit.dart';

/// The certified dialog of the skin lane.
///
/// Wraps [ShadDialog] with the typed contract protocol
/// (`contractId == 'zfa.dialog'`, [contractEnabled]). Use [ZfaDialog.show]
/// to present it imperatively, wrapping [showShadDialog].
///
/// The build places a chrome-neutral Flutter [Dialog] around [ShadDialog]
/// so Flutter's canonical `byType(Dialog)` scope resolves the certified
/// dialog (zuraffa_ui#43).
///
/// ```dart
/// ZfaDialog.show(
///   context,
///   title: const Text('Delete skin?'),
///   child: const Text('This cannot be undone.'),
/// );
/// ```
class ZfaDialog extends StatelessWidget with ZfaContract {
  /// Creates a certified dialog.
  const ZfaDialog({
    super.key,
    this.title,
    this.description,
    this.child,
    this.actions = const [],
    this.contractEnabled = true,
  });

  /// The title widget displayed at the top of the dialog.
  final Widget? title;

  /// The description widget displayed below the title.
  final Widget? description;

  /// The main content of the dialog.
  final Widget? child;

  /// The action widgets displayed at the bottom of the dialog.
  final List<Widget> actions;

  @override
  String get contractId => 'zfa.dialog';

  @override
  final bool contractEnabled;

  /// Presents this dialog modally, wrapping [showShadDialog].
  static Future<T?> show<T>(
    BuildContext context, {
    Widget? title,
    Widget? description,
    Widget? child,
    List<Widget> actions = const [],
  }) {
    return showShadDialog<T>(
      context: context,
      builder: (_) => ZfaDialog(
        title: title,
        description: description,
        actions: actions,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // Flutter-canonical dialog scope (zuraffa_ui#43): ShadDialog paints
      // the entire surface, so this Dialog contributes no chrome of its own
      // (transparent, no elevation, zero insets and constraints) — it exists
      // so the byType(Dialog)-scoped finders certification tests rely on
      // resolve the certified dialog. Dialog also consumes the keyboard
      // viewInsets exactly once (its AnimatedPadding), matching the single
      // shift ShadDialog applied on its own before this wrapper.
      backgroundColor: Colors.transparent,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.none,
      constraints: const BoxConstraints(),
      child: ShadDialog(
        title: title,
        description: description,
        actions: actions,
        child: child,
      ),
    );
  }
}
