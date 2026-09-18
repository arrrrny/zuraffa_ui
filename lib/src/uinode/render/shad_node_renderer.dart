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
      BadgeNode() => ShadBadgeMapper(
        label: (node as BadgeNode).label,
        variant: (node as BadgeNode).variant,
      ),
      TextNode() => ShadTextMapper(
        text: (node as TextNode).text,
        style: (node as TextNode).style,
        align: (node as TextNode).align,
      ),
      CardNode() => _card(context),
      CardHeaderNode() => ShadCardHeaderMapper(
        title: (node as CardHeaderNode).title,
        description: (node as CardHeaderNode).description,
      ),
      CardFooterNode() => ShadCardFooterMapper(
        content: _children(
          context,
          (node as CardFooterNode).content,
          'content',
        ),
      ),
      InputNode() => _input(context),
      SelectNode() => _select(context),
      SelectOptionNode() => ShadTextMapper(
        text: (node as SelectOptionNode).label,
      ),
      CheckboxNode() => _checkbox(context),
      SwitchNode() => _switch(context),
      RadioGroupNode() => _radioGroup(context),
      RadioOptionNode() => ShadTextMapper(
        text: (node as RadioOptionNode).label,
      ),
      FormItemNode() => _formItem(context),
      TabsNode() => _tabs(context),
      TabNode() => ShadTextMapper(text: (node as TabNode).label),
      TabPaneNode() => ShadColumnMapper(
        children: _children(context, (node as TabPaneNode).content, 'content'),
      ),
      ProgressNode() => ShadProgressMapper(
        value: (node as ProgressNode).indeterminate ?? false
            ? null
            : (node as ProgressNode).value,
      ),
      SeparatorNode() => ShadSeparatorMapper(
        orientation: (node as SeparatorNode).orientation,
      ),
      TooltipNode() => _tooltip(context),
      SheetNode() => _sheet(context),
      DialogNode() => _dialog(context),
      PopoverNode() => _popover(context),
      ToastNode() => ShadToastMapper(
        title: (node as ToastNode).title,
        description: (node as ToastNode).description,
        variant: (node as ToastNode).variant,
      ),
      RowNode() => ShadRowMapper(
        mainAxisAlignment: (node as RowNode).mainAxisAlignment,
        crossAxisAlignment: (node as RowNode).crossAxisAlignment,
        gap: (node as RowNode).gap,
        children: _children(context, (node as RowNode).children, 'children'),
      ),
      ColumnNode() => ShadColumnMapper(
        mainAxisAlignment: (node as ColumnNode).mainAxisAlignment,
        crossAxisAlignment: (node as ColumnNode).crossAxisAlignment,
        gap: (node as ColumnNode).gap,
        children: _children(context, (node as ColumnNode).children, 'children'),
      ),
      StackNode() => ShadStackMapper(
        alignment: (node as StackNode).alignment,
        children: _children(context, (node as StackNode).children, 'children'),
      ),
      PaddingNode() => ShadPaddingMapper(
        padding: (node as PaddingNode).padding,
        child: _child(context, (node as PaddingNode).child, 'child'),
      ),
      ExpandedNode() => ShadExpandedMapper(
        flex: (node as ExpandedNode).flex,
        child: ShadNodeMapper(
          renderer: renderer,
          path: '$path/child',
          node: (node as ExpandedNode).child,
        ),
      ),
      SizedBoxNode() => ShadSizedBoxMapper(
        width: (node as SizedBoxNode).width,
        height: (node as SizedBoxNode).height,
        child: _child(context, (node as SizedBoxNode).child, 'child'),
      ),
      ListViewNode() => ShadListViewMapper(
        spacing: (node as ListViewNode).spacing,
        shrinkWrap: (node as ListViewNode).shrinkWrap,
        reverse: (node as ListViewNode).reverse,
        children: _children(
          context,
          (node as ListViewNode).children,
          'children',
        ),
      ),
      ImageNode() => ShadImageMapper(
        src: (node as ImageNode).src,
        fit: (node as ImageNode).fit,
        width: (node as ImageNode).width,
        height: (node as ImageNode).height,
        alt: (node as ImageNode).alt,
      ),
      IconNode() => ShadIconMapper(
        name: (node as IconNode).name,
        size: (node as IconNode).size,
        style: (node as IconNode).style,
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
        for (final pane in n.panes)
          pane.value: _children(context, pane.content, 'panes'),
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
      child: ShadNodeMapper(
        renderer: renderer,
        path: '$path/child',
        node: n.child!,
      ),
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
