import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../../../../cubits/user/user_cubit.dart';
import '../../../../../data/models/data_class/class_with_details.dart';
import '../../../../../data/models/request/anouncement_req.dart';
import '../../../../../domain/repository/anouncement_repository.dart';
import '../../../../../shared/errors/api_errors.dart';
import '../../../../../shared/global/enums.dart';
import '../../../attendance/create_attendance/cubit/create_attendance_cubit.dart';
import '../pages/create_anouncement_page.dart';

part 'create_anouncement_state.dart';

class CreateAnouncementCubit extends Cubit<CreateAnouncementState> {
  final AnouncementRepository anouncementRepo;
  final UserCubit userCubit;
  CreateAnouncementCubit({
    required this.anouncementRepo,
    required this.userCubit,
  }) : super(const CreateAnouncementState.init());

  void setUpLayout(AnouncementLayoutType type) {
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

  void setAnouncementTitle(String val) {
    emit(state.copyWith(title: val.trim()));
  }

  void setAnouncementDescription(String val) {
    emit(state.copyWith(description: val.trim()));
  }

  Future<void> pickAndSetImage() async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      final _file = File(result.files.single.path!);
      emit(state.copyWith(image: _file));
    }
  }

  Future<void> pickAndSetMultiImage() async {
    final FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    if (result != null) {
      final _recentPickedFiles =
          result.paths.map((path) => File(path!)).toList();
      final allFiles = List<File>.from(state.multiImages)
        ..addAll(_recentPickedFiles);
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
    emit(const CreateAnouncementState.init());
  }

  Future<void> createAnouncemnt() async {
    emit(state.copyWith(status: CreateAnouncementStatus.loading));

    try {
      switch (state.layoutType) {
        case AnouncementLayoutType.onlyText:
          await anouncementRepo.createOnlyTextAnouncement(
            OnlyTextAnouncementReq(
              title: state.title!,
              description: state.description!,
              anounceTo: state.anounceTo,
              collegeId: userCubit.state.userDetails.collegeId,
              anouncementLayoutType: state.layoutType,
              anounceToClassIds:
                  state.selectedClasses.map((e) => e.id!).toList(),
            ),
          );
          break;
        case AnouncementLayoutType.imageWithText:
          final fileName = state.image?.path.split('/').last;
          await anouncementRepo.createImageWithTextAnouncemet(
            ImageWithTextAnouncementReq(
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
              anouncementLayoutType: state.layoutType,
              anounceToClassIds:
                  state.selectedClasses.map((e) => e.id!).toList(),
            ),
          );
          break;
        case AnouncementLayoutType.multiImageWithText:
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
          await anouncementRepo.createMultiImageWithTextAnouncement(
            MultiImageWithTextAnouncementRq(
              title: state.title!,
              description: state.description!,
              anounceTo: state.anounceTo,
              collegeId: userCubit.state.userDetails.collegeId,
              anouncementLayoutType: state.layoutType,
              anounceToClassIds:
                  state.selectedClasses.map((e) => e.id!).toList(),
              multipleFiles: multiFiles,
            ),
          );
          break;
      }

      emit(
        state.copyWith(
          status: CreateAnouncementStatus.success,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          status: CreateAnouncementStatus.error,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes =
          ApiErrorRes(devMessage: 'Creating anouncement failed');
      emit(
        state.copyWith(
          status: CreateAnouncementStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  CreateAnouncementValidationStatus validateCreateAnoucenmentReq() {
    if (state.selectedClasses.isEmpty) {
      return CreateAnouncementValidationStatus.issueInAnounceToClasses;
    }
    switch (state.layoutType) {
      case AnouncementLayoutType.onlyText:
        return CreateAnouncementValidationStatus.success;
      case AnouncementLayoutType.imageWithText:
        if (state.image == null) {
          return CreateAnouncementValidationStatus.issueInSingleImage;
        }
        return CreateAnouncementValidationStatus.success;
      case AnouncementLayoutType.multiImageWithText:
        if (state.multiImages.isEmpty) {
          return CreateAnouncementValidationStatus.issueInMultiImage;
        }
        return CreateAnouncementValidationStatus.success;
    }
  }
}
