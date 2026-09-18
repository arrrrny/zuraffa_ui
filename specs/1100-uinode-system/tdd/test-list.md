---
feature: 1100-uinode-system
loop: outside-in
profile: .specify/memory/tdd-profile.md
spec_criteria: 5
planned_at: cbc4506
updated_at: cbc4506
suite_baseline: green (395 passed, ~6 platform-skipped on macOS @ 47ec3f6 line)
---

# Test List: UINode system — every widget as serializable data

Derived from `spec.md` (SC-1…SC-5, FR-1…FR-16) and `plan.md`/`data-model.md`
(27 node types, parser, canonical writer, renderer, action registry).
Outer-loop behaviors prove the SCs end to end; inner-loop behaviors are
grouped by the owning file under `lib/src/uinode/`.

## Outer loop: acceptance behaviors

| id | behavior                                                                                                          | traces       | kind    | state   | test                                                                        |
| -- | ----------------------------------------------------------------------------------------------------------------- | ------------ | ------- | ------- | --------------------------------------------------------------------------- |
| A1 | Every v1 node type round-trips `tree → canonical JSON → tree` with node equality AND byte-stable canonical output over the seeded prop space | SC-2, FR-13  | example | PENDING | `test/uinode/nodes/round_trip_test.dart` + `test/uinode/canonical_json_test.dart` |
| A2 | ≥20 fixture trees render to matching goldens on the golden-generation platform (Linux; macOS skips per #7) and a token-only restyle changes the render with zero tree edits | SC-3, FR-5, FR-10 | approval | PENDING | `test/uinode/golden_test.dart`                                              |
| A3 | Hostile inputs — unknown widgetType, oversize (depth/count/text), newer schema major, unknown action, throwing handler — produce the spec'd typed outcomes with zero uncaught exceptions | SC-4, FR-7, FR-9, FR-12 | example | PENDING | `test/uinode/parser_test.dart` + `test/uinode/renderer_unknown_test.dart` + `test/uinode/actions_test.dart` |
| A4 | The coverage audit exists and is honest: every public component family is covered (v1 list) or excluded with a tier + reason; the v1 vocabulary set is asserted by test | SC-1, FR-1, FR-2, FR-3 | example | PENDING | `test/uinode/uinode_surface_test.dart` + `specs/1100-uinode-system/coverage-audit.md` |
| A5 | Quality gates: `flutter analyze` zero issues and the no-raw-colors gate passes on all node props                    | SC-5, FR-16  | example | PENDING | `test/uinode/prop_purity_test.dart` + analyzer exit code                     |

## Inner loop: unit behaviors

### `lib/src/uinode/nodes/shad_node.dart`

| id | behavior                                                                                     | traces      | kind    | state   | test                                    |
| -- | -------------------------------------------------------------------------------------------- | ----------- | ------- | ------- | --------------------------------------- |
| U1 | Every node class reports its const `widgetType` discriminator and carries an optional `id`; the union switches exhaustively | FR-4, A4    | example | PENDING | `test/uinode/nodes/union_test.dart`     |
| U2 | `UnknownNode` preserves an unrecognized object's `widgetType` and raw JSON through parse → canonical → parse | FR-9, FR-13 | example | PENDING | `test/uinode/nodes/union_test.dart`     |

### `lib/src/uinode/tree/shad_node_parser.dart`

| id | behavior                                                                                                    | traces       | kind    | state   | test                                  |
| -- | ----------------------------------------------------------------------------------------------------------- | ------------ | ------- | ------- | ------------------------------------- |
| U3 | `parse` accepts a JSON string or a decoded map and yields a `ShadNodeTree` (`schemaVersion`, `root`)         | FR-10, US1   | example | PENDING | `test/uinode/parse_entry_test.dart`   |
| U4 | Schema violations — unknown keys, wrong prop types, bad enum values, wrong child arity — fail with `UiParseError` naming the node path | FR-12, US4   | example | PENDING | `test/uinode/parse_entry_test.dart`   |
| U5 | Unknown `widgetType` parses to `UnknownNode` (tolerated, counted toward caps), siblings unaffected           | FR-9         | example | PENDING | `test/uinode/parse_entry_test.dart`   |
| U6 | Depth > 32, nodes > 500, text > 10 000 each fail with `UiTreeTooLarge` carrying the cap kind and node path   | FR-12, SC-4  | example | PENDING | `test/uinode/parser_test.dart`        |
| U7 | Newer major `schemaVersion` → `UiVersionError`; missing version accepted as current; minor stays parseable   | FR-8, SC-4   | example | PENDING | `test/uinode/parser_test.dart`        |
| U8 | `validate()` reports ok/errors for a tree without building any widgets (report lists every typed error)      | FR-14, SC-2  | example | PENDING | `test/uinode/parser_test.dart`        |

### `lib/src/uinode/tree/canonical_json.dart`

| id | behavior                                                                        | traces      | kind    | state   | test                                       |
| -- | ------------------------------------------------------------------------------- | ----------- | ------- | ------- | ------------------------------------------ |
| U9 | Serializing the same tree twice yields identical bytes; keys follow the documented schema order | FR-13, SC-2 | example | PENDING | `test/uinode/canonical_json_test.dart`     |
| U10 | The contract example (`contracts/uinode-api.md`) round-trips to a byte-exact canonical form | FR-13       | example | PENDING | `test/uinode/canonical_json_test.dart`     |

### `lib/src/uinode/render/` (shad_node_renderer + node_mappers + renderer_scope)

| id | behavior                                                                                                  | traces       | kind    | state   | test                                        |
| -- | --------------------------------------------------------------------------------------------------------- | ------------ | ------- | ------- | ------------------------------------------- |
| U11 | Layout primitives (row, column, stack, padding, expanded, sized box, list view) map to the expected engine widgets with correct arrangement props | FR-10, US1   | example | PENDING | `test/uinode/renderer_base_test.dart`       |
| U12 | Basic components (text, badge, button, card+header/footer, progress, separator, icon, image) map to engine widgets with token-resolved styling (`h1…h4`, `muted`, variants, sizes) | FR-5, FR-10  | example | PENDING | `test/uinode/renderer_basic_test.dart`      |
| U13 | A theme-token restyle changes the rendered styling with zero tree edits                                    | FR-5, SC-3   | example | PENDING | `test/uinode/renderer_basic_test.dart`      |
| U14 | Form nodes (input, select, checkbox, switch, radio-group, form-item) render; toggling/selecting updates renderer-scoped state; two renderers of one tree hold independent state | FR-11, US1   | example | PENDING | `test/uinode/renderer_form_test.dart`       |
| U15 | Overlay nodes (tabs, tooltip, sheet, dialog, popover, toast) render trigger/panes; the `open` prop and tab switching behave | FR-10, FR-11 | example | PENDING | `test/uinode/renderer_overlay_test.dart`    |
| U16 | UnknownNode renders a visible placeholder in debug (`debugFallbacks: true`), is omitted with a `UiNodeEvent` in release (`false`), and never breaks sibling rendering | FR-9, SC-4   | example | PENDING | `test/uinode/renderer_unknown_test.dart`    |

### `lib/src/uinode/actions/ui_action_handler.dart`

| id | behavior                                                                                | traces      | kind    | state   | test                                    |
| -- | ---------------------------------------------------------------------------------------- | ----------- | ------- | ------- | --------------------------------------- |
| U17 | A rendered node's action ID invokes the registered handler with its args on interaction  | FR-6, US2   | example | PENDING | `test/uinode/actions_test.dart`         |
| U18 | An unknown action name surfaces via `onUnknownAction` and does not throw or break siblings | FR-7, SC-4  | example | PENDING | `test/uinode/actions_test.dart`         |
| U19 | A throwing handler surfaces via `onHandlerError` and siblings stay interactive           | FR-7, SC-4  | example | PENDING | `test/uinode/actions_test.dart`         |

### `test/uinode/prop_purity_test.dart` (gate)

| id | behavior                                                                                     | traces      | kind    | state   | test                                    |
| -- | ---------------------------------------------------------------------------------------------- | ----------- | ------- | ------- | --------------------------------------- |
| U20 | No node prop type exposes a raw-color surface (`Color`, `int` RGB, hex strings); the parser rejects color-shaped style values with `UiParseErrorKind.colorRejected` | FR-16, FR-5, SC-5 | example | PENDING | `test/uinode/prop_purity_test.dart`     |

## Counts

- Acceptance (outer): 5 — A1…A5, tracing SC-1…SC-5.
- Unit (inner): 20 — U1…U20, tracing FR-1…FR-16.
- Characterization: 0 (new surface, no legacy to pin).
- Coverage method: example-based with seeded deterministic prop variations
  (research D9); no new test dependencies.
