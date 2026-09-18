# Data Model: 1100-uinode-system

Phase 1 output. Entities, fields, validation rules, and state transitions.
Node props are **data only**; token references are plain strings resolved at
render time.

## Envelope

### ShadNodeTree

| Field | Type | Rules |
|---|---|---|
| schemaVersion | int | ≥ 1; runtime refuses newer *major* with `UiVersionError`; absent on input → current |
| root | `$$ShadNode` | exactly one root node |

## Node union (`$$ShadNode` sealed base)

Every node carries `widgetType` (const per class, the wire discriminator
Zorphy's polymorphic `fromJson` reads as `__typename`) and optional
`id` (host-stable identity for action targets / controller binding).

### Component nodes (18)

| Node | Key props (all optional unless noted) | Children |
|---|---|---|
| ButtonNode | label (String), variant (`primary/secondary/destructive/outline/ghost/link`), size (`sm/md/lg`), leading/trailing (IconNode ref), action (ActionId) | — |
| BadgeNode | label (String, required), variant (`default/secondary/destructive/outline`) | — |
| TextNode | text (String, required), style token (`h1…h4, p, muted, small, large, bold`), align | — |
| CardNode | title, description, style token | header: CardHeaderNode?, content: `$$ShadNode` list, footer: CardFooterNode? |
| InputNode | value, placeholder, label, helper, errorText, enabled, obscure, keyboardType name, action (submit) | — |
| SelectNode | value, placeholder, label, options: [SelectOptionNode{value,label,enabled}], enabled | — |
| CheckboxNode | value (bool), label, enabled, action (change) | — |
| SwitchNode | value (bool), label, enabled, action (change) | — |
| RadioGroupNode | value, options: [RadioOptionNode{value,label,enabled}], enabled, action (change) | — |
| FormItemNode | label, helper, errorText, required | field: exactly one input/select/checkbox/switch/radio-group |
| TabsNode | value (active tab), tabs: [TabNode{value,label,enabled,action}], action (change) | panes: [TabPaneNode{value, content: `$$ShadNode` list}] |
| ProgressNode | value (0..1, required), indeterminate | — |
| SeparatorNode | orientation (`horizontal/vertical`), thickness | — |
| TooltipNode | message (String, required) | child: exactly one node |
| SheetNode | side (`top/bottom/left/right`), title, description, open (bool), action (open/close) | content: `$$ShadNode` list; trigger: `$$ShadNode`? |
| DialogNode | title, description, open (bool), actions: [ButtonNode], action (open/close) | content: `$$ShadNode` list; trigger: `$$ShadNode`? |
| PopoverNode | open (bool), action (open/close) | content: `$$ShadNode` list; trigger: `$$ShadNode`? |
| ToastNode | title, description, variant (`default/destructive/success/warning/info`), action (show) | — |

### Structural nodes (9)

| Node | Key props | Children |
|---|---|---|
| RowNode / ColumnNode | mainAxisAlignment, crossAxisAlignment, mainAxisSize, gap (double) | children: `$$ShadNode` list |
| StackNode | alignment, fit | children |
| PaddingNode | padding (logical, double per edge) | child: exactly one |
| ExpandedNode | flex (int ≥ 1) | child: exactly one |
| SizedBoxNode | width, height | child: exactly one (optional) |
| ListViewNode | shrinkWrap, reverse, spacing | children |
| ImageNode | src (String, required), fit name, width, height, alt | — |
| IconNode | name (Lucide name, String, required), size, style token | — |

### UnknownNode

| Field | Rules |
|---|---|
| widgetType (String, required) | the unrecognized discriminator |
| raw (Map) | the untouched original object; round-trip must preserve it |

## Value objects

- **ActionId**: `{action: String (required, non-empty), args: Map<String,dynamic> (optional)}` — opaque to this layer.
- **TokenRef**: plain String matching `^[a-zA-Z][a-zA-Z0-9_]*$`; resolved
  against `ShadTheme` at render (color tokens, text styles, radius/size
  scales). A raw color value (`#rrggbb`, `0xFF…`, `{r,g,b}` object) is a
  validation error (UiParseError.kind=colorRejected).
- **Enum props**: stored as their wire strings; parser validates membership.

## Validation rules (parser, single walk)

1. Envelope: `schemaVersion` check → `UiVersionError`.
2. Walk: unknown `widgetType` → `UnknownNode` (tolerated, counted as 1 node).
3. Caps: depth > maxDepth / count > maxNodes / text length > maxTextLength →
   `UiTreeTooLarge{cap, path}` (first violation wins).
4. Node schema: unknown keys → error naming path; wrong type / bad enum →
   error naming path; exactly-one-child violations → error.
5. Colors: any prop matching the color-shaped grammar → `UiParseError`.

## State transitions

- **Parse**: `json → (ok: ShadNodeTree)` | `(UiParseException)` — never
  partial trees.
- **Render**: tree (+ registry) → widget tree; interactive nodes hold state
  in the scope keyed by node path; host ids override.
- **Action**: interaction → registry lookup → (invoke | onUnknownAction |
  onHandlerError); no state change unless a handler mutates the host app or
  an `open` prop toggles via the renderer scope.
- **Round-trip**: `canonical(tree) → parse → canonical` byte-identical;
  `parse(canonical(tree)) == tree` (Zorphy equality).
