import 'package:hive_flutter/hive_flutter.dart';

import '../../../shared/extensions/extentions.dart';
import '../../../shared/global/hive_boxes.dart';
import '../../models/local/downloads.dart';

class DownloadsLocalDataSource {
  Box<Downloads> box = Hive.box(HiveBoxes.downloads.name);

  Future<void> addToDownloads(Downloads downloads) async {
    await box.add(downloads);
    // await isar.writeTxn(() async {
    //   await isar.downloads.put(downloads);
    // });
  }

  bool isDownloadedFileExits(String attachmentId) {
    return box.values
        .where((element) => element.downloadedFrom.attachmentId == attachmentId)
        .isNotEmpty;
    // final downloads = await isar.downloads
    //     .filter()
    //     .downloadedFrom((q) => q.attachmentIdEqualTo(attachmentId))
    //     .findFirst();
    // if (downloads != null) return true;
  }

  Future<Downloads?> getDownloadedFile(String attachmentId) async {
    return box.values.toList().firstWhereSafe(
          (element) => element.downloadedFrom.attachmentId == attachmentId,
        );
    // final downloads = await isar.downloads
    //     .filter()
    //     .downloadedFrom((q) => q.attachmentIdEqualTo(attachmentId))
    //     .findFirst();
  }

  Future<bool> deleteDownloadedFile(Downloads downloadedFile) async {
    final deleteItem = box.toMap().entries.firstWhereSafe(
          (element) =>
              element.value.downloadedFrom.attachmentId ==
              downloadedFile.downloadedFrom.attachmentId,
        );
    if (deleteItem == null) return false;
    await box.delete(deleteItem.key as int);
    // return isar.writeTxn<bool>(() async {
    //   return isar.downloads.delete(downloadedFile.id);
    // });
    return true;
  }

  Future<List<Downloads>> getAllDownloadsOfSubject(String subjectId) async {
    // final downloads = await isar.downloads
    //     .filter()
    //     .subjectIdEqualTo(subjectId)
    //     .sortByDownloadedAtDesc()
    //     .findAll();
    // return downloads;
    final downloads = box.values
        .where((element) => element.subjectId == subjectId)
        .toList()
      ..sort((a, b) => b.downloadedAt.compareTo(a.downloadedAt));
    return downloads;
  }

  Future<List<Downloads>> getAllDownloads() async {
    // final downloads =
    //     await isar.downloads.where().sortByDownloadedAtDesc().findAll();
    // return downloads;
    final downloads = box.values.toList()
      ..sort((a, b) => b.downloadedAt.compareTo(a.downloadedAt));
    return downloads;
  }
}
