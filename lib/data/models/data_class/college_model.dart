import 'dart:convert';

import '../../../utils/utils.dart';

class College extends MyEquatable {
  final String? id;
  final String? name;
  final String? email;
  final int? mobile;
  final String? website;
  final String? address;
  final String? description;
  final int? v;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const College({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.website,
    this.address,
    this.description,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory College.fromMap(Map<String, dynamic> data) => College(
        id: data['_id'] as String?,
        name: data['name'] as String?,
        email: data['email'] as String?,
        mobile: data['mobile'] as int?,
        website: data['website'] as String?,
        address: data['address'] as String?,
        description: data['description'] as String?,
        v: data['__v'] as int?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String).toLocal(),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String).toLocal(),
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name,
        'email': email,
        'mobile': mobile,
        'website': website,
        'address': address,
        'description': description,
        '__v': v,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [College].
  factory College.fromJson(String data) {
    return College.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [College] to a JSON string.
  String toJson() => json.encode(toMap());

  College copyWith({
    String? id,
    String? name,
    String? email,
    int? mobile,
    String? website,
    String? address,
    String? description,
    int? v,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return College(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      website: website ?? this.website,
      address: address ?? this.address,
      description: description ?? this.description,
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
      mobile,
      website,
      address,
      description,
      v,
      createdAt,
      updatedAt,
    ];
  }
}
