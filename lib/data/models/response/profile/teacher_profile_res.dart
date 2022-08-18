part of profile_entity;

class TeacherProfileDataRes extends UserProfileData {
  final String email;
  final String collegeId;

  const TeacherProfileDataRes({
    required super.id,
    required super.name,
    required this.email,
    required this.collegeId,
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

  factory TeacherProfileDataRes.fromMap(Map<String, dynamic> map) {
    return TeacherProfileDataRes(
      id: map['_id'],
      name: map['name'],
      email: map['email'],
      collegeId: map['collegeId'],
      userType: UserType.fromName(map['userType'])!,
      updatedAt: DateTime.parse(map['updatedAt']).toLocal(),
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
    );
  }

  factory TeacherProfileDataRes.fromJson(String source) =>
      TeacherProfileDataRes.fromMap(json.decode(source));
}
