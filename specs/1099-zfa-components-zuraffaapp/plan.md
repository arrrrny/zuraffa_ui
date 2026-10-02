# Implementation Plan: zuraffa_ui — identified Zfa components + ZuraffaApp

**Feature Branch**: `1099-zfa-components-zuraffaapp`

**Created**: 2026-09-05

## Architecture: wrap, don't depend

The fork IS the substrate. The repackage keeps the engine
(`lib/src/components/`, `lib/src/theme/`, ...) byte-compatible with upstream
`nank1ro/flutter-shadcn-ui` (modulo the one-time package-uri rewrite), and adds a
certified vocabulary on top:

```
zuraffa-ui/
├── pubspec.yaml                  # name: zuraffa_ui, version: 0.1.0
├── lib/zuraffa_ui.dart           # NEW package barrel: Zfa* + ZuraffaApp + theme only
├── lib/shad.dart                 # raw Shad* engine library (was lib/shadcn_ui.dart, content unchanged)
├── lib/src/                      # engine, upstream-shaped (package: uris rewritten)
│   ├── app.dart                  #   ShadApp internals (kept for upstream merges)
│   ├── components/...            #   button.dart, card.dart, ... (upstream)
│   └── identified/               # NEW — THE ZFA LAYER, never touched upstream
│       ├── app/zuraffa_app.dart          # observer + audit-bus chrome, default-on
│       ├── components/zfa_button.dart    # contractId + contractEnabled typed protocol
│       ├── components/zfa_input.dart
│       ├── components/zfa_card.dart
│       ├── components/zfa_sheet.dart
│       ├── components/zfa_toaster.dart
│       ├── components/zfa_dialog.dart
│       ├── theme/zfa_theme.dart          # ZfaTheme/ZfaThemeData aliases
│       └── contract/skin_contract_kit.dart # audit bus, route observer, violations
└── CHANGELOG.md                  # base fork SHA + upstream version per release
```

## Components

### 1. Package rename (mechanical)

- `pubspec.yaml`: `name: zuraffa_ui`, `version: 0.1.0`, description re-badged.
- `git mv lib/shadcn_ui.dart lib/shad.dart` (content: relative exports only — no
  edits needed).
- Repo-wide rewrite `package:shadcn_ui/` → `package:zuraffa_ui/` (lib/, test/,
  example/, playground/, docs where applicable).
- Engine tests carry over unchanged apart from the import URI.

### 2. Contract kit (`lib/src/identified/contract/skin_contract_kit.dart`)

Promoted from the 006-login-skin pilot (#1102):

- `ZfaAuditBus extends ChangeNotifier` — collects `ZfaContractViolation`s
  (report/clear, notifies listeners). Shared by observer + chrome.
- `ZuraffaRouteObserver extends NavigatorObserver` — reports a violation for
  every route pushed without contract identity (`route.settings.name == null`).
  Named pushes are recorded as contract events, not violations.
- `ZfaContractViolation` — code, message, timestamp.
- `SkinContractKit` — the facade: owns a bus + observer, exposes
  `violations`, `contractIdFor(Key)` (`zfa.` ValueKey convention from the pilot),
  and the registry of certified contract ids.
- `ZfaContract` mixin — the typed protocol: `String get contractId`,
  `bool get contractEnabled`.

### 3. Zfa components (`lib/src/identified/components/`)

Composition (not inheritance) — the curated surface IS the anti-corruption layer.
Each wrapper: stable `contractId`, `contractEnabled` (default true), forwards the
certified parameter subset to the Shad engine widget:

- `ZfaButton` → `ShadButton` (onPressed, child, leading, trailing, enabled, size,
  width, height, autofocus, focusNode)
- `ZfaInput` → `ShadInput` (controller, initialValue, placeholder, onChanged,
  onSubmitted, enabled, readOnly, obscureText, keyboardType, autofocus, focusNode)
- `ZfaCard` → `ShadCard` (title, description, child, footer, leading, trailing)
- `ZfaSheet` → `ShadSheet` + static `ZfaSheet.show` wrapping `showShadSheet`
  (title, description, child, actions, side)
- `ZfaDialog` → `ShadDialog` + static `ZfaDialog.show` wrapping `showShadDialog`
  (title, description, child, actions)
- `ZfaToaster` → `ShadToaster` (child) — for skins that mount their own toaster;
  ZuraffaApp's ShadApp already auto-mounts toaster+sonner internally.

### 4. ZuraffaApp (`lib/src/identified/app/zuraffa_app.dart`)

StatefulWidget wrapping `ShadApp`:

- Creates (or accepts) one `ZfaAuditBus`; passes it to a `ZuraffaRouteObserver`
  appended to user `navigatorObservers`.
- Wraps the app `builder` chain with `ZfaViolationChrome` (ListenableBuilder on
  the bus; when `showViolationChrome` is true and violations exist, a banner is
  overlaid at the top of the navigator child).
- Forwards: home, routes, initialRoute, navigatorKey, onGenerateRoute,
  onUnknownRoute, title, theme, darkTheme, themeMode, locale, supportedLocales,
  debugShowCheckedModeBanner, scrollBehavior.
- Toaster + sonner come free: `ShadApp` already mounts
  `ShadToaster(child: ShadSonner(...))` inside its internal builder chain.

### 5. Theme aliases (`lib/src/identified/theme/zfa_theme.dart`)

`typedef ZfaTheme = ShadTheme;` / `typedef ZfaThemeData = ShadThemeData;` —
skins type `ZfaTheme.of(context)` and never a Shad name. (Dart type aliases
preserve static members and constructors.)

### 6. Barrel (`lib/zuraffa_ui.dart`)

Exports ONLY: zuraffa_app, the six zfa components, zfa_theme, the contract kit.
No `Shad*` symbol, no engine library exports. Raw engine remains reachable via
`package:zuraffa_ui/shad.dart` (internal escape hatch).

## Testing strategy

TDD, outside-in: the acceptance tests (package identity, barrel surface, import
hygiene) are written first and stay red until the whole repackage lands; unit
behaviors (contract protocol, chrome, observer, bus) go red → green per cycle.
Baseline (cycle 0, fork SHA `afc9569`): 333 tests passing, analyzer clean in
`lib/`+`test/` (144 pre-existing errors confined to `playground/`).

## Risks

See spec.md "Risk & Mitigation" — golden tests, analyzer baseline, merge surface.
