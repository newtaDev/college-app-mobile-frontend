part of auth_entitie;

class AuthRes extends Equatable {
  final String? status;
  final String? accessToken;
  final String? refreshToken;
  final UserData? user;

  const AuthRes({this.status, this.accessToken, this.refreshToken, this.user});

  @override
  List<Object?> get props => [status, accessToken, refreshToken, user];

  factory AuthRes.fromMap(Map<String, dynamic> map) {
    final res = map['responseData'];
    return AuthRes(
      status: map['status'],
      accessToken: res['accessToken'],
      refreshToken: res['refreshToken'],
      user: res['user'] != null
          ? setUserData(
              userType: UserType.fromName(res['user']['userType'])!,
              user: res['user'],
            )
          : null,
    );
  }
  static UserData setUserData({
    required UserType userType,
    required Map<String, dynamic> user,
  }) {
    if (userType == UserType.teacher) {
      return TeacherUserData.fromMap(user);
    }
    if (userType == UserType.student) {}
    return StudentUserData.fromMap(user);
  }

  factory AuthRes.fromJson(String source) =>
      AuthRes.fromMap(json.decode(source));

  AuthRes copyWith({
    String? status,
    String? accessToken,
    String? refreshToken,
    UserData? user,
  }) {
    return AuthRes(
      status: status ?? this.status,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
    );
  }
}

class UserData extends Equatable {
final UserType userType;
  const UserData({
    required this.userType,
  });

  @override
  List<Object> get props => [userType];
}
