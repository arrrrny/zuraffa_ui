# UINode Coverage Audit (spec 1100 / SC-1)

Every public zuraffa_ui component family (from
`docs/src/content/docs/Components/`, 38 families) mapped to its UINode
status. Covered = a node class + renderer mapping exists and round-trips.
Exclusions carry a tier and a reason (spec FR-3, research D8).

## Covered — 27 node kinds (24 component + 9 structural)

| Component family | Node kind(s) | Notes |
|---|---|---|
| button | `button` | variants primary/secondary/destructive/outline/ghost/link; sm/lg sizes |
| badge | `badge` | 4 variants |
| card | `card`, `cardHeader`, `cardFooter` | header/footer as children or standalone |
| input | `input` | placeholder/label/helper/error/obscure/keyboard |
| checkbox | `checkbox` | lifted state + change action |
| switch | `switch` | lifted state + change action |
| select | `select`, `selectOption` | option list as data |
| popover | `popover` | ShadPopover controller; trigger tap toggles |
| progress | `progress` | value + indeterminate |
| radio-group | `radioGroup`, `radioOption` | lifted selection + change action |
| separator | `separator` | horizontal/vertical |
| sheet | `sheet` | native showShadSheet; trigger; auto-open via `open` |
| tabs | `tabs`, `tab`, `tabPane` | lifted selection + change action |
| toast | `toast` | inline render; overlay presentation is the host's ShadToaster choice |
| tooltip | `tooltip` | wraps any child |
| dialog | `dialog` | native showShadDialog; action buttons as ButtonNodes |
| form | `formItem` | label/helper/error chrome around a field node |
| — (structural) | `text` | token styles h1–h4/p/muted/small/large/bold |
| — (structural) | `row`, `column`, `stack`, `padding`, `expanded`, `sizedBox`, `listView` | layout primitives |
| — (structural) | `image` | network + error placeholder |
| — (structural) | `icon` | curated Lucide name map; unknown → circleAlert fallback |
| — (forward compat) | `unknown` | preserved raw objects (FR-9) |

The `form` family is covered by `formItem` (chrome + a field node); the
full `ShadForm` validation wiring is a deliberate v1 boundary (see below).

## Excluded — tier 1: simple variants (follow-up wave candidates)

Thin wrappers over already-covered primitives; adding them is additive
(minor schema bump) with no new state model:

| Family | Reason not in v1 |
|---|---|
| avatar | image node + shape; trivial follow-up |
| alert | card + badge composition; trivial follow-up |
| breadcrumb | row of link buttons; needs a nav-action convention first |
| icon-button | button variant; needs an icon-only affordance prop |
| textarea | input with maxLines; trivial follow-up |
| sonner | stacked toasts; needs the host toaster contract first |
| slider | continuous value + drag state model; smallest new state model |

## Excluded — tier 2: interaction-contract-pending

Their interactive state models need their own spec waves (each would grow
this contract materially):

| Family | Reason not in v1 |
|---|---|
| accordion | expand/collapse group state model |
| calendar | date representation (locale/timezone) is a contract decision |
| context-menu | nested menu + position model |
| date-picker | same date-representation question as calendar |
| input-otp | niche multi-cell input state model |
| menubar | nested menu model (shared with context-menu) |
| resizable | panel constraint protocol |
| table | two-dimensional data + cell composition contract |
| time-picker | same date-representation question as calendar |

## Enforceability

`test/uinode/uinode_surface_test.dart` pins the covered `widgetType` set;
`test/uinode/nodes/round_trip_test.dart` proves every covered kind
round-trips; `ShadNodeParser.supportedWidgetTypes` is the runtime query.
Tier-1 additions are minor schema bumps; removals/renames are major bumps
(contracts/uinode-api.md).
