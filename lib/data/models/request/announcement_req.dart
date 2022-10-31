import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../shared/global/enums.dart';

class OnlyTextAnnouncementReq {
  final String title;
  final String description;
  final AnounceTo anounceTo;
  final String collegeId;
  final AnnouncementLayoutType announcementLayoutType;
  final List<String> anounceToClassIds;
  OnlyTextAnnouncementReq({
    required this.title,
    required this.description,
    required this.anounceTo,
    required this.collegeId,
    required this.announcementLayoutType,
    required this.anounceToClassIds,
  });
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'anounceTo': anounceTo.value,
      'collegeId': collegeId,
      'announcementLayoutType': announcementLayoutType.value,
      'anounceToClassIds[]': anounceToClassIds,
    };
  }

  String toJson() => json.encode(toMap());
  FormData toFormData() => FormData.fromMap(toMap());
}

class ImageWithTextAnnouncementReq {
  final String title;
  final String description;
  final AnounceTo anounceTo;
  final String collegeId;
  final List<String> anounceToClassIds;
  final AnnouncementLayoutType announcementLayoutType;
  final MultipartFile imageFile;

  ImageWithTextAnnouncementReq({
    required this.title,
    required this.description,
    required this.imageFile,
    required this.anounceTo,
    required this.collegeId,
    required this.anounceToClassIds,
    required this.announcementLayoutType,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'anounceTo': anounceTo.value,
      'collegeId': collegeId,
      'announcementLayoutType': announcementLayoutType.value,
      'anounceToClassIds[]': anounceToClassIds,
      'imageFile': imageFile,
    };
  }

  String toJson() => json.encode(toMap());
  FormData toFormData() => FormData.fromMap(toMap());
}

class MultiImageWithTextAnnouncementRq {
  final String title;
  final String description;
  final AnounceTo anounceTo;
  final String collegeId;
  final List<String> anounceToClassIds;
  final AnnouncementLayoutType announcementLayoutType;
  final List<MultipartFile> multipleFiles;

  MultiImageWithTextAnnouncementRq({
    required this.title,
    required this.description,
    required this.multipleFiles,
    required this.anounceTo,
    required this.collegeId,
    required this.anounceToClassIds,
    required this.announcementLayoutType,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'anounceTo': anounceTo.value,
      'collegeId': collegeId,
      'announcementLayoutType': announcementLayoutType.value,
      'anounceToClassIds[]': anounceToClassIds,
      'multipleFiles': multipleFiles,
    };
  }

  String toJson() => json.encode(toMap());
  FormData toFormData() => FormData.fromMap(toMap());
}
