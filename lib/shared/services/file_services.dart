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
  static Future<FilePickerResult?> pickMutipleAudios() =>
      FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: true,
      );
  static Future<FilePickerResult?> pickMutipleVideos() =>
      FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: true,
      );
  static Future<FilePickerResult?> pickMutipleDocs() =>
      FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: FileHelpers.docExtensions,
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
