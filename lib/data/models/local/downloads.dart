import 'package:hive/hive.dart';
part 'downloads.g.dart';

@HiveType(typeId: 0)
class Downloads {
  @HiveField(0)
  late String localPath;
  @HiveField(1)
  String? subjectId;
  @HiveField(2)
  late DateTime downloadedAt;
  @HiveField(3)
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

@HiveType(typeId: 1)
class DownloadedFrom {
  @HiveField(0)
  String? attachmentId;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? s3path;
  @HiveField(3)
  String? url;
  @HiveField(4)
  String? contentType;
  @HiveField(5)
  int? size;
  @HiveField(6)
  DateTime? createdAt;
  @HiveField(7)
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
