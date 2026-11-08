import 'package:flutter/widgets.dart';
import 'package:zuraffa_ui/src/identified/theme/zfa_theme.dart';
import 'package:zuraffa_ui/src/theme/color_scheme/forklift.dart';

/// The skin-lane alias of the Forklift brand palette.
///
/// `ZfaForkliftPalette` **is** [ShadForkliftPalette]: the raw brand tokens
/// sampled from the app icon artwork.
typedef ZfaForkliftPalette = ShadForkliftPalette;

/// The certified Forklift theme entry points for skins.
///
/// Build a [ZfaThemeData] straight from the Forklift palette without
/// touching a `Shad*` engine name:
///
/// ```dart
/// ZuraffaApp(theme: ZfaForkliftTheme.dark(), ...)
/// ```
class ZfaForkliftTheme {
  const ZfaForkliftTheme._();

  /// The Forklift theme in light brightness.
  static ZfaThemeData light() => ZfaThemeData(
    colorScheme: const ShadForkliftColorScheme.light(),
    brightness: Brightness.light,
  );

  /// The Forklift theme in dark brightness, matching the app icon
  /// background ([ZfaForkliftPalette.background]).
  static ZfaThemeData dark() => ZfaThemeData(
    colorScheme: const ShadForkliftColorScheme.dark(),
    brightness: Brightness.dark,
  );
}
