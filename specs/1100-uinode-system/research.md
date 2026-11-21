# Research: 1100-uinode-system

Phase 0 output. Every decision below resolves a design question raised by
`spec.md`; no NEEDS CLARIFICATION items existed, so these are
decision+rationale records.

## D1 — Codegen: Zorphy for node entities

**Decision**: Add `zorphy_annotation` (runtime) + `zorphy` (dev) and declare
every node as `@Zorphy(generateJson: true) abstract class $XxxNode implements
$$ShadNode` (drop-the-$ concrete `XxxNode`). Generate with the repo's
existing `dart run build_runner build` (CI already has a build-runner
workflow that regenerates and pushes to PR branches).

**Rationale**: Mandated by issue R1. Zorphy gives immutable classes,
equality, copyWith, sealed unions (`$$ShadNode` base for exhaustive
switches) and polymorphic `fromJson` via a `__typename` discriminator —
exactly the node-model shape the issue specifies. Published by zuraffa.com,
so it is the program-blessed toolchain.

**Alternatives considered**: freezed (not program-blessed; same codegen
weight), hand-written immutables (27 classes × equality/copyWith/JSON by
hand — unmaintainable), json_serializable (no sealed unions, no copyWith).

## D2 — Canonical JSON: dedicated writer, not generated `toJson`

**Decision**: Byte-stable canonical form is produced by a hand-written
`canonical_json.dart` walker that emits compact JSON with keys in a fixed,
schema-declared order per node type, wrapped in the tree envelope
`{"schemaVersion":N,"root":{...}}`. Parsing accepts any valid JSON (object
key order irrelevant) via Zorphy's polymorphic `fromJson`; *emitting* is
always canonical.

**Rationale**: FR-13 makes byte-stability a contract; generated serializers
follow field-declaration order which is fragile under refactors, and
Zorphy's `__typename`/lean variants are not tuned for canonical output. A
single writer keyed off the same schema table the parser uses keeps one
source of truth and is trivially testable.

**Alternatives considered**: `jsonEncode` of generated maps with pre-sorted
keys (still couples to generated code shape), pretty-printed canonical form
(larger; agents emit compact).

## D3 — Unknown-node policy: parse-level tolerance, render-level fallback

**Decision**: The parser preserves unknown `widgetType` objects as a
dedicated `UnknownNode` (keeping the raw JSON), so round-trips never lose
data. The *renderer* implements the debug/release split: visible placeholder
in debug (asserts mode), omitted + `UiNodeEvent` in release. The root
envelope's `schemaVersion` gates parse: newer major → `UiVersionError`;
missing → current version.

**Rationale**: FR-8/FR-9 require both graceful render degradation *and* that
agents can round-trip trees containing types a given runtime doesn't know.
Failing at parse would make forward-compat impossible; dropping at parse
would break byte-stable round-trip of future trees.

**Alternatives considered**: fail-fast parse (breaks forward compat),
silent drop at parse (loses data).

## D4 — Caps: enforced in one parse pass with a single typed error

**Decision**: `ShadNodeParser` enforces maxDepth (default 32), maxNodes
(default 500), maxTextLength (default 10 000) during its single walk.
Violations throw `UiTreeTooLarge` (subtype of `UiParseError`) carrying the
cap kind and the node path. All errors are `Error`-free exceptions of one
sealed `UiParseException` family; `validate()` catches and reports them
without building widgets.

**Rationale**: FR-12 names one typed error class identifying cap + location;
a single walk is O(n) and cannot stack-overflow because depth is bounded
*during* descent, before recursion gets deep.

**Alternatives considered**: render-time enforcement (too late — widget
build must not throw), per-error classes per cap (API surface bloat; the
issue names one class).

## D5 — Renderer state lifting: path-keyed scope, not inherited controllers

**Decision**: `ShadNodeRenderer` is a `StatefulWidget` creating a
`NodeRenderScope` (an `InheritedWidget` + a state store keyed by stable node
path, e.g. `root/row[0]/checkbox[1]`). Interactive nodes (tabs, checkbox,
switch, input, select, radio group) read/write that store; identical JSON
re-renders deterministically because paths derive from tree structure, not
identity. Host-provided controllers (when a node carries an id the host
bound) take precedence.

**Rationale**: FR-11 requires lifted, renderer-scoped state and pure
re-render from JSON. Path keys survive re-parse (structure-stable) while
remaining local to one renderer instance — two renderers of the same tree
don't share state.

**Alternatives considered**: StatefulWidget per interactive node with local
state (state dies on tree edit reorder; not scope-addressable), global keys
(loses determinism, leaks across renderers).

## D6 — Actions: registry + zone events

**Decision**: `UiActionHandler = void Function(String name, Map<String,
dynamic> args)`; `UiActionRegistry` maps name→handler (case-sensitive).
Triggering: resolved → invoke; unknown name → `onUnknownAction` callback on
the registry (typed event, default no-op logs in debug); handler throw →
caught by the registry wrapper → `onHandlerError` callback. The renderer
never crashes from action plumbing.

**Rationale**: FR-6/FR-7 and US2 scenario 2/3. Callbacks keep the layer
dependency-free (no streams required by hosts that don't want them) while
remaining observable; the issue's "typed error event" is the callback pair.

**Alternatives considered**: broadcast stream (heavier API, easy to misuse),
rethrowing (violates never-crash contract).

## D7 — Goldens: Linux-CI rendered, platform-gated suite (per #7 precedent)

**Decision**: `golden_test.dart` renders ≥20 fixture trees to goldens with
the same fixed-view harness pattern as `sheet_test.dart` and gates the
comparisons on the golden-generation platform (Linux CI) exactly like the
expandable sheet goldens (skip on macOS). Goldens are only regenerated on
Linux.

**Rationale**: Issue #7 + its CI evidence established this repo's goldens
are Linux artifacts; the spec's Assumptions bind SC-3 to that platform.

**Alternatives considered**: `matchesGoldenFile` everywhere (reintroduces
the #7 failure mode), alchemist/screenshot packages (new deps, no need).

## D8 — Coverage scope for v1 and the exclusion audit

**Decision**: v1 implements the issue-named 18 component families + 9
structural primitives (27 node classes). The coverage audit
(`coverage-audit.md`) lists the remaining public families from
`docs/src/content/docs/Components/` as deliberate exclusions in two tiers:
simple-variant follow-ups (alert, avatar, breadcrumb, icon-button, textarea,
sonner, slider — thin wrappers over covered primitives) and
interaction-contract-pending (accordion, calendar, context-menu, date-picker,
input-otp, menubar, resizable, table, time-picker — their interactive state
models need their own spec waves).

**Rationale**: SC-1 permits deliberate exclusions with reasons; the issue's
"…" plus "full component coverage audit lands in the plan" anticipates
exactly this split. Shipping 27 solid nodes beats shipping 38 shallow ones.

**Alternatives considered**: all 38 in v1 (dilutes the foundation; several
need product decisions), fewer than the named 18 (violates the issue's
explicit list).

## D9 — Property-style tests without a new dependency

**Decision**: The round-trip "property tests over prop space" are a
seeded, deterministic generator in test helpers (`_gen.dart`): for every
node type it produces the nominal fixture plus N randomized-but-seeded prop
variations, all asserted for node-equality and byte-stability. No
`check`/`quickcheck` dependency.

**Rationale**: SC-2 demands coverage of the prop space; determinism keeps
the suite reproducible in CI; zero new dev deps keeps the dependency budget
the fork policy favors.

**Alternatives considered**: `check` package (new dep for marginal gain),
hand-written permutations only (weaker coverage claim).

## D10 — Exports and naming

**Decision**: Public surface exports from `lib/uinode.dart` (new entry)
**and** `lib/zfa.dart` (re-export). Names follow the issue contract:
`ShadNode`, `ShadNodeTree`, `ShadNodeParser`, `ShadNodeRenderer`,
`UiActionHandler`, `UiActionRegistry`, `UiTreeTooLarge`, `UiParseError`,
`UiVersionError`, `UiNodeEvent`, `UnknownNode`. Node classes: `ButtonNode`,
`CardNode`, …, `ColumnNode`, …. No `Zfa` renames anywhere (engine-name
policy); the identified/alias generator is untouched.

**Rationale**: Cross-repo consumers (zuraffa, zuraffa_agent issues) already
reference these names; AGENTS.md forbids renames and requires `zfa.dart` to
remain the one-stop import.

**Alternatives considered**: `Zfa*` prefix for the new layer (violates the
spirit of the naming policy — new *identified* surface took `Zfa`, but this
layer's names are a cross-repo wire contract fixed by the issue).
