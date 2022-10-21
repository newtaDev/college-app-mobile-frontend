import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../../../../cubits/user/user_cubit.dart';
import '../../../../../data/models/data_class/class_with_details.dart';
import '../../../../../data/models/request/announcement_req.dart';
import '../../../../../domain/repository/announcement_repository.dart';
import '../../../../../shared/errors/api_errors.dart';
import '../../../../../shared/global/enums.dart';
import '../../../../../shared/services/file_services.dart';

part 'create_announcement_state.dart';

class CreateAnnouncementCubit extends Cubit<CreateAnnouncementState> {
  final AnnouncementRepository announcementRepo;
  final UserCubit userCubit;
  CreateAnnouncementCubit({
    required this.announcementRepo,
    required this.userCubit,
  }) : super(const CreateAnnouncementState.init());

  void setUpLayout(AnnouncementLayoutType type) {
    emit(state.copyWith(layoutType: type));
  }

  void setSelectedClasses(List<ClassWithDetails> selectedClasses) {
    emit(state.copyWith(selectedClasses: List.from(selectedClasses)));
  }

  void removeSelectedClass(ClassWithDetails selectedClass) {
    final List<ClassWithDetails> removedClasses =
        List.from(state.selectedClasses)
          ..removeWhere((element) => element.id == selectedClass.id);
    emit(state.copyWith(selectedClasses: removedClasses));
  }

  void setAnnouncementTitle(String val) {
    emit(state.copyWith(title: val.trim()));
  }

  void setAnnouncementDescription(String val) {
    emit(state.copyWith(description: val.trim()));
  }

  Future<void> pickAndSetImage() async {
    final FilePickerResult? result = await FileServices.pickSingleImage();

    if (result != null) {
      final file = File(result.files.single.path!);
      emit(state.copyWith(image: file));
    }
  }

  Future<void> pickAndSetMultiImage() async {
    final FilePickerResult? result = await FileServices.pickMutipleImages();

    if (result != null) {
      final recentPickedFiles =
          result.paths.map((path) => File(path!)).toList();
      final allFiles = List<File>.from(state.multiImages)
        ..addAll(recentPickedFiles);
      emit(
        state.copyWith(
          multiImages:
              allFiles.length > 5 ? allFiles.take(5).toList() : allFiles,
        ),
      );
    }
  }

  void removeMultiImage(int index) {
    final remIMages = List<File>.from(state.multiImages)..removeAt(index);
    emit(state.copyWith(multiImages: remIMages));
  }

  void removeSingleImage() => emit(state.removeSingleImage());

  void clearState() {
    emit(const CreateAnnouncementState.init());
  }

  Future<void> createAnouncemnt() async {
    emit(state.copyWith(status: CreateAnnouncementStatus.loading));

    try {
      switch (state.layoutType) {
        case AnnouncementLayoutType.onlyText:
          await announcementRepo.createOnlyTextAnnouncement(
            OnlyTextAnnouncementReq(
              title: state.title!,
              description: state.description!,
              anounceTo: state.anounceTo,
              collegeId: userCubit.state.userDetails.collegeId,
              announcementLayoutType: state.layoutType,
              anounceToClassIds:
                  state.selectedClasses.map((e) => e.id!).toList(),
            ),
          );
          break;
        case AnnouncementLayoutType.imageWithText:
          final fileName = state.image?.path.split('/').last;
          await announcementRepo.createImageWithTextAnouncemet(
            ImageWithTextAnnouncementReq(
              title: state.title!,
              description: state.description!,
              imageFile: await MultipartFile.fromFile(
                state.image!.path,
                filename: fileName,
                contentType:
                    MediaType.parse(lookupMimeType(state.image!.path)!),
              ),
              anounceTo: state.anounceTo,
              collegeId: userCubit.state.userDetails.collegeId,
              announcementLayoutType: state.layoutType,
              anounceToClassIds:
                  state.selectedClasses.map((e) => e.id!).toList(),
            ),
          );
          break;
        case AnnouncementLayoutType.multiImageWithText:
          final multiFiles = state.multiImages.map(
            (imgFile) {
              final fileName = imgFile.path.split('/').last;
              return MultipartFile.fromFileSync(
                imgFile.path,
                filename: fileName,
                contentType: MediaType.parse(lookupMimeType(imgFile.path)!),
              );
            },
          ).toList();
          await announcementRepo.createMultiImageWithTextAnnouncement(
            MultiImageWithTextAnnouncementRq(
              title: state.title!,
              description: state.description!,
              anounceTo: state.anounceTo,
              collegeId: userCubit.state.userDetails.collegeId,
              announcementLayoutType: state.layoutType,
              anounceToClassIds:
                  state.selectedClasses.map((e) => e.id!).toList(),
              multipleFiles: multiFiles,
            ),
          );
          break;
      }

      emit(
        state.copyWith(
          status: CreateAnnouncementStatus.success,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          status: CreateAnnouncementStatus.error,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes =
          ApiErrorRes(devMessage: 'Creating announcement failed');
      emit(
        state.copyWith(
          status: CreateAnnouncementStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  CreateAnnouncementValidationStatus validateCreateAnoucenmentReq() {
    if (state.selectedClasses.isEmpty) {
      return CreateAnnouncementValidationStatus.issueInAnounceToClasses;
    }
    switch (state.layoutType) {
      case AnnouncementLayoutType.onlyText:
        return CreateAnnouncementValidationStatus.success;
      case AnnouncementLayoutType.imageWithText:
        if (state.image == null) {
          return CreateAnnouncementValidationStatus.issueInSingleImage;
        }
        return CreateAnnouncementValidationStatus.success;
      case AnnouncementLayoutType.multiImageWithText:
        if (state.multiImages.isEmpty) {
          return CreateAnnouncementValidationStatus.issueInMultiImage;
        }
        return CreateAnnouncementValidationStatus.success;
    }
  }
}
