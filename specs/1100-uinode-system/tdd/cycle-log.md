# TDD Cycle Log: 1100-uinode-system

## Baseline (planned_at cbc4506)

- Suite state before any feature work: **green** — 395 passed, ~6 skipped
  (expandable sheet goldens platform-gated per #7) on macOS, Flutter
  3.47.4, at the 47ec3f6 merge line.
- Profile: `.specify/memory/tdd-profile.md` (verified: single, file, suite,
  acceptance, mutation).
- 25 behaviors planned (5 acceptance + 20 unit); loop run in fallback mode
  (no `.zfa.json` → LLM-guided, per speckit-tdd-run detection).
- zfa engine v6.3.0 present but the project is not zuraffa-wired; the
  deterministic dispatcher was therefore unavailable.

## Cycle evidence (red → green, one line per behavior)

- **U1** union contract: RED `flutter test union_test` → compile failure
  `$$ShadNode isn't a type` (no node layer existed) → GREEN after the
  Zorphy vocabulary + wire extension (union_test +3).
- **U2** UnknownNode preservation: RED same compile failure → GREEN
  (entity raw preservation + round-trip in union/round_trip tests).
- **U3** parse entry (string/map): RED `ShadNodeParser isn't a type` →
  GREEN parser with envelope handling (+6 parse_entry).
- **U4** schema violations name the path: RED same → GREEN (+5, incl.
  arity for padding/tooltip exactly-one-child).
- **U5** unknown widgetType tolerance: RED same → GREEN (+1, raw kept).
- **U9/U10** canonical form: RED `canonicalJson` not found → GREEN
  byte-stable writer, contract example byte-exact (+3 canonical tests).
- **U17–U19** actions: RED `ShadNodeRenderer`/2-arg handler not found →
  GREEN dispatch + containment (+4 actions tests).
- **U11–U15** render mapping & lifted state: RED (mapper widgets absent) →
  GREEN across renderer_base/basic/form/overlay (+22 tests; two fixture
  bugs fixed in the tests themselves: engine-internal widget finders
  narrowed to ancestors, vertical separator given bounded height).
- **U6** caps: RED `validate` undefined / caps unenforced → GREEN
  depth/nodes/textLength with paths (+7 parser_test).
  *Depth regression caught by the loop*: a double `+1` per hop made
  nest(30) exceed the cap; found by probing the throw path (17 hops for
  nest(30)) and fixed by removing the extra increment at decoder call
  sites.
- **U7** version policy: RED generic malformed error → GREEN
  `UiVersionError{found, supported}`.
- **U8** validation-only: RED `validate` undefined → GREEN multi-error
  report; a probe exposed duplicate reports + wrong child paths +
  `colorRejected` never firing (regex `$` anchor bug) — all fixed (+2).
- **U16** unknown-node render: GREEN debug placeholder / release
  omit+event (+2 renderer_unknown).
- **U20/A5** prop purity gate: GREEN source-scan (no Color in nodes/tree
  layers) + hex/rgb/0x rejections (+3).
- **A4** vocabulary surface: GREEN `supportedWidgetTypes` equals the
  documented v1 set; barrels expose the contract names (+2).
- **A1** round-trip: GREEN seeded generator over the whole prop space
  (34 kinds × 3 variations), byte-stable (+3).
- **A2** goldens: fixtures authored (21 trees) + golden_test written with
  the Linux-only compare gate (research D7, issue #7 policy). On macOS all
  22 tests pass in render-only mode; the PNG comparisons complete on the
  Linux CI run (`--update-goldens` there only). **State: DONE-pending-CI**
  — the platform-gated compare is the one piece a macOS run cannot prove.

## Misfires (AGENTS.md rule)

- **arrrrny/zuraffa#1717**: zorphy's generated sealed base cannot be
  implemented outside its library → all node classes consolidated into a
  single library (nodes.dart), exhaustiveness preserved. Reported, worked
  around, commented in code.

## Final suite state

- `flutter analyze lib/src/uinode` → No issues found.
- `flutter test test/uinode/` → 67 + 22 golden (render-only on macOS) all
  green. Full-suite gate recorded in verification.md.
