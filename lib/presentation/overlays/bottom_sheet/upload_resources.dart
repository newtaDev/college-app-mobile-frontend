import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:mime/mime.dart';
import 'package:styles_lib/assets/assets.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets/widgets.dart';

import '../../../shared/extensions/extentions.dart';
import '../../../shared/helpers/file_helpers.dart';
import '../../../shared/validators/form_validator.dart';
import '../../features/pages/image_viewer_page.dart';
import '../../features/subject_resource/cubit/class_room_cubit.dart';
import '../../router/routes.dart';
import 'asset_file_type_picker_bottomsheet.dart';

class UploadSubjectResourcesBottomSheet extends StatefulWidget {
  final String subjectId;
  final void Function(FilePickerResult? pickedFiles) onFilesPicked;

  const UploadSubjectResourcesBottomSheet({
    super.key,
    required this.subjectId,
    required this.onFilesPicked,
  });

  @override
  State<UploadSubjectResourcesBottomSheet> createState() =>
      _UploadSubjectResourcesBottomSheetState();
}

class _UploadSubjectResourcesBottomSheetState
    extends State<UploadSubjectResourcesBottomSheet> {
  String? title;
  String? description;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    context.read<ClassRoomCubit>().resetUploadingResource();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            BlocBuilder<ClassRoomCubit, ClassRoomState>(
              buildWhen: (previous, current) =>
                  previous.uploadingResourcesStatus !=
                  current.uploadingResourcesStatus,
              builder: (context, state) {
                if (state.uploadingResourcesStatus.isUploading) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: Lottie.asset(LottieAssets.uploading),
                      ),
                      const Text('Uploading please wait')
                    ],
                  );
                }
                if (state.uploadingResourcesStatus.isUploaded) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      Lottie.asset(
                        LottieAssets.successCheck,
                        height: 120,
                        repeat: false,
                      ),
                      const SizedBox(height: 20),
                      const Text('Uploaded successfully'),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          context.read<ClassRoomCubit>().getAllSubjectResources(
                              subjectId: widget.subjectId);
                        },
                        child: const Text('continue'),
                      )
                    ],
                  );
                }
                if (state.uploadingResourcesStatus.isUploaded) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child:
                        Text(state.error?.message ?? 'Error while uploading'),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Resource title',
                              style: textTheme.titleMedium,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: FormValidator.requiredFieldValidator,
                              onChanged: (value) => title = value,
                              decoration: const InputDecoration(
                                hintText: 'Enter resource title',
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text('Description', style: textTheme.titleMedium),
                            const SizedBox(height: 10),
                            TextFormField(
                              onChanged: (value) => description = value,
                              decoration: const InputDecoration(
                                hintText: 'Enter a description',
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Divider(height: 1),
                            const SizedBox(height: 10),
                            BlocBuilder<ClassRoomCubit, ClassRoomState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.attach_file_rounded),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Add Attachments',
                                              style: textTheme.titleMedium,
                                            ),
                                            Text(
                                              'You can upload upto 5 attachments',
                                              style: textTheme.bodySmall,
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: state.uploadingAttachments
                                                      .length >=
                                                  5
                                              ? null
                                              : () {
                                                  showModalBottomSheet<void>(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    builder: (context) =>
                                                        AssetFileTypePicker(
                                                      onFilesPicked:
                                                          widget.onFilesPicked,
                                                    ),
                                                  );
                                                },
                                          icon: const Icon(Icons.add),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    const Divider(height: 1),
                                    const SizedBox(height: 20),
                                    ...List.generate(
                                      state.uploadingAttachments.length,
                                      (index) => UploadingAttachmentCard(
                                        attachment:
                                            state.uploadingAttachments[index],
                                        index: index,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context
                                      .read<ClassRoomCubit>()
                                      .uploadResources(
                                        title: title!,
                                        subjectId: widget.subjectId,
                                        description: description,
                                      );
                                }
                              },
                              child: const Text('Upload'),
                            ),

                            /// To increase height when keyboard is visible
                            SizedBox(
                              height: MediaQuery.of(context).viewInsets.bottom,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: const ColoredBox(
                color: ColorPallet.grey300,
                child: SizedBox(
                  height: 6,
                  width: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UploadingAttachmentCard extends StatelessWidget {
  final PlatformFile attachment;
  final int index;
  const UploadingAttachmentCard({
    super.key,
    required this.attachment,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final contentType = lookupMimeType(attachment.path!);
    final fileColor = FileHelpers.getColorFromContentType(contentType);
    final clasRoomCubit = context.read<ClassRoomCubit>();

    if (FileHelpers.imageContentTypes.contains(contentType)) {
      final imgFile = File(attachment.path!);
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
                        type: ImageViewerType.file,
                        heroTag: attachment.path!,
                        imageFile: imgFile,
                      ),
                    );
                  },
                  child: Hero(
                    tag: attachment.path!,
                    child: SizedBox(
                      height: 200,
                      width: double.maxFinite,
                      child: Image.file(imgFile, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          attachment.name,
                          style: textTheme.titleSmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Text(
                              attachment.size.convertBytesToReadableSize(),
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
                              attachment.name.split('.').last,
                              style: textTheme.bodySmall,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () => onDelete(context),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () async {
          final message =
              await clasRoomCubit.openFileFromPath(attachment.path!);
          if (message != null) BotToast.showText(text: message);
        },
        behavior: HitTestBehavior.opaque,
        child: BorderedBox(
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: fileColor.withOpacity(0.1),
                child: Icon(
                  FileHelpers.getIconFromContentType(contentType),
                  color: fileColor,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attachment.name,
                      style: textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          attachment.size.convertBytesToReadableSize(),
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
                          attachment.name.split('.').last,
                          style: textTheme.bodySmall,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () => onDelete(context),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onDelete(BuildContext context) {
    context.read<ClassRoomCubit>().removeUploadingAttachments(index);
  }
}
