import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../shared/helpers/file_helpers.dart';
import '../../../shared/services/file_services.dart';

class AssetFileTypePicker extends StatelessWidget {
  final void Function(FilePickerResult? pickedFiles) onFilesPicked;
  const AssetFileTypePicker({
    super.key,
    required this.onFilesPicked,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        children: [
          ColoredBox(
            color: Colors.red.withOpacity(0.1),
            child: ListTile(
              leading: const Icon(
                Icons.warning,
                color: Colors.red,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              title: Text(
                'Maximum file size : 50 Mb\nSupported formats',
                style: textTheme.titleSmall?.copyWith(color: Colors.red),
              ),
              subtitle: Text(
                [
                  ...FileHelpers.imageExtensions,
                  ...FileHelpers.audioExtensions,
                  ...FileHelpers.videoExtensions,
                  ...FileHelpers.docExtensions
                ].join(', '),
                style: textTheme.bodySmall
                    ?.copyWith(color: Colors.red.withOpacity(0.7)),
              ),
            ),
          ),
          ListTile(
            onTap: () async {
              Navigator.of(context).pop();

              final pickedFiles = await FileServices.pickMutipleImages();
              onFilesPicked(pickedFiles);
            },
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.image_rounded),
                SizedBox(width: 20),
                SizedBox(
                  height: 40,
                  width: 2,
                  child: VerticalDivider(),
                )
              ],
            ),
            title: const Text('Upload images'),
          ),
          const Divider(
            height: 1,
            indent: 50,
          ),
          ListTile(
            onTap: () async {
              Navigator.of(context).pop();

              final pickedFiles = await FileServices.pickMutipleAudios();
              onFilesPicked(pickedFiles);
            },
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.audiotrack_rounded),
                SizedBox(width: 20),
                SizedBox(
                  height: 40,
                  width: 2,
                  child: VerticalDivider(),
                )
              ],
            ),
            title: const Text('Upload audios'),
          ),
          const Divider(
            height: 1,
            indent: 50,
          ),
          ListTile(
            onTap: () async {
              Navigator.of(context).pop();

              final pickedFiles = await FileServices.pickMutipleVideos();
              onFilesPicked(pickedFiles);
            },
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.video_library_rounded),
                SizedBox(width: 20),
                SizedBox(
                  height: 40,
                  width: 2,
                  child: VerticalDivider(),
                )
              ],
            ),
            title: const Text('Upload videos'),
          ),
          const Divider(
            height: 1,
            indent: 50,
          ),
          ListTile(
            onTap: () async {
              Navigator.of(context).pop();

              final pickedFiles = await FileServices.pickMutipleDocs();
              onFilesPicked(pickedFiles);
            },
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.description),
                SizedBox(width: 20),
                SizedBox(
                  height: 40,
                  width: 2,
                  child: VerticalDivider(),
                )
              ],
            ),
            title: const Text('Upload documents'),
          ),
          const Divider(
            height: 1,
            indent: 50,
          ),
          ListTile(
            onTap: () async {
              Navigator.of(context).pop();

              final pickedFiles = await FileServices.pickMutipleFiles();
              onFilesPicked(pickedFiles);
            },
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.file_copy_rounded),
                SizedBox(width: 20),
                SizedBox(
                  height: 40,
                  width: 2,
                  child: VerticalDivider(),
                )
              ],
            ),
            title: const Text('Upload files'),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
