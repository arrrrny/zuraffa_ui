# Feature Specification: UINode system — every shadcn_ui widget as serializable data

**Feature Branch**: `1100-uinode-system`

**Created**: 2026-09-18

**Status**: Draft

**Input**: GitHub issue arrrrny/zuraffa_ui#4 — "UINode system: every shadcn_ui
widget as serializable data — Zorphy node entities, renderer, actions-as-IDs,
theme tokens (foundation)". ZikZak AI program, Wave U (Generative UI)
foundation; MAESTRO arrrrny/zik_zak#176. The issue body is the authoritative
requirements source for this spec.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Agent-authored UI renders as a native widget tree (Priority: P1)

A ZikZak AI agent emits a UI description as JSON — cards, badges, selects,
layouts, text, buttons — chosen from a constrained vocabulary. A host app
feeds that JSON into the UINode render entry point and a native zuraffa_ui
widget tree appears, styled entirely through theme tokens
(`"destructive"`, `"mutedForeground"`, `"card"`, size scales). The app never
interprets the JSON itself: parse → node tree → widget tree is one call.

**Why this priority**: This is the generative-UI substrate. Without the
author→render path nothing else in the ZikZak Wave U program (vocabulary
schemas, the `ui.render` tool, the engine payload typing) can be built.

**Independent Test**: Can be fully tested by parsing a fixture JSON tree for
each supported component and structural primitive, rendering it inside a
widget harness, and asserting the expected native widgets exist with the
expected theme-token-derived styling.

**Acceptance Scenarios**:

1. **Given** a valid JSON tree describing a card containing a badge, text, and
   a button, **When** the host renders it, **Then** the equivalent native
   widget tree is built with no host-side JSON handling.
2. **Given** a tree whose style props reference theme tokens by name,
   **When** it renders under a themed context, **Then** the resolved visual
   properties come from the ambient theme — a token restyle changes the render
   without any tree edit.
3. **Given** a tree using structural primitives (column, row, stack, padding,
   expanded, sized box, list, image, icon) to compose component nodes,
   **When** rendered, **Then** the layout primitives arrange the component
   widgets exactly as described.
4. **Given** interactive nodes (tabs, checkbox, switch, form fields) with no
   host-provided controllers, **When** rendered, **Then** interaction state is
   lifted into renderer-scoped state so the tree itself stays pure data and
   re-renders from the same JSON.

---

### User Story 2 - Actions are semantic IDs resolved by the host (Priority: P1)

A rendered tree contains a button whose action is `{"action": "open_url",
"args": {"url": "..."}}`. The host app has registered a handler map keyed by
action name. When the user taps the button, the host's handler for
`open_url` fires with the args. If the agent emits an action name the host
never registered, the host receives a typed error event — the app never
crashes and no closure ever travels through the JSON.

**Why this priority**: Interactivity is what makes agent-authored UI useful
rather than a poster; the action contract is shared with two other repos and
must be stable early.

**Independent Test**: Can be fully tested by rendering trees whose nodes
carry each action shape, driving the interaction, and asserting handler
invocation — including the unknown-action and handler-throws paths.

**Acceptance Scenarios**:

1. **Given** a registered handler for a node's action ID, **When** the user
   triggers the node, **Then** the handler is invoked with the action's args.
2. **Given** an action ID with no registered handler, **When** triggered,
   **Then** a typed error event surfaces (observable by the host) and the app
   continues running.
3. **Given** a registered handler that itself throws, **When** triggered,
   **Then** the error is contained and surfaced as a typed event, never an
   unhandled crash.

---

### User Story 3 - Trees survive a byte-stable round-trip (Priority: P2)

An agent-side toolchain serializes a node tree to JSON, diffs it, stores it,
or re-reads it. Serializing the same tree twice yields identical bytes; a
tree parsed from JSON re-serializes to the canonical form. A CI job can also
validate a tree — parse without rendering — as a self-check before it is ever
sent to an app.

**Why this priority**: Authoring-side tooling (schemas, tests, caching)
depends on canonical serialization, but it unblocks no render path until the
core exists.

**Independent Test**: Can be fully tested by round-tripping a fixture suite
covering every node type (and property-test variations over the prop space)
and asserting node equality plus byte-stable canonical output; validation
mode is tested by parsing without any widget binding.

**Acceptance Scenarios**:

1. **Given** any valid node tree, **When** it is serialized twice, **Then**
   both outputs are byte-identical (stable key order).
2. **Given** a JSON tree, **When** parsed and re-serialized, **Then** the
   result equals the canonical form and the parsed node equals the original.
3. **Given** a JSON tree in validation-only mode, **When** validated,
   **Then** the outcome (ok, or the specific typed error) is reported without
   building any widgets.

---

### User Story 4 - Hostile trees degrade gracefully (Priority: P2)

An agent (or a attacker-controlled channel) emits a tree with an unknown
widget type, a depth-1000 nesting, a 10,000-node blowup, a megabyte string,
or a raw color where a theme token belongs. The host sees a visible
placeholder for the unknown node in debug (or a silently omitted node plus an
event in release), a typed size-violation error asking the agent to retry
smaller, and rejection of raw colors at validation — never an exception
escaping into the app.

**Why this priority**: The render path's safety contract; required before any
real agent traffic, but independently testable and buildable after US1–US3
establish the vocabulary.

**Independent Test**: Can be fully tested by feeding malformed and oversized
trees to parse/render and asserting the typed outcomes: fallback rendering,
`UiTreeTooLarge`-class errors, color rejection, and zero thrown exceptions.

**Acceptance Scenarios**:

1. **Given** a tree containing an unknown `widgetType`, **When** rendered in
   debug, **Then** a visible placeholder appears where the node would be and
   the app does not throw; **When** rendered in release, **Then** the node is
   omitted and an event reports it.
2. **Given** a tree exceeding the depth cap (default 32), the node-count cap
   (default 500), or a text-length cap, **When** parsed, **Then** a typed
   size error identifies the violation and no widget is built.
3. **Given** a style prop carrying a raw color value instead of a token
   reference, **When** validated, **Then** it is rejected with a typed error.

---

### Edge Cases

- Empty tree / empty children list → renders nothing (or an empty shelf),
  never throws.
- `schemaVersion` missing → treated as the current version; a *newer*
  version than the runtime understands → parse fails with a typed
  version error, never silent misparse.
- Node with absent optional props → renderer applies the component's
  canonical defaults (mirroring the docs/skill usage).
- Duplicate keys or wrong-typed props in JSON → typed parse error naming the
  node path, not a crash.
- Text beyond the maximum length → rejected at parse (typed), so a renderer
  never has to truncate.
- Action args containing arbitrary nested JSON → passed through verbatim to
  the handler; the action layer does not interpret them.
- An image node with an unreachable source → render-level error containment
  (placeholder), not a tree-level failure.

## Requirements *(mandatory)*

### Functional Requirements

**Vocabulary coverage**

- **FR-1**: Every public zuraffa_ui component family MUST have a
  corresponding node class, at minimum: button, card (with header/footer
  children), badge, text, input, select, checkbox, switch, tabs, progress,
  separator, tooltip, sheet, dialog, popover, toast, radio group, form item.
- **FR-2**: Structural layout primitives MUST exist as nodes: column, row,
  stack, padding, expanded, sized box, list view, image, icon.
- **FR-3**: A coverage audit document MUST list every public component with
  its node-class status — covered, or deliberately excluded with a reason.
- **FR-4**: Node props MUST be data only (strings, numbers, booleans,
  enums, token references, nested nodes); closures, widget instances, and raw
  color values MUST NOT be representable.

**Tokens & actions**

- **FR-5**: Style props MUST reference theme tokens by name and the renderer
  MUST resolve them through the ambient theme at render time; raw colors
  MUST be rejected at validation.
- **FR-6**: Interactive props MUST be semantic action IDs of the shape
  `{"action": "<name>", "args": {...}}`, resolved against a host-registered
  handler map at render time.
- **FR-7**: Unknown action IDs and throwing handlers MUST surface as typed
  error events observable by the host; they MUST NOT throw, crash, or block
  sibling interaction.

**Forward compatibility**

- **FR-8**: Every serialized tree MUST carry a `schemaVersion`; a runtime
  encountering a newer major version MUST fail with a typed error, and an
  absent version MUST be accepted as the current version.
- **FR-9**: An unknown `widgetType` MUST render as a graceful fallback —
  visible placeholder in debug mode, omitted-with-event in release mode —
  never a thrown error.

**Rendering**

- **FR-10**: A single render entry point MUST map a node tree plus a handler
  registry to a widget tree, with one mapping per node type mirroring each
  component's canonical usage from the repo's own skill/docs.
- **FR-11**: Interactive state (tab selection, checkbox/switch values, form
  fields) MUST be lifted into renderer-scoped state so identical input JSON
  deterministically re-renders.
- **FR-12**: Parse-time composition caps — max depth (default 32), max node
  count (default 500), max text length — MUST be enforced and violations MUST
  produce one typed error class identifying which cap and where.

**Serialization & tooling**

- **FR-13**: Every node MUST round-trip JSON ↔ node with byte-stable
  canonical serialization (stable key order) as part of the public contract.
- **FR-14**: A validation-only mode MUST parse and check a tree without
  building widgets, suitable for CI and agent-side self-checks.
- **FR-15**: The widget-tree→node direction (an inspector) is OUT OF SCOPE;
  serialization is authoring-side only.

**Quality gates**

- **FR-16**: The feature's code MUST pass static analysis with zero issues,
  and a test-time gate MUST fail if any node prop accepts a hardcoded color
  value.

### Key Entities *(include if feature involves data)*

- **Node tree**: the serializable description of a UI — a typed root with
  typed children; one node kind per component family plus structural
  primitives; every tree carries a schema version.
- **Theme token reference**: a named style lookup ("destructive",
  "mutedForeground", "card", size scales) resolved against the ambient theme
  at render time; the only legal styling currency inside a tree.
- **Action ID**: `{"action": name, "args": object}` — a semantic handle the
  host resolves; carries no behavior.
- **Handler registry**: the host's name→handler map, plus the typed error
  channel for unknown names and handler failures.
- **Composition caps**: the depth/count/text limits enforced at parse,
  reported as one typed violation error.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-1**: 100% of the fork's public component families have a node class
  and renderer mapping, or appear in the coverage audit with an explicit
  exclusion reason (audit published with the feature).
- **SC-2**: The round-trip fixture suite covers every node type and passes
  node-equality plus byte-stability checks at 100%.
- **SC-3**: At least 20 fixture trees render to golden images and match on
  the golden-generation platform; a token-only restyle of a fixture changes
  the render with zero tree edits.
- **SC-4**: Unknown-node, oversize, unknown-action, and throwing-handler
  inputs produce the specified typed outcomes in 100% of the corresponding
  tests, with zero uncaught exceptions.
- **SC-5**: Static analysis reports zero issues for the new surface, and the
  no-raw-colors gate passes.

## Assumptions

- **Golden platform** (resolves the issue's "golden images on macOS" wording):
  repo precedent (#7, and its follow-up comment) established that this repo's
  goldens are Linux/CI artifacts and macOS drifts ~0.2%. SC-3's
  "golden-generation platform" therefore means the Linux CI platform; macOS
  local runs skip platform-sensitive goldens exactly as the sheet goldens
  already do.
- **Codegen**: node entities use Zorphy (pub.dev `zorphy`, published by
  zuraffa.com) with JSON generation enabled, per the issue's R1.
- **Naming**: the cross-repo contract names in the issue (`ShadNode`,
  `ShadNodeRenderer`, `UiActionHandler`, `UiTreeTooLarge` class of errors)
  are kept as the primary API names; the fork's Zfa*-alias policy (AGENTS.md)
  is satisfied by exposing aliases in the zfa barrel without renaming
  anything engine-side. The UINode layer is new surface and must not modify
  engine files.
- **Package surface**: the implementation lives under a new
  `lib/src/uinode/` tree, exported through a dedicated public barrel and
  re-exported from the main zfa barrel.
- **Defaults**: cap values (depth 32, nodes 500) and the debug/release
  fallback split follow the issue verbatim.
- **Out of scope**: widget-tree→node inspection (FR-15), vocabulary schema
  export (zuraffa repo), the `ui.render` agent tool (zuraffa repo), and any
  server/transport concerns.
