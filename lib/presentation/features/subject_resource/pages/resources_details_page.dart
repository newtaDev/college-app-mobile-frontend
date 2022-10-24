import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets/common/fitted_text.dart';
import 'package:widgets_lib/widgets/widgets.dart';

import '../../../../cubits/user/user_cubit.dart';
import '../../../../data/models/data_class/downloading_attachment.dart';
import '../../../../data/models/request/comment_req.dart';
import '../../../../domain/entities/class_room_entity.dart';
import '../../../../shared/extensions/extentions.dart';
import '../../../../shared/helpers/file_helpers.dart';
import '../../../../shared/services/file_services.dart';
import '../../../router/routes.dart';
import '../../pages/image_viewer_page.dart';
import '../../subject_resource/cubit/class_room_cubit.dart';

class SubjectResourceDetailsPage extends StatefulWidget {
  final String resourceId;
  const SubjectResourceDetailsPage({super.key, required this.resourceId});

  @override
  State<SubjectResourceDetailsPage> createState() =>
      _SubjectResourceDetailsPageState();
}

class _SubjectResourceDetailsPageState
    extends State<SubjectResourceDetailsPage> {
  late TextEditingController commentCtr;
  @override
  void initState() {
    super.initState();
    commentCtr = TextEditingController();
    context.read<ClassRoomCubit>().getSubjectResourceDetails(widget.resourceId);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ClassRoomCubit, ClassRoomState>(
        buildWhen: (previous, current) =>
            previous.subjectResourceDetailsStatus !=
                current.subjectResourceDetailsStatus ||
            previous.subjectResourceDetails != current.subjectResourceDetails,
        builder: (context, state) {
          if (state.subjectResourceDetailsStatus.isInitial ||
              state.subjectResourceDetailsStatus.isLoading) {
            return const LoadingIndicator();
          }

          if (state.subjectResourceDetails == null ||
              state.subjectResourceDetailsStatus.isError) {
            return const Center(child: Text('No resources found ̰'));
          }
          return Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: ResourceDetailsHeader(
                        resource: state.subjectResourceDetails!,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: FittedText(
                          'Attachments',
                          style: textTheme.titleMedium,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      sliver: (state.subjectResourceDetails?.attachments
                                  ?.isEmpty ??
                              true)
                          ? const SliverToBoxAdapter(
                              child:
                                  Center(child: Text('No Attachments found')),
                            )
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                                childCount: state.subjectResourceDetails
                                    ?.attachments?.length,
                                (context, index) => SubjectAttachmentCard(
                                  attachment: state.subjectResourceDetails!
                                      .attachments![index],
                                ),
                              ),
                            ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(height: 1),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: FittedText(
                              'Comments',
                              style: textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      sliver: (state
                                  .subjectResourceDetails?.comments?.isEmpty ??
                              true)
                          ? const SliverToBoxAdapter(
                              child: Center(child: Text('No Comments found')),
                            )
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                                childCount: state
                                    .subjectResourceDetails?.comments?.length,
                                (context, index) => SubjectCommentCard(
                                  comment: state
                                      .subjectResourceDetails!.comments![index],
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                thickness: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: commentCtr,
                  decoration: InputDecoration(
                    hintText: 'Type a comment...',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      child: BlocConsumer<ClassRoomCubit, ClassRoomState>(
                        listenWhen: (previous, current) =>
                            previous.commentStatus != current.commentStatus,
                        listener: (context, state) {
                          if (state.commentStatus == ClassRoomStatus.success) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                        },
                        buildWhen: (previous, current) =>
                            previous.commentStatus != current.commentStatus,
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              final comment = commentCtr.text.trim();
                              if (comment.isEmpty) return;

                              final user =
                                  context.read<UserCubit>().state.userDetails;

                              context
                                  .read<ClassRoomCubit>()
                                  .addCommentToResource(
                                    SubjectResourceCommentReq(
                                      resourceId: widget.resourceId,
                                      userId: user.id,
                                      comment: comment,
                                      userType: user.userType.value,
                                    ),
                                  );
                              commentCtr.clear();
                            },
                            child: state.commentStatus.isLoading
                                ? const SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: LoadingIndicator(),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: const ColoredBox(
                                      color: ColorPallet.grey200,
                                      child: Icon(Icons.send_rounded),
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class SubjectAttachmentCard extends StatelessWidget {
  final Attachment attachment;
  const SubjectAttachmentCard({
    super.key,
    required this.attachment,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final fileColor =
        FileHelpers.getColorFromContentType(attachment.contentType);
    if (FileHelpers.imageContentTypes.contains(attachment.contentType)) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: BorderedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColoredBox(
                color: ColorPallet.grey100,
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.pushNamed(
                      Routes.imageViewerScreen.name,
                      extra: ImageViewerPageParams(
                        type: ImageViewerType.url,
                        heroTag: attachment.path!,
                        imageUrl: attachment.url,
                      ),
                    );
                  },
                  child: Hero(
                    tag: attachment.path!,
                    child: SizedBox(
                      height: 200,
                      width: double.maxFinite,
                      child: Image.network(
                        attachment.url!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          return loadingProgress == null
                              ? child
                              : const LoadingIndicator(isIosStyle: false);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                attachment.name ?? 'N/A',
                style: textTheme.titleSmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    attachment.size!.convertBytesToReadableSize(),
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
                    attachment.name?.split('.').last ?? 'N/A',
                    style: textTheme.bodySmall,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () async {
          final clasRoomCubit = context.read<ClassRoomCubit>();
          if (await clasRoomCubit.isDownloadedFileExists(attachment.id!)) {
            await clasRoomCubit.openDownloadedFile(attachment.id!);
          } else {
            await clasRoomCubit.downloadResources(attachment);
          }
        },
        behavior: HitTestBehavior.opaque,
        child: BorderedBox(
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: fileColor.withOpacity(0.1),
                child: Icon(
                  FileHelpers.getIconFromContentType(attachment.contentType),
                  color: fileColor,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attachment.name ?? 'N/A',
                      style: textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          attachment.size!.convertBytesToReadableSize(),
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
                          attachment.name?.split('.').last ?? 'N/A',
                          style: textTheme.bodySmall,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(width: 10),
              FutureBuilder<bool>(
                future: context
                    .read<ClassRoomCubit>()
                    .isDownloadedFileExists(attachment.id!),
                builder: (context, snapshot) {
                  return BlocBuilder<ClassRoomCubit, ClassRoomState>(
                    buildWhen: (previous, current) =>
                        previous.downloadingAttachments.firstWhereSafe(
                          (element) => element.attachment.id == attachment.id,
                        ) !=
                        current.downloadingAttachments.firstWhereSafe(
                          (element) => element.attachment.id == attachment.id,
                        ),
                    builder: (context, state) {
                      final isFileFoundInDownloads = snapshot.data ?? false;
                      final downloadingAttachment =
                          state.downloadingAttachments.firstWhereSafe(
                        (element) => element.attachment.id == attachment.id,
                      );
                      if (downloadingAttachment?.status.isDownloading ??
                          false) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value:
                                  (downloadingAttachment?.progress ?? 0) / 100,
                              strokeWidth: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: FittedText(
                                '${downloadingAttachment?.progress}',
                                style: textTheme.bodySmall,
                              ),
                            )
                          ],
                        );
                      }
                      if ((downloadingAttachment?.status.isDownloaded ??
                              false) ||
                          isFileFoundInDownloads) {
                        return const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        );
                      }
                      return CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.1),
                        child: const Icon(
                          Icons.file_download_outlined,
                          color: Colors.black,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubjectCommentCard extends StatelessWidget {
  final Comment comment;
  const SubjectCommentCard({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      shadowColor: Colors.black45,
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: ColorPallet.grey200,
                  child: Text(
                    comment.userDetails?.emoji ?? '👨🏻',
                    style: textTheme.titleLarge,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.userDetails?.name ?? 'N/A',
                        style: textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (comment.userDetails?.username != null)
                        Text(
                          '@${comment.userDetails?.username}',
                          style: textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                Text(
                  comment.createdAt?.toDaysAgoWithLimit() ?? 'N/A',
                  style: textTheme.bodySmall,
                ),
              ],
            ),
            const Divider(height: 20),
            Text(
              comment.comment ?? 'N/A',
              style: textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}

class ResourceDetailsHeader extends StatelessWidget {
  final SubjectResource resource;
  const ResourceDetailsHeader({
    super.key,
    required this.resource,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.access_time_rounded,
                color: ColorPallet.grey,
                size: 16,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  resource.createdAt?.toDaysAgoWithLimit() ?? 'N/A',
                  style: textTheme.bodySmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            resource.title ?? 'N/A',
            style: textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          if (resource.description != null) const SizedBox(height: 5),
          if (resource.description != null)
            Text(
              resource.description ?? 'N/A',
              style: textTheme.titleSmall?.copyWith(color: ColorPallet.grey),
            ),
          const SizedBox(height: 20),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
