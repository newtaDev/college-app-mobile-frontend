part of auth_entitie;

class SignUpReq {
  String email;
  String password;
  String name;
  String confirmPassword;

  SignUpReq({
    required this.email,
    required this.password,
    required this.name,
    required this.confirmPassword,
  });

  Map<String, dynamic> toMap() => {
        'email': email,
        'password': password,
        'name': name,
        'confirmPassword': confirmPassword,
      };

  /// `dart:convert`
  ///
  /// Converts [SignUpReq] to a JSON string.
  String toJson() => json.encode(toMap());
}

class SignInReq {
  final String email;
  final String password;
  SignInReq({
    required this.email,
    required this.password,
  });

  SignInReq copyWith({
    String? email,
    String? password,
  }) {
    return SignInReq(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());
}
