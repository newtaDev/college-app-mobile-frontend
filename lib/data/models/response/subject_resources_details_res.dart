part of class_room_entity;

class SubjectResourcesDetailsRes extends MyEquatable {
  final String? status;
  final SubjectResource? responseData;

  const SubjectResourcesDetailsRes({this.status, this.responseData});

  factory SubjectResourcesDetailsRes.fromMap(Map<String, dynamic> data) {
    return SubjectResourcesDetailsRes(
      status: data['status'] as String?,
      responseData: data['responseData'] == null
          ? null
          : SubjectResource.fromMap(
              data['responseData'] as Map<String, dynamic>,
            ),
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SubjectResourcesDetailsRes].
  factory SubjectResourcesDetailsRes.fromJson(String data) {
    return SubjectResourcesDetailsRes.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  SubjectResourcesDetailsRes copyWith({
    String? status,
    SubjectResource? responseData,
  }) {
    return SubjectResourcesDetailsRes(
      status: status ?? this.status,
      responseData: responseData ?? this.responseData,
    );
  }

  @override
  List<Object?> get props => [status, responseData];
}
