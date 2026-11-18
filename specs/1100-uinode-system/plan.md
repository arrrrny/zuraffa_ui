# Implementation Plan: UINode system — every widget as serializable data

**Branch**: `1100-uinode-system` | **Date**: 2026-09-18 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `/specs/1100-uinode-system/spec.md`
(authors GitHub issue arrrrny/zuraffa_ui#4).

## Summary

Add a generative-UI substrate to the fork: every certified component (and the
structural layout primitives) exists a second time as **serializable data** —
a Zorphy node entity — plus a renderer that maps `json → node tree → widget
tree`, theme-token styling, actions as semantic IDs resolved by a host
registry, byte-stable canonical serialization with a validation-only mode,
and parse-time composition caps with typed degradation for unknown or
oversized trees. New surface only: no engine files are touched (AGENTS.md
fork policy).

## Technical Context

**Language/Version**: Dart 3.x / Flutter stable (repo CI: `subosito/flutter-action` stable)

**Primary Dependencies**: `zorphy_annotation` (new, runtime), `zorphy` (new, dev, codegen via existing `build_runner`), existing `zuraffa_ui` engine (`Shad*` components + `ShadTheme`)

**Storage**: N/A (in-memory trees; serialization is JSON strings)

**Testing**: `flutter test` (profile `.specify/memory/tdd-profile.md`: single/file/suite/acceptance verified; mutation via `zfa tdd verify --runner flutter`); goldens via `matchesGoldenFile` gated to the golden-generation platform (Linux CI) per repo precedent (#7)

**Target Platform**: Any Flutter target (the layer is pure widget/data code); goldens render on Linux CI

**Project Type**: Flutter library (pub package `zuraffa_ui`)

**Performance Goals**: Parse + validate a 500-node (cap-size) tree without perceptible jank in a debug build; no render-path allocation beyond the mapped widget tree

**Constraints**: No closures/widget instances/raw colors in node props; byte-stable canonical JSON; unknown/oversized input never throws; zero `flutter analyze` issues; engine files untouched

**Scale/Scope**: ~27 node classes (18 component + 9 structural), 1 parser, 1 canonical writer, 1 renderer with per-node mappers, ≥20 golden fixture trees, round-trip fixture suite covering every node type

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

The project constitution file is the unfilled template; the binding
governance is workspace `AGENTS.md`. Checked against it:

| AGENTS.md rule | Status |
|---|---|
| Never rename engine symbols to `Zfa*`; identified layer keeps upstream merges mechanical | **PASS** — new `lib/src/uinode/` surface only; issue contract names (`ShadNode`, `ShadNodeRenderer`, `UiActionHandler`) already use engine `Shad*` spelling; no engine file modified |
| `zfa.dart` carries `Zfa*` alias for every engine name | **PASS (n/a)** — UINode names are new surface, not engine aliases; `zfa.dart` re-exports the new public barrel unchanged in name |
| Fork surface `.github/FORK_OWNED_FILES` | **PASS** — no fork-owned file touched |
| Misfire rule (report + workaround + comment) | **ACK** — applies during the TDD loop; generator/codegen misfires (zorphy × build_runner) get an issue filed on `arrrrny/zuraffa_ui` before workaround |

Post-Phase-1 re-check: no new violations introduced by the design below.

## Project Structure

### Documentation (this feature)

```text
specs/1100-uinode-system/
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
├── contracts/           # Phase 1 output
│   └── uinode-api.md    # Public Dart API + JSON wire contract
├── coverage-audit.md    # Delivered with the feature (SC-1)
└── tasks.md             # Phase 2 output (/speckit-tasks)
```

### Source Code (repository root)

```text
lib/
├── uinode.dart                      # public barrel: export 'src/uinode/uinode.dart'
├── zfa.dart                         # + re-export of the uinode barrel (name-preserving)
└── src/uinode/
    ├── uinode.dart                  # internal barrel
    ├── nodes/
    │   ├── shad_node.dart           # $$ShadNode sealed union + ShadNodeTree envelope helpers
    │   ├── layout_nodes.dart        # Row/Column/Stack/Padding/Expanded/SizedBox/ListView/Image/Icon nodes
    │   ├── basic_nodes.dart         # Text/Badge/Button/Card(+Header/Footer)/Progress/Separator nodes
    │   ├── form_nodes.dart          # Input/Select/Checkbox/Switch/RadioGroup/FormItem nodes
    │   └── overlay_nodes.dart       # Tabs/Tooltip/Sheet/Dialog/Popover/Toast nodes
    ├── tree/
    │   ├── shad_node_tree.dart      # schemaVersion + root envelope (Zorphy)
    │   ├── shad_node_parser.dart    # json → tree; caps + version + unknown-type policy
    │   ├── canonical_json.dart      # byte-stable canonical writer (fixed key order)
    │   └── ui_errors.dart           # UiTreeTooLarge / UiParseError / UiVersionError / UiNodeEvent
    ├── actions/
    │   └── ui_action_handler.dart   # UiActionHandler typedef + UiActionRegistry + typed error event
    └── render/
        ├── shad_node_renderer.dart  # StatelessWidget entry: tree + registry → widgets
        ├── renderer_scope.dart      # renderer-scoped lifted state
        └── node_mappers.dart        # one mapper per node type (canonical usage)
test/uinode/
├── nodes/*_test.dart                # round-trip + prop-purity per family
├── parser_test.dart                 # caps, version, malformed, unknown type
├── canonical_json_test.dart         # byte stability + canonical form
├── actions_test.dart                # resolved / unknown / throwing handlers
├── renderer_*_test.dart             # per-family mapping + lifted state
├── golden_test.dart                 # ≥20 fixture goldens (platform-gated like #7)
├── fixtures/*.json                  # committed fixture trees
└── goldens/*.png
```

**Structure Decision**: Single pub package; a self-contained new layer under
`lib/src/uinode/` with two public barrels (`lib/uinode.dart` primary,
re-exported from `lib/zfa.dart`). Tests mirror the layer under `test/uinode/`,
consistent with the existing `test/src` + `test/identified` split.

## Complexity Tracking

> No constitution/AGENTS violations to justify. The only inherent complexity —
> codegen (Zorphy) — is mandated by the issue (R1) and reuses the repo's
> existing `build_runner` pipeline and CI workflow.
