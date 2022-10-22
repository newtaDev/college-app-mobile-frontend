import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:styles_lib/styles_lib.dart';
import 'package:widgets_lib/widgets_lib.dart';

import '../../../../data/models/data_class/subject_model.dart';
import '../../../../domain/entities/class_room_entity.dart';
import '../../../../shared/extensions/extentions.dart';
import '../../../router/routes.dart';
import '../cubit/class_room_cubit.dart';

class SubjectResourcesPageParams {
  final Subject subject;
  final Color genColor;

  SubjectResourcesPageParams({required this.subject, required this.genColor});
}

class SubjectResourcesPage extends StatefulWidget {
  final SubjectResourcesPageParams param;
  const SubjectResourcesPage({super.key, required this.param});

  @override
  State<SubjectResourcesPage> createState() => _SubjectResourcesPageState();
}

class _SubjectResourcesPageState extends State<SubjectResourcesPage> {
  @override
  void initState() {
    context
        .read<ClassRoomCubit>()
        .getAllSubjectResources(widget.param.subject.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.upload_outlined, color: Colors.white),
        onPressed: () {},
        label: Text(
          'Upload classes',
          style: textTheme.button
              ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: SubjectResourceHeader(
                subject: widget.param.subject,
                genColor: widget.param.genColor,
              ),
            ),
          ];
        },
        body: BlocBuilder<ClassRoomCubit, ClassRoomState>(
          builder: (context, state) {
            if (state.allSubjectResourcesStatus.isInitial ||
                state.allSubjectResourcesStatus.isLoading) {
              return const LoadingIndicator();
            }

            if (state.allSubjectResources.isEmpty ||
                state.allSubjectResourcesStatus.isError) {
              return const Center(child: Text('Attendances not found'));
            }
            return ListView.builder(
              itemCount: state.allSubjectResources.length,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SubjectResourceCard(
                  bgColor: widget.param.genColor,
                  subjectResource: state.allSubjectResources[index],
                  onTap: () => context.goNamed(
                    Routes.subjectResourceDetailsScreen.name,
                    extra: widget.param,
                    params: {
                      ...RouteParams.withDashboard,
                      'resourceId': state.allSubjectResources[index].id!
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SubjectResourceCard extends StatelessWidget {
  final SubjectResource subjectResource;
  final void Function()? onTap;
  const SubjectResourceCard({
    super.key,
    required this.bgColor,
    required this.subjectResource,
    this.onTap,
  });

  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: BorderedBox(
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: bgColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.description_rounded,
                        color: bgColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subjectResource.title ?? 'N/A',
                        style: textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subjectResource.description != null)
                        const SizedBox(height: 3),
                      if (subjectResource.description != null)
                        Text(
                          subjectResource.description!,
                          style: textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                )
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedText(
                  subjectResource.createdAt?.toDaysAgoWithLimit() ?? 'N/A',
                  style: textTheme.bodySmall,
                ),
                FittedText(
                  '${subjectResource.totalAttachments} Attachments',
                  style: textTheme.bodySmall,
                ),
                FittedText(
                  '${subjectResource.totalComments} Comments',
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectResourceHeader extends StatelessWidget {
  final Subject subject;
  final Color genColor;
  const SubjectResourceHeader({
    super.key,
    required this.subject,
    required this.genColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final bgHeight =
        (size.height * 0.2) < 100 ? (size.height * 0.4) : size.height * 0.2;
    return PhysicalModel(
      color: Theme.of(context).backgroundColor,
      shadowColor: Colors.black26,
      elevation: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: bgHeight,
                width: size.width,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: genColor.withOpacity(0.1)
                      // gradient: LinearGradient(
                      //   colors: [
                      //     ColorPallet.lightShadeColors[Random().nextInt(
                      //       ColorPallet.lightShadeColors.length,
                      //     )],
                      //     ColorPallet.lightShadeColors[Random().nextInt(
                      //       ColorPallet.lightShadeColors.length,
                      //     )],
                      //   ],
                      // ),
                      ),
                ),
              ),
              Positioned(
                bottom: -50,
                left: 20,
                child: Image.asset(
                  ImgAssets.booksEmojiIcon,
                  height: 80,
                  width: 80,
                ),
              ),
              Positioned(
                bottom: 10,
                right: 20,
                child: Text(
                  '- ${subject.assignedTo?.name}',
                  style: textTheme.titleSmall,
                ),
              ),
              Positioned(
                top: 0,
                child: SafeArea(
                  bottom: false,
                  child: SizedBox(
                    width: size.width,
                    child: Row(
                      children: [
                        const BackButton(),
                        const Spacer(),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.download_outlined),
                          label: Text(
                            'My downloads',
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 120, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subject.name ?? 'N/A', style: textTheme.titleLarge),
                RichText(
                  text: TextSpan(
                    style: textTheme.bodyMedium,
                    text: subject.classDetails?.name,
                    children: [
                      TextSpan(
                        style: textTheme.bodySmall,
                        text:
                            ' - ${subject.semester}${subject.semester?.getRankPosition} sem ',
                      ),
                    ],
                  ),
                )
                // Text('Class Name',style: textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
