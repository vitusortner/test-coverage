# test_cov [![Build Status](https://travis-ci.org/vitusortner/test_cov.svg?branch=master)](https://travis-ci.org/vitusortner/test_cov)

A simple command-line tool to collect test coverage information from
Dart VM tests. It is useful if you need to generate coverage reports
locally during development.

## Usage

Add dev dependency to your `pubspec.yaml`:

```yaml
dev_dependencies:
  test_cov: ^0.2.1
```

Run `pub get` to install. Then, in the root of your project run:

```bash
pub run test_cov
```

Result is saved in `coverage/lcov.info`. If you have `lcov` tool
installed on your system (for Mac it's `brew install lcov`) you can
generate coverage reports using `genhtml` command:

```bash
genhtml -o coverage coverage/lcov.info
# Open in the default browser (mac):
open coverage/index.html
```

## Integrations

Resulting `coverage/lcov.info` file is ready to be consumed by
Codecov command-line tool, so no extra step is needed.

This library was not tested with coveralls yet.

## Known limitations

* This library was created to run Dart VM tests. It has not been tested
  and likely won't work for Dart code targeting web platform (compiled
  to JavaScript). There is no need to use this tool for Flutter as it
  allows collecting coverage information with `flutter test --coverage`.

## How it works

The tool performs following steps:

### 1. Generates `test/.test_cov.dart` file which is essentially a "test all" script.

It is recommended to add this file to your `.gitignore`.

Below is an example of `test/.test_cov.dart`:

```dart
// Auto-generated by test_cov. Do not edit by hand.
// Consider adding this file to your .gitignore.

import 'some_test.dart' as some_test;
import 'nested/other_test.dart' as other_test;
import 'some_other_test.dart' as some_other_test;
void main() {
  some_test.main();
  other_test.main();
  some_other_test.main();
}
```

### 2. Runs the tests

Following command is used to run the tests:

```
dart --pause-isolates-on-exit --enable-vm-service test/.test_cov.dart
```

### 3. Collects and formats coverage information

When test execution is completed the tool uses functionality of the
`coverage` package to collect and format coverage report.

Feel free to file feature requests and bug reports at the
[issue tracker][].

[issue tracker]: https://github.com/vitusortner/test_cov/issues
