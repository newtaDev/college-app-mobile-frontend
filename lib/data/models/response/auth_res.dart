part of auth_entitie;

class AuthRes extends Equatable {
  final String? status;
  final String? accessToken;
  final String? refreshToken;
  final UserData? data;

  const AuthRes({this.status, this.accessToken, this.refreshToken, this.data});

  @override
  List<Object?> get props => [status, accessToken, refreshToken, data];

  factory AuthRes.fromMap(Map<String, dynamic> map) {
    return AuthRes(
      status: map['status'],
      accessToken: map['accessToken'],
      refreshToken: map['refreshToken'],
      data: map['data'] != null ? UserData.fromMap(map['data']) : null,
    );
  }

  factory AuthRes.fromJson(String source) =>
      AuthRes.fromMap(json.decode(source));

  AuthRes copyWith({
    String? status,
    String? accessToken,
    String? refreshToken,
    UserData? data,
  }) {
    return AuthRes(
      status: status ?? this.status,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      data: data ?? this.data,
    );
  }
}

class UserData extends Equatable {
  final String? name;
  final String? email;
  final String? sId;
  final String? createdAt;
  final String? updatedAt;

  const UserData({
    this.name,
    this.email,
    this.sId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [name, email, sId, createdAt, updatedAt];

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name']  ,
      email: map['email'],
      sId: map['_id'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));
}
