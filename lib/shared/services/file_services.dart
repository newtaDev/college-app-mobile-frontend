import 'package:file_picker/file_picker.dart';

import '../helpers/file_helpers.dart';

class FileServices {
  static Future<FilePickerResult?> pickSingleImage() =>
      FilePicker.platform.pickFiles(
        type: FileType.image,
      );

  static Future<FilePickerResult?> pickMutipleImages() =>
      FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );
  static Future<FilePickerResult?> pickMutipleFiles() =>
      FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          ...FileHelpers.imageExtensions,
          ...FileHelpers.audioExtensions,
          ...FileHelpers.videoExtensions,
          ...FileHelpers.docExtensions
        ],
        allowMultiple: true,
      );
}
