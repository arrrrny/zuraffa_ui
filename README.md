# Zuraffa UI

> `zuraffa_ui` — the skin lane's certified vocabulary: identified Zfa
> components + `ZuraffaApp`, repackaged end to end from the
> [`shadcn_ui`](https://github.com/nank1ro/flutter-shadcn-ui) Flutter port
> (fork of nank1ro/flutter-shadcn-ui at `shadcn_ui` 0.56.3, base fork SHA
> `afc95690e53629324ddbf094ca78021f56848bd4`).

## Skin lane usage (certified surface)

```yaml
dependencies:
  zuraffa_ui: ^0.1.0
```

```dart
import 'package:zuraffa_ui/zuraffa_ui.dart';

ZuraffaApp(
  theme: ZfaThemeData(brightness: Brightness.dark),
  home: const SkinShell(),
)
```

`ZfaButton`, `ZfaInput`, `ZfaCard`, `ZfaSheet`, `ZfaDialog`, `ZfaToaster` each
carry the typed contract protocol (`contractId` / `contractEnabled`), so
runtime contract auditors, xray decks and slice manifests can identify them
without grepping. Raw `Shad*` engine names are internal — reachable through
`package:zuraffa_ui/shad.dart`, never the package barrel.

## Engine (upstream lineage)

Everything below documents the engine underneath — the full shadcn/ui port
component set — and the upstream project it tracks.

[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://github.com/nank1ro/flutter-shadcn-ui/blob/main/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/nank1ro/flutter-shadcn-ui)](https://gitHub.com/nank1ro/flutter-shadcn-ui/stargazers/)
[![GitHub issues](https://img.shields.io/github/issues/nank1ro/flutter-shadcn-ui)](https://gitHub.com/nank1ro/flutter-shadcn-ui/issues/)
[![GitHub pull-requests](https://img.shields.io/github/issues-pr/nank1ro/flutter-shadcn-ui.svg)](https://gitHub.com/nank1ro/flutter-shadcn-ui/pull/)
[![shadcn_ui Pub Version (including pre-releases)](https://img.shields.io/pub/v/shadcn_ui?include_prereleases)](https://pub.dev/packages/shadcn_ui)
![CodeRabbit Pull Request Reviews](https://img.shields.io/coderabbit/prs/github/nank1ro/flutter-shadcn-ui)
[![Join Discord](https://dcbadge.limes.pink/api/server/ZhRMAPNh5Y?style=flat)](https://discord.gg/ZhRMAPNh5Y)
[![Supported by ufirst](https://custom-icon-badges.demolab.com/badge/Supported%20by-ufirst-blue?logo=heart)](https://ufirst.com)

<a href="https://www.buymeacoffee.com/nank1ro" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>

The engine: shadcn/ui ported in Flutter. Awesome UI components, fully customizable — carried over unchanged (apart from the package rename) from the upstream fork.

## Documentation

The certified `Zfa*` surface is documented above. The engine components below it
are documented by the upstream project: see the
[upstream documentation](https://mariuti.com/flutter-shadcn-ui/) to interact
with them and see the code.

### Agent Skills

You can install the [Agent Skills](https://agentskills.io) for this project with:

```bash
npx skills add arrrrny/zuraffa_ui
```

## Progress

> Follow the progress on [X (Twitter)](https://twitter.com/nank1ro)

- [x] [Accordion](https://mariuti.com/flutter-shadcn-ui/components/accordion/)
- [x] [Alert](https://mariuti.com/flutter-shadcn-ui/components/alert/)
- [x] [Breadcrumb](https://mariuti.com/flutter-shadcn-ui/components/breadcrumb/)
- [x] [Dialog](https://mariuti.com/flutter-shadcn-ui/components/dialog/)
- [x] [Avatar](https://mariuti.com/flutter-shadcn-ui/components/avatar/)
- [x] [Badge](https://mariuti.com/flutter-shadcn-ui/components/badge/)
- [x] [Button](https://mariuti.com/flutter-shadcn-ui/components/button/)
- [x] [IconButton](https://mariuti.com/flutter-shadcn-ui/components/icon-button/)
- [x] [Calendar](https://mariuti.com/flutter-shadcn-ui/components/calendar/)
- [x] [Card](https://mariuti.com/flutter-shadcn-ui/components/card/)
- [ ] Carousel
- [x] [Checkbox](https://mariuti.com/flutter-shadcn-ui/components/checkbox/)
- [ ] Collapsible
- [x] [Combobox](https://mariuti.com/flutter-shadcn-ui/components/select/#with-search)
- [ ] Command
- [x] [Context Menu](https://mariuti.com/flutter-shadcn-ui/components/context-menu/)
- [ ] Data Table
- [x] [Date Picker](https://mariuti.com/flutter-shadcn-ui/components/date-picker/)
- [ ] Drawer
- [x] <strike>Dropdown Menu</strike> Use Context Menu instead
- [x] [Form](https://mariuti.com/flutter-shadcn-ui/components/form/)
- [x] <strike>Hover Card</strike> Use Popover instead
- [x] [Input](https://mariuti.com/flutter-shadcn-ui/components/input/)
- [x] [Input OTP](https://mariuti.com/flutter-shadcn-ui/components/input-otp/)
- [x] <strike>Label</strike> Use Text instead
- [x] [Menubar](https://mariuti.com/flutter-shadcn-ui/components/menubar/)
- [ ] Navigation Menu
- [ ] Pagination
- [x] [Popover](https://mariuti.com/flutter-shadcn-ui/components/popover/)
- [x] [Progress](https://mariuti.com/flutter-shadcn-ui/components/progress/)
- [x] [RadioGroup](https://mariuti.com/flutter-shadcn-ui/components/radio-group/)
- [x] [Resizable](https://mariuti.com/flutter-shadcn-ui/components/resizable/)
- [x] <strike>Scroll Area</strike> Use SingleScrollView, ListView etc. instead
- [x] [Select](https://mariuti.com/flutter-shadcn-ui/components/select/)
- [x] [Separator](https://mariuti.com/flutter-shadcn-ui/components/separator/)
- [x] [Sheet](https://mariuti.com/flutter-shadcn-ui/components/sheet/)
- [ ] Skeleton
- [x] [Slider](https://mariuti.com/flutter-shadcn-ui/components/slider/)
- [x] [Sonner](https://mariuti.com/flutter-shadcn-ui/components/sonner/)
- [x] [Switch](https://mariuti.com/flutter-shadcn-ui/components/switch/)
- [x] [Table](https://mariuti.com/flutter-shadcn-ui/components/table/)
- [x] [Tabs](https://mariuti.com/flutter-shadcn-ui/components/tabs/)
- [x] [TextArea](https://mariuti.com/flutter-shadcn-ui/components/text-area/)
- [x] [Time Picker](https://mariuti.com/flutter-shadcn-ui/components/time-picker/)
- [x] [Toast](https://mariuti.com/flutter-shadcn-ui/components/toast/)
- [ ] Toggle
- [ ] ToggleGroup
- [x] [Tooltip](https://mariuti.com/flutter-shadcn-ui/components/tooltip/)

## FAQs

<details>
<summary>What's the difference with shadcn_flutter</summary>
My repo was created the 05/01/2024 while he started the 12/02/2024. He never contacted me to contribute.
It's an open source project, I'd love to have contributions.

Each widget I make takes some time because I try to solve problems in a simple way, making each widget extremely customizable.

Another library could probably come first with more widgets, but in the long run it's the quality the most important thing.
</details>

## Star History

[![Star History Chart](https://star-history.dera.page/svg?repos=nank1ro/flutter-shadcn-ui&type=Date)](https://star-history.dera.page/#nank1ro/flutter-shadcn-ui&Date)
