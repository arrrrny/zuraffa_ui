import 'package:zuraffa_ui/src/theme/data.dart';
import 'package:zuraffa_ui/src/theme/theme.dart';

// Re-export `ThemeMode` (and the `ThemeMode`-adjacent theme types a consumer
// needs to call the shell) so a skin that imports only this package barrel
// names the SAME `ThemeMode` `ShadApp`/`ZuraffaApp` accept — material_ui's,
// not the Flutter SDK's. Before zuraffa_ui 7.6.0 the shell's `themeMode`
// parameter was typed on the SDK's `ThemeMode`; the 7.6.0 minor adopted
// shadcn_ui 0.60.0's breaking `package:flutter/material.dart` -> standalone
// `material_ui` migration, so `themeMode` is now material_ui's `ThemeMode` —
// a nominally distinct type. A consumer importing `package:flutter/material.dart`
// for `ThemeMode` and passing it to the shell failed to compile with
// "The argument type 'ThemeMode/*1*/' can't be assigned to the parameter
// type 'ThemeMode/*2*/?'" (arrrrny/zuraffa#2110). Re-exporting the family's
// type here lets the consumer take it from the zuraffa_ui import instead.
export 'package:material_ui/material_ui.dart' show ThemeMode;

/// The theme alias of the skin lane.
///
/// `ZfaTheme` **is** [ShadTheme] — a type alias, not a copy: skins type
/// `ZfaTheme.of(context)` and never a Shad name, while the identified layer
/// stays a zero-cost rename that upstream cannot break.
typedef ZfaTheme = ShadTheme;

/// The theme data alias of the skin lane.
///
/// `ZfaThemeData` **is** [ShadThemeData]: constructors, statics and all.
typedef ZfaThemeData = ShadThemeData;
