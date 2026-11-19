import 'package:flutter/widgets.dart';

import 'package:zuraffa_ui/src/uinode/actions/ui_action_handler.dart';
import 'package:zuraffa_ui/src/uinode/nodes/nodes.dart';
import 'package:zuraffa_ui/src/uinode/nodes/props.dart';
import 'package:zuraffa_ui/src/uinode/render/node_mappers.dart';
import 'package:zuraffa_ui/src/uinode/render/renderer_scope.dart';
import 'package:zuraffa_ui/src/uinode/tree/shad_node_tree.dart';
import 'package:zuraffa_ui/src/uinode/tree/ui_errors.dart';

export 'renderer_scope.dart' show NodeRenderScope;

/// Maps a [ShadNodeTree] to a native widget tree (spec 1100 FR-10).
///
/// One mapper per node kind, mirroring each component's canonical usage
/// from the repo's own docs/skill. Interactive state is lifted into the
/// enclosing [NodeRenderScope]; theme-token references resolve through the
/// ambient theme at render time (FR-5).
/// What a node mapper needs from its enclosing renderer — the public seam
/// between [ShadNodeRenderer]'s state and the mapper tree.
abstract class ShadNodeRenderHost {
  /// The registry action IDs dispatch against (FR-6).
  UiActionRegistry get actions;

  /// Whether unknown nodes render a visible debug placeholder (FR-9).
  bool get debugFallbacks;

  /// Reports a render event (e.g. unknown node omitted in release).
  void publishEvent(UiNodeEvent event);
}

class ShadNodeRenderer extends StatefulWidget {
  // Not const: the default registry is a fresh mutable instance.
  ShadNodeRenderer({
    super.key,
    required this.tree,
    UiActionRegistry? actions,
    this.debugFallbacks = true,
    this.onNodeEvent,
  }) : actions = actions ?? UiActionRegistry();

  /// The tree to render.
  final ShadNodeTree tree;

  /// Host handler registry for action IDs (FR-6/FR-7).
  final UiActionRegistry actions;

  /// Debug-mode fallback for unknown nodes: a visible placeholder when
  /// true (default), omitted-with-event when false (release hosts).
  final bool debugFallbacks;

  /// Observes render events, e.g. an unknown node omitted in release mode.
  final ValueChanged<UiNodeEvent>? onNodeEvent;

  @override
  State<ShadNodeRenderer> createState() => _ShadNodeRendererState();
}

class _ShadNodeRendererState extends State<ShadNodeRenderer>
    implements ShadNodeRenderHost {
  final Map<String, Object?> _store = {};

  @override
  UiActionRegistry get actions => widget.actions;

  @override
  bool get debugFallbacks => widget.debugFallbacks;

  @override
  void publishEvent(UiNodeEvent event) => widget.onNodeEvent?.call(event);

  @override
  Widget build(BuildContext context) {
    return NodeRenderScope(
      store: _store,
      child: ShadNodeMapper(
        renderer: this,
        path: 'root',
        node: widget.tree.root,
      ),
    );
  }
}

/// The recursive render step: resolves one node against the renderer's
/// action registry, scope store, and event channel.
class ShadNodeMapper extends StatelessWidget {
  const ShadNodeMapper({
    super.key,
    required ShadNodeRenderHost renderer,
    required this.path,
    required this.node,
  }) : _host = renderer;

  final ShadNodeRenderHost _host;
  final String path;
  final ShadNode node;

  /// The enclosing renderer's host seam (registry, fallbacks, events).
  ShadNodeRenderHost get renderer => _host;

  @override
  Widget build(BuildContext context) {
    return switch (node) {
      ButtonNode() => _button(context),
      BadgeNode(:final label, :final variant) => ShadBadgeMapper(
        label: label,
        variant: variant,
      ),
      TextNode(:final text, :final style, :final align) => ShadTextMapper(
        text: text,
        style: style,
        align: align,
      ),
      CardNode() => _card(context),
      CardHeaderNode(:final title, :final description) => ShadCardHeaderMapper(
        title: title,
        description: description,
      ),
      CardFooterNode(:final content) => ShadCardFooterMapper(
        content: _children(context, content, 'content'),
      ),
      InputNode() => _input(context),
      SelectNode() => _select(context),
      SelectOptionNode(:final label) => ShadTextMapper(text: label),
      CheckboxNode() => _checkbox(context),
      SwitchNode() => _switch(context),
      RadioGroupNode() => _radioGroup(context),
      RadioOptionNode(:final label) => ShadTextMapper(text: label),
      FormItemNode() => _formItem(context),
      TabsNode() => _tabs(context),
      TabNode(:final label) => ShadTextMapper(text: label),
      TabPaneNode(:final content) => ShadColumnMapper(
        children: _children(context, content, 'content'),
      ),
      ProgressNode(:final value, :final indeterminate) => ShadProgressMapper(
        value: indeterminate ?? false ? null : value,
      ),
      SeparatorNode(:final orientation) => ShadSeparatorMapper(
        orientation: orientation,
      ),
      TooltipNode() => _tooltip(context),
      SheetNode() => _sheet(context),
      DialogNode() => _dialog(context),
      PopoverNode() => _popover(context),
      ToastNode(:final title, :final description, :final variant) =>
        ShadToastMapper(
          title: title,
          description: description,
          variant: variant,
        ),
      RowNode(
        :final mainAxisAlignment,
        :final crossAxisAlignment,
        :final gap,
        :final children,
      ) =>
        ShadRowMapper(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          gap: gap,
          children: _children(context, children, 'children'),
        ),
      ColumnNode(
        :final mainAxisAlignment,
        :final crossAxisAlignment,
        :final gap,
        :final children,
      ) =>
        ShadColumnMapper(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          gap: gap,
          children: _children(context, children, 'children'),
        ),
      StackNode(:final alignment, :final children) => ShadStackMapper(
        alignment: alignment,
        children: _children(context, children, 'children'),
      ),
      PaddingNode(:final padding, :final child) => ShadPaddingMapper(
        padding: padding,
        child: _child(context, child, 'child'),
      ),
      ExpandedNode(:final flex, :final child) => ShadExpandedMapper(
        flex: flex,
        child: ShadNodeMapper(
          renderer: renderer,
          path: '$path/child',
          node: child,
        ),
      ),
      SizedBoxNode(:final width, :final height, :final child) =>
        ShadSizedBoxMapper(
          width: width,
          height: height,
          child: _child(context, child, 'child'),
        ),
      ListViewNode(
        :final spacing,
        :final shrinkWrap,
        :final reverse,
        :final children,
      ) =>
        ShadListViewMapper(
          spacing: spacing,
          shrinkWrap: shrinkWrap,
          reverse: reverse,
          children: _children(context, children, 'children'),
        ),
      ImageNode(
        :final src,
        :final fit,
        :final width,
        :final height,
        :final alt,
      ) =>
        ShadImageMapper(
          src: src,
          fit: fit,
          width: width,
          height: height,
          alt: alt,
        ),
      IconNode(:final name, :final size, :final style) => ShadIconMapper(
        name: name,
        size: size,
        style: style,
      ),
      UnknownNode() => _unknown(context),
    };
  }

  // ── plumbing ─────────────────────────────────────────────────────────

  UiActionRegistry get _actions => renderer.actions;

  void _dispatch(ActionId? action) {
    if (action == null) return;
    _actions.dispatch(action.name, action.args);
  }

  String get _stateKey => node.id ?? path;

  ShadNodeMapper? _child(BuildContext context, ShadNode? n, String key) =>
      n == null
      ? null
      : ShadNodeMapper(
          renderer: renderer,
          path: '$path/$key',
          node: n,
        );

  List<Widget> _children(
    BuildContext context,
    List<ShadNode> nodes,
    String key,
  ) => [
    for (var i = 0; i < nodes.length; i++)
      ShadNodeMapper(
        renderer: renderer,
        path: '$path/$key[$i]',
        node: nodes[i],
      ),
  ];

  // ── basic components ─────────────────────────────────────────────────

  Widget _button(BuildContext context) {
    final n = node as ButtonNode;
    return ShadButtonMapper(
      label: n.label,
      variant: n.variant,
      size: n.size,
      onPressed: () => _dispatch(n.action),
    );
  }

  Widget _card(BuildContext context) {
    final n = node as CardNode;
    return ShadCardMapper(
      title: n.title,
      description: n.description,
      content: _children(context, n.content, 'content'),
      header: _child(context, n.header, 'header'),
      footer: _child(context, n.footer, 'footer'),
    );
  }

  // ── form components ──────────────────────────────────────────────────

  Widget _input(BuildContext context) {
    final n = node as InputNode;
    return ShadInputMapper(
      initial: NodeRenderScope.state<String>(context, _stateKey) ?? n.value,
      placeholder: n.placeholder,
      label: n.label,
      helper: n.helper,
      errorText: n.errorText,
      enabled: n.enabled,
      obscure: n.obscure,
      keyboard: n.keyboard,
      onChanged: (v) => NodeRenderScope.put(context, _stateKey, v),
      onSubmit: () => _dispatch(n.action),
    );
  }

  Widget _select(BuildContext context) {
    final n = node as SelectNode;
    return ShadSelectMapper(
      initial: NodeRenderScope.state<String>(context, _stateKey) ?? n.value,
      placeholder: n.placeholder,
      label: n.label,
      enabled: n.enabled,
      options: {for (final o in n.options) o.value: o.label},
      onChanged: (v) => NodeRenderScope.put(context, _stateKey, v),
    );
  }

  Widget _checkbox(BuildContext context) {
    final n = node as CheckboxNode;
    return ShadCheckboxMapper(
      initial:
          NodeRenderScope.state<bool>(context, _stateKey) ?? n.value ?? false,
      label: n.label,
      enabled: n.enabled,
      onChanged: (v) {
        NodeRenderScope.put(context, _stateKey, v);
        _dispatch(n.action);
      },
    );
  }

  Widget _switch(BuildContext context) {
    final n = node as SwitchNode;
    return ShadSwitchMapper(
      initial:
          NodeRenderScope.state<bool>(context, _stateKey) ?? n.value ?? false,
      label: n.label,
      enabled: n.enabled,
      onChanged: (v) {
        NodeRenderScope.put(context, _stateKey, v);
        _dispatch(n.action);
      },
    );
  }

  Widget _radioGroup(BuildContext context) {
    final n = node as RadioGroupNode;
    return ShadRadioGroupMapper(
      initial: NodeRenderScope.state<String>(context, _stateKey) ?? n.value,
      options: {for (final o in n.options) o.value: o.label},
      onChanged: (v) {
        NodeRenderScope.put(context, _stateKey, v);
        _dispatch(n.action);
      },
    );
  }

  Widget _formItem(BuildContext context) {
    final n = node as FormItemNode;
    return ShadFormItemMapper(
      label: n.label,
      helper: n.helper,
      errorText: n.errorText,
      required_: n.required_,
      field: ShadNodeMapper(
        renderer: renderer,
        path: '$path/field',
        node: n.field,
      ),
    );
  }

  // ── overlay components ───────────────────────────────────────────────

  Widget _tabs(BuildContext context) {
    final n = node as TabsNode;
    return ShadTabsMapper(
      initial: NodeRenderScope.state<String>(context, _stateKey) ?? n.value,
      tabs: {for (final t in n.tabs) t.value: t.label},
      paneContents: {
        for (var i = 0; i < n.panes.length; i++)
          n.panes[i].value: _children(
            context,
            n.panes[i].content,
            'panes[$i]',
          ),
      },
      onChanged: (v) {
        NodeRenderScope.put(context, _stateKey, v);
        _dispatch(n.action);
      },
    );
  }

  Widget _tooltip(BuildContext context) {
    final n = node as TooltipNode;
    return ShadTooltipMapper(
      message: n.message,
      // Hand-built trees may carry a null child (the entity allows it);
      // degrade to an empty box instead of crashing the build.
      child: _child(context, n.child, 'child') ?? const SizedBox.shrink(),
    );
  }

  Widget _sheet(BuildContext context) {
    final n = node as SheetNode;
    return ShadOverlayTriggerMapper(
      kind: ShadOverlayKind.sheet,
      side: n.side,
      title: n.title,
      description: n.description,
      actions: const [],
      content: _children(context, n.content, 'content'),
      trigger: _child(context, n.trigger, 'trigger'),
      onOpen: () => _dispatch(n.action),
      autoOpen: n.open ?? false,
      stateKey: _stateKey,
    );
  }

  Widget _dialog(BuildContext context) {
    final n = node as DialogNode;
    return ShadOverlayTriggerMapper(
      kind: ShadOverlayKind.dialog,
      side: null,
      title: n.title,
      description: n.description,
      actions: _children(context, n.actions, 'actions'),
      content: _children(context, n.content, 'content'),
      trigger: _child(context, n.trigger, 'trigger'),
      onOpen: () => _dispatch(n.action),
      autoOpen: n.open ?? false,
      stateKey: _stateKey,
    );
  }

  Widget _popover(BuildContext context) {
    final n = node as PopoverNode;
    return ShadOverlayTriggerMapper(
      kind: ShadOverlayKind.popover,
      side: null,
      title: null,
      description: null,
      actions: const [],
      content: _children(context, n.content, 'content'),
      trigger: _child(context, n.trigger, 'trigger'),
      onOpen: () => _dispatch(n.action),
      autoOpen: n.open ?? false,
      stateKey: _stateKey,
    );
  }

  // ── degradation ──────────────────────────────────────────────────────

  Widget _unknown(BuildContext context) {
    final n = node as UnknownNode;
    if (renderer.debugFallbacks) {
      return ShadUnknownPlaceholderMapper(widgetType: n.widgetType);
    }
    renderer.publishEvent(
      UiNodeEvent(kind: 'unknownNodeOmitted', path: path),
    );
    return const SizedBox.shrink();
  }
}
