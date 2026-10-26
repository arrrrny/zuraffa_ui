/// The UINode surface: every certified component as serializable data.
///
/// Import this library for the generative-UI substrate —
/// `json → node tree → widget tree` and back:
///
/// ```dart
/// import 'package:zuraffa_ui/uinode.dart';
///
/// final tree = ShadNodeParser().parse(jsonString);
/// ShadNodeRenderer(tree: tree, actions: UiActionRegistry());
/// ```
///
/// Also re-exported from `package:zuraffa_ui/zfa.dart`. The wire contract
/// (node names, JSON shapes, action IDs) is cross-repo: zuraffa and
/// zuraffa_agent build on it — changes are breaking changes.
library;

export 'src/uinode/uinode.dart';
