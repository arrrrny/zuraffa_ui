---
title: UINode
sidebar:
  order: 6
---

The UINode layer turns the component library into **serializable data**:
a UI arrives as JSON, is parsed into a typed node tree, rendered with the
same engine widgets you would write by hand — and can be emitted back to
byte-stable JSON. It is the substrate for generative UI: a server or agent
sends a widget tree, the app renders it, and user interactions flow back as
semantic action IDs.

Import it directly or through the main barrel:

```dart
import 'package:zuraffa_ui/uinode.dart'; // or package:zuraffa_ui/zfa.dart
```

## The pipeline

```
JSON ──parse──▶ ShadNode tree ──render──▶ Widget tree
  ▲                                        │
  └──────────── canonicalJson ◀──(data)────┘
```

- **`ShadNode`** — a sealed union of 34 node kinds (24 component kinds,
  9 structural primitives, plus `unknown`). Props are data only; styling
  comes from theme tokens; interactions are semantic action IDs
  (`{action, args}`).
- **`ShadNodeParser`** — one-walk schema validation with path-named typed
  errors. Composition is capped (depth 32 / 500 nodes / 10k text →
  `UiTreeTooLarge`), newer major versions fail with `UiVersionError`,
  unknown `widgetType`s are tolerated as `UnknownNode` (raw JSON
  preserved), and raw color-shaped values are rejected
  (`colorRejected`). `validate()` collects every error for CI self-checks.
- **`canonicalJson`** — byte-stable emission (fixed key order) plus
  canonical-form deep equality, so two semantically equal trees always
  serialize identically.
- **`ShadNodeRenderer`** — one mapper per kind onto the engine widget,
  theme-token resolution, and interaction state lifted into a path-keyed
  scope (two renderers of the same tree hold independent state). Unknown
  nodes render a debug placeholder in debug builds and are omitted with an
  event in release.
- **`UiActionRegistry`** — resolved handlers run with their args; unknown
  actions and throwing handlers surface as typed callbacks, never as
  crashes.

## Minimal example

```dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zuraffa_ui/zfa.dart';

void main() {
  final tree = ShadNodeParser().parse(jsonDecode(sampleJson));
  runApp(MaterialApp(
    home: Scaffold(
      body: ShadNodeRenderer(
        tree: tree,
        actions: UiActionRegistry(
          handlers: {
            'submit_selection': (name, args) => debugPrint('$name $args'),
          },
          onUnknownAction: (name) => debugPrint('unknown action: $name'),
        ),
      ),
    ),
  ));
}
```

A card with text, an input, and a working button — zero host-side JSON
handling.

## Wire contract

The JSON shape is a cross-repo contract (consumed by `zuraffa` and
`zuraffa_agent` tooling). The normative reference lives in
[`specs/1100-uinode-system/contracts/uinode-api.md`](https://github.com/arrrrny/zuraffa_ui/blob/master/specs/1100-uinode-system/contracts/uinode-api.md)
in the repository, together with the coverage audit that lists the v1
vocabulary and the kinds deliberately excluded from it.
