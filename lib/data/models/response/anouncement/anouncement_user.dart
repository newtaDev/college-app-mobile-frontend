part of anouncement_entity;

class AnouncementUser extends MyEquatable {
  final String? id;
  final String? name;
  final String? userType;
  final bool? isProfileCompleted;

  const AnouncementUser({
    this.id,
    this.name,
    this.userType,
    this.isProfileCompleted,
  });

  factory AnouncementUser.fromMap(Map<String, dynamic> data) => AnouncementUser(
        id: data['_id'] as String?,
        name: data['name'] as String?,
        userType: data['userType'] as String?,
        isProfileCompleted: data['isProfileCompleted'] as bool?,
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AnouncementUser].
  factory AnouncementUser.fromJson(String data) {
    return AnouncementUser.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  AnouncementUser copyWith({
    String? id,
    String? name,
    String? userType,
    bool? isProfileCompleted,
  }) {
    return AnouncementUser(
      id: id ?? this.id,
      name: name ?? this.name,
      userType: userType ?? this.userType,
      isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      userType,
      isProfileCompleted,
    ];
  }
}
