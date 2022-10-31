import 'package:flutter/material.dart';

class FileHelpers {
  static const imageContentTypes = ['image/jpeg', 'image/png', 'image/webp'];
  static const docsContentTypes = [
    'application/pdf', // .pdf
    'application/msword', // .doc
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document', // .docx
    'application/vnd.ms-excel', // xls
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', // .xlsx
    'application/vnd.ms-excel', // .csv
    'application/vnd.ms-powerpoint', // .ppt
    'application/vnd.openxmlformats-officedocument.presentationml.presentation', // .pptx
  ];
  static const audioContentTypes = [
    'audio/x-wav', //.wav
    'audio/mpeg', // .mp3
  ];
  static const videoContentTypes = [
    'video/mp4', // .mp4
    'video/quicktime', // .mov
  ];
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
  static const videoExtensions = ['mp4','mov'];

  static IconData getIconFromContentType(String? contentType) {
    if (docsContentTypes.contains(contentType)) {
      return Icons.description_rounded;
    }
    if (videoContentTypes.contains(contentType)) {
      return Icons.play_arrow_rounded;
    }
    if (audioContentTypes.contains(contentType)) {
      return Icons.audiotrack_rounded;
    }
    if (imageContentTypes.contains(contentType)) {
      return Icons.image;
    }

    /// default
    return Icons.file_present_rounded;
  }

  static Color getColorFromContentType(String? contentType) {
    if (docsContentTypes.contains(contentType)) {
      return Colors.blue;
    }
    if (videoContentTypes.contains(contentType)) {
      return Colors.red;
    }
    if (audioContentTypes.contains(contentType)) {
      return Colors.green;
    }
    if (imageContentTypes.contains(contentType)) {
      return Colors.purple;
    }

    /// default
    return Colors.black;
  }
}
