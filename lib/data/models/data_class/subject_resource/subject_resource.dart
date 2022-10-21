part of class_room_entity;

class SubjectResource extends MyEquatable {
  final String? id;
  final String? title;
  final String? userId;
  final String? collegeId;
  final String? subjectId;
  final String? description;
  final List<Attachment>? attachments;
  final List<Comment>? comments;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int totalComments;
  final int totalAttachments;

  const SubjectResource({
    this.id,
    this.title,
    this.userId,
    this.collegeId,
    this.subjectId,
    this.description,
    this.attachments,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.totalComments = 0,
    this.totalAttachments = 0,
  });

  factory SubjectResource.fromMap(Map<String, dynamic> data) {
    return SubjectResource(
      id: data['_id'] as String?,
      title: data['title'] as String?,
      userId: data['userId'] as String?,
      collegeId: data['collegeId'] as String?,
      subjectId: data['subjectId'] as String?,
      description: data['description'] as String?,
      attachments: (data['attachments'] as List<dynamic>?)
          ?.map((e) => Attachment.fromMap(e as Map<String, dynamic>))
          .toList(),
      comments: (data['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromMap(e as Map<String, dynamic>))
          .toList(),
      createdAt: data['createdAt'] == null
          ? null
          : DateTime.parse(data['createdAt'] as String),
      updatedAt: data['updatedAt'] == null
          ? null
          : DateTime.parse(data['updatedAt'] as String),
      totalAttachments:
          data['totalAttachments'] == null || data['totalAttachments'] is! int
              ? 0
              : data['totalAttachments'],
      totalComments:
          data['totalComments'] == null || data['totalComments'] is! int
              ? 0
              : data['totalComments'],
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SubjectResource].
  factory SubjectResource.fromJson(String data) {
    return SubjectResource.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  SubjectResource copyWith({
    String? id,
    String? title,
    String? userId,
    String? collegeId,
    String? subjectId,
    String? description,
    List<Attachment>? attachments,
    List<Comment>? comments,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? totalComments,
    int? totalAttachments,
  }) {
    return SubjectResource(
      id: id ?? this.id,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      collegeId: collegeId ?? this.collegeId,
      subjectId: subjectId ?? this.subjectId,
      description: description ?? this.description,
      attachments: attachments ?? this.attachments,
      comments: comments ?? this.comments,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      totalComments: totalComments ?? this.totalComments,
      totalAttachments: totalAttachments ?? this.totalAttachments,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      title,
      userId,
      collegeId,
      subjectId,
      description,
      attachments,
      comments,
      createdAt,
      updatedAt,
      totalComments,
      totalAttachments,
    ];
  }
}
