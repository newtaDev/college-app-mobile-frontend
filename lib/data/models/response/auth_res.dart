part of auth_entitie;

class AuthRes extends MyEquatable {
  final String status;
  final String accessToken;
  final String refreshToken;
  final UserDetails? user;

  const AuthRes({
    required this.status,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  @override
  List<Object?> get props => [status, accessToken, refreshToken, user];

  factory AuthRes.fromMap(Map<String, dynamic> map) {
    final res = map['responseData'];
    return AuthRes(
      status: map['status'],
      accessToken: res['accessToken'],
      refreshToken: res['refreshToken'],
      user: res['user'] != null
          ? UserHelper.setUserData(
              userType: UserType.fromName(res['user']['userType'])!,
              user: res['user'],
            )
          : null,
    );
  }

  factory AuthRes.fromJson(String source) =>
      AuthRes.fromMap(json.decode(source));

  AuthRes copyWith({
    String? status,
    String? accessToken,
    String? refreshToken,
    UserDetails? user,
  }) {
    return AuthRes(
      status: status ?? this.status,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
    );
  }
}
