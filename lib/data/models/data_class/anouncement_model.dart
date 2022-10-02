part of anouncement_entity;

class AnouncementModel extends MyEquatable {
  final String? id;
  final String? collegeId;
  final String? title;
  final String? description;
  final AnounceTo? anounceTo;
  final AnouncementLayoutType? anouncementLayoutType;
  final List<String>? anounceToClassIds;
  final List<String>? multipleImages;
  final String? image;
  final CreatedOrModifiedBy? createdBy;
  final CreatedOrModifiedBy? lastModifiedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AnouncementModel({
    this.id,
    this.collegeId,
    this.title,
    this.image,
    this.description,
    this.anounceTo,
    this.anouncementLayoutType,
    this.anounceToClassIds,
    this.multipleImages,
    this.createdBy,
    this.lastModifiedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory AnouncementModel.fromMap(Map<String, dynamic> data) =>
      AnouncementModel(
        id: data['_id'] as String?,
        collegeId: data['collegeId'] as String?,
        title: data['title'] as String?,
        description: data['description'] as String?,
        anounceTo: AnounceTo.fromName(data['anounceTo'] as String),
        anouncementLayoutType: AnouncementLayoutType.fromName(
          data['anouncementLayoutType'] as String,
        ),
        image: data['imageName'] as String?,
        anounceToClassIds: (data['anounceToClassIds'] as List<dynamic>?)
            ?.map((dynamic e) => e.toString())
            .toList(),
        multipleImages: (data['multipleImages'] as List<dynamic>?)
            ?.map((dynamic e) => e.toString())
            .toList(),
        createdBy: data['createdBy'] == null
            ? null
            : CreatedOrModifiedBy.fromMap(
                data['createdBy'] as Map<String, dynamic>,
              ),
        lastModifiedBy: data['lastModifiedBy'] == null
            ? null
            : CreatedOrModifiedBy.fromMap(
                data['lastModifiedBy'] as Map<String, dynamic>,
              ),
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AnouncementModel].
  factory AnouncementModel.fromJson(String data) {
    return AnouncementModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  AnouncementModel copyWith({
    String? id,
    String? collegeId,
    String? title,
    String? image,
    String? description,
    AnounceTo? anounceTo,
    AnouncementLayoutType? anouncementLayoutType,
    List<String>? anounceToClassIds,
    List<String>? multipleImages,
    CreatedOrModifiedBy? createdBy,
    CreatedOrModifiedBy? lastModifiedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AnouncementModel(
      id: id ?? this.id,
      collegeId: collegeId ?? this.collegeId,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      anounceTo: anounceTo ?? this.anounceTo,
      anouncementLayoutType:
          anouncementLayoutType ?? this.anouncementLayoutType,
      anounceToClassIds: anounceToClassIds ?? this.anounceToClassIds,
      multipleImages: multipleImages ?? this.multipleImages,
      createdBy: createdBy ?? this.createdBy,
      lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      collegeId,
      title,
      description,
      anounceTo,
      anouncementLayoutType,
      anounceToClassIds,
      multipleImages,
      createdBy,
      lastModifiedBy,
      createdAt,
      updatedAt,
    ];
  }
}
