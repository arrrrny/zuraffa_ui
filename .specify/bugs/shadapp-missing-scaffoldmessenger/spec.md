**Template Version**: `zuraffa-1.0`

# Bug Specification: ZuraffaApp must provide a ScaffoldMessenger under the app shell

**Bug Branch**: `fix/shadapp-missing-scaffoldmessenger`

**Created**: 2026-09-18

**Status**: Approved

**Input**: GitHub issue #168 — https://github.com/arrrrny/zuraffa_browser/issues/168
("ZuraffaApp/ShadApp provides no ScaffoldMessenger, so ScaffoldMessenger.of throws
under the app shell"), reported from feature 116's export flow. The issue's failing
command:
`flutter test test/widget/markdown_viewer_test.dart --plain-name "the success snackbar's View action opens the document just saved"`.

## Bug Summary

`ZuraffaApp` delegates to the vendored `ShadApp` engine (`ShadApp` → `WidgetsApp`
with `ShadAppBuilder`). That chain mounts `ShadToaster` and `ShadSonner` above the
navigator but never inserts a `ScaffoldMessenger` — the widget `MaterialApp`
inserts above its navigator. As a result `ScaffoldMessenger.of(context)` throws
`No ScaffoldMessenger widget found` for every widget mounted under the shell, so
any feature that surfaces feedback through `ScaffoldMessenger` (snackbars,
`showSnackBar`, undo bars) cannot work under the shipping shell.

## User Scenarios & Testing

### User Story 1 - A feature shows feedback through the shell (Priority: P1)

A widget mounted under `ZuraffaApp` — the home widget or a widget on a pushed
route — calls `ScaffoldMessenger.of(context).showSnackBar(...)` from inside a
`Scaffold`. The SnackBar renders, exactly as it would under `MaterialApp`.

**Why this priority**: This is the reported breakage; it blocks feature 116's
export flow in `zuraffa_browser` at the first `ScaffoldMessenger` use.

**Acceptance Scenarios**:

1. **Given** a widget mounted under `ZuraffaApp` inside a `Scaffold`, **When** it calls `ScaffoldMessenger.of(context)`, **Then** it resolves a `ScaffoldMessengerState` without throwing.
   **Type**: acceptance
2. **Given** a widget mounted under `ZuraffaApp` inside a `Scaffold`, **When** it calls `ScaffoldMessenger.of(context).showSnackBar` with a `SnackBar`, **Then** the SnackBar's content renders in the widget tree.
   **Type**: acceptance
3. **Given** a route pushed onto `ZuraffaApp`'s navigator, **When** a widget on the pushed route calls `ScaffoldMessenger.of(context)`, **Then** it resolves the shell's messenger without throwing.
   **Type**: acceptance
4. **Given** the shell's default wiring, **When** `ZuraffaApp` builds with a user builder and observers, **Then** the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.
   **Type**: acceptance

## Out of Scope

- Standardising feedback on shadcn `ShadSonner` toasts app-wide — a possible
  later direction; this bug only restores `ScaffoldMessenger` semantics under the
  shell.
- Removing the `zuraffa_browser` feature 116 workaround (test-side explicit
  `ScaffoldMessenger` wrap and the comment in
  `lib/src/markdown/ui/markdown_export_feedback.dart`) — separate repository.
