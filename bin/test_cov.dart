// Copyright (c) 2018, Anatoly Pulyaevskiy. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:test_cov/test_cov.dart';

Future main(List<String> arguments) async {
  final packageRoot = Directory.current;
  final testFiles = findTestFiles(packageRoot);
  print('Found ${testFiles.length} test files.');

  generateMainScript(packageRoot, testFiles);
  print('Generated test-all script in test/.test_cov.dart.');

  await runTestsAndCollect(Directory.current.path);
}
