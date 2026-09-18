import 'package:flutter/widgets.dart';
import 'package:zuraffa_ui/src/components/toast.dart';
import 'package:zuraffa_ui/src/identified/contract/skin_contract_kit.dart';
import 'package:zuraffa_ui/src/identified/mapping/zfa_engine_aliases.dart';

/// The certified toaster of the skin lane.
///
/// Wraps [ShadToaster] with the typed contract protocol
/// (`contractId == 'zfa.toaster'`, [contractEnabled]).
///
/// ZuraffaApp already mounts a toaster through the engine's app shell, so
/// most skins never construct this directly. Mount it yourself only when you
/// build a custom app shell: place it in your app's `builder`, exactly where
/// the engine places it.
///
/// ```dart
/// ShadApp(
///   builder: (context, child) => ZfaToaster(child: child!),
///   home: ...,
/// )
/// ```
class ZfaToaster extends StatelessWidget with ZfaContract {
  /// Creates a certified toaster wrapping [child].
  const ZfaToaster({
    super.key,
    required this.child,
    this.contractEnabled = true,
  });

  /// The widget below the toaster, over which toasts are displayed.
  final Widget child;

  /// The [ZfaToasterState] of the nearest [ZfaToaster] ancestor — the same
  /// seam as [ShadToaster.of], so toasts go through certified names:
  ///
  /// ```dart
  /// ZfaToaster.of(context).show(ZfaToast(title: const Text('Saved')));
  /// ```
  static ZfaToasterState of(BuildContext context) => ShadToaster.of(context);

  @override
  String get contractId => 'zfa.toaster';

  @override
  final bool contractEnabled;

  @override
  Widget build(BuildContext context) {
    return ShadToaster(child: child);
  }
}
