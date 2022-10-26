import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets/widgets.dart';

import '../../../../../cubits/user/user_cubit.dart';
import '../../../../../shared/global/enums.dart';
import '../../../../../shared/validators/form_validator.dart';
import '../../../../overlays/dialogs/multi_select_my_classes_dialog.dart';
import '../../../../router/routes.dart';
import '../../../../widgets/rounded_close_button.dart';
import '../../widgets/announcement_cards.dart';
import '../cubit/create_announcement_cubit.dart';

class CreateAnnouncementScreen extends StatefulWidget {
  const CreateAnnouncementScreen({super.key});

  @override
  State<CreateAnnouncementScreen> createState() =>
      _CreateAnnouncementScreenState();
}

class _CreateAnnouncementScreenState extends State<CreateAnnouncementScreen> {
  late final CreateAnnouncementCubit announcementCubit;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    announcementCubit = context.read<CreateAnnouncementCubit>();
    super.initState();
  }

  @override
  void dispose() {
    if (!announcementCubit.isClosed) announcementCubit.clearState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    final isImageWithTextLayout = announcementCubit.state.layoutType ==
        AnnouncementLayoutType.imageWithText;
    final isMultiImageLayout = announcementCubit.state.layoutType ==
        AnnouncementLayoutType.multiImageWithText;

    return Scaffold(
      appBar: AppBar(title: const Text('Create Announcement')),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<CreateAnnouncementCubit, CreateAnnouncementState>(
          listenWhen: (previous, current) =>
              current.status == CreateAnnouncementStatus.success,
          listener: (context, state) {
            showSnackBar('Announcement created successfully');
            context.goNamed(Routes.dashboardScreen.name);
          },
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            if (state.status.isLoading) {
              return const SizedBox(height: 40, child: LoadingIndicator());
            }
            return ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  switch (announcementCubit.validateCreateAnoucenmentReq()) {
                    case CreateAnnouncementValidationStatus.success:
                      announcementCubit.createAnouncemnt();
                      break;
                    case CreateAnnouncementValidationStatus
                        .issueInAnounceToClasses:
                      showSnackBar('Please choose announcement classes');
                      break;
                    case CreateAnnouncementValidationStatus.issueInMultiImage:
                      showSnackBar('Please upload announcement images');
                      break;
                    case CreateAnnouncementValidationStatus.issueInSingleImage:
                      showSnackBar('Announcement image is required');
                      break;
                  }
                }
              },
              child: const Text('Anounce'),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isImageWithTextLayout)
                  const SingleAnnouncementImagePicker(),
                if (isMultiImageLayout) const MultiAnnouncementImagePicker(),
                Text('Announcement Title', style: textTheme.titleMedium),
                const SizedBox(height: 10),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormValidator.requiredFieldValidator,
                  decoration: const InputDecoration(
                    hintText: 'Enter announcement title',
                  ),
                  onChanged: announcementCubit.setAnnouncementTitle,
                ),
                const SizedBox(height: 20),
                Text('Description', style: textTheme.titleMedium),
                const SizedBox(height: 10),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormValidator.requiredFieldValidator,
                  textInputAction: TextInputAction.newline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Enter announcement description...',
                  ),
                  onChanged: announcementCubit.setAnnouncementDescription,
                ),
                const SizedBox(height: 20),
                BlocBuilder<CreateAnnouncementCubit, CreateAnnouncementState>(
                  buildWhen: (previous, current) =>
                      previous.selectedClasses != current.selectedClasses,
                  builder: (_, state) {
                    return _multiSelectBoxWithTitle(
                      title: 'Anounce to',
                      onTap: () {
                        final assignedClasses = context
                                .read<UserCubit>()
                                .state
                                .userAsTeacher
                                ?.assignedClasses ??
                            [];
                        FocusManager.instance.primaryFocus?.unfocus();
                        showDialog<void>(
                          context: context,
                          builder: (_) {
                            return MutliSelectMyClassesDialog(
                              initialSelectedClasses: state.selectedClasses,
                              classes: assignedClasses,
                              onClassesSelected: (_, userSelectedClasses) {
                                announcementCubit
                                    .setSelectedClasses(userSelectedClasses);
                              },
                            );
                          },
                        );
                      },
                      multipleValues: List.generate(
                        state.selectedClasses.length,
                        (index) => Chip(
                          label: Text(
                            state.selectedClasses[index].name ?? 'N/A',
                          ),
                          backgroundColor: ColorPallet.grey200,
                          deleteIcon: const Icon(Icons.close, size: 18),
                          onDeleted: () {
                            announcementCubit.removeSelectedClass(
                              state.selectedClasses[index],
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(child: Divider(endIndent: 20)),
                    Text('Preview', style: textTheme.bodySmall),
                    const Expanded(child: Divider(indent: 20)),
                  ],
                ),
                const SizedBox(height: 20),
                const AnnouncementPreviews(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  Column _multiSelectBoxWithTitle({
    required String title,
    required List<Widget> multipleValues,
    void Function()? onTap,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: onTap,
          child: BorderedBox(
            height: multipleValues.isEmpty ? 56 : null,
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: multipleValues.isEmpty ? 10 : 5,
            ),
            child: multipleValues.isEmpty
                ? Text(
                    'Choose classes',
                    style: textTheme.bodyLarge
                        ?.copyWith(color: ColorPallet.grey700),
                    overflow: TextOverflow.ellipsis,
                  )
                : Wrap(spacing: 10, children: multipleValues),
          ),
        ),
      ],
    );
  }
}

class AnnouncementPreviews extends StatelessWidget {
  const AnnouncementPreviews({super.key});

  @override
  Widget build(BuildContext context) {
    final announcementCubit = context.read<CreateAnnouncementCubit>();
    const title = 'Announcement card title';
    const description =
        'This is the description of announcement card, you can create description of any length. Description can contain charecters, symbols, emojis etc.';
    final by = context.read<UserCubit>().state.userAsTeacher?.name ?? 'user';
    final dateTime = DateTime.now();
    switch (announcementCubit.state.layoutType) {
      case AnnouncementLayoutType.onlyText:
        return BlocBuilder<CreateAnnouncementCubit, CreateAnnouncementState>(
          buildWhen: (previous, current) =>
              previous.title != current.title ||
              previous.description != current.description,
          builder: (context, state) {
            return TextAnnouncementCard(
              title: state.title ?? title,
              description: state.description ?? description,
              by: by,
              createdOn: dateTime,
            );
          },
        );
      case AnnouncementLayoutType.imageWithText:
        return BlocBuilder<CreateAnnouncementCubit, CreateAnnouncementState>(
          buildWhen: (previous, current) =>
              previous.title != current.title ||
              previous.description != current.description ||
              previous.image != current.image,
          builder: (context, state) {
            return TextWithImageAnnouncementCard(
              title: state.title ?? title,
              description: state.description ?? description,
              by: by,
              createdOn: dateTime,
              imageFile: state.image,
              imageWidget: state.image == null
                  ? null
                  : Image.file(
                      state.image!,
                      fit: BoxFit.cover,
                    ),
            );
          },
        );
      case AnnouncementLayoutType.multiImageWithText:
        return BlocBuilder<CreateAnnouncementCubit, CreateAnnouncementState>(
          buildWhen: (previous, current) =>
              previous.title != current.title ||
              previous.description != current.description ||
              previous.multiImages != current.multiImages,
          builder: (context, state) {
            return MutiImageAnnouncementCard(
              title: state.title ?? title,
              description: state.description ?? description,
              by: by,
              createdOn: dateTime,
              imageFiles: state.multiImages,
              images: state.multiImages
                  .map((e) => Image.file(e, fit: BoxFit.cover))
                  .toList(),
            );
          },
        );
    }
  }
}

class SingleAnnouncementImagePicker extends StatelessWidget {
  const SingleAnnouncementImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final announcementCubit = context.read<CreateAnnouncementCubit>();
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Announcement Image', style: textTheme.titleMedium),
        Text('You can upload only 1 image', style: textTheme.bodySmall),
        const SizedBox(height: 10),
        Center(
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              announcementCubit.pickAndSetImage();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 100,
                width: 100,
                child: BlocBuilder<CreateAnnouncementCubit,
                    CreateAnnouncementState>(
                  buildWhen: (previous, current) =>
                      previous.image != current.image,
                  builder: (context, state) {
                    if (state.image != null) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.file(
                            state.image!,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: RoundedCloseButton(
                              onTap: announcementCubit.removeSingleImage,
                            ),
                          ),
                        ],
                      );
                    }
                    return const ColoredBox(
                      color: ColorPallet.grey100,
                      child: Icon(
                        Icons.add_a_photo_rounded,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class MultiAnnouncementImagePicker extends StatelessWidget {
  const MultiAnnouncementImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final announcementCubit = context.read<CreateAnnouncementCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Announcement Images', style: textTheme.titleMedium),
        Text('You can upload upto 5 images', style: textTheme.bodySmall),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 100,
            child:
                BlocBuilder<CreateAnnouncementCubit, CreateAnnouncementState>(
              buildWhen: (previous, current) =>
                  previous.multiImages != current.multiImages,
              builder: (context, state) {
                return CarouselSlider.builder(
                  itemCount: state.multiImages.length + 1,
                  itemBuilder: (context, index, realIndex) {
                    if (index > state.multiImages.length - 1) {
                      if (state.multiImages.length >= 5) {
                        return const SizedBox();
                      }
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            announcementCubit.pickAndSetMultiImage();
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: const SizedBox(
                              height: 100,
                              width: 100,
                              child: ColoredBox(
                                color: ColorPallet.grey100,
                                child: Icon(
                                  Icons.add_a_photo_rounded,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.file(
                                state.multiImages[index],
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: RoundedCloseButton(
                                  onTap: () =>
                                      announcementCubit.removeMultiImage(index),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {},
                    height: 140,
                    viewportFraction: 0.3,
                    // enlargeCenterPage: true,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
