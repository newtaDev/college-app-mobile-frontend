part of students_entity;

class StudentsInClassRes extends MyEquatable {
  final String? status;
  final List<StudentUser>? responseData;

  const StudentsInClassRes({this.status, this.responseData});

  factory StudentsInClassRes.fromMap(Map<String, dynamic> data) {
    return StudentsInClassRes(
      status: data['status'] as String?,
      responseData: (data['responseData'] as List<dynamic>?)
          ?.map((e) => StudentUser.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [StudentsInClassRes].
  factory StudentsInClassRes.fromJson(String data) {
    return StudentsInClassRes.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  StudentsInClassRes copyWith({
    String? status,
    List<StudentUser>? responseData,
  }) {
    return StudentsInClassRes(
      status: status ?? this.status,
      responseData: responseData ?? this.responseData,
    );
  }

  @override
  List<Object?> get props => [status, responseData];
}
