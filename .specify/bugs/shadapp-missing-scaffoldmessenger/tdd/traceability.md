# Traceability: shadapp-missing-scaffoldmessenger

Coverage proof for `zfa tdd plan` (bug #846): every FR/AC requirement statement maps to a behavior row or an explicit manual declaration. Verify re-checks the hash — a spec edited after plan is drift (exit 3, re-plan required).

<!-- tdd:traceability
spec-hash: sha256:f9c1bfcd72a434305ba44107a6993cb61d6f242dedc08180f48f358f0af0248b
statements: 4
automated: 4
manual: 0
fr-manual: 0
open-gaps: 0
-->

| requirement | line | statement | behavior | status |
| --- | --- | --- | --- | --- |
| AC-1 | 40 | 1. **Given** a widget mounted under `ZuraffaApp` inside a `Scaffold`, **When** it calls `ScaffoldMessenger.of(context)`, **Then** it resolves a `ScaffoldMessengerState` without throwing. | A1 | automated |
| AC-2 | 42 | 2. **Given** a widget mounted under `ZuraffaApp` inside a `Scaffold`, **When** it calls `ScaffoldMessenger.of(context).showSnackBar` with a `SnackBar`, **Then** the SnackBar's content renders in the widget tree. | A2 | automated |
| AC-3 | 44 | 3. **Given** a route pushed onto `ZuraffaApp`'s navigator, **When** a widget on the pushed route calls `ScaffoldMessenger.of(context)`, **Then** it resolves the shell's messenger without throwing. | A3 | automated |
| AC-4 | 46 | 4. **Given** the shell's default wiring, **When** `ZuraffaApp` builds with a user builder and observers, **Then** the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator. | A4 | automated |

