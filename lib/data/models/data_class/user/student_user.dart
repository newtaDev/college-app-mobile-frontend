part of user_entity;

class StudentUser extends UserDetails {
  final String classId;
  final List<String> myOptionalSubjects;
  final StudentProfile? profile;

  const StudentUser({
    required super.name,
    super.email,
    required super.collegeId,
    required this.classId,
    required super.userType,
    required this.myOptionalSubjects,
    required this.profile,
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
        profile: data['profile'] == null
            ? null
            : StudentProfile.fromMap(data['profile'] as Map<String, dynamic>),
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
        'userType': userType,
        'myOptionalSubjects': myOptionalSubjects,
        'profile': profile?.toMap(),
        'username': username,
        'isProfileCompleted': isProfileCompleted,
        '_id': id,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
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
    StudentProfile? profile,
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
      profile: profile ?? this.profile,
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
      profile,
      username,
      isProfileCompleted,
      id,
      createdAt,
      updatedAt,
    ];
  }
}

class StudentProfile extends MyEquatable {
  final int? phoneNumber;
  final String? currentAddress;
  final DateTime? dob;
  final int? parentsNumber;
  final String? id;

  const StudentProfile({
    this.phoneNumber,
    this.currentAddress,
    this.dob,
    this.parentsNumber,
    this.id,
  });

  factory StudentProfile.fromMap(Map<String, dynamic> data) => StudentProfile(
        phoneNumber: data['phoneNumber'] as int?,
        currentAddress: data['currentAddress'] as String?,
        dob: data['dob'] == null ? null : DateTime.parse(data['dob'] as String),
        parentsNumber: data['parentsNumber'] as int?,
        id: data['_id'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'phoneNumber': phoneNumber,
        'currentAddress': currentAddress,
        'dob': dob?.toIso8601String(),
        'parentsNumber': parentsNumber,
        '_id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [StudentProfile].
  factory StudentProfile.fromJson(String data) {
    return StudentProfile.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [StudentProfile] to a JSON string.
  String toJson() => json.encode(toMap());

  StudentProfile copyWith({
    int? phoneNumber,
    String? currentAddress,
    DateTime? dob,
    int? parentsNumber,
    String? id,
  }) {
    return StudentProfile(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      currentAddress: currentAddress ?? this.currentAddress,
      dob: dob ?? this.dob,
      parentsNumber: parentsNumber ?? this.parentsNumber,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props {
    return [
      phoneNumber,
      currentAddress,
      dob,
      parentsNumber,
      id,
    ];
  }
}
