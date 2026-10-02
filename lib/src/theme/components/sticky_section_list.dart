import 'package:flutter/widgets.dart';
import 'package:theme_extensions_builder_annotation/theme_extensions_builder_annotation.dart';
import 'package:zuraffa_ui/src/utils/border.dart';

part 'sticky_section_list.g.theme.dart';

@themeGen
@immutable
class ShadStickySectionListTheme with _$ShadStickySectionListTheme {
  const ShadStickySectionListTheme({
    bool canMerge = true,
    this.padding,
    this.headerPadding,
    this.headerBackgroundColor,
    this.headerBorder,
    this.headerAlignment,
    this.inlineHeaderPadding,
    this.inlineHeaderBackgroundColor,
    this.clipBehavior,
  }) : _canMerge = canMerge;

  @ignore
  final bool _canMerge;

  @override
  bool get canMerge => _canMerge;

  /// {@macro ShadStickySectionList.padding}
  final EdgeInsetsGeometry? padding;

  /// {@macro ShadStickySectionList.headerPadding}
  final EdgeInsetsGeometry? headerPadding;

  /// {@macro ShadStickySectionList.headerBackgroundColor}
  final Color? headerBackgroundColor;

  /// {@macro ShadStickySectionList.headerBorder}
  final ShadBorder? headerBorder;

  /// {@macro ShadStickySectionList.headerAlignment}
  final AlignmentGeometry? headerAlignment;

  /// {@macro ShadStickySectionList.inlineHeaderPadding}
  final EdgeInsetsGeometry? inlineHeaderPadding;

  /// {@macro ShadStickySectionList.inlineHeaderBackgroundColor}
  final Color? inlineHeaderBackgroundColor;

  /// {@macro ShadStickySectionList.clipBehavior}
  final Clip? clipBehavior;

  static ShadStickySectionListTheme? lerp(
    ShadStickySectionListTheme? a,
    ShadStickySectionListTheme? b,
    double t,
  ) => _$ShadStickySectionListTheme.lerp(a, b, t);
}
