import 'package:better_open_file/better_open_file.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../cubits/user/user_cubit.dart';
import '../../../../../data/models/data_class/subject_model.dart';
import '../../../../../domain/repository/class_room_repository.dart';
import '../../../../../shared/errors/api_errors.dart';
import '../../../../data/data_source/local/downloads.lds.dart';
import '../../../../data/models/data_class/downloading_attachment.dart';
import '../../../../data/models/local/downloads.dart';
import '../../../../data/models/request/comment_req.dart';
import '../../../../domain/entities/class_room_entity.dart';
import '../../../../domain/entities/common_entity.dart';
import '../../../../domain/repository/common_repository.dart';
import '../../../../shared/extensions/extentions.dart';
import '../../../../shared/helpers/network/dio_client.dart';

part 'class_room_state.dart';

class ClassRoomCubit extends Cubit<ClassRoomState> {
  final ClassRoomRepository classRoomRepo;
  final CommonRepository commonRepo;
  final UserCubit userCubit;
  final DownloadsLocalDataSource downloadsLds;
  ClassRoomCubit({
    required this.classRoomRepo,
    required this.commonRepo,
    required this.userCubit,
    required this.downloadsLds,
  }) : super(const ClassRoomState.init());

  Future<void> getMySubjects() async {
    emit(state.copyWith(mySubjectStatus: ClassRoomStatus.loading));
    try {
      late SubjectsRes res;
      if (userCubit.state.isTeacher) {
        res = await commonRepo
            .getAssignedSubjectsOfTeacher(userCubit.state.userAsTeacher!.id);
      } else {
        res = await commonRepo.getSubjectsOfClass(
          userCubit.state.userAsStudent!.classId,
        );
      }
      emit(
        state.copyWith(
          mySubjectStatus: ClassRoomStatus.success,
          mySubjects: res.responseData,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          mySubjectStatus: ClassRoomStatus.error,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Fetching Subjects failed');
      emit(
        state.copyWith(
          mySubjectStatus: ClassRoomStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  Future<void> getAllSubjectResources(String subjectId) async {
    emit(state.copyWith(allSubjectResourcesStatus: ClassRoomStatus.loading));
    try {
      final res =
          await classRoomRepo.getAllSubjectResourcesWithCount(subjectId);
      emit(
        state.copyWith(
          allSubjectResourcesStatus: ClassRoomStatus.success,
          allSubjectResources: res.responseData,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          allSubjectResourcesStatus: ClassRoomStatus.error,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes =
          ApiErrorRes(devMessage: 'Fetching All subject resource failed');
      emit(
        state.copyWith(
          allSubjectResourcesStatus: ClassRoomStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  Future<void> getSubjectResourceDetails(String resourceId) async {
    emit(state.copyWith(subjectResourceDetailsStatus: ClassRoomStatus.loading));
    try {
      final res = await classRoomRepo.getSubjectResourceDetails(resourceId);
      emit(
        state.copyWith(
          subjectResourceDetailsStatus: ClassRoomStatus.success,
          subjectResourceDetails: res.responseData,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          subjectResourceDetailsStatus: ClassRoomStatus.error,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes =
          ApiErrorRes(devMessage: 'Fetching subject resource details failed');
      emit(
        state.copyWith(
          subjectResourceDetailsStatus: ClassRoomStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  Future<void> addCommentToResource(
    SubjectResourceCommentReq commentReq,
  ) async {
    emit(state.copyWith(commentStatus: ClassRoomStatus.loading));
    try {
      /// Add comment and fetch new resource details
      await classRoomRepo.addCommentToResource(commentReq);
      final res =
          await classRoomRepo.getSubjectResourceDetails(commentReq.resourceId);

      emit(
        state.copyWith(
          commentStatus: ClassRoomStatus.success,
          subjectResourceDetails: res.responseData,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          commentStatus: ClassRoomStatus.error,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes =
          ApiErrorRes(devMessage: 'Fetching subject resource details failed');
      emit(
        state.copyWith(
          commentStatus: ClassRoomStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  void deleteDownloadedFileFromMemory(String attachmentId) {
    final updatedAttachments = List<DowloadingAttachment>.from(
      state.downloadingAttachments,
    )

      /// replace
      ..removeWhere(
        (element) => element.attachment.id == attachmentId,
      );
    emit(state.copyWith(downloadingAttachments: updatedAttachments));
  }

  Future<String?> openDownloadedFile(String attachmentId) async {
    // final downloadedFile = await downloadsLds.getDownloadedFile(attachmentId);
    final downloadedFile = await downloadsLds.getDownloadedFile(attachmentId);
    if (downloadedFile == null) return 'Downloaded file not found';
    final result = await OpenFile.open(downloadedFile.localPath);
    if (result.type != ResultType.done) return result.message;
    return null;
  }

  bool isAttachmentDownloading(String attachmentId) {
    return state.downloadingAttachments
            .firstWhereSafe(
              (element) => element.attachment.id == attachmentId,
            )
            ?.status ==
        DownloadinAttachmentStatus.downloading;
  }

  Future<void> downloadResources(Attachment attachment) async {
    if (isAttachmentDownloading(attachment.id!)) return;
    final dir = await getApplicationDocumentsDirectory();
    final dio = Dio()..interceptors.add(DioClient.logReq());
    final downloadedFilePath = '${dir.path}/${attachment.path}';
    final updatedAttachments = List<DowloadingAttachment>.from(
      state.downloadingAttachments,
    )..add(
        DowloadingAttachment(
          attachment: attachment,
          progress: 0,
          path: downloadedFilePath,
          status: DownloadinAttachmentStatus.downloading,
        ),
      );
    emit(state.copyWith(downloadingAttachments: updatedAttachments));
    await dio.download(
      attachment.url!,
      downloadedFilePath,
      onReceiveProgress: (count, total) async {
        final progress = (count / total) * 100;
        final downloadingAttachment =
            state.downloadingAttachments.firstWhereSafe(
          (element) => element.attachment.id == attachment.id,
        );

        /// if already exists || downloading started
        if (downloadingAttachment != null) {
          final updatedAttachments = List<DowloadingAttachment>.from(
            state.downloadingAttachments,
          )

            /// replace
            ..removeWhere(
              (element) =>
                  element.attachment.id == downloadingAttachment.attachment.id,
            )
            ..add(
              downloadingAttachment.copyWith(
                progress: progress.floor(),
                status: progress == 100
                    ? DownloadinAttachmentStatus.downloaded
                    : DownloadinAttachmentStatus.downloading,
              ),
            );
          if (progress == 100) {
            await addAttachmentToDownloads(
              attachment: attachment,
              downloadedPath: downloadedFilePath,
            );
          }
          emit(state.copyWith(downloadingAttachments: updatedAttachments));
        }
      },
    );
  }

  bool isDownloadedFileExists(String attachmentId) {
    return downloadsLds.isDownloadedFileExits(attachmentId);
  }

  Future<void> addAttachmentToDownloads({
    required String downloadedPath,
    required Attachment attachment,
  }) async {
    final isDownloaded = isDownloadedFileExists(attachment.id!);

    if (!isDownloaded) {
      await downloadsLds.addToDownloads(
        Downloads(
          localPath: downloadedPath,
          subjectId: state.subjectResourceDetails!.subjectId,
          downloadedAt: DateTime.now(),
          downloadedFrom: DownloadedFrom.fromMap(attachment.toMap()),
        ),
      );
    }
  }

  void setSubjectsForTeacher() {
    emit(
      state.copyWith(
        mySubjects: userCubit.state.userAsTeacher?.assignedSubjects,
        mySubjectStatus: ClassRoomStatus.success,
      ),
    );
  }
}
