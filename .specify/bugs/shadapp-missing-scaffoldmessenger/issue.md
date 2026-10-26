# Bug Issue: ZuraffaApp/ShadApp provides no ScaffoldMessenger, so ScaffoldMessenger.of throws under the app shell

- **Slug**: shadapp-missing-scaffoldmessenger
- **Fetched**: 2026-09-18
- **Issue**: 168
- **URL**: https://github.com/arrrrny/zuraffa_browser/issues/168
- **State**: open
- **Severity**: unknown
- **Author**: arrrrny (Ahmet TOK)
- **Labels**: (none)

## Body

## Command that failed

```
flutter test test/widget/markdown_viewer_test.dart \
  --plain-name "the success snackbar's View action opens the document just saved"
```

(feature 116 — export page to markdown, branch `136-export-page-markdown`)

## Expected vs actual

- **Expected**: a widget pumped inside the app's own shell can show a snackbar.
- **Actual**:

```
══╡ EXCEPTION CAUGHT BY GESTURE ╞══════════════════════════════════════
The following assertion was thrown while handling a gesture:
No ScaffoldMessenger widget found.
Builder widgets require a ScaffoldMessenger widget ancestor.
The specific widget that could not find a ScaffoldMessenger ancestor was:
  Builder
The ancestors of this widget were:
  ...
  _BodyBuilder
  MediaQuery
  LayoutId-[<_ScaffoldSlot.body>]
```

## Root cause

`ZuraffaApp` (`zuraffa_ui`) delegates to `ShadApp` (`shadcn_ui`). `ShadApp` is a
`StatefulWidget` that builds the Material app pieces itself, and it contains
**zero** references to `ScaffoldMessenger`:

```
grep -c ScaffoldMessenger ~/.pub-cache/hosted/pub.dev/shadcn_ui-0.56.1/lib/src/app.dart
-> 0
```

`MaterialApp` normally inserts a `ScaffoldMessenger` above `home`; `ShadApp`
does not, so `ScaffoldMessenger.of(context)` throws for any widget below the
shell — a `Scaffold` ancestor alone is not enough.

## Impact

Any feature that surfaces feedback through `ScaffoldMessenger` (snackbars,
`showSnackBar`, undo bars) cannot work under the app's shipping shell. For
feature 116 that is the export flow's "Saved <name>.md" snackbar with its View
action. `lib/main.dart` currently contains **no** `ScaffoldMessenger` usage, so
this is the first surface to hit it.

## Workaround applied

- The widget test pumps the same widget under `ZuraffaApp` but wraps the body in
  an explicit `ScaffoldMessenger`, and the feature's feedback helper
  (`lib/src/markdown/ui/markdown_export_feedback.dart`) carries a comment
  pointing at this issue, so the wiring task (T021) knows the shell must supply
  the messenger (or the app must move to shadcn's `ShadSonner` toasts).

## Suggested fix

Either wrap the app's home in a `ScaffoldMessenger` inside `ZuraffaApp`, or
expose a `scaffoldMessengerKey` on the shell so features can register one; or
standardise on `ShadSonner` for toasts app-wide and give
`showMarkdownExportOutcome` a toast implementation instead.

## Comments

None.
