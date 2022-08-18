part of attendance_entity;

class SubjectReportRes extends Equatable {
  final String? status;
  final List<SubjectReports>? responseData;

  const SubjectReportRes({this.status, this.responseData});

  factory SubjectReportRes.fromMap(Map<String, dynamic> data) {
    return SubjectReportRes(
      status: data['status'] as String?,
      responseData: (data['responseData'] as List<dynamic>?)
          ?.map((e) => SubjectReports.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'responseData': responseData?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SubjectReportRes].
  factory SubjectReportRes.fromJson(String data) {
    return SubjectReportRes.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [SubjectReportRes] to a JSON string.
  String toJson() => json.encode(toMap());

  SubjectReportRes copyWith({
    String? status,
    List<SubjectReports>? responseData,
  }) {
    return SubjectReportRes(
      status: status ?? this.status,
      responseData: responseData ?? this.responseData,
    );
  }

  @override
  List<Object?> get props => [status, responseData];
}
