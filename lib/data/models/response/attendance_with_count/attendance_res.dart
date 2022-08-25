part of attendance_entity;

class AttendanceWithCountRes extends MyEquatable {
  final String? status;
  final List<AttendanceWithCount>? responseData;

  const AttendanceWithCountRes({this.status, this.responseData});

  factory AttendanceWithCountRes.fromMap(Map<String, dynamic> data) =>
      AttendanceWithCountRes(
        status: data['status'] as String?,
        responseData: (data['responseData'] as List<dynamic>?)
            ?.map((e) => AttendanceWithCount.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'responseData': responseData?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AttendanceWithCountRes].
  factory AttendanceWithCountRes.fromJson(String data) {
    return AttendanceWithCountRes.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [AttendanceWithCountRes] to a JSON string.
  String toJson() => json.encode(toMap());

  AttendanceWithCountRes copyWith({
    String? status,
    List<AttendanceWithCount>? responseData,
  }) {
    return AttendanceWithCountRes(
      status: status ?? this.status,
      responseData: responseData ?? this.responseData,
    );
  }

  @override
  List<Object?> get props => [status, responseData];
}
