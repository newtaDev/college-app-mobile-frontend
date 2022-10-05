import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_lib/overlays/overlays.dart';
import 'package:widgets_lib/widgets/common/loading_indicator.dart';

import '../../../cubits/selection/selection_cubit.dart';
import '../../../data/models/data_class/subject_model.dart';
import '../../../shared/extensions/extentions.dart';

class SelectSubjectDialog extends StatefulWidget {
  final void Function(Subject subject) onSubjectSelected;
  final String courseId;
  const SelectSubjectDialog(
      {super.key, required this.onSubjectSelected, required this.courseId});

  @override
  State<SelectSubjectDialog> createState() => _SelectSubjectDialogState();
}

class _SelectSubjectDialogState extends State<SelectSubjectDialog> {
  @override
  void initState() {
    context
        .read<SelectionCubit>()
        .getSubjectWithDetailsOfCourse(widget.courseId);
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
              previous.courseSubjectSelectionStates.status !=
              current.courseSubjectSelectionStates.status,
          builder: (context, state) {
            if (state.courseSubjectSelectionStates.status.isInitial ||
                state.courseSubjectSelectionStates.status.isLoading) {
              return const LoadingIndicator();
            }
            if (state.courseSubjectSelectionStates.courseSubjects.isEmpty ||
                state.courseSubjectSelectionStates.status.isError) {
              return const Center(
                child: Text('Subjects not found'),
              );
            }
            return ShowSearchDialog<Subject>(
              searchList: state.courseSubjectSelectionStates.courseSubjects,
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
                        backgroundColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          subject.name?.getInitials(takeUpto: 2) ?? 'N/A',
                        ),
                      ),
                      title: Text(subject.name ?? 'N/A'),
                      subtitle: subject.course?.name == null
                          ? null
                          : Text('course: ${subject.course!.name!}'),
                      onTap: () {
                        widget.onSubjectSelected(subject);
                        Navigator.of(context).pop();
                      },
                    ),
                    const Divider(indent: 70)
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
