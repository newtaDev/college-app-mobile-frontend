part of common_entity;

class SubjectsRes extends MyEquatable {
  final String? status;
  final List<Subject>? responseData;

  const SubjectsRes({this.status, this.responseData});

  factory SubjectsRes.fromMap(Map<String, dynamic> data) {
    return SubjectsRes(
      status: data['status'] as String?,
      responseData: (data['responseData'] as List<dynamic>?)
          ?.map((e) => Subject.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SubjectsRes].
  factory SubjectsRes.fromJson(String data) {
    return SubjectsRes.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  SubjectsRes copyWith({
    String? status,
    List<Subject>? responseData,
  }) {
    return SubjectsRes(
      status: status ?? this.status,
      responseData: responseData ?? this.responseData,
    );
  }

  @override
  List<Object?> get props => [status, responseData];
}
