import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/overlays/overlays.dart';
import 'package:widgets_lib/widgets/common/loading_indicator.dart';

import '../../../cubits/selection/selection_cubit.dart';
import '../../../data/models/data_class/subject_model.dart';
import '../../../domain/entities/attendance_entity.dart';
import '../../../shared/extensions/extentions.dart';
import '../../router/routes.dart';

class CreateOrViewAttendanceBottomSheet extends StatefulWidget {
  final String? title;
  const CreateOrViewAttendanceBottomSheet({
    super.key,
    this.title,
  });

  @override
  State<CreateOrViewAttendanceBottomSheet> createState() =>
      _CreateOrViewAttendanceBottomSheetState();
}

class _CreateOrViewAttendanceBottomSheetState
    extends State<CreateOrViewAttendanceBottomSheet> {
  @override
  void initState() {
    context.read<SelectionCubit>().getAndSetAssignedSubjectsOfTeacher();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: BlocBuilder<SelectionCubit, SelectionState>(
        buildWhen: (previous, current) =>
            previous.assignedSubjectSelectionStates.status !=
                current.assignedSubjectSelectionStates.status ||
            previous.assignedSubjectSelectionStates.selectedSubject !=
                current.assignedSubjectSelectionStates.selectedSubject,
        builder: (context, state) {
          if (state.assignedSubjectSelectionStates.status.isInitial ||
              state.assignedSubjectSelectionStates.status.isLoading) {
            return const LoadingIndicator();
          }
          if (state.assignedSubjectSelectionStates.subjects.isEmpty ||
              state.assignedSubjectSelectionStates.status.isError) {
            return const Center(
              child: Text('Subjects not found'),
            );
          }
          return Column(
            children: [
              if (widget.title != null)
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20),
                  child: Text(
                    widget.title!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              const SizedBox(height: 15),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ShowSearchDialog<Subject>(
                    searchList: state.assignedSubjectSelectionStates.subjects,
                    searchCondition: (data, searchInput) {
                      return data.name!.toLowerCase().contains(
                            searchInput.toLowerCase(),
                          );
                    },
                    searchItemBuilder: (context, searchList, searchIndex) {
                      final subject = searchList[searchIndex];
                      return Column(
                        children: [
                          ColoredBox(
                            color: subject.id ==
                                    state.assignedSubjectSelectionStates
                                        .selectedSubject?.id
                                ? ColorPallet.grey100
                                : Colors.transparent,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).primaryColorLight,
                                child: Text(
                                  subject.name?.getInitials(takeUpto: 2) ??
                                      'N/A',
                                ),
                              ),
                              title: Text(subject.name ?? 'N/A'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (subject.classDetails?.name != null)
                                    Text(subject.classDetails!.name!),
                                  if (subject.classDetails?.currentSem != null)
                                    Text(
                                      '${subject.classDetails!.currentSem!}${subject.classDetails!.currentSem!.getRankPosition} semester',
                                    ),
                                ],
                              ),
                              onTap: () {
                                context
                                    .read<SelectionCubit>()
                                    .setSelectedSubject(subject);
                              },
                            ),
                          ),
                          const Divider(indent: 70)
                        ],
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: state.assignedSubjectSelectionStates
                                    .selectedSubject ==
                                null
                            ? null
                            : () {
                                context.goNamed(
                                  Routes.viewAttendanceScreen.name,
                                  params: RouteParams.withDashboard,
                                );
                              },
                        child: const Text('View'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: state.assignedSubjectSelectionStates
                                    .selectedSubject ==
                                null
                            ? null
                            : () {
                                final selectedSubject = state
                                    .assignedSubjectSelectionStates
                                    .selectedSubject;
                                Navigator.of(context).pop();
                                context.pushNamed(
                                  Routes.createAttendanceScreen.name,
                                  params: RouteParams.withDashboard,
                                  extra: AttendanceWithCount(
                                    subjectId: selectedSubject?.id,
                                    subject: selectedSubject,
                                    currentSem: selectedSubject
                                        ?.classDetails?.currentSem,
                                    collegeId: selectedSubject?.collegeId,
                                    classId: selectedSubject?.classId,
                                  ),
                                );
                              },
                        child: const Text('Create'),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
