part of user_entity;

class SearchUserProfilesRes extends MyEquatable {
  final String? status;
  final List<AnonymousUser>? responseData;

  const SearchUserProfilesRes({this.status, this.responseData});

  factory SearchUserProfilesRes.fromMap(Map<String, dynamic> data) {
    return SearchUserProfilesRes(
      status: data['status'] as String?,
      responseData: (data['responseData'] as List<dynamic>?)
          ?.map((e) => AnonymousUser.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SearchUserProfilesRes].
  factory SearchUserProfilesRes.fromJson(String data) {
    return SearchUserProfilesRes.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  SearchUserProfilesRes copyWith({
    String? status,
    List<AnonymousUser>? responseData,
  }) {
    return SearchUserProfilesRes(
      status: status ?? this.status,
      responseData: responseData ?? this.responseData,
    );
  }

  @override
  List<Object?> get props => [status, responseData];
}
