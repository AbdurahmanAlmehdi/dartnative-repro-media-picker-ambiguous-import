import 'package:dartnative/dartnative.dart';
import 'package:dartnative_media_picker/dartnative_media_picker.dart';

import 'dartnative_plugin_registrant.dart';

// `dn run` / `dn analyze` fail: showMediaPicker, MediaFile and MediaPickerType
// are exported by both package:dartnative and dartnative_media_picker
// (ambiguous_import). The usual pair of imports for an app that uses the
// plugin, nothing else.
//
// Workaround: import 'package:dartnative/dartnative.dart'
//     hide MediaFile, MediaPickerType, showMediaPicker;
void main() {
  DartNativePluginRegistrant.registerAll();
  runApp(const PickerRepro());
}

class PickerRepro extends StatefulWidget {
  const PickerRepro({super.key});

  @override
  State<PickerRepro> createState() => _PickerReproState();
}

class _PickerReproState extends State<PickerRepro> {
  String _result = 'nothing picked yet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Button(
              title: 'Pick photos',
              onPressed: () async {
                final List<MediaFile> files = await showMediaPicker(
                  type: MediaPickerType.images,
                  maxSelection: 10,
                );
                if (!mounted) return;
                setState(() => _result = '${files.length} picked');
              },
            ),
            const SizedBox(height: 16),
            Text(_result, style: const TextStyle(color: Color(0xFF111111))),
          ],
        ),
      ),
    );
  }
}
