import 'package:zuraffa_ui/src/theme/data.dart';
import 'package:zuraffa_ui/src/theme/theme.dart';

// `ThemeMode` is the type `ShadApp.themeMode` / `ZuraffaApp.themeMode` accept.
// material_ui re-declares the enum instead of re-exporting the framework one,
// so a migrating app takes it from here and needs no direct material_ui
// dependency (#78). It is re-exported from this file — which
// `lib/zuraffa_ui.dart` exports and `lib/zfa.dart` reaches through its trailing
// `export 'zuraffa_ui.dart';` — so both barrels carry it with one declaration.
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
