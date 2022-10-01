part of anouncement_entity;

class CreatedOrModifiedBy extends MyEquatable {
  final AnouncementUser? user;
  final String? userType;

  const CreatedOrModifiedBy({this.user, this.userType});

  factory CreatedOrModifiedBy.fromMap(Map<String, dynamic> data) => CreatedOrModifiedBy(
        user: data['userId'] == null
            ? null
            : AnouncementUser.fromMap(data['userId'] as Map<String, dynamic>),
        userType: data['userType'] as String?,
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CreatedOrModifiedBy].
  factory CreatedOrModifiedBy.fromJson(String data) {
    return CreatedOrModifiedBy.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  CreatedOrModifiedBy copyWith({
    AnouncementUser? user,
    String? userType,
  }) {
    return CreatedOrModifiedBy(
      user: user ?? this.user,
      userType: userType ?? this.userType,
    );
  }

  @override
  List<Object?> get props => [user, userType];
}
