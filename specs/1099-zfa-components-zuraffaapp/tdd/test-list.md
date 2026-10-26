---
feature: 1099-zfa-components-zuraffaapp
loop: outside-in
profile: .specify/memory/tdd-profile.md
spec_criteria: 8
planned_at: afc9569
updated_at: e3e1784
suite_baseline: green
suite_final: 369 passed (333 carried over + 36 identified)
---

# Test List: zuraffa_ui — identified Zfa components + ZuraffaApp

Derived from `spec.md` (8 acceptance criteria) and `plan.md` (6 components).
Outer-loop behaviors prove the end-to-end repackage; inner-loop behaviors are
grouped by the identified-layer file that owns them.

## Outer loop: acceptance behaviors

One per acceptance criterion (or criterion cluster). Each stays red until the
repackage works end to end through the real package resolution.

| id  | behavior                                                                      | traces    | kind    | state | test                                                     |
| --- | ----------------------------------------------------------------------------- | --------- | ------- | ----- | -------------------------------------------------------- |
| A1  | The package is `zuraffa_ui` 0.1.0 and CHANGELOG records base SHA + upstream   | AC-1, AC-6| example | DONE  | `test/identified/barrel_surface_test.dart::package identity` |
| A2  | Barrel `lib/zuraffa_ui.dart` exports the identified surface only, no raw Shad*| AC-2      | example | DONE  | `test/identified/barrel_surface_test.dart::barrel surface` |
| A3  | Zero `package:shadcn_ui/` imports remain in lib/, test/, example/, playground/| AC-1      | example | DONE  | `test/identified/barrel_surface_test.dart::import hygiene` |
| A4  | The certified vocabulary compiles from the barrel and renders end to end      | AC-2, AC-7| example | DONE  | `test/identified/zfa_components_test.dart::*` |

## Inner loop: unit behaviors

### `lib/src/identified/components/zfa_button.dart`

| id  | behavior                                                            | traces     | kind    | state | test                                            |
| --- | ------------------------------------------------------------------- | ---------- | ------- | ----- | ----------------------------------------------- |
| U1  | ZfaButton answers its typed contract: id `zfa.button`, enabled true by default, false when constructed so | AC-3 | example | DONE | `test/identified/zfa_components_test.dart::ZfaButton contract` |
| U2  | ZfaButton forwards onPressed and taps reach the handler            | AC-3       | example | DONE  | `test/identified/zfa_components_test.dart::ZfaButton forwards onPressed` |
| U3  | ZfaButton renders the ShadButton engine widget beneath it          | AC-2       | example | DONE  | `test/identified/zfa_components_test.dart::ZfaButton renders engine` |

### `lib/src/identified/components/zfa_input.dart`

| id  | behavior                                                            | traces     | kind    | state | test                                            |
| --- | ------------------------------------------------------------------- | ---------- | ------- | ----- | ----------------------------------------------- |
| U4  | ZfaInput answers its typed contract: id `zfa.input`                 | AC-3       | example | DONE  | `...::ZfaInput contract` |
| U5  | ZfaInput forwards controller + onChanged; typing notifies           | AC-3       | example | DONE  | `...::ZfaInput forwards controller and onChanged` |

### `lib/src/identified/components/zfa_card.dart`

| id  | behavior                                                            | traces     | kind    | state | test                                            |
| --- | ------------------------------------------------------------------- | ---------- | ------- | ----- | ----------------------------------------------- |
| U6  | ZfaCard answers its typed contract: id `zfa.card` and renders title/description/child | AC-2, AC-3 | example | DONE | `...::ZfaCard contract and rendering` |

### `lib/src/identified/components/zfa_sheet.dart` / `zfa_dialog.dart` / `zfa_toaster.dart`

| id  | behavior                                                            | traces     | kind    | state | test                                            |
| --- | ------------------------------------------------------------------- | ---------- | ------- | ----- | ----------------------------------------------- |
| U7  | ZfaSheet: id `zfa.sheet`; `show` wraps `showShadSheet` and renders   | AC-3       | example | DONE  | `...::ZfaSheet contract and show` |
| U8  | ZfaDialog: id `zfa.dialog`; `show` wraps `showShadDialog`            | AC-3       | example | DONE  | `...::ZfaDialog contract and show` |
| U9  | ZfaToaster: id `zfa.toaster`; toasts shown through it appear        | AC-3       | example | DONE  | `...::ZfaToaster contract and toast` |

### `lib/src/identified/app/zuraffa_app.dart`

| id  | behavior                                                            | traces     | kind    | state | test                                            |
| --- | ------------------------------------------------------------------- | ---------- | ------- | ----- | ----------------------------------------------- |
| U10 | ZuraffaApp mounts the route-contract observer: unnamed push violates, named push does not | AC-4 | example | DONE | `test/identified/zuraffa_app_test.dart::route contract observer` |
| U11 | Violation chrome shows a banner when the shared bus reports; hidden when disabled | AC-4  | example | DONE  | `...::violation chrome` |
| U12 | ZuraffaApp wraps ShadApp: theme + home render; user builder preserved; user observers merged | AC-4, AC-2 | example | DONE | `...::wraps ShadApp` |

### `lib/src/identified/contract/skin_contract_kit.dart`

| id  | behavior                                                            | traces     | kind    | state | test                                            |
| --- | ------------------------------------------------------------------- | ---------- | ------- | ----- | ----------------------------------------------- |
| U13 | Audit bus reports, clears and notifies listeners                    | AC-4       | example | DONE  | `test/identified/skin_contract_kit_test.dart::bus` |
| U14 | Route observer reports unnamed pushes, records named ones clean      | AC-4       | example | DONE  | `...::route observer` |
| U15 | SkinContractKit exposes the certified id registry + zfa-key parsing  | AC-3, AC-4 | example | DONE  | `...::kit registry and keys` |

### `lib/src/identified/theme/zfa_theme.dart`

| id  | behavior                                                            | traces     | kind    | state | test                                            |
| --- | ------------------------------------------------------------------- | ---------- | ------- | ----- | ----------------------------------------------- |
| U16 | ZfaTheme.of resolves the mounted ShadTheme; ZfaThemeData aliases the engine data class | AC-5 | example | DONE | `test/identified/zfa_theme_test.dart::aliases` |

## Carried-over suite (characterization)

| id  | behavior                                                            | traces     | kind    | state | test                                            |
| --- | ------------------------------------------------------------------- | ---------- | ------- | ----- | ----------------------------------------------- |
| C1  | The fork's 333 engine tests keep passing after the rename           | AC-7       | characterization | DONE | `test/src/**` (untouched apart from import URIs) |
