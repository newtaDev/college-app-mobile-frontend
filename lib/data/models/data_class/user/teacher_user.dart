part of user_entity;

class TeacherUser extends UserDetails {
  final List<ClassWithDetails> accessibleClasses;
  final List<Subject> assignedSubjects;
  final List<String> assignedClassIds;
  final List<String> assignedSubjectIds;
  final int? phoneNumber;
  final String? currentAddress;
  final DateTime? dob;

  const TeacherUser({
    required super.name,
    super.email,
    required super.collegeId,
    required super.userType,
    required this.accessibleClasses,
    required this.assignedClassIds,
    required this.assignedSubjects,
    required this.assignedSubjectIds,
    this.phoneNumber,
    this.currentAddress,
    this.dob,
    super.username,
    super.emoji,
    super.bio,
    required super.isProfileCompleted,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TeacherUser.fromMap(Map<String, dynamic> data) => TeacherUser(
        name: data['name'],
        email: data['email'] as String?,
        emoji: data['emoji'] as String? ?? '👩🏻‍🏫',
        bio: data['bio'] as String?,
        collegeId: data['collegeId'] as String,
        userType: UserType.fromName(data['userType'])!,
        assignedClassIds:
            data['accessibleClasses'] == null || data['accessibleClasses'].isEmpty
                ? []
                : data['accessibleClasses'][0] is Map<String, dynamic>
                    ? data['accessibleClasses']
                        .map<String>((dynamic e) => e['_id'].toString())
                        .toList()
                    : data['accessibleClasses']
                        .map<String>((dynamic e) => e.toString())
                        .toList(),
        assignedSubjectIds:
            data['assignedSubjects'] == null || data['assignedSubjects'].isEmpty
                ? []
                : data['assignedSubjects'][0] is Map<String, dynamic>
                    ? data['assignedSubjects']
                        .map<String>((dynamic e) => e['_id'].toString())
                        .toList()
                    : data['assignedSubjects']
                        .map<String>((dynamic e) => e.toString())
                        .toList(),
        accessibleClasses:
            data['accessibleClasses'] == null || data['accessibleClasses'].isEmpty
                ? []
                : data['accessibleClasses'][0] is Map<String, dynamic>
                    ? (data['accessibleClasses'] as List<dynamic>?)
                            ?.map(
                              (dynamic e) => ClassWithDetails.fromMap(
                                e as Map<String, dynamic>,
                              ),
                            )
                            .toList() ??
                        []
                    : [],
        assignedSubjects:
            data['assignedSubjects'] == null || data['assignedSubjects'].isEmpty
                ? []
                : data['assignedSubjects'][0] is Map<String, dynamic>
                    ? (data['assignedSubjects'] as List<dynamic>?)
                            ?.map(
                              (dynamic e) => Subject.fromMap(
                                e as Map<String, dynamic>,
                              ),
                            )
                            .toList() ??
                        []
                    : [],
        phoneNumber: data['phoneNumber'] as int?,
        currentAddress: data['currentAddress'] as String?,
        dob: data['dob'] == null
            ? null
            : DateTime.parse(data['dob'] as String).toLocal(),
        username: data['username'] as String?,
        isProfileCompleted: data['isProfileCompleted'] as bool,
        id: data['_id'] as String,
        createdAt: DateTime.parse(data['createdAt'] as String).toLocal(),
        updatedAt: DateTime.parse(data['updatedAt'] as String).toLocal(),
      );

  Map<String, dynamic> toMap() => {
        'email': email,
        'emoji': emoji,
        'bio': bio,
        'username': username,
        'isProfileCompleted': isProfileCompleted,
        'phoneNumber': phoneNumber,
        'currentAddress': currentAddress,
        'dob': dob?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TeacherUser].
  factory TeacherUser.fromJson(String data) {
    return TeacherUser.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TeacherUser] to a JSON string.
  String toJson() => json.encode(toMap());

  TeacherUser copyWith({
    String? name,
    String? email,
    String? collegeId,
    UserType? userType,
    List<ClassWithDetails>? accessibleClasses,
    List<Subject>? assignedSubjects,
    List<String>? assignedClassIds,
    List<String>? assignedSubjectIds,
    String? username,
    bool? isProfileCompleted,
    String? id,
    int? phoneNumber,
    String? emoji,
    String? bio,
    String? currentAddress,
    DateTime? dob,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TeacherUser(
      name: name ?? this.name,
      email: email ?? this.email,
      emoji: emoji ?? this.emoji,
      bio: bio ?? this.bio,
      collegeId: collegeId ?? this.collegeId,
      userType: userType ?? this.userType,
      accessibleClasses: accessibleClasses ?? this.accessibleClasses,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      currentAddress: currentAddress ?? this.currentAddress,
      dob: dob ?? this.dob,
      username: username ?? this.username,
      isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      assignedClassIds: assignedClassIds ?? this.assignedClassIds,
      assignedSubjectIds: assignedSubjectIds ?? this.assignedSubjectIds,
      assignedSubjects: assignedSubjects ?? this.assignedSubjects,
    );
  }

  @override
  List<Object?> get props {
    return [
      name,
      email,
      emoji,
      bio,
      collegeId,
      userType,
      accessibleClasses,
      assignedClassIds,
      assignedSubjectIds,
      assignedSubjects,
      phoneNumber,
      currentAddress,
      dob,
      username,
      isProfileCompleted,
      id,
      createdAt,
      updatedAt,
    ];
  }
}
