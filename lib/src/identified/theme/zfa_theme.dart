import 'package:zuraffa_ui/src/theme/data.dart';
import 'package:zuraffa_ui/src/theme/theme.dart';

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
