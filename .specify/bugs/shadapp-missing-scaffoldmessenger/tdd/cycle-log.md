# Cycle Log

Append only. Newest last. Every entry's `red` block is the evidence that the test existed and failed before the implementation.

## Cycle: A1 (error)

- behavior: A1
- kind: error
- outcome: unresolved
- criterion: AC-1
- test: test/
- command: `/Users/arrrrny/.local/bin/zfa tdd verify-red A1 --feature .specify/bugs/shadapp-missing-scaffoldmessenger --project /Users/arrrrny/Developer/zuraffa_ui --timeout 25.0000`
- exit: 1
- at: 2026-09-17T22:09:59.347187Z
- output:
```
zfa tdd verify-red: behavior A1
   feature: shadapp-missing-scaffoldmessenger
   test: test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart
zfa tdd verify-red: no `single` command template found in /Users/arrrrny/Developer/zuraffa_ui/.specify/memory/tdd-profile.md. Add a `single:` key to the Keys (machine-readable) block or a `- Single test:` bullet, then re-run.
verify-red: behavior=A1 classification=unresolved certified=false feature=shadapp-missing-scaffoldmessenger
```

- schema: 1
- prev-hash: genesis
- hash: fadd03677474f34ffc58f63951206f106977431c1717266872b69b7c9874d489

## Cycle: A1 (red)

- behavior: A1
- kind: red
- classification: assertionFailure
- subject-hash: b43fa09a12be1a7c71d22cb36af6de7c8b09cdd4f810155498b4d5dfd360ee5c
- criterion: AC-1
- test: test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart
- command: `flutter test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart --plain-name "it resolves a `ScaffoldMessengerState` without throwing."`
- exit: 1
- at: 2026-09-17T22:14:53.931375Z
- output:
```
Resolving dependencies...
Downloading packages...
  code_assets 2.0.0 (2.1.0 available)
  lucide_icons_flutter 3.1.19 (3.1.20 available)
  material_color_utilities 0.13.0 (0.13.1 available)
  slang 4.19.1 (4.19.2 available)
  test_api 0.7.12 (0.7.14 available)
  very_good_analysis 10.3.0 (11.0.0 available)
Got dependencies!
6 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Resolving dependencies in `./example`...
Downloading packages...
Got dependencies in `./example`.

00:00 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:01 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:02 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:03 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:04 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:05 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:06 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:07 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:08 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:09 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:10 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:11 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:12 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:13 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:14 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:15 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:16 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:17 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:17 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:18 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:18 +0 -1: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing. [E]                                                                                                               
  Expected: not <Instance of 'UnimplementedError'>
    Actual: UnimplementedError:<UnimplementedError: subject_a1 not implemented>
  
  package:matcher                                               expect
  package:flutter_test/src/widget_tester.dart 473:18            expect
  test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart 37:7  main.<fn>.<fn>
  

To run this test again: /usr/local/share/flutter/bin/cache/dart-sdk/bin/dart test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart -p vm --plain-name 'A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.'

00:18 +0 -1: Some tests failed.
```

- schema: 1
- prev-hash: fadd03677474f34ffc58f63951206f106977431c1717266872b69b7c9874d489
- hash: 3829bf97c406ea0544345d8b07686d8e1a2c9461922d229bef6f4d13988a9e48

## Cycle: A1 (green)

- behavior: A1
- kind: green
- subject-hash: 0ff4c6a9f26965d7bf2933d4dc3095405fb10a51128dea0c93f59415d876d950
- criterion: AC-1
- test: test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart
- command: `flutter test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart --plain-name "it resolves a `ScaffoldMessengerState` without throwing."`
- exit: 0
- at: 2026-09-17T22:22:24.313801Z
- output:
```
Resolving dependencies...
Downloading packages...
  code_assets 2.0.0 (2.1.0 available)
  lucide_icons_flutter 3.1.19 (3.1.20 available)
  material_color_utilities 0.13.0 (0.13.1 available)
  slang 4.19.1 (4.19.2 available)
  test_api 0.7.12 (0.7.14 available)
  very_good_analysis 10.3.0 (11.0.0 available)
Got dependencies!
6 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Resolving dependencies in `./example`...
Downloading packages...
Got dependencies in `./example`.

00:00 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:01 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:02 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:03 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:04 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:05 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:06 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:07 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:08 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:09 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:10 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:11 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:12 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:13 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:14 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:15 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:16 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:17 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:18 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:19 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:20 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:21 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:22 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:23 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:24 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:25 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:26 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:27 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:28 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:29 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:30 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:31 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:32 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:33 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:34 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:35 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:36 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:37 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:37 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:38 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:39 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:40 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:41 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:42 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:43 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:44 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:45 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:46 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:47 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:48 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:49 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:50 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:51 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:52 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:53 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:54 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:55 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:56 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:57 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:58 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:59 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:00 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:01 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:02 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:03 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:04 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:04 +1: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:04 +1: All tests passed!
```
- generation:
  (none)
- suite: baseline=0 guard=0 new=(none)

- schema: 1
- prev-hash: 3829bf97c406ea0544345d8b07686d8e1a2c9461922d229bef6f4d13988a9e48
- hash: 33243b05ff830b6793b503eed339bdae0e7a98b5fad2b48864de8a075f3c8dc4

## Cycle: A1 (green)

- behavior: A1
- kind: green
- subject-hash: 0ff4c6a9f26965d7bf2933d4dc3095405fb10a51128dea0c93f59415d876d950
- criterion: AC-1
- test: test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart
- command: `flutter test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart --plain-name "it resolves a `ScaffoldMessengerState` without throwing."`
- exit: 0
- at: 2026-09-17T22:34:47.960473Z
- output:
```
Resolving dependencies...
Downloading packages...
  code_assets 2.0.0 (2.1.0 available)
  lucide_icons_flutter 3.1.19 (3.1.20 available)
  material_color_utilities 0.13.0 (0.13.1 available)
  slang 4.19.1 (4.19.2 available)
  test_api 0.7.12 (0.7.14 available)
  very_good_analysis 10.3.0 (11.0.0 available)
Got dependencies!
6 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Resolving dependencies in `./example`...
Downloading packages...
Got dependencies in `./example`.

00:00 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:01 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:02 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:03 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:04 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:05 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:06 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:07 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:08 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:09 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:10 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:11 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:12 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:13 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:14 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:15 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:16 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:17 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:18 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:19 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:20 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:21 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:22 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:23 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:24 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:25 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:26 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:27 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:28 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:29 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:30 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:31 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:32 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:33 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:34 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:35 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:36 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:37 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:38 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:39 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:40 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:41 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:42 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:43 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:44 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:45 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:46 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:47 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:48 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:49 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:50 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:51 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:52 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:53 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:54 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:55 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:55 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:56 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:57 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:58 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:59 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:00 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:01 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:02 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:03 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:04 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:05 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:06 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:07 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:08 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:09 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:10 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:11 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:12 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:13 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:14 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:15 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:16 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:17 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:18 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:19 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:20 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:21 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:22 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:23 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:24 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:24 +1: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
01:24 +1: All tests passed!
```
- generation:
  (none)
- suite: baseline=0 guard=0 new=(none)

- schema: 1
- prev-hash: 33243b05ff830b6793b503eed339bdae0e7a98b5fad2b48864de8a075f3c8dc4
- hash: 1cbd915e1eb66a2c4fe51f1cce08585603915596df2391930092379f6392f850

## Cycle: A3 (red)

- behavior: A3
- kind: red
- classification: assertionFailure
- subject-hash: 13cb333438ee697aacbd5c3ff9f3db60a75d3392c1b8b3b2d396d4d6ed8742fd
- criterion: AC-3
- test: test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart
- command: `flutter test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart --plain-name "it resolves the shell's messenger without throwing."`
- exit: 1
- at: 2026-09-17T22:36:40.508454Z
- output:
```
Resolving dependencies...
Downloading packages...
  code_assets 2.0.0 (2.1.0 available)
  lucide_icons_flutter 3.1.19 (3.1.20 available)
  material_color_utilities 0.13.0 (0.13.1 available)
  slang 4.19.1 (4.19.2 available)
  test_api 0.7.12 (0.7.14 available)
  very_good_analysis 10.3.0 (11.0.0 available)
Got dependencies!
6 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Resolving dependencies in `./example`...
Downloading packages...
Got dependencies in `./example`.

00:00 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:02 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:03 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:04 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:05 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:06 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:07 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:08 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:09 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:10 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:11 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:12 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:13 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:14 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:15 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:16 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:17 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:18 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:19 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:20 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:21 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:22 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:23 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:24 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:25 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:26 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:27 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:28 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:29 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:30 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:31 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:32 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:33 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:34 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:35 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:36 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:37 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:38 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:39 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:40 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:41 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:42 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:43 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:44 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:45 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:46 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:47 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:48 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:49 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:50 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:51 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:52 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:53 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:54 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:55 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:56 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:57 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:58 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:59 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:00 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:01 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:02 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:03 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:03 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:04 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:04 +0 -1: A3 (AC-3) A3 — it resolves the shell's messenger without throwing. [E]                                                                                                                    
  Expected: not <Instance of 'UnimplementedError'>
    Actual: UnimplementedError:<UnimplementedError: subject_a3 not implemented>
  
  package:matcher                                               expect
  package:flutter_test/src/widget_tester.dart 473:18            expect
  test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart 37:7  main.<fn>.<fn>
  

To run this test again: /usr/local/share/flutter/bin/cache/dart-sdk/bin/dart test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart -p vm --plain-name 'A3 (AC-3) A3 — it resolves the shell'\''s messenger without throwing.'

01:05 +0 -1: Some tests failed.
```

- schema: 1
- prev-hash: genesis
- hash: 77e001b9540600ebff7d73b4c1a31e9576177d32a12b0f767237848ab97c20a0

## Cycle: A3 (green)

- behavior: A3
- kind: green
- subject-hash: 20dced93b6b5278c30a92fc0660bd1af16509f96ed231e8b1d828202ceb02023
- criterion: AC-3
- test: test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart
- command: `flutter test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart --plain-name "it resolves the shell's messenger without throwing."`
- exit: 0
- at: 2026-09-17T22:47:18.055212Z
- output:
```
Resolving dependencies...
Downloading packages...
  code_assets 2.0.0 (2.1.0 available)
  lucide_icons_flutter 3.1.19 (3.1.20 available)
  material_color_utilities 0.13.0 (0.13.1 available)
  slang 4.19.1 (4.19.2 available)
  test_api 0.7.12 (0.7.14 available)
  very_good_analysis 10.3.0 (11.0.0 available)
Got dependencies!
6 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Resolving dependencies in `./example`...
Downloading packages...
Got dependencies in `./example`.

00:00 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:01 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:02 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:03 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:04 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:05 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:06 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:07 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:08 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:09 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:10 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:11 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:12 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:13 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:14 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:15 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:16 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:17 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:18 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:19 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:20 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:21 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:22 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:23 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:24 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:25 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:26 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:27 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:28 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:29 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:30 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:31 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:32 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:33 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:34 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:35 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:36 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:37 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:38 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:39 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:40 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:41 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:42 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:43 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:44 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:45 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:46 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:47 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:48 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:49 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:50 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:51 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:52 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:53 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:54 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:55 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:56 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:57 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:58 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:59 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:00 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:01 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:02 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:03 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:04 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:05 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:06 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:07 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:08 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:09 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:10 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:11 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:12 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:13 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:14 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:15 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:16 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:17 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:18 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:18 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:19 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:20 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:21 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:22 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:23 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:24 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:25 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:26 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:27 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:28 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:29 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:30 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:31 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:32 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:33 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:34 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:35 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:36 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:37 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:38 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:39 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:40 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:41 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:42 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:43 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:44 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:45 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:46 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:47 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:48 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:49 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:50 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:51 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:52 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:53 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:54 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:55 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:56 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:57 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:58 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:59 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
02:00 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
02:01 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
02:02 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
02:03 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
02:04 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
02:05 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
02:06 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
02:07 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
02:08 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
02:09 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
02:10 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
02:11 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
02:11 +1: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
02:12 +1: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
02:13 +1: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
02:13 +1: All tests passed!
```
- generation:
  (none)
- suite: baseline=0 guard=0 new=(none)

- schema: 1
- prev-hash: 77e001b9540600ebff7d73b4c1a31e9576177d32a12b0f767237848ab97c20a0
- hash: cfe75fd95c33c1b705e66d38db70671d0c10643df01e33f33ae70ed21facfca5

## Cycle: A3 (green)

- behavior: A3
- kind: green
- subject-hash: 20dced93b6b5278c30a92fc0660bd1af16509f96ed231e8b1d828202ceb02023
- criterion: AC-3
- test: test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart
- command: `flutter test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart --plain-name "it resolves the shell's messenger without throwing."`
- exit: 0
- at: 2026-09-17T23:03:34.566331Z
- output:
```
Resolving dependencies...
Downloading packages...
  code_assets 2.0.0 (2.1.0 available)
  lucide_icons_flutter 3.1.19 (3.1.20 available)
  material_color_utilities 0.13.0 (0.13.1 available)
  slang 4.19.1 (4.19.2 available)
  test_api 0.7.12 (0.7.14 available)
  very_good_analysis 10.3.0 (11.0.0 available)
Got dependencies!
6 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Resolving dependencies in `./example`...
Downloading packages...
Got dependencies in `./example`.

00:00 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:01 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:02 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:03 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:04 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:05 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:06 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:07 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:08 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:09 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:10 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:11 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:12 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:13 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:14 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:15 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:16 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:17 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:18 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:19 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:20 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:21 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:22 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:23 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:24 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:25 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:26 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:27 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:28 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:29 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:30 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:31 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:32 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:33 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:34 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:35 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:36 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:37 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:38 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:39 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:40 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:41 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:42 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:43 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:44 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:45 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:46 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:47 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:48 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:49 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:50 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:51 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:52 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:53 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:54 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:55 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:56 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:57 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:58 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:59 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:00 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:01 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:02 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:03 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:04 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:05 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:06 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:07 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:08 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:09 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:10 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:11 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:12 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:13 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:14 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:15 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
01:15 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:16 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:17 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:18 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:19 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:20 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:21 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:22 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:23 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:24 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:25 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:26 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:27 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:28 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:29 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:30 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:31 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:32 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:33 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:34 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:35 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:36 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:37 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:38 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:39 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:40 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:41 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:42 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:43 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:44 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:45 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:46 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:47 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:48 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:49 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:50 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:51 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:51 +1: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
01:51 +1: All tests passed!
```
- generation:
  (none)
- suite: baseline=0 guard=0 new=(none)

- schema: 1
- prev-hash: cfe75fd95c33c1b705e66d38db70671d0c10643df01e33f33ae70ed21facfca5
- hash: 3b4771dcde42837071f75d74652956c25b258aa25165bd8f4da3eca10d5b3393

## Cycle: A4 (red)

- behavior: A4
- kind: red
- classification: assertionFailure
- subject-hash: f71566f534c9f096062eef03db9acdab96326ee58a32f46b153bbff1790e9c41
- criterion: AC-4
- test: test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart
- command: `flutter test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart --plain-name "the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator."`
- exit: 1
- at: 2026-09-17T23:05:23.319335Z
- output:
```
Resolving dependencies...
Downloading packages...
  code_assets 2.0.0 (2.1.0 available)
  lucide_icons_flutter 3.1.19 (3.1.20 available)
  material_color_utilities 0.13.0 (0.13.1 available)
  slang 4.19.1 (4.19.2 available)
  test_api 0.7.12 (0.7.14 available)
  very_good_analysis 10.3.0 (11.0.0 available)
Got dependencies!
6 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Resolving dependencies in `./example`...
Downloading packages...
Got dependencies in `./example`.

00:00 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:02 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:03 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:04 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:05 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:06 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:07 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:08 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:09 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:10 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:11 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:12 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:13 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:14 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:15 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:16 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:17 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:18 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:19 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:20 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:21 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:22 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:23 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:24 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:25 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:26 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:27 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:28 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:29 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:30 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:31 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:32 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:33 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:34 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:35 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:36 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:37 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:38 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:39 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:40 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:41 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:42 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:43 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:44 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:45 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:46 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:47 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:48 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:49 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:50 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:50 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:51 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:52 +0 -1: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                        
00:52 +0 -1: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator. [E]                    
  Expected: not <Instance of 'UnimplementedError'>
    Actual: UnimplementedError:<UnimplementedError: subject_a4 not implemented>
  
  package:matcher                                               expect
  package:flutter_test/src/widget_tester.dart 473:18            expect
  test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart 37:7  main.<fn>.<fn>
  

To run this test again: /usr/local/share/flutter/bin/cache/dart-sdk/bin/dart test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart -p vm --plain-name 'A4 (AC-4) A4 — the user'\''s builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.'

00:52 +0 -1: Some tests failed.
```

- schema: 1
- prev-hash: genesis
- hash: 2f0aa929f4b1e1bc755d55e5c083bef172af91f501250c58dd9fa90695b4670b

## Cycle: A4 (green)

- behavior: A4
- kind: green
- subject-hash: 4025d2e08f467f7b62b8974d0655b2bb9caaa612e4a61ac2354a33b995e62eed
- criterion: AC-4
- test: test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart
- command: `flutter test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart --plain-name "the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator."`
- exit: 0
- at: 2026-09-17T23:11:57.032708Z
- output:
```
Resolving dependencies...
Downloading packages...
  code_assets 2.0.0 (2.1.0 available)
  lucide_icons_flutter 3.1.19 (3.1.20 available)
  material_color_utilities 0.13.0 (0.13.1 available)
  slang 4.19.1 (4.19.2 available)
  test_api 0.7.12 (0.7.14 available)
  very_good_analysis 10.3.0 (11.0.0 available)
Got dependencies!
6 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Resolving dependencies in `./example`...
Downloading packages...
Got dependencies in `./example`.

00:00 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:01 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:02 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:03 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:04 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:05 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:06 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:07 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:08 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:09 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:10 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:11 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:12 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:13 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:14 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:15 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:16 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:17 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:18 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:19 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:20 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:21 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:22 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:23 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:24 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:25 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:26 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:27 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:28 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:29 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:30 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:31 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:32 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:33 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:34 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:35 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:36 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:37 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:38 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:39 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:40 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:41 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:42 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:43 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:44 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:44 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:45 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:46 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:47 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:48 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:49 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:50 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:51 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:52 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:53 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:54 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:55 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:56 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:57 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:58 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:59 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:00 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:01 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:02 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:03 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:04 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:05 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:06 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:07 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:08 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:09 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:10 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:11 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:12 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:13 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:14 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:15 +1: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:15 +1: All tests passed!
```
- generation:
  (none)
- suite: baseline=0 guard=0 new=(none)

- schema: 1
- prev-hash: 2f0aa929f4b1e1bc755d55e5c083bef172af91f501250c58dd9fa90695b4670b
- hash: 37021d93a969acee2ab7c48d14f574251a666b7e65802d0a7c4e4b6c9b01daaf

## Cycle: A4 (green)

- behavior: A4
- kind: green
- subject-hash: 4025d2e08f467f7b62b8974d0655b2bb9caaa612e4a61ac2354a33b995e62eed
- criterion: AC-4
- test: test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart
- command: `flutter test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart --plain-name "the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator."`
- exit: 0
- at: 2026-09-17T23:23:29.669138Z
- output:
```
Resolving dependencies...
Downloading packages...
  code_assets 2.0.0 (2.1.0 available)
  lucide_icons_flutter 3.1.19 (3.1.20 available)
  material_color_utilities 0.13.0 (0.13.1 available)
  slang 4.19.1 (4.19.2 available)
  test_api 0.7.12 (0.7.14 available)
  very_good_analysis 10.3.0 (11.0.0 available)
Got dependencies!
6 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Resolving dependencies in `./example`...
Downloading packages...
Got dependencies in `./example`.

00:00 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:01 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:02 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:03 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:04 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:05 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:06 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:07 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:08 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:09 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:10 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:11 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:12 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:13 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:14 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:15 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:16 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:17 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:18 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:19 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:20 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:21 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:22 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:23 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:24 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:25 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:26 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:27 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:28 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:29 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:30 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:31 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:32 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:33 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:34 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:35 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:36 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:37 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:38 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:39 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:40 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:41 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:41 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:42 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:43 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:44 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:45 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:46 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:47 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:48 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:49 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:50 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:51 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:52 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:53 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:54 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:55 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:56 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:57 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:58 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:59 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:00 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:01 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:02 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:03 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:04 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:05 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:06 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:07 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:08 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:09 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:10 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:10 +1: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:11 +1: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
01:11 +1: All tests passed!
```
- generation:
  (none)
- suite: baseline=0 guard=0 new=(none)

- schema: 1
- prev-hash: 37021d93a969acee2ab7c48d14f574251a666b7e65802d0a7c4e4b6c9b01daaf
- hash: 2412532624c86325973ba9d10256452c79f904aa8f23267267011e7e93f8df1b

## Cycle: A1 (error)

- behavior: A1
- kind: error
- outcome: runner-error
- criterion: AC-1
- test: test/
- command: `/Users/arrrrny/.local/bin/zfa tdd refactor A1 --feature .specify/bugs/shadapp-missing-scaffoldmessenger --project /Users/arrrrny/Developer/zuraffa_ui --suite-baseline /Users/arrrrny/Developer/zuraffa_ui/.specify/bugs/shadapp-missing-scaffoldmessenger/tdd/run-baseline.json --timeout 36.3439 --pass-batch`
- exit: 1
- at: 2026-09-17T23:33:32.802782Z
- output:
```
zfa tdd refactor: preflight suite
   command: flutter test
   preflight exit: 1
   suite baseline: cached (2026-09-17T23:21:18.814772Z) — 6 pre-existing failure(s) excluded from the green verdicts (issue #922)
   suite is RED but every failure is pre-existing at baseline — 6 tolerated (issue #922):
   tolerated: /Users/arrrrny/Developer/zuraffa_ui/test/src/components/sheet_test.dart: ShadSheet expandable golden: expandable bottom sheet at initial size
   tolerated: /Users/arrrrny/Developer/zuraffa_ui/test/src/components/sheet_test.dart: ShadSheet expandable golden: expandable bottom sheet at maxSize
   tolerated: /Users/arrrrny/Developer/zuraffa_ui/test/src/components/sheet_test.dart: ShadSheet expandable golden: expandable top sheet
   tolerated: /Users/arrrrny/Developer/zuraffa_ui/test/src/components/sheet_test.dart: ShadSheet expandable golden: expandable left sheet
   tolerated: /Users/arrrrny/Developer/zuraffa_ui/test/src/components/sheet_test.dart: ShadSheet expandable golden: expandable right sheet
   tolerated: /Users/arrrrny/Developer/zuraffa_ui/test/src/components/sheet_test.dart: ShadSheet expandable golden: expandable sheet with custom drag handle
zfa tdd refactor: applying passes
   pass: build
     command: /Users/arrrrny/.local/bin/zfa build
     exit: 1
     duration: 0.6s
     changed: (none)
   pass "build" failed — misfire-stop.
zfa tdd refactor: re-proof suite
   command: flutter test
   re-proof exit: 1
   re-proof RED but every failure is pre-existing at baseline — 6 tolerated, no regression (issue #922).
refactor: feature=shadapp-missing-scaffoldmessenger outcome=runner-error applied=0
```

- schema: 1
- prev-hash: 1cbd915e1eb66a2c4fe51f1cce08585603915596df2391930092379f6392f850
- hash: f4dba0c1884feae3cd741fcff570bce4876904f2117e2aede1764b1b9a21de7b

## Cycle: A1 (green)

- behavior: A1
- kind: green
- evidence: issue #1162 re-certification — the subject was hand-implemented after the certified red; this green evidence binds the NEW subject shape with the passing transcript
- subject-hash: 49f65e9592591e0eeb5a4d2507e69e82e41e44e25df729c2c0342db4449e1cb3
- criterion: AC-1
- test: test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart
- command: `flutter test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart --plain-name "it resolves a `ScaffoldMessengerState` without throwing."`
- exit: 0
- at: 2026-09-17T23:46:22.375897Z
- output:
```
Resolving dependencies...
Downloading packages...
  code_assets 2.0.0 (2.1.0 available)
  lucide_icons_flutter 3.1.19 (3.1.20 available)
  material_color_utilities 0.13.0 (0.13.1 available)
  slang 4.19.1 (4.19.2 available)
  test_api 0.7.12 (0.7.14 available)
  very_good_analysis 10.3.0 (11.0.0 available)
Got dependencies!
6 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Resolving dependencies in `./example`...
Downloading packages...
Got dependencies in `./example`.

00:00 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:01 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:02 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:03 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:04 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:05 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:06 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:07 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:08 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:09 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:10 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:11 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:12 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:13 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:14 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:15 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:16 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:17 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:18 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:18 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:19 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:20 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:21 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:22 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:23 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:24 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:25 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:26 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:27 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:27 +1: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:27 +1: All tests passed!
```
- generation:
  (none)
- suite: baseline=0 guard=0 new=(none)

- schema: 1
- prev-hash: f4dba0c1884feae3cd741fcff570bce4876904f2117e2aede1764b1b9a21de7b
- hash: 6d98bda675a41cda30f2e219f1fa8b839968640117b2bc5158cd0cc344423b8b

## Cycle: A1 (green)

- behavior: A1
- kind: green
- subject-hash: 49f65e9592591e0eeb5a4d2507e69e82e41e44e25df729c2c0342db4449e1cb3
- criterion: AC-1
- test: test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart
- command: `flutter test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart --plain-name "it resolves a `ScaffoldMessengerState` without throwing."`
- exit: 0
- at: 2026-09-17T23:47:00.085049Z
- output:
```
Resolving dependencies...
Downloading packages...
  code_assets 2.0.0 (2.1.0 available)
  lucide_icons_flutter 3.1.19 (3.1.20 available)
  material_color_utilities 0.13.0 (0.13.1 available)
  slang 4.19.1 (4.19.2 available)
  test_api 0.7.12 (0.7.14 available)
  very_good_analysis 10.3.0 (11.0.0 available)
Got dependencies!
6 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Resolving dependencies in `./example`...
Downloading packages...
Got dependencies in `./example`.

00:00 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:01 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:02 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:03 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:04 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:05 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:06 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:07 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:08 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:09 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:10 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:11 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:12 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:13 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:14 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:15 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:16 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a1_test.dart                                                                                          
00:16 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:17 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:18 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:19 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:20 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:21 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:22 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:23 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:24 +0: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:24 +1: A1 (AC-1) A1 — it resolves a `ScaffoldMessengerState` without throwing.                                                                                                                      
00:24 +1: All tests passed!
```
- generation:
  (none)
- suite: baseline=0 guard=0 new=(none)

- schema: 1
- prev-hash: 6d98bda675a41cda30f2e219f1fa8b839968640117b2bc5158cd0cc344423b8b
- hash: fcd142f2491512deaf355295839daccf52dfb12943446051c4118781200e5728

## Cycle: A3 (green)

- behavior: A3
- kind: green
- evidence: issue #1162 re-certification — the subject was hand-implemented after the certified red; this green evidence binds the NEW subject shape with the passing transcript
- subject-hash: e8e513934593092cbcdde0bcff02fa0115ff47a4e10e65e0592b7337ee077a76
- criterion: AC-3
- test: test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart
- command: `flutter test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart --plain-name "it resolves the shell's messenger without throwing."`
- exit: 0
- at: 2026-09-17T23:47:44.713349Z
- output:
```
Resolving dependencies...
Downloading packages...
  code_assets 2.0.0 (2.1.0 available)
  lucide_icons_flutter 3.1.19 (3.1.20 available)
  material_color_utilities 0.13.0 (0.13.1 available)
  slang 4.19.1 (4.19.2 available)
  test_api 0.7.12 (0.7.14 available)
  very_good_analysis 10.3.0 (11.0.0 available)
Got dependencies!
6 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Resolving dependencies in `./example`...
Downloading packages...
Got dependencies in `./example`.

00:00 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:01 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:02 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:03 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:04 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:05 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:06 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:07 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:08 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:09 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:10 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:11 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:12 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:13 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:14 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:15 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:16 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:17 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:18 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:19 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:20 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:21 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:22 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:23 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:24 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:25 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:26 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:27 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:27 +1: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:27 +1: All tests passed!
```
- generation:
  (none)
- suite: baseline=0 guard=0 new=(none)

- schema: 1
- prev-hash: 3b4771dcde42837071f75d74652956c25b258aa25165bd8f4da3eca10d5b3393
- hash: 7babe090f7bda7c57c0918f7fc2cc9de2b34702fc6e5b5808b2bdfe50b5bf298

## Cycle: A3 (green)

- behavior: A3
- kind: green
- subject-hash: e8e513934593092cbcdde0bcff02fa0115ff47a4e10e65e0592b7337ee077a76
- criterion: AC-3
- test: test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart
- command: `flutter test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart --plain-name "it resolves the shell's messenger without throwing."`
- exit: 0
- at: 2026-09-17T23:48:29.096768Z
- output:
```
Resolving dependencies...
Downloading packages...
  code_assets 2.0.0 (2.1.0 available)
  lucide_icons_flutter 3.1.19 (3.1.20 available)
  material_color_utilities 0.13.0 (0.13.1 available)
  slang 4.19.1 (4.19.2 available)
  test_api 0.7.12 (0.7.14 available)
  very_good_analysis 10.3.0 (11.0.0 available)
Got dependencies!
6 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Resolving dependencies in `./example`...
Downloading packages...
Got dependencies in `./example`.

00:00 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:01 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:02 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:03 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:04 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:05 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:06 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:07 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:08 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:09 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:10 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:11 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:12 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:13 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:14 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:15 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:16 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:17 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a3_test.dart                                                                                          
00:17 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:18 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:19 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:20 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:21 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:22 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:23 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:24 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:25 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:26 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:27 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:28 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:29 +0: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:29 +1: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:30 +1: A3 (AC-3) A3 — it resolves the shell's messenger without throwing.                                                                                                                           
00:30 +1: All tests passed!
```
- generation:
  (none)
- suite: baseline=0 guard=0 new=(none)

- schema: 1
- prev-hash: 7babe090f7bda7c57c0918f7fc2cc9de2b34702fc6e5b5808b2bdfe50b5bf298
- hash: 6f61b871928bd4ff96c6ef55bbf1803462ad7688f88f543b8607cfad2934a3c6

## Cycle: A4 (green)

- behavior: A4
- kind: green
- evidence: issue #1162 re-certification — the subject was hand-implemented after the certified red; this green evidence binds the NEW subject shape with the passing transcript
- subject-hash: 8c5375cf88342b8f65bb815cb8f3cbb4ee37bebac0c3b728733cff25e4dcf1ca
- criterion: AC-4
- test: test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart
- command: `flutter test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart --plain-name "the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator."`
- exit: 0
- at: 2026-09-17T23:49:22.131438Z
- output:
```
Resolving dependencies...
Downloading packages...
  code_assets 2.0.0 (2.1.0 available)
  lucide_icons_flutter 3.1.19 (3.1.20 available)
  material_color_utilities 0.13.0 (0.13.1 available)
  slang 4.19.1 (4.19.2 available)
  test_api 0.7.12 (0.7.14 available)
  very_good_analysis 10.3.0 (11.0.0 available)
Got dependencies!
6 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Resolving dependencies in `./example`...
Downloading packages...
Got dependencies in `./example`.

00:00 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:01 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:02 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:03 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:04 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:05 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:06 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:07 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:08 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:09 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:10 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:11 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:12 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:13 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:14 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:15 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:16 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:17 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:18 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:19 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:20 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:21 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:22 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:23 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:24 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:24 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:25 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:26 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:27 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:28 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:29 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:30 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:31 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:32 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:33 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:34 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:35 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:35 +1: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:36 +1: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:36 +1: All tests passed!                                                                                                                                                                            
Waiting for another flutter command to release the startup lock...
```
- generation:
  (none)
- suite: baseline=0 guard=0 new=(none)

- schema: 1
- prev-hash: 2412532624c86325973ba9d10256452c79f904aa8f23267267011e7e93f8df1b
- hash: 2818cff04c94cfda88c906ccfb03db0c243eafe30f2f871144c64ff35c6eb925

## Cycle: A4 (green)

- behavior: A4
- kind: green
- subject-hash: 8c5375cf88342b8f65bb815cb8f3cbb4ee37bebac0c3b728733cff25e4dcf1ca
- criterion: AC-4
- test: test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart
- command: `flutter test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart --plain-name "the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator."`
- exit: 0
- at: 2026-09-17T23:50:06.217401Z
- output:
```
Resolving dependencies...
Downloading packages...
  code_assets 2.0.0 (2.1.0 available)
  lucide_icons_flutter 3.1.19 (3.1.20 available)
  material_color_utilities 0.13.0 (0.13.1 available)
  slang 4.19.1 (4.19.2 available)
  test_api 0.7.12 (0.7.14 available)
  very_good_analysis 10.3.0 (11.0.0 available)
Got dependencies!
6 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Resolving dependencies in `./example`...
Downloading packages...
Got dependencies in `./example`.

00:00 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:01 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:02 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:03 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:04 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:05 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:06 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:07 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:08 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:09 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:10 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:11 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:12 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:13 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:14 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:15 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:16 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:17 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:18 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:19 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a4_test.dart                                                                                          
00:19 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:20 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:21 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:22 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:23 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:24 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:25 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:26 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:27 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:28 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:29 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:30 +0: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:30 +1: A4 (AC-4) A4 — the user's builder output, the violation chrome, the route-contract observer and `ShadToaster`/`ShadSonner` all remain mounted above the navigator.                           
00:30 +1: All tests passed!
```
- generation:
  (none)
- suite: baseline=0 guard=0 new=(none)

- schema: 1
- prev-hash: 2818cff04c94cfda88c906ccfb03db0c243eafe30f2f871144c64ff35c6eb925
- hash: 2a6f683d8a3bfcc74eed4c7613857eaf281d67c7ab31825f282f0026a096d8d2

## Cycle: A2 (red)

- behavior: A2
- kind: red
- classification: assertionFailure
- subject-hash: d1266994302ed8231ab9b0f307fb00aedaf3f4d85168d77b395dc8414e31f834
- criterion: AC-2
- test: test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart
- command: `flutter test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart --plain-name "the SnackBar's content renders in the widget tree."`
- exit: 1
- at: 2026-09-17T23:51:34.377612Z
- output:
```
Resolving dependencies...
Downloading packages...
  code_assets 2.0.0 (2.1.0 available)
  lucide_icons_flutter 3.1.19 (3.1.20 available)
  material_color_utilities 0.13.0 (0.13.1 available)
  slang 4.19.1 (4.19.2 available)
  test_api 0.7.12 (0.7.14 available)
  very_good_analysis 10.3.0 (11.0.0 available)
Got dependencies!
6 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Resolving dependencies in `./example`...
Downloading packages...
Got dependencies in `./example`.

00:00 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:01 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:02 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:03 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:04 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:05 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:06 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:07 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:08 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:09 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:10 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:11 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:12 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:13 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:14 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:15 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:15 +0: A2 (AC-2) A2 — the SnackBar's content renders in the widget tree.                                                                                                                            
00:16 +0: A2 (AC-2) A2 — the SnackBar's content renders in the widget tree.                                                                                                                            
00:16 +0 -1: A2 (AC-2) A2 — the SnackBar's content renders in the widget tree. [E]                                                                                                                     
  Expected: not <Instance of 'UnimplementedError'>
    Actual: UnimplementedError:<UnimplementedError: subject_a2 not implemented>
  
  package:matcher                                               expect
  package:flutter_test/src/widget_tester.dart 473:18            expect
  test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart 37:7  main.<fn>.<fn>
  

To run this test again: /usr/local/share/flutter/bin/cache/dart-sdk/bin/dart test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart -p vm --plain-name 'A2 (AC-2) A2 — the SnackBar'\''s content renders in the widget tree.'

00:16 +0 -1: Some tests failed.
```

- schema: 1
- prev-hash: genesis
- hash: 623c5bb519a2f8b309554e750ed721f864e5c5d7ff6c9e7eed0ab2d4ef7e734f

## Cycle: A2 (green)

- behavior: A2
- kind: green
- subject-hash: 2991fb09f30b5af76ce883c19b0e01b2006049dc6d3e0f415e7236c668e0a04d
- criterion: AC-2
- test: test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart
- command: `flutter test /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart --plain-name "the SnackBar's content renders in the widget tree."`
- exit: 0
- at: 2026-09-17T23:53:41.658733Z
- output:
```
Resolving dependencies...
Downloading packages...
  code_assets 2.0.0 (2.1.0 available)
  lucide_icons_flutter 3.1.19 (3.1.20 available)
  material_color_utilities 0.13.0 (0.13.1 available)
  slang 4.19.1 (4.19.2 available)
  test_api 0.7.12 (0.7.14 available)
  very_good_analysis 10.3.0 (11.0.0 available)
Got dependencies!
6 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Resolving dependencies in `./example`...
Downloading packages...
Got dependencies in `./example`.

00:00 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:01 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:02 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:03 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:04 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:05 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:06 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:07 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:08 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:09 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:10 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:11 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:12 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:13 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:14 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:15 +0: loading /Users/arrrrny/Developer/zuraffa_ui/test/tdd/shadapp-missing-scaffoldmessenger/a2_test.dart                                                                                          
00:15 +0: A2 (AC-2) A2 — the SnackBar's content renders in the widget tree.                                                                                                                            
00:16 +0: A2 (AC-2) A2 — the SnackBar's content renders in the widget tree.                                                                                                                            
00:17 +0: A2 (AC-2) A2 — the SnackBar's content renders in the widget tree.                                                                                                                            
00:18 +0: A2 (AC-2) A2 — the SnackBar's content renders in the widget tree.                                                                                                                            
00:19 +0: A2 (AC-2) A2 — the SnackBar's content renders in the widget tree.                                                                                                                            
00:20 +0: A2 (AC-2) A2 — the SnackBar's content renders in the widget tree.                                                                                                                            
00:21 +0: A2 (AC-2) A2 — the SnackBar's content renders in the widget tree.                                                                                                                            
00:22 +0: A2 (AC-2) A2 — the SnackBar's content renders in the widget tree.                                                                                                                            
00:23 +0: A2 (AC-2) A2 — the SnackBar's content renders in the widget tree.                                                                                                                            
00:24 +0: A2 (AC-2) A2 — the SnackBar's content renders in the widget tree.                                                                                                                            
00:25 +0: A2 (AC-2) A2 — the SnackBar's content renders in the widget tree.                                                                                                                            
00:26 +0: A2 (AC-2) A2 — the SnackBar's content renders in the widget tree.                                                                                                                            
00:26 +1: A2 (AC-2) A2 — the SnackBar's content renders in the widget tree.                                                                                                                            
00:26 +1: All tests passed!
```
- generation:
  (none)
- suite: baseline=0 guard=0 new=(none)

- schema: 1
- prev-hash: 623c5bb519a2f8b309554e750ed721f864e5c5d7ff6c9e7eed0ab2d4ef7e734f
- hash: d9e1ba9f3d1d576c13cdc6e32bfbd914e0c503acd34dce95a92f3f5338ee5b64

