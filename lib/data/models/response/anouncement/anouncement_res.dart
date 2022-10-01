part of anouncement_entity;

class AnouncementRes extends MyEquatable {
  final String? status;
  final List<AnouncementModel>? responseData;

  const AnouncementRes({this.status, this.responseData});

  factory AnouncementRes.fromMap(Map<String, dynamic> data) {
    return AnouncementRes(
      status: data['status'] as String?,
      responseData: (data['responseData'] as List<dynamic>?)
          ?.map((e) => AnouncementModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AnouncementRes].
  factory AnouncementRes.fromJson(String data) {
    return AnouncementRes.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  AnouncementRes copyWith({
    String? status,
    List<AnouncementModel>? responseData,
  }) {
    return AnouncementRes(
      status: status ?? this.status,
      responseData: responseData ?? this.responseData,
    );
  }

  @override
  List<Object?> get props => [status, responseData];
}
