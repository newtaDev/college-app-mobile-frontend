import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_lib/overlays/overlays.dart';
import 'package:widgets_lib/widgets/common/loading_indicator.dart';

import '../../../cubits/selection/selection_cubit.dart';
import '../../../data/models/data_class/class_with_details.dart';
import '../../../shared/extensions/extentions.dart';

class AttendanceFilterDialog extends StatefulWidget {
  final void Function(ClassWithDetails classes) onClassSelected;
  const AttendanceFilterDialog({super.key, required this.onClassSelected});

  @override
  State<AttendanceFilterDialog> createState() => _AttendanceFilterDialogState();
}

class _AttendanceFilterDialogState extends State<AttendanceFilterDialog> {
  @override
  void initState() {
    context.read<SelectionCubit>().getAccessibleClassesOfTeacher();
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
              previous.accessibleClassesStates.status !=
              current.accessibleClassesStates.status,
          builder: (context, state) {
            if (state.accessibleClassesStates.status.isInitial ||
                state.accessibleClassesStates.status.isLoading) {
              return const LoadingIndicator();
            }
            if (state.accessibleClassesStates.status.isError) {
              return const Center(child: Text('Classes not found'));
            }
            if (state.accessibleClassesStates.classes
                .isEmpty) {
              return const Center(
                child: Text("You don't have access to any classes"),
              );
            }

            return ShowSearchDialog<ClassWithDetails>(
              searchList:
                  state.accessibleClassesStates.classes,
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
            );
          },
        ),
      ),
    );
  }
}
