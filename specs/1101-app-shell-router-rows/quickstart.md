# Quickstart: 1101 Verification Workflow

**Branch**: `1101-app-shell-router-rows`

## Prerequisites

```bash
cd ~/Developer/zuraffa_ui
git checkout 1101-app-shell-router-rows
flutter pub get          # resolve after rebase onto origin/master
```

## Red → Green for the router shell

```bash
# 1. Prove the capability is missing (RED):
flutter test --concurrency=2 test/identified/zuraffa_app_test.dart \
  --plain-name "router"
# Expect: compile errors / failing tests (ZuraffaApp.router does not exist yet).

# 2. Implement ZuraffaApp.router + fields (GREEN), then:
flutter test --concurrency=2 test/identified/zuraffa_app_test.dart
# Expect: ALL tests green (router group + existing home-path groups).
```

## Red → Green for the snack bar theme

```bash
# 1. RED:
flutter test --concurrency=2 test/src/app/material_theme_snack_bar_test.dart
# Expect: failing (no snackBarTheme yet).

# 2. Add the snackBarTheme block in materialTheme(), then:
flutter test --concurrency=2 test/src/app/material_theme_snack_bar_test.dart
```

## ShadItem verification (existing capability)

```bash
flutter test --concurrency=2 test/src/components/item_test.dart
# Expect: 56 green — proves FR-007..015 ride the release.
flutter test --concurrency=2 test/identified/zfa_alias_coverage_test.dart
# Expect: green — all ZfaItem* aliases resolve.
```

## Full gate before PR

```bash
flutter analyze                          # 0 errors/warnings expected
flutter test --concurrency=2             # full suite green (SC-005)
./scripts/local_ci.sh                    # the same gate CI would run
```

## Consumer smoke check (optional, SC-001/SC-003 evidence)

```bash
# In any app that resolves zuraffa_ui from this path:
#   ZuraffaApp.router(routerConfig: GoRouter(routes: [...]))
#   - app boots to the initial route
#   - ScaffoldMessenger.of(context) resolves from a route
#   - SnackBar is theme-coloured, not near-black
```
