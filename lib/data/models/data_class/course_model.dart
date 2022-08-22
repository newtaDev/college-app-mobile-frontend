import 'dart:convert';

import '../../../utils/utils.dart';

class Course extends MyEquatable {
  final String? id;
  final String? name;
  final String? collegeId;
  final int? totalSem;
  final int? v;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Course({
    this.id,
    this.name,
    this.collegeId,
    this.totalSem,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory Course.fromMap(Map<String, dynamic> data) => Course(
        id: data['_id'] as String?,
        name: data['name'] as String?,
        collegeId: data['collegeId'] as String?,
        totalSem: data['totalSem'] as int?,
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
        'collegeId': collegeId,
        'totalSem': totalSem,
        '__v': v,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Course].
  factory Course.fromJson(String data) {
    return Course.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Course] to a JSON string.
  String toJson() => json.encode(toMap());

  Course copyWith({
    String? id,
    String? name,
    String? collegeId,
    int? totalSem,
    int? v,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Course(
      id: id ?? this.id,
      name: name ?? this.name,
      collegeId: collegeId ?? this.collegeId,
      totalSem: totalSem ?? this.totalSem,
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
      collegeId,
      totalSem,
      v,
      createdAt,
      updatedAt,
    ];
  }
}
