part of class_room_entity;

class AllSubjectResourceRes extends MyEquatable {
  final String? status;
  final List<SubjectResource>? responseData;

  const AllSubjectResourceRes({this.status, this.responseData});

  factory AllSubjectResourceRes.fromMap(Map<String, dynamic> data) {
    return AllSubjectResourceRes(
      status: data['status'] as String?,
      responseData: (data['responseData'] as List<dynamic>?)
          ?.map((e) => SubjectResource.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AllSubjectResourceRes].
  factory AllSubjectResourceRes.fromJson(String data) {
    return AllSubjectResourceRes.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  AllSubjectResourceRes copyWith({
    String? status,
    List<SubjectResource>? responseData,
  }) {
    return AllSubjectResourceRes(
      status: status ?? this.status,
      responseData: responseData ?? this.responseData,
    );
  }

  @override
  List<Object?> get props => [status, responseData];
}
