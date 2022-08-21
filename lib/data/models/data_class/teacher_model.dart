import 'dart:convert';

import '../../../utils/utils.dart';

class TeacherModel extends MyEquatable {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? collegeId;
  final String? userType;
  final int? v;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TeacherModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.collegeId,
    this.userType,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory TeacherModel.fromMap(Map<String, dynamic> data) => TeacherModel(
        id: data['_id'] as String?,
        name: data['name'] as String?,
        email: data['email'] as String?,
        password: data['password'] as String?,
        collegeId: data['collegeId'] as String?,
        userType: data['userType'] as String?,
        v: data['__v'] as int?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name,
        'email': email,
        'password': password,
        'collegeId': collegeId,
        'userType': userType,
        '__v': v,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TeacherModel
  /// ].
  factory TeacherModel.fromJson(String data) {
    return TeacherModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TeacherModel
  /// ] to a JSON string.
  String toJson() => json.encode(toMap());

  TeacherModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? collegeId,
    String? userType,
    int? v,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TeacherModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      collegeId: collegeId ?? this.collegeId,
      userType: userType ?? this.userType,
      v: v ?? this.v,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      email,
      password,
      collegeId,
      userType,
      v,
      createdAt,
      updatedAt,
    ];
  }
}
