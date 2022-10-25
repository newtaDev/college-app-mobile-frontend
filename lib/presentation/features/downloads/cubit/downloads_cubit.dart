import 'dart:io';

import 'package:better_open_file/better_open_file.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/data_source/local/downloads.lds.dart';
import '../../../../data/models/local/downloads.dart';
import '../../../../shared/errors/api_errors.dart';

part 'downloads_state.dart';

class DownloadsCubit extends Cubit<DownloadsState> {
  final DownloadsLocalDataSource downloadsLds;
  DownloadsCubit({
    required this.downloadsLds,
  }) : super(const DownloadsState.init());

  Future<void> getDownloadsFormSubjectId(String subjectId) async {
    emit(state.copyWith(status: DownloadsStatus.loading));
    try {
      final res = await downloadsLds.getAllDownloadsOfSubject(subjectId);
      emit(
        state.copyWith(
          status: DownloadsStatus.success,
          downloads: res,
        ),
      );
    } catch (e) {
      final apiErrorRes =
          ApiErrorRes(message: 'Fetching subejct downloads failed');
      emit(
        state.copyWith(
          status: DownloadsStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  Future<void> getAllDownloads() async {
    emit(state.copyWith(status: DownloadsStatus.loading));
    try {
      final res = await downloadsLds.getAllDownloads();
      emit(
        state.copyWith(
          status: DownloadsStatus.success,
          downloads: res,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(message: 'Fetching  downloads failed');
      emit(
        state.copyWith(
          status: DownloadsStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  Future<String?> openDownloadedFile(Downloads downloadedFile) async {
    final result = await OpenFile.open(downloadedFile.localPath);
    if (result.type != ResultType.done) return result.message;
    return null;
  }

  /// Delete from [local db] ,[from app directory], [from memory]
  Future deleteFileFromDownloads({
    required Downloads downloadedFile,
    required void Function(Downloads downloadedFile) onDownloadsDeleted,
  }) async {
    try {
      // delete from memory
      onDownloadsDeleted(downloadedFile);
      final downloads = List<Downloads>.from(state.downloads)
        ..removeWhere(
          (element) =>
              element.downloadedFrom.attachmentId ==
              downloadedFile.downloadedFrom.attachmentId,
        );
      emit(
        state.copyWith(
          downloads: downloads,
        ),
      );
      // delete from local db
      await downloadsLds.deleteDownloadedFile(downloadedFile);
      // delete from app directory
      final file = File(downloadedFile.localPath);
      await file.delete();
    } catch (e) {
      final apiErrorRes = ApiErrorRes(message: 'Deleting Downloads failed');
      emit(
        state.copyWith(error: apiErrorRes),
      );
      rethrow;
    }
  }
}
