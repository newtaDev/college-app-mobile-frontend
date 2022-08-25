part of common_entity;
class ClassWithDetailsRes extends MyEquatable {
  final String? status;
  final List<ClassWithDetails>? responseData;

  const ClassWithDetailsRes({this.status, this.responseData});

  factory ClassWithDetailsRes.fromMap(Map<String, dynamic> data) {
    return ClassWithDetailsRes(
      status: data['status'] as String?,
      responseData: (data['responseData'] as List<dynamic>?)
          ?.map((e) => ClassWithDetails.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'responseData': responseData?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ClassWithDetailsRes].
  factory ClassWithDetailsRes.fromJson(String data) {
    return ClassWithDetailsRes.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [ClassWithDetailsRes] to a JSON string.
  String toJson() => json.encode(toMap());

  ClassWithDetailsRes copyWith({
    String? status,
    List<ClassWithDetails>? responseData,
  }) {
    return ClassWithDetailsRes(
      status: status ?? this.status,
      responseData: responseData ?? this.responseData,
    );
  }

  @override
  List<Object?> get props => [status, responseData];
}
