import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../shared/global/enums.dart';

class OnlyTextAnouncementReq {
  final String title;
  final String description;
  final AnounceTo anounceTo;
  final String collegeId;
  final AnouncementLayoutType anouncementLayoutType;
  final List<String> anounceToClassIds;
  OnlyTextAnouncementReq({
    required this.title,
    required this.description,
    required this.anounceTo,
    required this.collegeId,
    required this.anouncementLayoutType,
    required this.anounceToClassIds,
  });
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'anounceTo': anounceTo.value,
      'collegeId': collegeId,
      'anouncementLayoutType': anouncementLayoutType.value,
      'anounceToClassIds[]': anounceToClassIds,
    };
  }

  String toJson() => json.encode(toMap());
  FormData toFormData() => FormData.fromMap(toMap());
}

class ImageWithTextAnouncementReq {
  final String title;
  final String description;
  final AnounceTo anounceTo;
  final String collegeId;
  final List<String> anounceToClassIds;
  final AnouncementLayoutType anouncementLayoutType;
  final MultipartFile imageFile;

  ImageWithTextAnouncementReq({
    required this.title,
    required this.description,
    required this.imageFile,
    required this.anounceTo,
    required this.collegeId,
    required this.anounceToClassIds,
    required this.anouncementLayoutType,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'anounceTo': anounceTo.value,
      'collegeId': collegeId,
      'anouncementLayoutType': anouncementLayoutType.value,
      'anounceToClassIds[]': anounceToClassIds,
      'imageFile': imageFile,
    };
  }

  String toJson() => json.encode(toMap());
  FormData toFormData() => FormData.fromMap(toMap());
}

class MultiImageWithTextAnouncementRq {
  final String title;
  final String description;
  final AnounceTo anounceTo;
  final String collegeId;
  final List<String> anounceToClassIds;
  final AnouncementLayoutType anouncementLayoutType;
  final List<MultipartFile> multipleFiles;

  MultiImageWithTextAnouncementRq({
    required this.title,
    required this.description,
    required this.multipleFiles,
    required this.anounceTo,
    required this.collegeId,
    required this.anounceToClassIds,
    required this.anouncementLayoutType,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'anounceTo': anounceTo.value,
      'collegeId': collegeId,
      'anouncementLayoutType': anouncementLayoutType.value,
      'anounceToClassIds[]': anounceToClassIds,
      'multipleFiles': multipleFiles,
    };
  }

  String toJson() => json.encode(toMap());
  FormData toFormData() => FormData.fromMap(toMap());
}
