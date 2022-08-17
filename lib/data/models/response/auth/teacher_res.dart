part of auth_entitie;

class TeacherUserData extends UserData {
  final String id;
  final String name;
  final String email;
  final String collegeId;

  final DateTime updatedAt;
  final DateTime createdAt;

  const TeacherUserData({
    required this.id,
    required this.name,
    required this.email,
    required this.collegeId,
    required super.userType,
    required this.updatedAt,
    required this.createdAt,
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

  factory TeacherUserData.fromMap(Map<String, dynamic> map) {
    return TeacherUserData(
      id: map['_id'],
      name: map['name'],
      email: map['email'],
      collegeId: map['collegeId'],
      userType: UserType.fromName(map['userType'])!,
      updatedAt: DateTime.parse(map['updatedAt']).toLocal(),
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
    );
  }

  factory TeacherUserData.fromJson(String source) =>
      TeacherUserData.fromMap(json.decode(source));
}
