part of user_entity;

class AnonymousUser extends UserDetails {
  const AnonymousUser({
    required super.name,
    super.email,
    required super.collegeId,
    required super.userType,
    super.username,
    super.emoji,
    super.bio,
    required super.isProfileCompleted,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
  });

  factory AnonymousUser.fromMap(Map<String, dynamic> data) => AnonymousUser(
        id: data['_id'] as String,
        name: data['name'] as String,
        emoji: data['emoji'] as String?,
        email: data['email'] as String?,
        bio: data['bio'] as String?,
        userType: UserType.fromName(data['userType'])!,
        isProfileCompleted: data['isProfileCompleted'] ?? false,
        username: data['username'] as String?,
        collegeId: data['collegeId'] as String,
        createdAt: DateTime.parse(data['createdAt'] as String).toLocal(),
        updatedAt: DateTime.parse(data['updatedAt'] as String).toLocal(),
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AnonymousUser].
  factory AnonymousUser.fromJson(String data) {
    return AnonymousUser.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  AnonymousUser copyWith({
    String? name,
    String? id,
    String? email,
    String? username,
    String? emoji,
    String? bio,
    bool? isProfileCompleted,
    String? collegeId,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserType? userType,
  }) {
    return AnonymousUser(
      name: name ?? this.name,
      id: id ?? this.id,
      username: username ?? this.username,
      emoji: emoji ?? this.emoji,
      userType: userType ?? this.userType,
      isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
      collegeId: collegeId ?? this.collegeId,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      name,
      id,
      email,
      username,
      emoji,
      bio,
      isProfileCompleted,
      collegeId,
      createdAt,
      updatedAt,
      userType,
    ];
  }
}
