import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets/common/loading_indicator.dart';
import 'package:widgets_lib/widgets_lib.dart';

import '../../../data/models/local/downloads.dart';
import '../../../shared/extensions/extentions.dart';
import '../../../shared/helpers/file_helpers.dart';
import 'cubit/downloads_cubit.dart';

class DownloadsPageParam {
  final String? subjectId;
  final void Function(Downloads downloadedFile) onDownloadsDeleted;
  DownloadsPageParam({
    this.subjectId,
    required this.onDownloadsDeleted,
  });
}

class DownloadsPage extends StatefulWidget {
  final DownloadsPageParam params;
  const DownloadsPage({super.key, required this.params});

  @override
  State<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  @override
  void initState() {
    if (widget.params.subjectId != null) {
      context
          .read<DownloadsCubit>()
          .getDownloadsFormSubjectId(widget.params.subjectId!);
    } else {
      context.read<DownloadsCubit>().getAllDownloads();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
      ),
      body: BlocBuilder<DownloadsCubit, DownloadsState>(
        builder: (context, state) {
          if (state.status.isInitial || state.status.isLoading) {
            return const LoadingIndicator();
          }

          if (state.status.isError) {
            return  Center(child: Text(state.error?.message??'Oops... Something went wrong'));
          }
          if (state.downloads.isEmpty ) {
            return const Center(child: Text('No downloads found'));
          }
          return ListView.builder(
            itemCount: state.downloads.length,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            itemBuilder: (context, index) => DownloadedAttachmentCard(
              downloadedFile: state.downloads[index],
              onDownloadsDeleted: widget.params.onDownloadsDeleted,
            ),
          );
        },
      ),
    );
  }
}

class DownloadedAttachmentCard extends StatelessWidget {
  final Downloads downloadedFile;
  final void Function(Downloads downloadedFile) onDownloadsDeleted;
  const DownloadedAttachmentCard(
      {super.key,
      required this.downloadedFile,
      required this.onDownloadsDeleted});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final fileColor = FileHelpers.getColorFromContentType(
      downloadedFile.downloadedFrom.contentType,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () async {},
        behavior: HitTestBehavior.opaque,
        child: BorderedBox(
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: fileColor.withOpacity(0.1),
                child: Icon(
                  FileHelpers.getIconFromContentType(
                    downloadedFile.downloadedFrom.contentType,
                  ),
                  color: fileColor,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      downloadedFile.downloadedFrom.name ?? 'N/A',
                      style: textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          downloadedFile.downloadedFrom.size!
                              .convertBytesToReadableSize(),
                          style: textTheme.bodySmall,
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.circle,
                          size: 6,
                          color: ColorPallet.grey400,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          downloadedFile.downloadedFrom.name?.split('.').last ??
                              'N/A',
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                    Text(
                      downloadedFile.downloadedAt.toDaysAgoWithLimit(),
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  context.read<DownloadsCubit>().deleteFileFromDownloads(
                        downloadedFile: downloadedFile,
                        onDownloadsDeleted: onDownloadsDeleted,
                      );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
