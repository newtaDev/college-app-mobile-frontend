import 'package:file_picker/file_picker.dart';

class FileServices {
  static const imageExtensions = ['jpeg', 'png', 'jpg'];
  static const docExtensions = [
    'pdf',
    'doc',
    'docx',
    'xls',
    'xlsx',
    'csv',
    'ppt',
    'pptx'
  ];
  static const audioExtensions = ['mp3', 'wav'];
  static const videoExtensions = ['mp4'];

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
          ...imageExtensions,
          ...audioExtensions,
          ...videoExtensions,
          ...docExtensions
        ],
        allowMultiple: true,
      );
}
