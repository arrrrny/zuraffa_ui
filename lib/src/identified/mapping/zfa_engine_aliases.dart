// GENERATED FILE — do not edit by hand.
//
// Regenerate with:
//
//     dart run scripts/generate_zfa_aliases.dart
//
// The Zfa brand map for the raw Shad* engine (lib/zfa.dart). Every
// public Shad* declaration the engine exports gets a Zfa* counterpart
// here, so consumers of package:zuraffa_ui/zfa.dart can write Zfa names
// only. The engine itself keeps the upstream Shad* spelling.
//
// An alias is the engine name with its first Shad replaced by Zfa: a
// leading Shad gives a Zfa* name (ShadShadows -> ZfaShadows), while the
// engine's showShad*/GlobalShad*/RestorableShad* shapes keep their
// prefix (showShadDialog -> showZfaDialog, GlobalShadLocalizations ->
// GlobalZfaLocalizations).
//
// Already identified elsewhere (not re-aliased here):
//   ShadButton, ShadCard, ShadDialog, ShadInput, ShadSheet, ShadToaster,
//   ShadTheme, ShadThemeData — certified wrappers and the theme alias seam
//   in src/identified/theme/zfa_theme.dart.
//
// Extension declarations cannot be aliased in Dart (they are
// reached by dot notation, never typed by name):
//   ShadNodeX
//   ShadNodePropertyHelpers
//   ShadNodeCompareE
//   ShadDurationExt
//   ShadDateTime
//   ShadBreakpointsExt
//   ShadBorderSideToBorderSide
//   ShadBorderToBorder
//   ShadRoundedSuperellipseBorderExt
// ignore_for_file: deprecated_member_use_from_same_package

import 'package:zuraffa_ui/src/app.dart';
import 'package:zuraffa_ui/src/components/accordion.dart';
import 'package:zuraffa_ui/src/components/alert.dart';
import 'package:zuraffa_ui/src/components/avatar.dart';
import 'package:zuraffa_ui/src/components/badge.dart';
import 'package:zuraffa_ui/src/components/breadcrumb.dart';
import 'package:zuraffa_ui/src/components/button.dart';
import 'package:zuraffa_ui/src/components/calendar.dart';
import 'package:zuraffa_ui/src/components/checkbox.dart';
import 'package:zuraffa_ui/src/components/context_menu.dart';
import 'package:zuraffa_ui/src/components/date_picker.dart';
import 'package:zuraffa_ui/src/components/default_keyboard_toolbar.dart';
import 'package:zuraffa_ui/src/components/dialog.dart';
import 'package:zuraffa_ui/src/components/form/field.dart';
import 'package:zuraffa_ui/src/components/form/fields/checkbox.dart';
import 'package:zuraffa_ui/src/components/form/fields/date_picker.dart';
import 'package:zuraffa_ui/src/components/form/fields/date_range_picker.dart';
import 'package:zuraffa_ui/src/components/form/fields/input.dart';
import 'package:zuraffa_ui/src/components/form/fields/input_otp.dart';
import 'package:zuraffa_ui/src/components/form/fields/radio.dart';
import 'package:zuraffa_ui/src/components/form/fields/select.dart';
import 'package:zuraffa_ui/src/components/form/fields/switch.dart';
import 'package:zuraffa_ui/src/components/form/fields/textarea.dart';
import 'package:zuraffa_ui/src/components/form/fields/time_picker.dart';
import 'package:zuraffa_ui/src/components/form/form.dart';
import 'package:zuraffa_ui/src/components/icon_button.dart';
import 'package:zuraffa_ui/src/components/input.dart';
import 'package:zuraffa_ui/src/components/input_otp.dart';
import 'package:zuraffa_ui/src/components/menubar.dart';
import 'package:zuraffa_ui/src/components/popover.dart';
import 'package:zuraffa_ui/src/components/progress.dart';
import 'package:zuraffa_ui/src/components/radio.dart';
import 'package:zuraffa_ui/src/components/resizable.dart';
import 'package:zuraffa_ui/src/components/select.dart';
import 'package:zuraffa_ui/src/components/separator.dart';
import 'package:zuraffa_ui/src/components/sheet.dart';
import 'package:zuraffa_ui/src/components/slider.dart';
import 'package:zuraffa_ui/src/components/sonner.dart';
import 'package:zuraffa_ui/src/components/sticky_section_list.dart';
import 'package:zuraffa_ui/src/components/switch.dart';
import 'package:zuraffa_ui/src/components/table.dart';
import 'package:zuraffa_ui/src/components/tabs.dart';
import 'package:zuraffa_ui/src/components/textarea.dart';
import 'package:zuraffa_ui/src/components/time_picker.dart';
import 'package:zuraffa_ui/src/components/toast.dart';
import 'package:zuraffa_ui/src/components/tooltip.dart';
import 'package:zuraffa_ui/src/i18n/localizations_delegate.dart';
import 'package:zuraffa_ui/src/i18n/strings.g.dart';
import 'package:zuraffa_ui/src/raw_components/focusable.dart';
import 'package:zuraffa_ui/src/raw_components/keyboard_toolbar.dart';
import 'package:zuraffa_ui/src/raw_components/portal.dart';
import 'package:zuraffa_ui/src/theme/color_scheme/base.dart';
import 'package:zuraffa_ui/src/theme/color_scheme/blue.dart';
import 'package:zuraffa_ui/src/theme/color_scheme/gray.dart';
import 'package:zuraffa_ui/src/theme/color_scheme/green.dart';
import 'package:zuraffa_ui/src/theme/color_scheme/neutral.dart';
import 'package:zuraffa_ui/src/theme/color_scheme/orange.dart';
import 'package:zuraffa_ui/src/theme/color_scheme/red.dart';
import 'package:zuraffa_ui/src/theme/color_scheme/rose.dart';
import 'package:zuraffa_ui/src/theme/color_scheme/slate.dart';
import 'package:zuraffa_ui/src/theme/color_scheme/stone.dart';
import 'package:zuraffa_ui/src/theme/color_scheme/violet.dart';
import 'package:zuraffa_ui/src/theme/color_scheme/yellow.dart';
import 'package:zuraffa_ui/src/theme/color_scheme/zinc.dart';
import 'package:zuraffa_ui/src/theme/components/accordion.dart';
import 'package:zuraffa_ui/src/theme/components/alert.dart';
import 'package:zuraffa_ui/src/theme/components/avatar.dart';
import 'package:zuraffa_ui/src/theme/components/badge.dart';
import 'package:zuraffa_ui/src/theme/components/breadcrumb.dart';
import 'package:zuraffa_ui/src/theme/components/button.dart';
import 'package:zuraffa_ui/src/theme/components/button_sizes.dart';
import 'package:zuraffa_ui/src/theme/components/calendar.dart';
import 'package:zuraffa_ui/src/theme/components/card.dart';
import 'package:zuraffa_ui/src/theme/components/checkbox.dart';
import 'package:zuraffa_ui/src/theme/components/context_menu.dart';
import 'package:zuraffa_ui/src/theme/components/date_picker.dart';
import 'package:zuraffa_ui/src/theme/components/decorator.dart';
import 'package:zuraffa_ui/src/theme/components/default_keyboard_toolbar.dart';
import 'package:zuraffa_ui/src/theme/components/dialog.dart';
import 'package:zuraffa_ui/src/theme/components/input.dart';
import 'package:zuraffa_ui/src/theme/components/input_decorator.dart';
import 'package:zuraffa_ui/src/theme/components/input_otp.dart';
import 'package:zuraffa_ui/src/theme/components/menubar.dart';
import 'package:zuraffa_ui/src/theme/components/option.dart';
import 'package:zuraffa_ui/src/theme/components/popover.dart';
import 'package:zuraffa_ui/src/theme/components/progress.dart';
import 'package:zuraffa_ui/src/theme/components/radio.dart';
import 'package:zuraffa_ui/src/theme/components/resizable.dart';
import 'package:zuraffa_ui/src/theme/components/select.dart';
import 'package:zuraffa_ui/src/theme/components/separator.dart';
import 'package:zuraffa_ui/src/theme/components/sheet.dart';
import 'package:zuraffa_ui/src/theme/components/slider.dart';
import 'package:zuraffa_ui/src/theme/components/sonner.dart';
import 'package:zuraffa_ui/src/theme/components/sticky_section_list.dart';
import 'package:zuraffa_ui/src/theme/components/switch.dart';
import 'package:zuraffa_ui/src/theme/components/table.dart';
import 'package:zuraffa_ui/src/theme/components/tabs.dart';
import 'package:zuraffa_ui/src/theme/components/textarea.dart';
import 'package:zuraffa_ui/src/theme/components/time_picker.dart';
import 'package:zuraffa_ui/src/theme/components/toast.dart';
import 'package:zuraffa_ui/src/theme/components/tooltip.dart';
import 'package:zuraffa_ui/src/theme/text_theme/text_styles_default.dart';
import 'package:zuraffa_ui/src/theme/text_theme/theme.dart';
import 'package:zuraffa_ui/src/theme/theme.dart';
import 'package:zuraffa_ui/src/theme/themes/base.dart';
import 'package:zuraffa_ui/src/theme/themes/default_theme_variant.dart';
import 'package:zuraffa_ui/src/theme/themes/shadows.dart';
import 'package:zuraffa_ui/src/uinode/nodes/nodes.dart';
import 'package:zuraffa_ui/src/uinode/render/shad_node_renderer.dart';
import 'package:zuraffa_ui/src/uinode/tree/shad_node_parser.dart';
import 'package:zuraffa_ui/src/uinode/tree/shad_node_tree.dart';
import 'package:zuraffa_ui/src/utils/animate.dart';
import 'package:zuraffa_ui/src/utils/animation_builder.dart';
import 'package:zuraffa_ui/src/utils/border.dart';
import 'package:zuraffa_ui/src/utils/clipboard/clipboard_service.dart';
import 'package:zuraffa_ui/src/utils/gesture_detector.dart';
import 'package:zuraffa_ui/src/utils/mouse_area.dart';
import 'package:zuraffa_ui/src/utils/mouse_cursor_provider.dart';
import 'package:zuraffa_ui/src/utils/position.dart';
import 'package:zuraffa_ui/src/utils/provider.dart';
import 'package:zuraffa_ui/src/utils/provider_index.dart';
import 'package:zuraffa_ui/src/utils/responsive.dart';
import 'package:zuraffa_ui/src/utils/states_controller.dart';
import 'package:zuraffa_ui/src/utils/text_editing_controller.dart';

// src/uinode/tree/shad_node_tree.dart
typedef ZfaNodeTree = ShadNodeTree;

// src/uinode/tree/shad_node_parser.dart
typedef ZfaNodeParser = ShadNodeParser;

// src/uinode/render/shad_node_renderer.dart
typedef ZfaNodeRenderHost = ShadNodeRenderHost;
typedef ZfaNodeRenderer = ShadNodeRenderer;
typedef ZfaNodeMapper = ShadNodeMapper;

// src/uinode/nodes/nodes.dart
typedef ZfaNode = ShadNode;

// src/utils/text_editing_controller.dart
typedef ZfaTextEditingController = ShadTextEditingController;

// src/utils/states_controller.dart
typedef ZfaState = ShadState;
typedef ZfaStatesController = ShadStatesController;

// src/utils/responsive.dart
typedef ZfaBreakpoints = ShadBreakpoints;
typedef ZfaBreakpoint = ShadBreakpoint;
typedef ZfaBreakpointTN = ShadBreakpointTN;
typedef ZfaBreakpointSM = ShadBreakpointSM;
typedef ZfaBreakpointMD = ShadBreakpointMD;
typedef ZfaBreakpointLG = ShadBreakpointLG;
typedef ZfaBreakpointXL = ShadBreakpointXL;
typedef ZfaBreakpointXXL = ShadBreakpointXXL;
typedef ZfaResponsiveBuilder = ShadResponsiveBuilder;

// src/utils/provider_index.dart
typedef ZfaProviderIndex = ShadProviderIndex;
typedef ZfaIndexProvider = ShadIndexProvider;

// src/utils/provider.dart
typedef ZfaProvider<T> = ShadProvider<T>;

// src/utils/position.dart
typedef ZfaPosition = ShadPosition;

// src/utils/mouse_cursor_provider.dart
typedef ZfaMouseCursorController = ShadMouseCursorController;
typedef ZfaMouseCursorProvider = ShadMouseCursorProvider;
typedef ZfaMouseCursorProviderState = ShadMouseCursorProviderState;

// src/utils/mouse_area.dart
typedef ZfaMouseArea = ShadMouseArea;
typedef ZfaMouseAreaRenderBox = ShadMouseAreaRenderBox;
typedef ZfaMouseAreaSurface = ShadMouseAreaSurface;

// src/utils/gesture_detector.dart
typedef ZfaHoverStrategies = ShadHoverStrategies;
typedef ZfaHoverStrategy = ShadHoverStrategy;
typedef ZfaGestureDetector = ShadGestureDetector;

// src/utils/clipboard/clipboard_service.dart
typedef ZfaClipboardItem = ShadClipboardItem;

// src/utils/border.dart
typedef ZfaBorder = ShadBorder;
typedef ZfaBorderSide = ShadBorderSide;
typedef ZfaRoundedSuperellipseBorder = ShadRoundedSuperellipseBorder;

// src/utils/animation_builder.dart
typedef ZfaAnimationBuilder = ShadAnimationBuilder;

// src/utils/animate.dart
typedef ZfaAnimate = ShadAnimate;

// src/theme/themes/shadows.dart
typedef ZfaShadows = ShadShadows;

// src/theme/themes/default_theme_variant.dart
typedef ZfaDefaultThemeVariant = ShadDefaultThemeVariant;

// src/theme/themes/base.dart
typedef ZfaBaseTheme = ShadBaseTheme;
typedef ZfaThemeVariant = ShadThemeVariant;

// src/theme/theme.dart
typedef ZfaInheritedTheme = ShadInheritedTheme;
typedef ZfaThemeDataTween = ShadThemeDataTween;
typedef ZfaAnimatedTheme = ShadAnimatedTheme;

// src/theme/text_theme/theme.dart
typedef ZfaTextTheme = ShadTextTheme;

// src/theme/text_theme/text_styles_default.dart
typedef ZfaTextDefaultTheme = ShadTextDefaultTheme;

// src/theme/components/tooltip.dart
typedef ZfaTooltipTheme = ShadTooltipTheme;

// src/theme/components/toast.dart
typedef ZfaToastTheme = ShadToastTheme;

// src/theme/components/time_picker.dart
typedef ZfaTimePickerTheme = ShadTimePickerTheme;

// src/theme/components/textarea.dart
typedef ZfaTextareaTheme = ShadTextareaTheme;

// src/theme/components/tabs.dart
typedef ZfaTabsTheme = ShadTabsTheme;

// src/theme/components/table.dart
typedef ZfaTableTheme = ShadTableTheme;

// src/theme/components/switch.dart
typedef ZfaSwitchTheme = ShadSwitchTheme;

// src/theme/components/sticky_section_list.dart
typedef ZfaStickySectionListTheme = ShadStickySectionListTheme;

// src/theme/components/sonner.dart
typedef ZfaSonnerTheme = ShadSonnerTheme;

// src/theme/components/slider.dart
typedef ZfaSliderTheme = ShadSliderTheme;

// src/theme/components/sheet.dart
typedef ZfaSheetTheme = ShadSheetTheme;

// src/theme/components/separator.dart
typedef ZfaSeparatorTheme = ShadSeparatorTheme;

// src/theme/components/select.dart
typedef ZfaSelectTheme = ShadSelectTheme;

// src/theme/components/resizable.dart
typedef ZfaResizableTheme = ShadResizableTheme;

// src/theme/components/radio.dart
typedef ZfaRadioTheme = ShadRadioTheme;

// src/theme/components/progress.dart
typedef ZfaProgressTheme = ShadProgressTheme;

// src/theme/components/popover.dart
typedef ZfaPopoverTheme = ShadPopoverTheme;

// src/theme/components/option.dart
typedef ZfaOptionTheme = ShadOptionTheme;

// src/theme/components/menubar.dart
typedef ZfaMenubarTheme = ShadMenubarTheme;

// src/theme/components/input_otp.dart
typedef ZfaInputOTPTheme = ShadInputOTPTheme;

// src/theme/components/input_decorator.dart
typedef ZfaInputDecorator = ShadInputDecorator;

// src/theme/components/input.dart
typedef ZfaInputTheme = ShadInputTheme;

// src/theme/components/dialog.dart
typedef ZfaDialogTheme = ShadDialogTheme;

// src/theme/components/default_keyboard_toolbar.dart
typedef ZfaDefaultKeyboardToolbarTheme = ShadDefaultKeyboardToolbarTheme;

// src/theme/components/decorator.dart
typedef ZfaDecoration = ShadDecoration;
typedef ZfaDecorator = ShadDecorator;
typedef ZfaOutwardBorderPainter = ShadOutwardBorderPainter;

// src/theme/components/date_picker.dart
typedef ZfaDatePickerTheme = ShadDatePickerTheme;

// src/theme/components/context_menu.dart
typedef ZfaContextMenuTheme = ShadContextMenuTheme;

// src/theme/components/checkbox.dart
typedef ZfaCheckboxTheme = ShadCheckboxTheme;

// src/theme/components/card.dart
typedef ZfaCardTheme = ShadCardTheme;

// src/theme/components/calendar.dart
typedef ZfaCalendarTheme = ShadCalendarTheme;

// src/theme/components/button_sizes.dart
typedef ZfaButtonSizeTheme = ShadButtonSizeTheme;
typedef ZfaButtonSizesTheme = ShadButtonSizesTheme;

// src/theme/components/button.dart
typedef ZfaButtonTheme = ShadButtonTheme;

// src/theme/components/breadcrumb.dart
typedef ZfaBreadcrumbTheme = ShadBreadcrumbTheme;

// src/theme/components/badge.dart
typedef ZfaBadgeTheme = ShadBadgeTheme;

// src/theme/components/avatar.dart
typedef ZfaAvatarTheme = ShadAvatarTheme;

// src/theme/components/alert.dart
typedef ZfaAlertTheme = ShadAlertTheme;

// src/theme/components/accordion.dart
typedef ZfaAccordionTheme = ShadAccordionTheme;

// src/theme/color_scheme/zinc.dart
typedef ZfaZincColorScheme = ShadZincColorScheme;

// src/theme/color_scheme/yellow.dart
typedef ZfaYellowColorScheme = ShadYellowColorScheme;

// src/theme/color_scheme/violet.dart
typedef ZfaVioletColorScheme = ShadVioletColorScheme;

// src/theme/color_scheme/stone.dart
typedef ZfaStoneColorScheme = ShadStoneColorScheme;

// src/theme/color_scheme/slate.dart
typedef ZfaSlateColorScheme = ShadSlateColorScheme;

// src/theme/color_scheme/rose.dart
typedef ZfaRoseColorScheme = ShadRoseColorScheme;

// src/theme/color_scheme/red.dart
typedef ZfaRedColorScheme = ShadRedColorScheme;

// src/theme/color_scheme/orange.dart
typedef ZfaOrangeColorScheme = ShadOrangeColorScheme;

// src/theme/color_scheme/neutral.dart
typedef ZfaNeutralColorScheme = ShadNeutralColorScheme;

// src/theme/color_scheme/green.dart
typedef ZfaGreenColorScheme = ShadGreenColorScheme;

// src/theme/color_scheme/gray.dart
typedef ZfaGrayColorScheme = ShadGrayColorScheme;

// src/theme/color_scheme/blue.dart
typedef ZfaBlueColorScheme = ShadBlueColorScheme;

// src/theme/color_scheme/base.dart
typedef ZfaColorScheme = ShadColorScheme;

// src/raw_components/portal.dart
typedef ZfaAnchorBase = ShadAnchorBase;
typedef ZfaAnchorAuto = ShadAnchorAuto;
typedef ZfaAnchor = ShadAnchor;
typedef ZfaGlobalAnchor = ShadGlobalAnchor;
typedef ZfaPortal = ShadPortal;
typedef ZfaPositionDelegate = ShadPositionDelegate;

// src/raw_components/keyboard_toolbar.dart
typedef ZfaKeyboardToolbar = ShadKeyboardToolbar;

// src/raw_components/focusable.dart
typedef ZfaFocusable = ShadFocusable;

// src/i18n/strings.g.dart
typedef ZfaLocale = ShadLocale;
typedef ZfaLocalizationsDataEn = ShadLocalizationsDataEn;
typedef ZfaLocalizationsData = ShadLocalizationsData;
typedef ZfaLocalizationsData$timePicker$en =
    ShadLocalizationsData$timePicker$en;
typedef ZfaLocalizationsData$datePicker$en =
    ShadLocalizationsData$datePicker$en;
typedef ZfaLocalizationsData$input$en = ShadLocalizationsData$input$en;
typedef ZfaLocalizationsData$keyboardToolbar$en =
    ShadLocalizationsData$keyboardToolbar$en;

// src/i18n/localizations_delegate.dart
typedef GlobalZfaLocalizations = GlobalShadLocalizations;
typedef ZfaLocalizations = ShadLocalizations;

// src/components/tooltip.dart
typedef ZfaTooltipController = ShadTooltipController;
typedef ZfaTooltip = ShadTooltip;

// src/components/toast.dart
typedef ZfaToasterState = ShadToasterState;
typedef ZfaToasterScope = ShadToasterScope;
typedef ZfaToastVariant = ShadToastVariant;
typedef ZfaToast = ShadToast;

// src/components/time_picker.dart
typedef ZfaDayPeriod = ShadDayPeriod;
typedef ZfaTimeOfDay = ShadTimeOfDay;
typedef ZfaTimePickerController = ShadTimePickerController;
typedef ZfaTimePickerVariant = ShadTimePickerVariant;
typedef ZfaTimePicker = ShadTimePicker;
typedef ZfaTimePickerField = ShadTimePickerField;
typedef ZfaTimePickerTextEditingController =
    ShadTimePickerTextEditingController;

// src/components/textarea.dart
typedef ZfaTextarea = ShadTextarea;
typedef ZfaDefaultResizeGrip = ShadDefaultResizeGrip;
typedef ZfaResizeGripPainter = ShadResizeGripPainter;

// src/components/tabs.dart
typedef ZfaTabsController<T> = ShadTabsController<T>;
typedef RestorableZfaTabsController<T> = RestorableShadTabsController<T>;
typedef ZfaTabs<T> = ShadTabs<T>;
typedef ZfaTabsState<T> = ShadTabsState<T>;
typedef ZfaTab<T> = ShadTab<T>;

// src/components/table.dart
typedef ZfaTableCellBuilder = ShadTableCellBuilder;
typedef ZfaTableCellVariant = ShadTableCellVariant;
typedef ZfaTableCell = ShadTableCell;
typedef ZfaTable = ShadTable;

// src/components/switch.dart
typedef ZfaSwitch = ShadSwitch;

// src/components/sticky_section_list.dart
typedef ZfaListSection = ShadListSection;
typedef ZfaStickySectionList = ShadStickySectionList;

// src/components/sonner.dart
typedef ZfaSonnerScope = ShadSonnerScope;
typedef ZfaSonner = ShadSonner;
typedef ZfaSonnerState = ShadSonnerState;

// src/components/slider.dart
typedef ZfaSliderInteraction = ShadSliderInteraction;
typedef ZfaSliderController = ShadSliderController;
typedef ZfaSlider = ShadSlider;

// src/components/sheet.dart
const showZfaSheet = showShadSheet;
typedef ZfaSheetInheritedWidget = ShadSheetInheritedWidget;
typedef ZfaSheetSide = ShadSheetSide;
typedef ZfaSheetDragHandleBuilder = ShadSheetDragHandleBuilder;
typedef ZfaSheetController = ShadSheetController;
typedef ZfaSheetGestureDetector = ShadSheetGestureDetector;
typedef ZfaSheetResizeHandle = ShadSheetResizeHandle;
typedef ZfaSheetLayoutWithSizeListener = ShadSheetLayoutWithSizeListener;

// src/components/separator.dart
typedef ZfaSeparatorVariant = ShadSeparatorVariant;
typedef ZfaSeparator = ShadSeparator;

// src/components/select.dart
typedef ZfaSelectedOptionBuilder<T> = ShadSelectedOptionBuilder<T>;
typedef ZfaSelectController<T> = ShadSelectController<T>;
typedef ZfaSelectVariant = ShadSelectVariant;
typedef ZfaSelect<T> = ShadSelect<T>;
typedef ZfaSelectState<T> = ShadSelectState<T>;
typedef ZfaOption<T> = ShadOption<T>;

// src/components/resizable.dart
typedef ZfaResizeResult = ShadResizeResult;
typedef ZfaPanelInfo = ShadPanelInfo;
typedef ZfaResizableController = ShadResizableController;
typedef ZfaResizablePanelGroup = ShadResizablePanelGroup;
typedef ZfaResizablePanelGroupState = ShadResizablePanelGroupState;
typedef ZfaResizablePanel = ShadResizablePanel;

// src/components/radio.dart
typedef ZfaRadioController<T> = ShadRadioController<T>;
typedef ZfaRadioGroup<T> = ShadRadioGroup<T>;
typedef ZfaRadioGroupState<T> = ShadRadioGroupState<T>;
typedef ZfaRadio<T> = ShadRadio<T>;

// src/components/progress.dart
typedef ZfaProgress = ShadProgress;
typedef ZfaIndeterminateProgress = ShadIndeterminateProgress;
typedef ZfaDeterminateProgress = ShadDeterminateProgress;

// src/components/popover.dart
typedef ZfaPopoverController = ShadPopoverController;
typedef ZfaPopover = ShadPopover;

// src/components/menubar.dart
typedef ZfaMenubarController = ShadMenubarController;
typedef ZfaMenubar = ShadMenubar;
typedef ZfaMenubarItem = ShadMenubarItem;

// src/components/input_otp.dart
typedef ZfaInputOTP = ShadInputOTP;
typedef ZfaInputOTPState = ShadInputOTPState;
typedef ZfaInputOTPGroup = ShadInputOTPGroup;
typedef ZfaInputOTPSlot = ShadInputOTPSlot;

// src/components/input.dart
typedef ZfaInputState = ShadInputState;
typedef ZfaTextSelectionToolbar = ShadTextSelectionToolbar;
typedef ZfaToolbarButton = ShadToolbarButton;

// src/components/icon_button.dart
typedef ZfaIconButton = ShadIconButton;

// src/components/form/form.dart
typedef ZfaAutovalidateMode = ShadAutovalidateMode;
typedef ZfaFormFields = ShadFormFields;
typedef ZfaForm = ShadForm;
typedef ZfaFormState = ShadFormState;
typedef ZfaFormScope = ShadFormScope;

// src/components/form/fields/time_picker.dart
typedef ZfaTimePickerFormField = ShadTimePickerFormField;
typedef ZfaFormBuilderTimePickerState = ShadFormBuilderTimePickerState;

// src/components/form/fields/textarea.dart
typedef ZfaTextareaFormField = ShadTextareaFormField;
typedef ZfaFormBuilderTextareaState = ShadFormBuilderTextareaState;

// src/components/form/fields/switch.dart
typedef ZfaSwitchFormField = ShadSwitchFormField;
typedef ZfaFormBuilderSwitchState = ShadFormBuilderSwitchState;

// src/components/form/fields/select.dart
typedef ZfaSelectFormField<T> = ShadSelectFormField<T>;
typedef ZfaFormBuilderSelectState<T> = ShadFormBuilderSelectState<T>;
typedef ZfaSelectMultipleFormField<T> = ShadSelectMultipleFormField<T>;
typedef ZfaFormBuilderSelectMultipleState<T> =
    ShadFormBuilderSelectMultipleState<T>;

// src/components/form/fields/radio.dart
typedef ZfaRadioGroupFormField<T> = ShadRadioGroupFormField<T>;
typedef ZfaFormBuilderRadioGroupState<T> = ShadFormBuilderRadioGroupState<T>;

// src/components/form/fields/input_otp.dart
typedef ZfaInputOTPFormField = ShadInputOTPFormField;
typedef ZfaFormBuilderInputOTPState = ShadFormBuilderInputOTPState;

// src/components/form/fields/input.dart
typedef ZfaInputFormField = ShadInputFormField;
typedef ZfaFormBuilderInputState = ShadFormBuilderInputState;

// src/components/form/fields/date_range_picker.dart
typedef ZfaDateRangePickerFormField = ShadDateRangePickerFormField;
typedef ZfaFormBuilderDateRangePickerState =
    ShadFormBuilderDateRangePickerState;

// src/components/form/fields/date_picker.dart
typedef ZfaDatePickerFormField = ShadDatePickerFormField;
typedef ZfaFormBuilderDatePickerState = ShadFormBuilderDatePickerState;

// src/components/form/fields/checkbox.dart
typedef ZfaCheckboxFormField = ShadCheckboxFormField;
typedef ZfaFormBuilderCheckboxState = ShadFormBuilderCheckboxState;

// src/components/form/field.dart
typedef ZfaFormBuilderField<T> = ShadFormBuilderField<T>;
typedef ZfaFormBuilderFieldState<F extends ShadFormBuilderField<T>, T> =
    ShadFormBuilderFieldState<F, T>;

// src/components/dialog.dart
typedef ZfaDialogRoute<T> = ShadDialogRoute<T>;
const showZfaDialog = showShadDialog;
typedef ZfaDialogVariant = ShadDialogVariant;

// src/components/default_keyboard_toolbar.dart
typedef ZfaDefaultKeyboardToolbar = ShadDefaultKeyboardToolbar;

// src/components/date_picker.dart
typedef ZfaDatePickerVariant = ShadDatePickerVariant;
typedef ZfaDatePicker = ShadDatePicker;

// src/components/context_menu.dart
typedef ZfaContextMenuRegion = ShadContextMenuRegion;
typedef ZfaContextMenuController = ShadContextMenuController;
typedef ZfaContextMenu = ShadContextMenu;
typedef ZfaContextMenuState = ShadContextMenuState;
typedef ZfaContextMenuItemController = ShadContextMenuItemController;
typedef ZfaContextMenuItemVariant = ShadContextMenuItemVariant;
typedef ZfaContextMenuItem = ShadContextMenuItem;

// src/components/checkbox.dart
typedef ZfaCheckbox = ShadCheckbox;

// src/components/calendar.dart
typedef ZfaDateTimeRange = ShadDateTimeRange;
typedef ZfaCalendarModel = ShadCalendarModel;
typedef ZfaCalendarVariant = ShadCalendarVariant;
typedef ZfaCalendarCaptionLayout = ShadCalendarCaptionLayout;
typedef ZfaCalendar = ShadCalendar;

// src/components/button.dart
typedef ZfaButtonVariant = ShadButtonVariant;
typedef ZfaButtonSize = ShadButtonSize;

// src/components/breadcrumb.dart
typedef ZfaBreadcrumb = ShadBreadcrumb;
typedef ZfaBreadcrumbLink = ShadBreadcrumbLink;
typedef ZfaBreadcrumbSeparator = ShadBreadcrumbSeparator;
typedef ZfaBreadcrumbEllipsis = ShadBreadcrumbEllipsis;
typedef ZfaBreadcrumbDropdown = ShadBreadcrumbDropdown;
typedef ZfaBreadcrumbDropMenuItem = ShadBreadcrumbDropMenuItem;

// src/components/badge.dart
typedef ZfaBadgeVariant = ShadBadgeVariant;
typedef ZfaBadge = ShadBadge;

// src/components/avatar.dart
typedef ZfaAvatar = ShadAvatar;

// src/components/alert.dart
typedef ZfaAlertVariant = ShadAlertVariant;
typedef ZfaAlert = ShadAlert;

// src/components/accordion.dart
typedef ZfaAccordionController<T> = ShadAccordionController<T>;
typedef ZfaAccordionVariant = ShadAccordionVariant;
typedef ZfaAccordion<T> = ShadAccordion<T>;
typedef ZfaAccordionState<T> = ShadAccordionState<T>;
typedef ZfaAccordionItem<T> = ShadAccordionItem<T>;

// src/app.dart
typedef ZfaAppType = ShadAppType;
typedef ZfaApp = ShadApp;
typedef ZfaScrollBehavior = ShadScrollBehavior;
typedef ZfaAppBuilder = ShadAppBuilder;
