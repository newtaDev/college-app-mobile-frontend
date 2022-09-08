part of user_entity;

class StudentUser extends UserDetails {
  final String classId;
  final List<String> myOptionalSubjects;
  final int? phoneNumber;
  final String? currentAddress;
  final int? parentsNumber;
  final DateTime? dob;

  const StudentUser({
    required super.name,
    super.email,
    required super.collegeId,
    required this.classId,
    required super.userType,
    required this.myOptionalSubjects,
    this.phoneNumber,
    this.parentsNumber,
    this.currentAddress,
    this.dob,
    super.username,
    required super.isProfileCompleted,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
  });

  factory StudentUser.fromMap(Map<String, dynamic> data) => StudentUser(
        name: data['name'] as String,
        email: data['email'] as String,
        collegeId: data['collegeId'] as String,
        classId: data['classId'] as String,
        userType: UserType.fromName(data['userType'])!,
        myOptionalSubjects: data['myOptionalSubjects']
            .map<String>((dynamic e) => e.toString())
            .toList(),
        phoneNumber: data['phoneNumber'] as int?,
        parentsNumber: data['parentsNumber'] as int?,
        currentAddress: data['currentAddress'] as String?,
        dob: data['dob'] == null ? null : DateTime.parse(data['dob'] as String),
        username: data['username'] as String?,
        isProfileCompleted: data['isProfileCompleted'] as bool,
        id: data['_id'] as String,
        createdAt: DateTime.parse(data['createdAt'] as String),
        updatedAt: DateTime.parse(data['updatedAt'] as String),
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'collegeId': collegeId,
        'classId': classId,
        'userType': userType.value,
        'myOptionalSubjects': myOptionalSubjects,
        'phoneNumber': phoneNumber,
        'currentAddress': currentAddress,
        'dob': dob?.toIso8601String(),
        'parentsNumber': parentsNumber,
        'username': username,
        'isProfileCompleted': isProfileCompleted,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [StudentUser].
  factory StudentUser.fromJson(String data) {
    return StudentUser.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [StudentUser] to a JSON string.
  String toJson() => json.encode(toMap());

  StudentUser copyWith({
    String? name,
    String? email,
    String? collegeId,
    String? classId,
    UserType? userType,
    List<String>? myOptionalSubjects,
    int? phoneNumber,
    String? currentAddress,
    DateTime? dob,
    int? parentsNumber,
    String? username,
    bool? isProfileCompleted,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudentUser(
      name: name ?? this.name,
      email: email ?? this.email,
      collegeId: collegeId ?? this.collegeId,
      classId: classId ?? this.classId,
      userType: userType ?? this.userType,
      myOptionalSubjects: myOptionalSubjects ?? this.myOptionalSubjects,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      currentAddress: currentAddress ?? this.currentAddress,
      dob: dob ?? this.dob,
      parentsNumber: parentsNumber ?? this.parentsNumber,
      username: username ?? this.username,
      isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      name,
      email,
      collegeId,
      classId,
      userType,
      myOptionalSubjects,
      phoneNumber,
      currentAddress,
      dob,
      parentsNumber,
      username,
      isProfileCompleted,
      id,
      createdAt,
      updatedAt,
    ];
  }
}
