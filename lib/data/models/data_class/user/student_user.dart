part of user_entity;

class StudentUser extends UserDetails {
  final String classId;
  final List<String> myOptionalSubjects;

  const StudentUser({
    required super.id,
    required super.name,
    required super.email,
    required super.collegeId,
    required this.classId,
    required this.myOptionalSubjects,
    required super.updatedAt,
    required super.createdAt,
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

  factory StudentUser.fromMap(Map<String, dynamic> map) {
    return StudentUser(
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

  factory StudentUser.fromJson(String source) =>
      StudentUser.fromMap(json.decode(source));
}
