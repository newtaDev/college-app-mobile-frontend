part of class_room_entity;

class Comment extends MyEquatable {
  final String? userId;
  final AnonymousUser? userDetails;
  final String? comment;
  final String? userType;
  final String? id;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  const Comment({
    this.userId,
    this.userDetails,
    this.comment,
    this.userType,
    this.id,
    this.updatedAt,
    this.createdAt,
  });

  factory Comment.fromMap(Map<String, dynamic> data) => Comment(
        userId: data['userId'] != null && data['userId'] is Map<String, dynamic>
            ? data['userId']['_id']
            : data['userId'],
        userDetails:
            data['userId'] != null && data['userId'] is Map<String, dynamic>
                ? AnonymousUser.fromMap(data['userId'] as Map<String, dynamic>)
                : null,
        comment: data['comment'] as String?,
        userType: data['userType'] as String?,
        id: data['_id'] as String?,
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'comment': comment,
        'userType': userType,
        '_id': id,
        'updatedAt': updatedAt?.toIso8601String(),
        'createdAt': createdAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Comment].
  factory Comment.fromJson(String data) {
    return Comment.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Comment] to a JSON string.
  String toJson() => json.encode(toMap());

  Comment copyWith({
    String? userId,
    AnonymousUser? userDetails,
    String? comment,
    String? userType,
    String? id,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return Comment(
      userId: userId ?? this.userId,
      userDetails: userDetails ?? this.userDetails,
      comment: comment ?? this.comment,
      userType: userType ?? this.userType,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      userId,
      comment,
      userType,
      id,
      userDetails,
      updatedAt,
      createdAt,
    ];
  }
}
