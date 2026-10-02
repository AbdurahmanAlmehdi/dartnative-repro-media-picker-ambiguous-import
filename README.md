# Repro: `showMediaPicker`, `MediaFile` and `MediaPickerType` are ambiguous with `dartnative_media_picker`

An app that uses `dartnative_media_picker` imports the plugin next to
`package:dartnative/dartnative.dart`, as every DartNative app does. Both
libraries export `showMediaPicker`, `MediaFile` and `MediaPickerType`, so the
app doesn't compile until it adds a `hide` to the framework import.

## Run

`dn run` (any device).

## What you'll see

The build fails before the app starts:

```console
lib/main.dart:2:1: Error: 'MediaFile' is imported from both 'package:dartnative/src/widgets/native_media_picker.dart' and 'package:dartnative_media_picker/src/media_picker.dart'.
lib/main.dart:40:25: Error: 'MediaPickerType' is imported from both 'package:dartnative/src/widgets/native_media_picker.dart' and 'package:dartnative_media_picker/src/media_picker.dart'.
lib/main.dart:39:53: Error: 'showMediaPicker' is imported from both 'package:dartnative/src/widgets/native_media_picker.dart' and 'package:dartnative_media_picker/src/media_picker.dart'.
```

`dn analyze` reports the same three as `ambiguous_import`.

## Expected

The plugin's documented API compiles with the usual two imports.

## Workaround

```dart
import 'package:dartnative/dartnative.dart'
    hide MediaFile, MediaPickerType, showMediaPicker;
```

## Environment

- DartNative 1.0.0 (SDK `113c27aacb2`, framework edition `7ae29132`), Dart 3.12.0, `dartnative_media_picker` 1.1.0
- macOS 26.7.1, Xcode 26.1.1
- iPhone 17 simulator, iOS 26.1
