import 'package:flutter/widgets.dart';

import 'package:zuraffa_ui/src/components/sheet.dart';
import 'package:zuraffa_ui/src/identified/contract/skin_contract_kit.dart';

/// The certified sheet of the skin lane.
///
/// Wraps [ShadSheet] with the typed contract protocol
/// (`contractId == 'zfa.sheet'`, [contractEnabled]). Use [ZfaSheet.show] to
/// present it imperatively, wrapping [showShadSheet].
///
/// ```dart
/// ZfaSheet.show(
///   context,
///   title: const Text('Filters'),
///   child: const Text('...'),
/// );
/// ```
class ZfaSheet extends StatelessWidget with ZfaContract {
  /// Creates a certified sheet.
  const ZfaSheet({
    super.key,
    this.title,
    this.description,
    this.child,
    this.actions = const [],
    this.contractEnabled = true,
  });

  /// The title widget displayed at the top of the sheet.
  final Widget? title;

  /// The description widget displayed below the title.
  final Widget? description;

  /// The main content of the sheet.
  final Widget? child;

  /// The action widgets displayed at the bottom of the sheet.
  final List<Widget> actions;

  @override
  String get contractId => 'zfa.sheet';

  @override
  final bool contractEnabled;

  /// Presents this sheet modally, wrapping [showShadSheet].
  static Future<T?> show<T>(
    BuildContext context, {
    Widget? title,
    Widget? description,
    Widget? child,
    List<Widget> actions = const [],
  }) {
    return showShadSheet<T>(
      context: context,
      builder: (_) => ZfaSheet(
        title: title,
        description: description,
        actions: actions,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShadSheet(
      title: title,
      description: description,
      actions: actions,
      child: child,
    );
  }
}
