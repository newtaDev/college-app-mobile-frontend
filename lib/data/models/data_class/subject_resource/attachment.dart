part of class_room_entity;

class Attachment extends MyEquatable {
  final String? name;
  final String? path;
  final String? url;
  final String? contentType;
  final int? size;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Attachment({
    this.name,
    this.path,
    this.url,
    this.contentType,
    this.size,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory Attachment.fromMap(Map<String, dynamic> data) => Attachment(
        name: data['name'] as String?,
        path: data['path'] as String?,
        url: data['url'] as String?,
        contentType: data['contentType'] as String?,
        size: data['size'] as int?,
        id: data['_id'] as String?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Attachment].
  factory Attachment.fromJson(String data) {
    return Attachment.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Attachment] to a JSON string.

  Attachment copyWith({
    String? name,
    String? path,
    String? url,
    String? contentType,
    int? size,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Attachment(
      name: name ?? this.name,
      path: path ?? this.path,
      url: url ?? this.url,
      contentType: contentType ?? this.contentType,
      size: size ?? this.size,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      name,
      path,
      url,
      contentType,
      size,
      id,
      createdAt,
      updatedAt,
    ];
  }
}
