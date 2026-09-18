---
description: "Task list for feature implementation"
---

# Tasks: UINode system (1100-uinode-system)

**Input**: Design documents from `/specs/1100-uinode-system/`

**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/uinode-api.md, quickstart.md, tdd/test-list.md

**Tests**: MANDATORY — TDD pipeline. Every task carrying `[behavior: <id>]`
is test-first: its test must exist and fail for the right reason before the
matching implementation task starts. Behavior ids refer to
`tdd/test-list.md`.

**Organization**: Grouped by user story (spec.md US1–US4).

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Owning user story (US1–US4)
- `[behavior: …]`: TDD link to tdd/test-list.md — test task (mandatory, red
  first) paired with the implementation task carrying the same ids
- Exact file paths in every description

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Dependencies, layer skeleton, codegen proof

- [ ] T001 Add `zorphy_annotation` to `pubspec.yaml` dependencies and `zorphy` to dev_dependencies; run `flutter pub get`
- [ ] T002 [P] Create the layer skeleton: `lib/src/uinode/uinode.dart` (internal barrel), `lib/uinode.dart` (public export), and add the re-export line to `lib/zfa.dart`
- [ ] T003 Create `lib/src/uinode/nodes/shad_node.dart` with the `$$ShadNode` sealed base (`widgetType`, `id`) and `UnknownNode` (`widgetType`, `raw`); run `dart run build_runner build --delete-conflicting-outputs` and prove generation is clean [behavior-impl: U1, U2]

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Types every story depends on — no behavior yet

- [ ] T004 Create `lib/src/uinode/tree/ui_errors.dart`: sealed `UiParseException` (`path`), `UiTreeTooLarge` (`cap`), `UiVersionError` (`found`), `UiParseError` (`kind`), `UiCapKind` + `UiParseErrorKind` enums, and `UiNodeEvent`
- [ ] T005 [P] Create `lib/src/uinode/actions/ui_action_handler.dart`: `UiActionHandler` typedef and `UiActionRegistry` with the handlers map + `register`/`unregister` (no dispatch yet)
- [ ] T006 [P] Create `lib/src/uinode/tree/shad_node_tree.dart`: `ShadNodeTree` Zorphy entity (`schemaVersion`, `root: $$ShadNode`); regenerate codegen

**Checkpoint**: Foundation ready — US1 can begin

---

## Phase 3: User Story 1 — Agent-authored UI renders as a native widget tree (Priority: P1) 🎯 MVP

**Goal**: `json → ShadNodeTree → widget tree` in one call for all 27 v1 node types, theme-token styled, state lifted.

**Independent Test**: `flutter test test/uinode/` — fixture trees parse and render to the expected engine widgets.

### Behavior tests for US1 (MANDATORY — write first, prove red)

- [ ] T007 [US1] **TEST** Failing union-contract tests in `test/uinode/nodes/union_test.dart`: every node class reports its const `widgetType`, optional `id`, exhaustive switch; `UnknownNode` preserves raw JSON through parse → canonical → parse [behavior: U1, U2]
- [ ] T008 [US1] **TEST** Failing parse-entry tests in `test/uinode/parse_entry_test.dart`: JSON string or decoded map → `ShadNodeTree`; schema violations (unknown key, wrong type, bad enum, bad arity) → `UiParseError` naming the path; unknown `widgetType` → `UnknownNode`, siblings unaffected [behavior: U3, U4, U5]
- [ ] T009 [US1] **TEST** Failing layout-mapping tests in `test/uinode/renderer_base_test.dart`: row/column/stack/padding/expanded/sized-box/list-view fixtures map to the expected engine widgets with correct arrangement props [behavior: U11]
- [ ] T010 [P] [US1] **TEST** Failing basic-component tests in `test/uinode/renderer_basic_test.dart`: text (style tokens h1–h4/p/muted), badge variants, button variants/sizes, card with header/footer, progress, separator, icon (Lucide name), image — correct engine widget + token-resolved styling; a token restyle changes the render with zero tree edits [behavior: U12, U13]
- [ ] T011 [P] [US1] **TEST** Failing form tests in `test/uinode/renderer_form_test.dart`: input, select, checkbox, switch, radio-group, form-item render; toggling/selecting updates renderer-scoped state; two renderers of the same tree hold independent state [behavior: U14]
- [ ] T012 [P] [US1] **TEST** Failing overlay tests in `test/uinode/renderer_overlay_test.dart`: tabs render with active pane and switch on tap; tooltip wraps child; sheet/dialog/popover render trigger+content (open prop honored); toast surfaces via its action [behavior: U15]

### Implementation for US1

- [ ] T013 [US1] Create `lib/src/uinode/nodes/layout_nodes.dart`: RowNode, ColumnNode, StackNode, PaddingNode, ExpandedNode, SizedBoxNode, ListViewNode, ImageNode, IconNode (per data-model.md); regenerate codegen [behavior-impl: U11]
- [ ] T014 [P] [US1] Create `lib/src/uinode/nodes/basic_nodes.dart`: TextNode, BadgeNode, ButtonNode, CardNode + CardHeaderNode + CardFooterNode, ProgressNode, SeparatorNode; regenerate [behavior-impl: U12, U13]
- [ ] T015 [P] [US1] Create `lib/src/uinode/nodes/form_nodes.dart`: InputNode, SelectNode + SelectOptionNode, CheckboxNode, SwitchNode, RadioGroupNode + RadioOptionNode, FormItemNode; regenerate [behavior-impl: U14]
- [ ] T016 [P] [US1] Create `lib/src/uinode/nodes/overlay_nodes.dart`: TabsNode + TabNode + TabPaneNode, TooltipNode, SheetNode, DialogNode, PopoverNode, ToastNode; regenerate [behavior-impl: U15]
- [ ] T017 [US1] Create `lib/src/uinode/tree/shad_node_parser.dart`: `parse(Object? json)` (String or Map), `widgetType` ↔ `__typename` translation, schema validation with path-naming `UiParseError`s, unknown `widgetType` → `UnknownNode` (caps/version come in US4); regenerate [behavior-impl: U3, U4, U5]
- [ ] T018 [US1] Create `lib/src/uinode/render/shad_node_renderer.dart` + `renderer_scope.dart` + `node_mappers.dart`: StatelessWidget entry (`tree`, `actions`, `debugFallbacks`), path-keyed lifted state, one mapper per node type mirroring canonical usage, theme-token resolution via `ShadTheme` [behavior-impl: U11, U12, U13, U14, U15]
- [ ] T019 [US1] Complete the barrels: export all public uinode names from `lib/src/uinode/uinode.dart`; verify `lib/uinode.dart` and the `lib/zfa.dart` re-export surface them; `flutter analyze` clean

**Checkpoint**: US1 independently functional — MVP demo possible

---

## Phase 4: User Story 2 — Actions are semantic IDs resolved by the host (Priority: P1)

**Goal**: Triggering an interactive node dispatches the action ID against the host registry; unknown/throwing never crash.

**Independent Test**: `flutter test test/uinode/actions_test.dart`.

### Behavior tests for US2 (MANDATORY — write first, prove red)

- [ ] T020 [US2] **TEST** Failing tests in `test/uinode/actions_test.dart`: (a) resolved handler invoked with args from a rendered button tap; (b) unknown action name → `onUnknownAction`, no throw; (c) throwing handler → `onHandlerError`, siblings still interactive [behavior: U17, U18, U19]

### Implementation for US2

- [ ] T021 [US2] Implement `dispatch` + `onUnknownAction`/`onHandlerError` in `lib/src/uinode/actions/ui_action_handler.dart`; wire button/checkbox/switch/tabs/sheet/dialog/popover/toast trigger interactions in `node_mappers.dart` through the registry [behavior-impl: U17, U18, U19]

**Checkpoint**: US1 + US2 both functional

---

## Phase 5: User Story 3 — Trees survive a byte-stable round-trip (Priority: P2)

**Goal**: Canonical JSON emission, round-trip equality over the whole prop space, validation-only mode.

**Independent Test**: `flutter test test/uinode/canonical_json_test.dart test/uinode/nodes/round_trip_test.dart test/uinode/parser_test.dart`.

### Behavior tests for US3 (MANDATORY — write first, prove red)

- [ ] T022 [P] [US3] **TEST** Failing round-trip tests in `test/uinode/nodes/round_trip_test.dart` with the seeded generator helper `test/uinode/helpers/gen.dart`: every node type × seeded prop variations satisfy `parse(canonical(t)) == t` [behavior: A1, U2]
- [ ] T023 [P] [US3] **TEST** Failing canonical tests in `test/uinode/canonical_json_test.dart`: same tree twice → identical bytes; fixed key order matches the documented schema order; the contract example in `contracts/uinode-api.md` round-trips byte-exact [behavior: U9, U10]
- [ ] T024 [P] [US3] **TEST** Failing validation-mode tests in `test/uinode/parser_test.dart` (validation section): `validate()` reports ok for a valid tree and every typed error for invalid ones — without building any widgets [behavior: U8]

### Implementation for US3

- [ ] T025 [US3] Implement `lib/src/uinode/tree/canonical_json.dart` (`canonicalJson`) with the fixed key-order table; ensure the parser accepts canonical output [behavior-impl: A1, U9, U10]
- [ ] T026 [US3] Implement `validate()` + `UiParseReport` in `lib/src/uinode/tree/shad_node_parser.dart` reusing the same walk (parse = validate + build-tree) [behavior-impl: U8]

**Checkpoint**: US1–US3 functional

---

## Phase 6: User Story 4 — Hostile trees degrade gracefully (Priority: P2)

**Goal**: Caps, version policy, unknown-node render fallback — typed outcomes, zero throws.

**Independent Test**: `flutter test test/uinode/parser_test.dart test/uinode/renderer_unknown_test.dart`.

### Behavior tests for US4 (MANDATORY — write first, prove red)

- [ ] T027 [P] [US4] **TEST** Failing caps/version tests in `test/uinode/parser_test.dart` (caps section): depth 33 / 501 nodes / oversized text → `UiTreeTooLarge` naming cap+path; newer major `schemaVersion` → `UiVersionError`; missing version accepted as current [behavior: U6, U7]
- [ ] T028 [P] [US4] **TEST** Failing unknown-node render tests in `test/uinode/renderer_unknown_test.dart`: debug (`debugFallbacks: true`) shows a visible placeholder; release (`false`) omits and reports a `UiNodeEvent`; a tree containing `UnknownNode` still renders its siblings [behavior: U16]

### Implementation for US4

- [ ] T029 [US4] Implement caps (32/500/10000 defaults) + version policy in `lib/src/uinode/tree/shad_node_parser.dart`; wire the release/debug fallback + event reporting in `lib/src/uinode/render/` (`debugFallbacks`, `UiNodeEvent` channel) [behavior-impl: U6, U7, U16, A3]

**Checkpoint**: All four stories functional

---

## Phase 7: Polish & Cross-Cutting Concerns

- [ ] T030 Author ≥20 fixture trees in `test/uinode/fixtures/*.json` (one per node type minimum, several composed) and `test/uinode/golden_test.dart` rendering them with the fixed-view harness, platform-gated per research D7; generate goldens **on Linux only** (`--update-goldens`) [behavior: A2]
- [ ] T031 [P] **TEST+GATE** Write the prop-purity gate in `test/uinode/prop_purity_test.dart`: static check that no node prop type accepts `Color`/`int` color encodings, and the parser rejects color-shaped style values with `UiParseErrorKind.colorRejected` [behavior: U20, A5]
- [ ] T032 [P] Write `specs/1100-uinode-system/coverage-audit.md`: every public component family from `docs/src/content/docs/Components/` mapped to node status — covered (27) or excluded with tier + reason (research D8); add `test/uinode/uinode_surface_test.dart` asserting the v1 `widgetType` vocabulary set [behavior: A4]
- [ ] T033 [P] Add the CHANGELOG.md entry for the new public `package:zuraffa_ui/uinode.dart` surface
- [ ] T034 Run the full quickstart gate: `flutter analyze` (zero issues) and `flutter test` (suite green with documented platform skips) [behavior: A5]

---

## Dependencies & Execution Order

### Phase Dependencies

- Setup (1) → Foundational (2) → US1 (3) → US2 (4) → US3 (5) → US4 (6) → Polish (7)
- Within US1: behavior tests T007–T012 first (red), then node files T013–T016 ([P]), then parser T017, renderer T018, barrels T019.
- US2–US4 tests touch files created in US1; strictly sequential phases keep the TDD loop honest (one failing test at a time).

### Story Dependencies

- US1 is the MVP and blocks US2–US4 (they decorate the render path).
- US3 and US4 depend only on US1's parser/renderer skeletons, not on each other.

### Parallel Opportunities

- T005/T006 in Foundational; T010–T012 (test files) and T014–T016 (node group files) within US1; T022–T024 within US3; T027–T028 within US4; T031–T033 in Polish.

---

## Implementation Strategy

- **MVP**: Phases 1–3 (US1 alone demos agent-JSON → native UI).
- **TDD**: every `**TEST**` task is written and proven failing before its implementation task; red/green evidence goes in `tdd/cycle-log.md`.
- **Codegen**: after every node-file task, `dart run build_runner build --delete-conflicting-outputs`; committed `.zorphy.dart` parts stay in the diff (repo CI regenerates + verifies).
- Stop at any checkpoint to validate the story independently.
