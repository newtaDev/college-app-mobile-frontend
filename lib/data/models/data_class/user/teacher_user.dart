part of user_entity;

class TeacherUser extends UserDetails {
  final List<String> assignedClasses;
  final int? phoneNumber;
  final String? currentAddress;
  final DateTime? dob;

  const TeacherUser({
    required super.name,
    super.email,
    required super.collegeId,
    required super.userType,
    required this.assignedClasses,
    this.phoneNumber,
    this.currentAddress,
    this.dob,
    super.username,
    required super.isProfileCompleted,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TeacherUser.fromMap(Map<String, dynamic> data) => TeacherUser(
        name: data['name'],
        email: data['email'] as String?,
        collegeId: data['collegeId'] as String,
        userType: UserType.fromName(data['userType'])!,
        assignedClasses: data['assignedClasses']
            .map<String>((dynamic e) => e.toString())
            .toList(),
        phoneNumber: data['phoneNumber'] as int?,
        currentAddress: data['currentAddress'] as String?,
        dob: data['dob'] == null ? null : DateTime.parse(data['dob'] as String).toLocal(),
        username: data['username'] as String?,
        isProfileCompleted: data['isProfileCompleted'] as bool,
        id: data['_id'] as String,
        createdAt: DateTime.parse(data['createdAt'] as String).toLocal(),
        updatedAt: DateTime.parse(data['updatedAt'] as String).toLocal(),
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'collegeId': collegeId,
        'userType': userType,
        'assignedClasses': assignedClasses,
        'username': username,
        'isProfileCompleted': isProfileCompleted,
        '_id': id,
        'phoneNumber': phoneNumber,
        'currentAddress': currentAddress,
        'dob': dob?.toIso8601String(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
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
    List<String>? assignedClasses,
    String? username,
    bool? isProfileCompleted,
    String? id,
    int? phoneNumber,
    String? currentAddress,
    DateTime? dob,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TeacherUser(
      name: name ?? this.name,
      email: email ?? this.email,
      collegeId: collegeId ?? this.collegeId,
      userType: userType ?? this.userType,
      assignedClasses: assignedClasses ?? this.assignedClasses,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      currentAddress: currentAddress ?? this.currentAddress,
      dob: dob ?? this.dob,
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
      userType,
      assignedClasses,
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
