part of profile_entity;

class ProfileRes extends MyEquatable {
  final String? status;
  final UserProfileData? responseData;

  const ProfileRes({this.status, this.responseData});

  factory ProfileRes.fromMap(Map<String, dynamic> data) {
    return ProfileRes(
      status: data['status'] as String?,
      responseData: data['responseData'] != null
          ? UserHelper.setUserData(
              userType: UserType.fromName(data['responseData']['userType'])!,
              user: data['responseData'],
            )
          : null,
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProfileRes].
  factory ProfileRes.fromJson(String data) {
    return ProfileRes.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  @override
  List<Object?> get props => [status, responseData];

  ProfileRes copyWith({
    String? status,
    UserProfileData? responseData,
  }) {
    return ProfileRes(
      status: status ?? this.status,
      responseData: responseData ?? this.responseData,
    );
  }
}
