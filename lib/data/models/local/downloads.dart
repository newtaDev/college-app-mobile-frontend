import 'package:isar/isar.dart';

part 'downloads.g.dart';

@collection
class Downloads {
  Id id = Isar.autoIncrement;
  late String localPath;
  String? subjectId;
  late DateTime downloadedAt;
  late DownloadedFrom downloadedFrom;
  Downloads({
    required this.localPath,
    required this.subjectId,
    required this.downloadedAt,
    required this.downloadedFrom,
  });

  Downloads copyWith({
    String? localPath,
    String? subjectId,
    DateTime? downloadedAt,
    DownloadedFrom? downloadedFrom,
  }) {
    return Downloads(
      localPath: localPath ?? this.localPath,
      subjectId: subjectId ?? this.subjectId,
      downloadedAt: downloadedAt ?? this.downloadedAt,
      downloadedFrom: downloadedFrom ?? this.downloadedFrom,
    );
  }
}

@embedded
class DownloadedFrom {
  String? attachmentId;
  String? name;
  String? s3path;
  String? url;
  String? contentType;
  int? size;
  DateTime? createdAt;
  DateTime? updatedAt;
  DownloadedFrom({
    this.attachmentId,
    this.name,
    this.s3path,
    this.url,
    this.contentType,
    this.size,
    this.createdAt,
    this.updatedAt,
  });

  DownloadedFrom copyWith({
    String? attachmentId,
    String? name,
    String? s3path,
    String? url,
    String? contentType,
    int? size,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DownloadedFrom(
      attachmentId: attachmentId ?? this.attachmentId,
      name: name ?? this.name,
      s3path: s3path ?? this.s3path,
      url: url ?? this.url,
      contentType: contentType ?? this.contentType,
      size: size ?? this.size,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory DownloadedFrom.fromMap(Map<String, dynamic> map) {
    return DownloadedFrom(
      attachmentId: map['id'],
      name: map['name'],
      s3path: map['path'],
      url: map['url'],
      contentType: map['contentType'],
      size: map['size']?.toInt(),
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
    );
  }
}
