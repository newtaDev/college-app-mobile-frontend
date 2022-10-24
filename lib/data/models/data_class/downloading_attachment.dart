import '../../../domain/entities/class_room_entity.dart';
import '../../../utils/utils.dart';

enum DownloadinAttachmentStatus { initial, downloading, downloaded, error }

extension DownloadinAttachmentStatusX on DownloadinAttachmentStatus {
  bool get isInitial => this == DownloadinAttachmentStatus.initial;
  bool get isDownloaded => this == DownloadinAttachmentStatus.downloaded;
  bool get isError => this == DownloadinAttachmentStatus.error;
  bool get isDownloading => this == DownloadinAttachmentStatus.downloading;
}

class DowloadingAttachment extends MyEquatable {
  final Attachment attachment;
  final int progress;
  final String path;
  final DownloadinAttachmentStatus status;
  const DowloadingAttachment({
    required this.attachment,
    required this.progress,
    required this.path,
    required this.status,
  });

  DowloadingAttachment copyWith({
    Attachment? attachment,
    int? progress,
    String? path,
    DownloadinAttachmentStatus? status,
  }) {
    return DowloadingAttachment(
      attachment: attachment ?? this.attachment,
      progress: progress ?? this.progress,
      path: path ?? this.path,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [attachment, progress, status, path];
}
