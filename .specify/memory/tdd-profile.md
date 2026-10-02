---
detected_at: afc9569
ecosystems: [dart]
default: dart
stacks:
  dart:
    cwd: .
    runner: flutter test
    single: 'flutter test {file} --plain-name "{name}"'
    file: 'flutter test {file}'
    suite: 'flutter test'
    watch: null
    coverage: null
    mutation: 'dart run mutation_test'
    acceptance: 'flutter test {file}'
    property: null
    approval: flutter test (matchesGoldenFile)
    contract: null
    test_glob: "test/**/*_test.dart"
    exemplar:
      unit: test/src/components/button_test.dart
      acceptance: test/identified/barrel_surface_test.dart
    helpers: []
verified: [single, file, suite, acceptance, mutation]
suite_baseline: green
suite_seconds: 71
notes: >-
  mutation_test 1.8.1 is a dev dependency; `zfa tdd verify --runner flutter`
  drives it over a feature's TDD subjects (latest audit: gate pass, 8 killed /
  0 survived, 373s). Flutter widget tests run under `flutter test`; `dart test`
  cannot run them.
---
