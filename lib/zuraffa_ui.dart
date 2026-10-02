/// The zuraffa_ui package barrel: the skin lane's certified vocabulary.
///
/// Only identified `Zfa*` names are exported here — the app shell
/// (ZuraffaApp), the certified components, the theme aliases
/// (ZfaTheme/ZfaThemeData) and the contract kit. Raw `Shad*` engine names
/// are internal: they are reachable through the engine library
/// `package:zuraffa_ui/zfa.dart`, never through this barrel. Skins import
/// only this file.
library;

export 'src/identified/app/zuraffa_app.dart';
export 'src/identified/components/zfa_button.dart';
export 'src/identified/components/zfa_card.dart';
export 'src/identified/components/zfa_dialog.dart';
export 'src/identified/components/zfa_input.dart';
export 'src/identified/components/zfa_sheet.dart';
export 'src/identified/components/zfa_toaster.dart';
export 'src/identified/contract/skin_contract_kit.dart';
export 'src/identified/theme/zfa_theme.dart';
