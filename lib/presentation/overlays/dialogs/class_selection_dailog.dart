import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_lib/overlays/overlays.dart';
import 'package:widgets_lib/widgets/common/loading_indicator.dart';

import '../../../cubits/selection/selection_cubit.dart';
import '../../../data/models/data_class/class_with_details.dart';
import '../../../shared/extensions/extentions.dart';

class AssignedClassSelectionDialog extends StatefulWidget {
  final void Function(ClassWithDetails classes) onClassSelected;
  const AssignedClassSelectionDialog(
      {super.key, required this.onClassSelected});

  @override
  State<AssignedClassSelectionDialog> createState() =>
      _AssignedClassSelectionDialogState();
}

class _AssignedClassSelectionDialogState
    extends State<AssignedClassSelectionDialog> {
  @override
  void initState() {
    context.read<SelectionCubit>().getAssignedClassesOfTeacherFromRemote();
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
              previous.assignedClassesSelectonStates.status !=
              current.assignedClassesSelectonStates.status,
          builder: (context, state) {
            if (state.assignedClassesSelectonStates.status.isInitial ||
                state.assignedClassesSelectonStates.status.isLoading) {
              return const LoadingIndicator();
            }
            if (state.assignedClassesSelectonStates.status.isError) {
              return const Center(child: Text('Classes not found'));
            }
            if (state.assignedClassesSelectonStates.assignedClassesOfTeacher
                .isEmpty) {
              return const Center(
                child: Text("You don't have access to any classes"),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: ShowSearchDialog<ClassWithDetails>(
                searchList: state
                    .assignedClassesSelectonStates.assignedClassesOfTeacher,
                searchCondition: (data, searchInput) {
                  return data.name!.toLowerCase().contains(
                        searchInput.toLowerCase(),
                      );
                },
                searchItemBuilder: (context, searchList, searchIndex) {
                  final classes = searchList[searchIndex];
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            classes.name?.getInitials(takeUpto: 2) ?? 'N/A',
                          ),
                        ),
                        title: Text(classes.name ?? 'N/A'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (classes.batch != null)
                              Text('batch: ${classes.batch}'),
                            if (classes.course?.name != null)
                              Text('course: ${classes.course!.name!}'),
                          ],
                        ),
                        onTap: () {
                          widget.onClassSelected(classes);
                          Navigator.of(context).pop();
                        },
                      ),
                      const Divider(indent: 70)
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
