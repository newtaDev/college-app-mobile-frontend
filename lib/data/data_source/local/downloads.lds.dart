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
}
