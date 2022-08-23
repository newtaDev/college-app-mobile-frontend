part of attendance_entity;


class AllAttendanceWithQueryReq extends MyEquatable {
  final String? classId;
  final int? currentSem;
  const AllAttendanceWithQueryReq({
    this.classId,
    this.currentSem,
  });
  @override
  List<Object?> get props => [classId, currentSem];

  Map<String, dynamic> toMap() {
    return {
      if (classId != null) 'classId': classId,
      if (currentSem != null) 'currentSem': currentSem,
    };
  }

  String toJson() => json.encode(toMap());
}
