import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_lib/overlays/overlays.dart';
import 'package:widgets_lib/widgets/common/loading_indicator.dart';

import '../../../cubits/selection/selection_cubit.dart';
import '../../../cubits/user/user_cubit.dart';
import '../../../data/models/data_class/subject_model.dart';
import '../../../shared/extensions/extentions.dart';

class SelectSubjectDialog extends StatefulWidget {
  final void Function(Subject subject) onSubjectSelected;
  final String? title;
  const SelectSubjectDialog({
    super.key,
    required this.onSubjectSelected,
    this.title,
  });

  @override
  State<SelectSubjectDialog> createState() => _SelectSubjectDialogState();
}

class _SelectSubjectDialogState extends State<SelectSubjectDialog> {
  @override
  void initState() {
    if (context.read<UserCubit>().state.isStudent) {
      context.read<SelectionCubit>().getAccessibleSubjectsOfStudents();
    }
    if (context.read<UserCubit>().state.isTeacher) {
      context.read<SelectionCubit>().getAccessibleSubjectsOfTeacher();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      widthFactor: 0.9,
      child: Material(
        borderRadius: BorderRadius.circular(12),
        child: BlocBuilder<SelectionCubit, SelectionState>(
          buildWhen: (previous, current) =>
              previous.accessibleSubjectStates.status !=
              current.accessibleSubjectStates.status,
          builder: (context, state) {
            if (state.accessibleSubjectStates.status.isInitial ||
                state.accessibleSubjectStates.status.isLoading) {
              return const LoadingIndicator();
            }
            if (state.accessibleSubjectStates.subjects.isEmpty ||
                state.accessibleSubjectStates.status.isError) {
              return const Center(
                child: Text('Subjects not found'),
              );
            }
            return Column(
              children: [
                if (widget.title != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      widget.title!,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 20,
                    ),
                    child: ShowSearchDialog<Subject>(
                      searchList: state.accessibleSubjectStates.subjects,
                      searchCondition: (data, searchInput) {
                        return data.name!.toLowerCase().contains(
                              searchInput.toLowerCase(),
                            );
                      },
                      searchItemBuilder: (context, searchList, searchIndex) {
                        final subject = searchList[searchIndex];
                        return Column(
                          children: [
                            ListTile(
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
                                      '${subject.semester!}${subject.semester!.getRankPosition} semester',
                                    ),
                                ],
                              ),
                              onTap: () => widget.onSubjectSelected(subject),
                            ),
                            const Divider(indent: 70)
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
