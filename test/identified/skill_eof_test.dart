import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every generated skill file ends with exactly one trailing newline', () {
    final files = Directory(
      'skills/zuraffa-ui-flutter',
    ).listSync(recursive: true).whereType<File>().toList();

    expect(files, hasLength(40));
    for (final file in files) {
      final content = file.readAsStringSync();
      expect(
        content.endsWith('\n') && !content.endsWith('\n\n'),
        isTrue,
        reason:
            '${file.path} must end with exactly one newline — regenerate with '
            '`dart run scripts/generate_skills.dart`',
      );
    }
  });
}
