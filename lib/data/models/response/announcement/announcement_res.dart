part of announcement_entity;

class AnnouncementRes extends MyEquatable {
  final String? status;
  final List<AnnouncementModel>? responseData;

  const AnnouncementRes({this.status, this.responseData});

  factory AnnouncementRes.fromMap(Map<String, dynamic> data) {
    return AnnouncementRes(
      status: data['status'] as String?,
      responseData: (data['responseData'] as List<dynamic>?)
          ?.map((e) => AnnouncementModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AnnouncementRes].
  factory AnnouncementRes.fromJson(String data) {
    return AnnouncementRes.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  AnnouncementRes copyWith({
    String? status,
    List<AnnouncementModel>? responseData,
  }) {
    return AnnouncementRes(
      status: status ?? this.status,
      responseData: responseData ?? this.responseData,
    );
  }

  @override
  List<Object?> get props => [status, responseData];
}
