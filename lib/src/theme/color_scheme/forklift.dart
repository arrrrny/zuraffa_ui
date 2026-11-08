import 'package:flutter/widgets.dart';
import 'package:zuraffa_ui/src/theme/color_scheme/base.dart';

/// The Forklift brand palette, sampled from the app icon artwork.
///
/// These are the raw brand tokens; [ShadForkliftColorScheme] maps them onto
/// the semantic [ShadColorScheme] slots for light and dark brightness.
@immutable
class ShadForkliftPalette {
  const ShadForkliftPalette._();

  /// App-icon background.
  static const Color background = Color(0xFF27272B);

  /// Frame / mast purple.
  static const Color purple = Color(0xFF7662BD);

  /// Shaded purple.
  static const Color purpleDark = Color(0xFF594A8E);

  /// Deep purple, used for selection and pressed states.
  static const Color purpleDeep = Color(0xFF43386B);

  /// Body orange, the primary brand color.
  static const Color orange = Color(0xFFFFA538);

  /// Highlight orange.
  static const Color orangeLight = Color(0xFFFFC538);

  /// Cardboard tan, the accent brand color.
  static const Color tan = Color(0xFFDEA861);

  /// Shaded tan.
  static const Color tanDark = Color(0xFFCC8241);

  /// Light tan, top faces of the cargo.
  static const Color tanLight = Color(0xFFEBCBA0);

  /// Wheel hubs / near-white foreground on dark.
  static const Color hub = Color(0xFFE9E5F6);
}

@immutable
class ShadForkliftColorScheme extends ShadColorScheme {
  const ShadForkliftColorScheme({
    required super.background,
    required super.foreground,
    required super.card,
    required super.cardForeground,
    required super.popover,
    required super.popoverForeground,
    required super.primary,
    required super.primaryForeground,
    required super.secondary,
    required super.secondaryForeground,
    required super.muted,
    required super.mutedForeground,
    required super.accent,
    required super.accentForeground,
    required super.destructive,
    required super.destructiveForeground,
    required super.border,
    required super.input,
    required super.ring,
    required super.selection,
    super.custom,
  });

  const ShadForkliftColorScheme.light({
    super.background = const Color(0xFFFFFFFF),
    super.foreground = ShadForkliftPalette.background,
    super.card = const Color(0xFFFFFFFF),
    super.cardForeground = ShadForkliftPalette.background,
    super.popover = const Color(0xFFFFFFFF),
    super.popoverForeground = ShadForkliftPalette.background,
    super.primary = const Color(0xFFE8890C),
    super.primaryForeground = const Color(0xFFFFFFFF),
    super.secondary = ShadForkliftPalette.purple,
    super.secondaryForeground = const Color(0xFFFFFFFF),
    super.muted = const Color(0xFFF4F4F5),
    super.mutedForeground = const Color(0xFF71717A),
    super.accent = ShadForkliftPalette.tan,
    super.accentForeground = ShadForkliftPalette.background,
    super.destructive = const Color(0xFFEF4444),
    super.destructiveForeground = const Color(0xFFFAFAFA),
    super.border = const Color(0xFFE4E4E7),
    super.input = const Color(0xFFE4E4E7),
    super.ring = ShadForkliftPalette.purple,
    super.selection = const Color(0xFFDCD6F2),
    super.custom = const {
      'brandPurple': ShadForkliftPalette.purple,
      'brandPurpleDark': ShadForkliftPalette.purpleDark,
      'brandPurpleDeep': ShadForkliftPalette.purpleDeep,
      'brandOrange': ShadForkliftPalette.orange,
      'brandOrangeLight': ShadForkliftPalette.orangeLight,
      'brandTan': ShadForkliftPalette.tan,
      'brandTanDark': ShadForkliftPalette.tanDark,
      'brandTanLight': ShadForkliftPalette.tanLight,
    },
  });

  const ShadForkliftColorScheme.dark({
    super.background = ShadForkliftPalette.background,
    super.foreground = ShadForkliftPalette.hub,
    super.card = const Color(0xFF2E2E34),
    super.cardForeground = ShadForkliftPalette.hub,
    super.popover = const Color(0xFF2E2E34),
    super.popoverForeground = ShadForkliftPalette.hub,
    super.primary = ShadForkliftPalette.orange,
    super.primaryForeground = ShadForkliftPalette.background,
    super.secondary = ShadForkliftPalette.purple,
    super.secondaryForeground = ShadForkliftPalette.hub,
    super.muted = const Color(0xFF35353D),
    super.mutedForeground = const Color(0xFFA1A1AA),
    super.accent = ShadForkliftPalette.tan,
    super.accentForeground = ShadForkliftPalette.background,
    super.destructive = const Color(0xFFEF4444),
    super.destructiveForeground = const Color(0xFFFAFAFA),
    super.border = const Color(0xFF3F3F46),
    super.input = const Color(0xFF3F3F46),
    super.ring = ShadForkliftPalette.orange,
    super.selection = ShadForkliftPalette.purpleDeep,
    super.custom = const {
      'brandPurple': ShadForkliftPalette.purple,
      'brandPurpleDark': ShadForkliftPalette.purpleDark,
      'brandPurpleDeep': ShadForkliftPalette.purpleDeep,
      'brandOrange': ShadForkliftPalette.orange,
      'brandOrangeLight': ShadForkliftPalette.orangeLight,
      'brandTan': ShadForkliftPalette.tan,
      'brandTanDark': ShadForkliftPalette.tanDark,
      'brandTanLight': ShadForkliftPalette.tanLight,
    },
  });
}
