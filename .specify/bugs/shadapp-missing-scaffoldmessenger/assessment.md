# Bug Assessment: ZuraffaApp/ShadApp provides no ScaffoldMessenger, so ScaffoldMessenger.of throws under the app shell

- **Slug**: shadapp-missing-scaffoldmessenger
- **Created**: 2026-09-18
- **Source**: https://github.com/arrrrny/zuraffa_browser/issues/168
- **Verdict**: likely valid, needs reproduction
- **Severity**: unknown

## Report (verbatim or summarized)

Fetched from https://github.com/arrrrny/zuraffa_browser/issues/168 (open, author arrrrny, no labels).

`flutter test test/widget/markdown_viewer_test.dart --plain-name "the success snackbar's View action opens the document just saved"` (feature 116, export page to markdown, branch `136-export-page-markdown`) fails: a widget pumped inside the app's own shell cannot show a snackbar.

Reported root cause: `ZuraffaApp` (zuraffa_ui) delegates to `ShadApp` (shadcn_ui), which builds the Material app pieces itself and contains zero references to `ScaffoldMessenger` — `MaterialApp` normally inserts one above `home`, `ShadApp` does not, so `ScaffoldMessenger.of(context)` throws for any widget below the shell.

Impact: any feature surfacing feedback through `ScaffoldMessenger` (snackbars, `showSnackBar`, undo bars) cannot work under the app's shipping shell. First surface hit: feature 116's export flow "Saved <name>.md" snackbar with its View action.

## Symptom

`ScaffoldMessenger.of(context)` throws "No ScaffoldMessenger widget found" for widgets mounted under `ZuraffaApp`/`ShadApp`; a `Scaffold` ancestor alone is not enough.

## Reproduction

1. From `zuraffa_browser`, run the failing test: `flutter test test/widget/markdown_viewer_test.dart --plain-name "the success snackbar's View action opens the document just saved"` (feature 116, branch `136-export-page-markdown`).
2. Pump a widget under `ZuraffaApp` that triggers a snackbar (the export flow's "Saved <name>.md" with its View action).
3. Observe: assertion thrown while handling the gesture — `No ScaffoldMessenger widget found.`

## Suspected Code Paths

[NEEDS CLARIFICATION — run /speckit-bug-assess to locate the code, or fill in manually.]

## Root Cause Hypothesis

[NEEDS CLARIFICATION — not yet analyzed.]

## Proposed Remediation

[NEEDS CLARIFICATION — run /speckit-bug-assess to propose a fix, or apply a fix directly with /speckit-bug-fix.]

## Risks & Considerations

- Loaded from an existing GitHub issue; triage is incomplete until refined.

## Open Questions

- [NEEDS CLARIFICATION: does the fix belong in `ZuraffaApp` wrapping `home` in a `ScaffoldMessenger`, in an exposed `scaffoldMessengerKey` on the shell, or in standardising on shadcn's `ShadSonner` toasts?]
