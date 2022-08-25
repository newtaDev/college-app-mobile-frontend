part of user_entity;

class TeacherUser extends UserDetails {
  const TeacherUser({
    required super.id,
    required super.name,
    required super.email,
    required super.collegeId,
    required super.userType,
    required super.updatedAt,
    required super.createdAt,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      collegeId,
      userType,
      updatedAt,
      createdAt,
    ];
  }

  factory TeacherUser.fromMap(Map<String, dynamic> map) {
    return TeacherUser(
      id: map['_id'],
      name: map['name'],
      email: map['email'],
      collegeId: map['collegeId'],
      userType: UserType.fromName(map['userType'])!,
      updatedAt: DateTime.parse(map['updatedAt']).toLocal(),
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
    );
  }

  factory TeacherUser.fromJson(String source) =>
      TeacherUser.fromMap(json.decode(source));
}
