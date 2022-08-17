part of auth_entitie;

class StudentUserData extends UserData {
  final String id;
  final String name;
  final String email;
  final String collegeId;
  final String classId;
  final List<String> myOptionalSubjects;
  final DateTime updatedAt;
  final DateTime createdAt;

  const StudentUserData({
    required this.id,
    required this.name,
    required this.email,
    required this.collegeId,
    required this.classId,
    required this.myOptionalSubjects,
    required this.updatedAt,
    required this.createdAt,
    required super.userType,
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

  factory StudentUserData.fromMap(Map<String, dynamic> map) {
    return StudentUserData(
      id: map['_id'],
      name: map['name'],
      email: map['email'],
      collegeId: map['collegeId'],
      classId: map['classId'],
      userType: UserType.fromName(map['userType'])!,
      myOptionalSubjects: List<String>.from(map['mySubjectIds']),
      updatedAt: DateTime.parse(map['updatedAt']).toLocal(),
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
    );
  }

  factory StudentUserData.fromJson(String source) =>
      StudentUserData.fromMap(json.decode(source));
}
