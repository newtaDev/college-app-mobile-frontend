// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloads.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadsAdapter extends TypeAdapter<Downloads> {
  @override
  final int typeId = 0;

  @override
  Downloads read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Downloads(
      localPath: fields[0] as String,
      subjectId: fields[1] as String?,
      downloadedAt: fields[2] as DateTime,
      downloadedFrom: fields[3] as DownloadedFrom,
    );
  }

  @override
  void write(BinaryWriter writer, Downloads obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.localPath)
      ..writeByte(1)
      ..write(obj.subjectId)
      ..writeByte(2)
      ..write(obj.downloadedAt)
      ..writeByte(3)
      ..write(obj.downloadedFrom);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DownloadedFromAdapter extends TypeAdapter<DownloadedFrom> {
  @override
  final int typeId = 1;

  @override
  DownloadedFrom read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownloadedFrom(
      attachmentId: fields[0] as String?,
      name: fields[1] as String?,
      s3path: fields[2] as String?,
      url: fields[3] as String?,
      contentType: fields[4] as String?,
      size: fields[5] as int?,
      createdAt: fields[6] as DateTime?,
      updatedAt: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, DownloadedFrom obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.attachmentId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.s3path)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.contentType)
      ..writeByte(5)
      ..write(obj.size)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadedFromAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
