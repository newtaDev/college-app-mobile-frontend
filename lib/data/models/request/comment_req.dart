import 'dart:convert';

class SubjectResourceCommentReq {
  final String resourceId;
  final String userId;
  final String comment;
  final String userType;

  SubjectResourceCommentReq({
    required this.resourceId,
    required this.userId,
    required this.comment,
    required this.userType,
  });

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'comment': comment,
        'userType': userType,
      };

  String toJson() => json.encode(toMap());
}
