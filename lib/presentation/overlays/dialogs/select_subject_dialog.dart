import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_lib/overlays/overlays.dart';
import 'package:widgets_lib/widgets/common/loading_indicator.dart';

import '../../../cubits/selection/selection_cubit.dart';
import '../../../data/models/data_class/subject_model.dart';
import '../../../shared/extensions/extentions.dart';

class SelectSubjectDialog extends StatefulWidget {
  final void Function(Subject subject) onSubjectSelected;
  const SelectSubjectDialog({super.key, required this.onSubjectSelected});

  @override
  State<SelectSubjectDialog> createState() => _SelectSubjectDialogState();
}

class _SelectSubjectDialogState extends State<SelectSubjectDialog> {
  @override
  void initState() {
    final cubit = context.read<SelectionCubit>();
    final courseId = cubit.state.selectedClass?.course?.id;
    cubit.getSubjectWithDetailsOfCourse(courseId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      widthFactor: 0.9,
      child: BlocBuilder<SelectionCubit, SelectionState>(
        buildWhen: (previous, current) =>
            previous.subjectStatus != current.subjectStatus,
        builder: (context, state) {
          if (state.subjectStatus.isInitial || state.subjectStatus.isLoading) {
            return Material(
              borderRadius: BorderRadius.circular(12),
              child: const LoadingIndicator(),
            );
          }
          if (state.subjects.isEmpty || state.subjectStatus.isError) {
            return Material(
              borderRadius: BorderRadius.circular(12),
              child: const Center(
                child: Text('Subjects not found'),
              ),
            );
          }
          return ShowSearchDialog<Subject>(
            searchList: state.subjects,
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
                  const Divider(
                    height: 1,
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
