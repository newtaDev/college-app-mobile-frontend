import 'package:isar/isar.dart';

import '../../models/local/downloads.dart';

class DownloadsLocalDataSource {
  Isar isar = Isar.getInstance()!;

  Future<void> addToDownloads(Downloads downloads) async {
    await isar.writeTxn(() async {
      await isar.downloads.put(downloads);
    });
  }

  Future<bool> isDownloadedFileExits(String attachmentId) async {
    final downloads = await isar.downloads
        .filter()
        .downloadedFrom((q) => q.attachmentIdEqualTo(attachmentId))
        .findFirst();
    if (downloads != null) return true;
    return false;
  }

  Future<Downloads?> getDownloadedFile(String attachmentId) async {
    final downloads = await isar.downloads
        .filter()
        .downloadedFrom((q) => q.attachmentIdEqualTo(attachmentId))
        .findFirst();
    return downloads;
  }

  Future<bool> deleteDownloadedFile(Downloads downloadedFile) async {
    return isar.writeTxn<bool>(() async {
      return isar.downloads.delete(downloadedFile.id);
    });
  }

  Future<List<Downloads>> getAllDownloadsOfSubject(String subjectId) async {
    final downloads = await isar.downloads
        .filter()
        .subjectIdEqualTo(subjectId)
        .sortByDownloadedAtDesc()
        .findAll();
    return downloads;
  }

  Future<List<Downloads>> getAllDownloads() async {
    final downloads =
        await isar.downloads.where().sortByDownloadedAtDesc().findAll();
    return downloads;
  }
}
