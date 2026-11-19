// The UINode layer barrel: nodes, tree tooling, actions, renderer.
//
// Every public name of the layer must be exported here exactly once.
export 'actions/ui_action_handler.dart';
// $$ShadNode is the codegen-only written abstract; the sealed
// ShadNode it generates is the public union type.
export 'nodes/nodes.dart' hide $$ShadNode;
export 'nodes/props.dart';
export 'render/renderer_scope.dart';
export 'render/shad_node_renderer.dart';
export 'tree/canonical_json.dart';
export 'tree/shad_node_parser.dart';
export 'tree/shad_node_tree.dart';
export 'tree/ui_errors.dart';
