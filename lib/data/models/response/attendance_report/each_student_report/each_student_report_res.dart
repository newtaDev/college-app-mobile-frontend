part of reports_entity;

class EachStudentReportRes extends MyEquatable {
  final String? status;
  final List<EachStudentReport>? responseData;

  const EachStudentReportRes({this.status, this.responseData});

  factory EachStudentReportRes.fromMap(Map<String, dynamic> data) {
    return EachStudentReportRes(
      status: data['status'] as String?,
      responseData: (data['responseData'] as List<dynamic>?)
          ?.map((e) => EachStudentReport.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'responseData': responseData?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [EachStudentReportRes].
  factory EachStudentReportRes.fromJson(String data) {
    return EachStudentReportRes.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [EachStudentReportRes] to a JSON string.
  String toJson() => json.encode(toMap());

  EachStudentReportRes copyWith({
    String? status,
    List<EachStudentReport>? responseData,
  }) {
    return EachStudentReportRes(
      status: status ?? this.status,
      responseData: responseData ?? this.responseData,
    );
  }

  @override
  List<Object?> get props => [status, responseData];
}
