import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:zuraffa_ui/zfa.dart' as zfa;

// The Zfa brand map (lib/src/identified/mapping/zfa_engine_aliases.dart) must
// cover every public Shad* name the engine exports through lib/zfa.dart, so a
// consumer of that library can write Zfa names only.
//
// This test walks the same export graph the generator walks
// (scripts/generate_zfa_aliases.dart, following relative `export` and `part`
// directives) and fails when the engine and the map drift apart.
//
// Keep the exemption set in sync with `_alreadyIdentified` in the generator.

/// Shad* names that already carry a Zfa identity elsewhere in the identified
/// layer, so the map does not alias them a second time.
const _alreadyIdentified = <String>{
  'ShadButton', // ZfaButton — certified wrapper
  'ShadCard', // ZfaCard
  'ShadDialog', // ZfaDialog
  'ShadInput', // ZfaInput
  'ShadSheet', // ZfaSheet
  'ShadToaster', // ZfaToaster
  'ShadTheme', // ZfaTheme — the alias seam in zfa_theme.dart
  'ShadThemeData', // ZfaThemeData
};

const _identifier = r'[A-Za-z0-9_$]';

final _typeDeclaration = RegExp(
  '^(?:abstract |sealed |final |base |interface )?'
  '(?:class|mixin|enum|typedef)\\s+($_identifier+)',
);
final _extensionDeclaration = RegExp('^extension\\s+($_identifier+)');
final _functionDeclaration = RegExp(
  '^[A-Za-z_\$][A-Za-z0-9_<>,?\\. ]*\\s+([a-z]$_identifier*)'
  r'(?:<[^>]*>)?\s*\(',
);

const _mappingPath = 'lib/src/identified/mapping/zfa_engine_aliases.dart';

void main() {
  final mapping = File(_mappingPath).readAsStringSync();
  final engine = _engineDeclarations();

  // alias -> engine name, from `typedef ZfaX<T> = ShadX<T>;` and the
  // `final`/`const` forms, including wrapped lines.
  final aliases = <String, String>{
    for (final match in RegExp(
      '^(?:typedef|final|const) ($_identifier+)(?:<[^=]*?>)? =\\s*'
      '($_identifier+)',
      multiLine: true,
    ).allMatches(mapping))
      match.group(1)!: match.group(2)!,
  };

  group('Zfa brand map', () {
    test('aliases every public Shad* type the engine exports', () {
      final missing = <String>[];
      for (final name in engine.types) {
        if (_alreadyIdentified.contains(name)) continue;
        if (aliases[name.replaceAll('Shad', 'Zfa')] != name) missing.add(name);
      }
      expect(
        missing,
        isEmpty,
        reason:
            'every public Shad* type reachable from lib/zfa.dart needs a '
            '`typedef Zfa* = Shad*;` in $_mappingPath — run '
            '`dart run scripts/generate_zfa_aliases.dart`. Missing: $missing',
      );
    });

    test('aliases every public Shad* function and variable', () {
      final missing = <String>[];
      for (final name in engine.values) {
        if (aliases[name.replaceAll('Shad', 'Zfa')] != name) missing.add(name);
      }
      expect(
        missing,
        isEmpty,
        reason:
            'every public Shad* function or variable reachable from '
            'lib/zfa.dart needs a `Zfa* = Shad*;` alias in $_mappingPath — '
            'run `dart run scripts/generate_zfa_aliases.dart`. '
            'Missing: $missing',
      );
    });

    test('contains no alias the engine no longer declares', () {
      final engineNames = {...engine.types, ...engine.values};
      final known = {
        for (final name in engineNames) name.replaceAll('Shad', 'Zfa'),
      };
      final stale = <String>[];
      for (final alias in aliases.keys) {
        if (!known.contains(alias)) stale.add(alias);
      }
      expect(
        stale,
        isEmpty,
        reason:
            'aliases without an engine counterpart are drift — regenerate '
            '$_mappingPath. Stale: $stale',
      );
    });

    test('documents the Shad* extensions it cannot alias', () {
      // Dart cannot alias an extension name; the map records them instead, so
      // an engine that grows a new Shad* extension fails here until the
      // generator is rerun.
      final undocumented = <String>[];
      for (final name in engine.extensions) {
        if (!_alreadyIdentified.contains(name) &&
            !mapping.contains('//   $name')) {
          undocumented.add(name);
        }
      }
      expect(
        undocumented,
        isEmpty,
        reason:
            'Shad* extensions cannot be aliased; the generated header must '
            'list them — run `dart run scripts/generate_zfa_aliases.dart`. '
            'Undocumented: $undocumented',
      );
    });
  });

  group('consumer surface', () {
    test('Zfa names resolve through package:zuraffa_ui/zfa.dart', () {
      // Compile-time proof: the names the app writes resolve, and the engine's
      // generic dialog helper stays generic under its Zfa alias.
      final types = <Type>[
        zfa.ZfaApp,
        zfa.ZfaTooltip,
        zfa.ZfaIconButton,
        zfa.ZfaSelect,
        zfa.ZfaOption,
        zfa.ZfaSeparator,
        zfa.ZfaSwitch,
        zfa.ZfaToast,
        zfa.ZfaZincColorScheme,
        zfa.ZfaPopover,
        zfa.ZfaPopoverController,
        zfa.ZfaContextMenuRegion,
        zfa.ZfaContextMenuItem,
        zfa.ZfaCard,
        zfa.ZfaButton,
        zfa.ZfaTheme,
        zfa.ZfaThemeData,
        zfa.ZuraffaApp,
      ];
      expect(types, hasLength(18));

      // The engine's generic dialog helper stays generic under its alias.
      expect(zfa.showZfaDialog<int>, isNotNull);
    });
  });
}

class _EngineDeclarations {
  _EngineDeclarations(this.types, this.values, this.extensions);

  final Set<String> types;
  final Set<String> values;
  final Set<String> extensions;
}

_EngineDeclarations _engineDeclarations() {
  final types = <String>{};
  final values = <String>{};
  final extensions = <String>{};

  for (final file in _exportedEngineFiles(
    File('lib/zfa.dart').readAsStringSync(),
  )) {
    for (final line in File('lib/$file').readAsStringSync().split('\n')) {
      final type = _typeDeclaration.firstMatch(line);
      if (type != null) {
        types.add(type.group(1)!);
        continue;
      }
      final function = _functionDeclaration.firstMatch(line);
      if (function != null) {
        values.add(function.group(1)!);
        continue;
      }
      final extension = _extensionDeclaration.firstMatch(line);
      if (extension != null && extension.group(1) != 'on') {
        extensions.add(extension.group(1)!);
      }
    }
  }

  bool mapped(String name) => name.contains('Shad') && !name.startsWith('_');
  return _EngineDeclarations(
    types.where(mapped).toSet(),
    values.where(mapped).toSet(),
    extensions.where(mapped).toSet(),
  );
}

/// Every engine file reachable from [source], following relative `export` and
/// `part` directives.
Set<String> _exportedEngineFiles(String source) {
  final files = <String>{};
  final pending = <String>[
    for (final match in RegExp(
      "export '(src/[^']+)'",
      multiLine: true,
    ).allMatches(source))
      match.group(1)!,
  ];
  while (pending.isNotEmpty) {
    final file = pending.removeLast();
    if (!files.add(file)) continue;
    final path = File('lib/$file');
    if (!path.existsSync()) continue;
    final content = path.readAsStringSync();
    final directory = file.substring(0, file.lastIndexOf('/'));
    final relative = RegExp(
      "^(?:part|export) '([^']+)'",
      multiLine: true,
    );
    for (final match in relative.allMatches(content)) {
      final target = match.group(1)!;
      if (target.startsWith('package:') || target.startsWith('dart:')) continue;
      pending.add(_normalize(directory, target));
    }
  }
  return files;
}

String _normalize(String directory, String path) {
  final stacked = <String>[];
  for (final part in [...directory.split('/'), ...path.split('/')]) {
    switch (part) {
      case '.':
        break;
      case '..':
        if (stacked.isNotEmpty) stacked.removeLast();
      default:
        stacked.add(part);
    }
  }
  return stacked.join('/');
}
