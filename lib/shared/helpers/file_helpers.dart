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
  static const videoExtensions = ['mp4'];
}
