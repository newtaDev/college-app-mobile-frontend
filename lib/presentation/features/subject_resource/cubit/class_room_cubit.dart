import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../cubits/user/user_cubit.dart';
import '../../../../../data/models/data_class/subject_model.dart';
import '../../../../../domain/repository/class_room_repository.dart';
import '../../../../../shared/errors/api_errors.dart';
import '../../../../data/models/data_class/downloading_attachment.dart';
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
  ClassRoomCubit({
    required this.classRoomRepo,
    required this.commonRepo,
    required this.userCubit,
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
  //   Future deleteFile() async {
  //   final dir = await getApplicationDocumentsDirectory();
  //   var file = File('${dir.path}/image.jpg');
  //   await file.delete();
  // }

  Future<void> downloadResources(Attachment attachment) async {
    final dir = await getApplicationDocumentsDirectory();
    final dio = Dio()..interceptors.add(DioClient.logReq());
    final downloadedFilePath = '${dir.path}/${attachment.path}';
    await dio.download(
      attachment.url!,
      downloadedFilePath,
      onReceiveProgress: (count, total) {
        final progress = (count / total) * 100;
        final downloadingAttachment =
            state.downloadingAttachments.firstWhereSafe(
          (element) => element.attachment.id == attachment.id,
        );

        /// if already exists
        if (downloadingAttachment != null) {
          final updatedAttachments = List<DowloadingAttachment>.from(
            state.downloadingAttachments,
          )
            ..removeWhere(
              (element) =>
                  element.attachment.id == downloadingAttachment.attachment.id,
            )
            ..add(
              downloadingAttachment.copyWith(
                progress: progress,
                status: progress == 100
                    ? DownloadinAttachmentStatus.downloaded
                    : DownloadinAttachmentStatus.downloading,
              ),
            );
          emit(state.copyWith(downloadingAttachments: updatedAttachments));
        } else {
          final updatedAttachments = List<DowloadingAttachment>.from(
            state.downloadingAttachments,
          )..add(
              DowloadingAttachment(
                attachment: attachment,
                progress: progress,
                path: downloadedFilePath,
                status: DownloadinAttachmentStatus.downloading,
              ),
            );
          emit(state.copyWith(downloadingAttachments: updatedAttachments));
        }
      },
    );
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
