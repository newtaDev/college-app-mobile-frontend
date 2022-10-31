part of class_room_entity;

class UploadSubjectResourceReq {
  final String title;
  final String subjectId;
  final String userId;
  final String? description;
  final List<MultipartFile> attachments;

  UploadSubjectResourceReq({
    required this.title,
    required this.subjectId,
    required this.userId,
     this.description,
    required this.attachments,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subjectId': subjectId,
      'userId': userId,
      'description': description,
      'attachments': attachments,
    };
  }

  String toJson() => json.encode(toMap());
  FormData toFormData() => FormData.fromMap(toMap());
}
