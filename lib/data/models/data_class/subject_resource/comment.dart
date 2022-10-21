part of class_room_entity;
class Comment extends MyEquatable {
  final String? userId;
  final String? comment;
  final String? userType;
  final String? id;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  const Comment({
    this.userId,
    this.comment,
    this.userType,
    this.id,
    this.updatedAt,
    this.createdAt,
  });

  factory Comment.fromMap(Map<String, dynamic> data) => Comment(
        userId: data['userId'] as String?,
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
    String? comment,
    String? modelName,
    String? userType,
    String? id,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return Comment(
      userId: userId ?? this.userId,
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
      updatedAt,
      createdAt,
    ];
  }
}
