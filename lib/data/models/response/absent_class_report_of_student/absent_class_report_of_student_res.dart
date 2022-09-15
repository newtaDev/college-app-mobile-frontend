part of reports_entity;

class AbsentClassReportOfStudentRes extends MyEquatable {
  final String? status;
  final ClassWithDetails userClass;
  final List<AbsentClassReportOfStudent> reports;

  const AbsentClassReportOfStudentRes({
    this.status,
    required this.userClass,
    required this.reports,
  });

  factory AbsentClassReportOfStudentRes.fromMap(Map<String, dynamic> data) {
    return AbsentClassReportOfStudentRes(
      status: data['status'] as String?,
      userClass: ClassWithDetails.fromMap(data['responseData']['class']),
      reports: (data['responseData']['report'] as List<dynamic>?)
              ?.map(
                (e) => AbsentClassReportOfStudent.fromMap(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'responseData': reports.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AbsentClassReportOfStudentRes].
  factory AbsentClassReportOfStudentRes.fromJson(String data) {
    return AbsentClassReportOfStudentRes.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [AbsentClassReportOfStudentRes] to a JSON string.
  String toJson() => json.encode(toMap());

  AbsentClassReportOfStudentRes copyWith({
    String? status,
    ClassWithDetails? userClass,
    List<AbsentClassReportOfStudent>? reports,
  }) {
    return AbsentClassReportOfStudentRes(
      status: status ?? this.status,
      userClass: userClass ?? this.userClass,
      reports: reports ?? this.reports,
    );
  }

  @override
  List<Object?> get props => [status, reports, userClass];
}
