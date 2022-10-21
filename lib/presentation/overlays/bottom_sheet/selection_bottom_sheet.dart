import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets/cards/src/bordered_box.dart';

import '../../../cubits/selection/selection_cubit.dart';
import '../dialogs/class_selection_dailog.dart';
import 'widgets/selectable_sem_list.dart';

class ClassAndSemSelectionBottomSheet extends StatelessWidget {
  final VoidCallback onContinue;
  const ClassAndSemSelectionBottomSheet({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final selectionCubit = context.read<SelectionCubit>();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Select class and Semester', style: textTheme.titleLarge),
          const SizedBox(height: 20),
          BlocBuilder<SelectionCubit, SelectionState>(
            buildWhen: (previous, current) =>
                previous.accessibleClassesStates.selectedClass !=
                current.accessibleClassesStates.selectedClass,
            builder: (context, state) {
              return _selectableBox(
                context: context,
                hintText: 'Select a class',
                value: state.accessibleClassesStates.selectedClass?.name,
                onTap: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) => AssignedClassSelectionDialog(
                      onClassSelected: selectionCubit.setSelectedAssignedClass,
                    ),
                  );
                },
              );
            },
          ),
          // const Expanded(child: SelectableClassesList()),
          BlocSelector<SelectionCubit, SelectionState, int>(
            selector: (state) =>
                state.accessibleClassesStates.totalSem ?? 0,
            builder: (context, totalSem) {
              return AnimatedCrossFade(
                crossFadeState: totalSem > 0
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
                firstChild: const SizedBox(height: 10, width: double.maxFinite),
                secondChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    if (totalSem == 0) const Text('No Semesters found'),
                    if (totalSem != 0)
                      SizedBox(
                        height: 35,
                        child: SelectableSemList(totalSem: totalSem),
                      ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          BlocSelector<SelectionCubit, SelectionState, bool>(
            selector: (state) =>
                state.accessibleClassesStates.selectedClass != null &&
                state.accessibleClassesStates.selectedSem != null,
            builder: (context, isTapabled) {
              return ElevatedButton(
                onPressed: !isTapabled ? null : onContinue,
                child: const Text('Continue'),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _selectableBox({
    required String hintText,
    required BuildContext context,
    String? value,
    void Function()? onTap,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: BorderedBox(
        height: 56,
        width: double.maxFinite,
        child: Text(
          value ?? hintText,
          style: value != null
              ? textTheme.bodyLarge
              : textTheme.bodyLarge?.copyWith(color: ColorPallet.grey700),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
