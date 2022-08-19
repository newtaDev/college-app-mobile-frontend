part of reports_entity;

class Student extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? collegeId;
  final String? classId;
  final String? userType;
  final List<dynamic>? mySubjectIds;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Student({
    this.id,
    this.name,
    this.email,
    this.collegeId,
    this.classId,
    this.userType,
    this.mySubjectIds,
    this.createdAt,
    this.updatedAt,
  });

  factory Student.fromMap(Map<String, dynamic> data) => Student(
        id: data['_id'] as String?,
        name: data['name'] as String?,
        email: data['email'] as String?,
        collegeId: data['collegeId'] as String?,
        classId: data['classId'] as String?,
        userType: data['userType'] as String?,
        mySubjectIds: data['mySubjectIds'] as List<dynamic>?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name,
        'email': email,
        'collegeId': collegeId,
        'classId': classId,
        'userType': userType,
        'mySubjectIds': mySubjectIds,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Student].
  factory Student.fromJson(String data) {
    return Student.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Student] to a JSON string.
  String toJson() => json.encode(toMap());

  Student copyWith({
    String? id,
    String? name,
    String? email,
    String? collegeId,
    String? classId,
    String? userType,
    List<dynamic>? mySubjectIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      collegeId: collegeId ?? this.collegeId,
      classId: classId ?? this.classId,
      userType: userType ?? this.userType,
      mySubjectIds: mySubjectIds ?? this.mySubjectIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      email,
      collegeId,
      classId,
      userType,
      mySubjectIds,
      createdAt,
      updatedAt,
    ];
  }
}
