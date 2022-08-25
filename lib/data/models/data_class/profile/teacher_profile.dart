part of profile_entity;

class TeacherProfileData extends UserProfileData {

  const TeacherProfileData({
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

  factory TeacherProfileData.fromMap(Map<String, dynamic> map) {
    return TeacherProfileData(
      id: map['_id'],
      name: map['name'],
      email: map['email'],
      collegeId: map['collegeId'],
      userType: UserType.fromName(map['userType'])!,
      updatedAt: DateTime.parse(map['updatedAt']).toLocal(),
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
    );
  }

  factory TeacherProfileData.fromJson(String source) =>
      TeacherProfileData.fromMap(json.decode(source));
}
