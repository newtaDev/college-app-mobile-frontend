part of user_entity;

class UserDetailsRes extends MyEquatable {
  final String? status;
  final UserDetails? responseData;

  const UserDetailsRes({this.status, this.responseData});

  factory UserDetailsRes.fromMap(Map<String, dynamic> data) {
    return UserDetailsRes(
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
  /// Parses the string and returns the resulting Json object as [UserDetailsRes].
  factory UserDetailsRes.fromJson(String data) {
    return UserDetailsRes.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  @override
  List<Object?> get props => [status, responseData];

  UserDetailsRes copyWith({
    String? status,
    UserDetails? responseData,
  }) {
    return UserDetailsRes(
      status: status ?? this.status,
      responseData: responseData ?? this.responseData,
    );
  }
}
