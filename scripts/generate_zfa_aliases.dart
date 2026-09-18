// Generates the Zfa brand map for the raw Shad* engine.
//
//     dart run scripts/generate_zfa_aliases.dart
//
// The engine (`lib/zfa.dart` and everything it exports) keeps its upstream
// `Shad*` names so upstream merges stay mechanical. This script writes one
// `Zfa*` alias per public `Shad*` declaration into
// `lib/src/identified/mapping/zfa_engine_aliases.dart`, so consumers of
// `package:zuraffa_ui/zfa.dart` can write Zfa names only.
//
// The coverage test `test/identified/zfa_alias_coverage_test.dart` fails when
// the map drifts from the engine.
import 'dart:io';

/// The generated map, relative to `lib/`. The generator writes it and the
/// export walk skips it — it is output, not engine input.
const _mappingPath = 'src/identified/mapping/zfa_engine_aliases.dart';

/// Shad* names that already carry a Zfa identity elsewhere in the identified
/// layer; the map must not alias them a second time.
///
/// Kept in sync with `_alreadyIdentified` in
/// `test/identified/zfa_alias_coverage_test.dart`.
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

final _typeDeclaration = RegExp(
  '^(?:abstract |sealed |final |base |interface )?'
  r'(?:class|mixin|enum|typedef)\s+([A-Za-z_$][A-Za-z0-9_$]*)',
);
final _extensionDeclaration = RegExp(
  r'^extension\s+([A-Za-z_$][A-Za-z0-9_$]*)',
);
final _variableDeclaration = RegExp(
  r'^(?:const|final|var|late)\s+(?:[A-Za-z_$][A-Za-z0-9_<>,?\. ]*\s+)?'
  r'([A-Za-z_$][A-Za-z0-9_$]*)\s*[=;]',
);
final _functionDeclaration = RegExp(
  r'^[A-Za-z_$][A-Za-z0-9_<>,?\. ]*\s+([a-z][A-Za-z0-9_$]*)'
  r'(?:<[^>]*>)?\s*\(',
);

/// A `Shad*` name declared at the top level of an exported engine file.
class _Declaration {
  _Declaration(this.name, this.kind, [this.typeParameters]);

  final String name;

  /// `type`, `variable`, `function` or `extension`.
  final String kind;

  /// The raw `<...>` that follows a generic type's name, e.g. `<T>`.
  final String? typeParameters;
}

void main() {
  final barrel = File('lib/zfa.dart');
  if (!barrel.existsSync()) {
    stderr.writeln('lib/zfa.dart not found — run from the repository root.');
    exitCode = 1;
    return;
  }

  final files = _exportedEngineFiles(barrel.readAsStringSync());
  final declarationsByLibrary = <String, List<_Declaration>>{};
  final extensions = <String>[];
  final seen = <String, String>{};

  for (final entry in files.entries) {
    final file = entry.key;
    final library = entry.value;
    final source = File('lib/$file').readAsStringSync();
    final declarations = <_Declaration>[];
    for (final line in source.split('\n')) {
      final declaration = _parseDeclaration(line);
      if (declaration == null) continue;
      if (declaration.kind == 'extension') {
        // Dart cannot alias an extension name; only the Shad-named ones are
        // worth reporting (an unnamed `extension on X` parses as `on`).
        if (declaration.name != 'on' &&
            declaration.name.contains('Shad') &&
            !extensions.contains(declaration.name)) {
          extensions.add(declaration.name);
        }
        continue;
      }
      if (!declaration.name.contains('Shad')) continue;
      if (declaration.name.startsWith('_')) continue;
      if (_alreadyIdentified.contains(declaration.name)) continue;
      final previous = seen[declaration.name];
      if (previous != null) {
        if (previous != file) {
          stderr.writeln(
            'warning: ${declaration.name} declared in both $previous and $file',
          );
        }
        continue;
      }
      seen[declaration.name] = file;
      declarations.add(declaration);
    }
    if (declarations.isNotEmpty) {
      declarationsByLibrary.putIfAbsent(library, () => []).addAll(declarations);
    }
  }

  final buffer = StringBuffer()
    ..writeln('// GENERATED FILE — do not edit by hand.')
    ..writeln('//')
    ..writeln('// Regenerate with:')
    ..writeln('//')
    ..writeln('//     dart run scripts/generate_zfa_aliases.dart')
    ..writeln('//')
    ..writeln(
      '// The Zfa brand map for the raw Shad* engine (lib/zfa.dart). Every',
    )
    ..writeln(
      '// public Shad* declaration the engine exports gets a Zfa* counterpart',
    )
    ..writeln(
      '// here, so consumers of package:zuraffa_ui/zfa.dart can write Zfa names',
    )
    ..writeln('// only. The engine itself keeps the upstream Shad* spelling.')
    ..writeln('//')
    ..writeln(
      '// An alias is the engine name with its first Shad replaced by Zfa: a',
    )
    ..writeln(
      '// leading Shad gives a Zfa* name (ShadShadows -> ZfaShadows), while the',
    )
    ..writeln(
      "// engine's showShad*/GlobalShad*/RestorableShad* shapes keep their",
    )
    ..writeln(
      '// prefix (showShadDialog -> showZfaDialog, GlobalShadLocalizations ->',
    )
    ..writeln('// GlobalZfaLocalizations).')
    ..writeln('//')
    ..writeln('// Already identified elsewhere (not re-aliased here):');
  for (final line in _wrap(
    '${_alreadyIdentified.join(', ')} — certified wrappers and '
    'the theme alias seam in src/identified/theme/zfa_theme.dart.',
    72,
  )) {
    buffer.writeln('//   $line');
  }
  buffer.writeln('//');
  buffer.writeln(
    '// Extension declarations cannot be aliased in Dart (they are',
  );
  buffer.writeln('// reached by dot notation, never typed by name):');
  for (final extension in extensions) {
    buffer.writeln('//   $extension');
  }
  buffer
    ..writeln('// ignore_for_file: deprecated_member_use_from_same_package')
    ..writeln();

  final imports = declarationsByLibrary.keys.toList()..sort();
  for (final file in imports) {
    buffer.writeln("import 'package:zuraffa_ui/$file';");
  }
  buffer.writeln();

  for (final file in declarationsByLibrary.keys) {
    buffer.writeln('// $file');
    for (final declaration in declarationsByLibrary[file]!) {
      final alias = _aliasFor(declaration.name);
      final parameters = declaration.typeParameters;
      final aliasParameters = parameters == null
          ? ''
          : '<${_typeParameterDeclarations(parameters).join(', ')}>';
      final arguments = parameters == null
          ? ''
          : '<${_typeParameterNames(parameters).join(', ')}>';
      switch (declaration.kind) {
        case 'type':
          _write(
            buffer,
            'typedef $alias$aliasParameters = ${declaration.name}$arguments;',
          );
        case 'function':
          _write(buffer, 'const $alias = ${declaration.name};');
        default:
          _write(buffer, 'final $alias = ${declaration.name};');
      }
    }
    buffer.writeln();
  }

  final output = File(
    'lib/$_mappingPath',
  );
  output.parent.createSync(recursive: true);
  output.writeAsStringSync('${buffer.toString().trimRight()}\n');

  final aliasCount = seen.length;
  stdout.writeln(
    'wrote ${output.path}: $aliasCount aliases '
    'from ${declarationsByLibrary.length} engine libraries',
  );
  if (extensions.isNotEmpty) {
    stdout.writeln(
      'skipped ${extensions.length} extensions: ${extensions.join(', ')}',
    );
  }
}

/// The `Zfa*` alias for an engine declaration named [name].
///
/// The engine name's **first** `Shad` becomes `Zfa`; every later occurrence is
/// left alone (`ShadShadows` -> `ZfaShadows`, never `ZfaZfaows`). Two shapes
/// come out of that rule:
///
///   - a leading `Shad` gives a `Zfa*` name — `ShadButton` -> `ZfaButton`;
///   - the engine's `showShad*` / `GlobalShad*` / `RestorableShad*` names keep
///     their prefix, with the `Shad` after it becoming `Zfa` —
///     `showShadDialog` -> `showZfaDialog`, `GlobalShadLocalizations` ->
///     `GlobalZfaLocalizations`, `RestorableShadTabsController` ->
///     `RestorableZfaTabsController`.
///
/// `test/identified/zfa_alias_coverage_test.dart` asserts the map matches this
/// rule, so an engine name that would break it fails the guard.
String _aliasFor(String name) => name.replaceFirst('Shad', 'Zfa');

/// Every engine file reachable from `lib/zfa.dart`, mapped to the library file
/// that must be imported to reach its declarations (a `part` file is imported
/// through the library it belongs to).
///
/// Every *relative* `export` is followed, not only the `src/` ones, so a barrel
/// re-export such as `lib/zfa.dart`'s own `export 'zuraffa_ui.dart';` cannot
/// hide a public `Shad*` name from the map. `package:`/`dart:` exports leave
/// the engine tree and are skipped.
Map<String, String> _exportedEngineFiles(String source) {
  final libraries = <String, String>{};
  final pending = <String>[
    for (final match in RegExp(
      "export '([^']+)'",
      multiLine: true,
    ).allMatches(source))
      if (!_isExternalExport(match.group(1)!)) match.group(1)!,
  ];
  while (pending.isNotEmpty) {
    final file = pending.removeLast();
    // Never walk the map itself: it is the generator's output, so its own
    // `Zfa*` declarations (e.g. `ZfaShadows`) would otherwise be read back as
    // engine names and re-aliased on every run.
    if (file == _mappingPath) continue;
    if (libraries.containsKey(file)) continue;
    final path = File('lib/$file');
    if (!path.existsSync()) {
      stderr.writeln('warning: exported file lib/$file does not exist');
      continue;
    }
    libraries[file] = file;
    final content = path.readAsStringSync();
    final directory = _directoryOf(file);
    for (final match in RegExp(
      "^part '([^']+)'",
      multiLine: true,
    ).allMatches(content)) {
      libraries[_normalize(directory, match.group(1)!)] = file;
    }
    for (final match in RegExp(
      "export '([^']+)'",
      multiLine: true,
    ).allMatches(content)) {
      final target = match.group(1)!;
      if (_isExternalExport(target)) continue;
      pending.add(_normalize(directory, target));
    }
  }
  return libraries;
}

/// Whether [path] leaves the engine tree (`package:` / `dart:` imports).
bool _isExternalExport(String path) =>
    path.startsWith('package:') || path.startsWith('dart:');

/// The directory part of [file], or `''` for a top-level `lib/` file — whose
/// `lastIndexOf('/')` is `-1`, not a usable offset.
String _directoryOf(String file) {
  final cut = file.lastIndexOf('/');
  return cut < 0 ? '' : file.substring(0, cut);
}

String _normalize(String directory, String path) {
  final parts = <String>[...directory.split('/'), ...path.split('/')];
  final stacked = <String>[];
  for (final part in parts) {
    switch (part) {
      case '':
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

_Declaration? _parseDeclaration(String line) {
  final type = _typeDeclaration.firstMatch(line);
  if (type != null) {
    final name = type.group(1)!;
    return _Declaration(name, 'type', _typeParameters(line, name));
  }
  final extension = _extensionDeclaration.firstMatch(line);
  if (extension != null) return _Declaration(extension.group(1)!, 'extension');
  final variable = _variableDeclaration.firstMatch(line);
  if (variable != null) return _Declaration(variable.group(1)!, 'variable');
  final function = _functionDeclaration.firstMatch(line);
  if (function != null) return _Declaration(function.group(1)!, 'function');
  return null;
}

/// The `<...>` type-parameter list following [name] on [line], if any.
String? _typeParameters(String line, String name) {
  final index = line.indexOf(name);
  if (index < 0) return null;
  final rest = line.substring(index + name.length);
  if (!rest.startsWith('<')) return null;
  var depth = 0;
  for (var i = 0; i < rest.length; i++) {
    if (rest[i] == '<') depth++;
    if (rest[i] == '>') {
      depth--;
      if (depth == 0) return rest.substring(0, i + 1);
    }
  }
  return null;
}

/// The alias-side type-parameter list: bounds kept (a bound naming an engine
/// type must still be satisfied), defaults dropped.
List<String> _typeParameterDeclarations(String parameters) => [
  for (final part in _typeParameterParts(parameters))
    _stripDefault(part.trim()),
];

/// The target-side type arguments, e.g. `<F extends A<T>, T>` -> `F, T`.
List<String> _typeParameterNames(String parameters) => [
  for (final part in _typeParameterParts(parameters))
    if (RegExp(r'^\s*([A-Za-z_$][A-Za-z0-9_$]*)').firstMatch(part)
        case final match?)
      match.group(1)!,
];

/// Splits `<...>` into its top-level comma-separated parts.
List<String> _typeParameterParts(String parameters) {
  final parts = <String>[];
  final current = StringBuffer();
  var depth = 0;
  for (final char in parameters.substring(1, parameters.length - 1).split('')) {
    switch (char) {
      case '<':
      case '(':
      case '[':
        depth++;
      case '>':
      case ')':
      case ']':
        depth--;
      case ',' when depth == 0:
        parts.add(current.toString());
        current.clear();
        continue;
    }
    current.write(char);
  }
  parts.add(current.toString());
  return parts;
}

String _stripDefault(String parameter) {
  final index = parameter.indexOf(' = ');
  return index < 0 ? parameter : parameter.substring(0, index);
}

/// Writes [line], wrapping after `=` when it would exceed 80 characters.
void _write(StringBuffer buffer, String line) {
  if (line.length <= 80) {
    buffer.writeln(line);
    return;
  }
  final index = line.indexOf(' = ');
  buffer
    ..writeln(line.substring(0, index + 2))
    ..writeln('    ${line.substring(index + 3)}');
}

/// Greedily wraps [text] to lines of at most [width] characters.
List<String> _wrap(String text, int width) {
  final lines = <String>[];
  var current = StringBuffer();
  for (final word in text.split(' ')) {
    if (current.isNotEmpty && current.length + word.length + 1 > width) {
      lines.add(current.toString());
      current = StringBuffer();
    }
    if (current.isNotEmpty) current.write(' ');
    current.write(word);
  }
  if (current.isNotEmpty) lines.add(current.toString());
  return lines;
}
