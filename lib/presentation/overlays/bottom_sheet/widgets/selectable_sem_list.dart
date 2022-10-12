import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styles_lib/theme/themes.dart';

import '../../../../cubits/selection/selection_cubit.dart';

class SelectableSemList extends StatelessWidget {
  final int totalSem;
  const SelectableSemList({
    super.key,
    required this.totalSem,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SelectionCubit>();
    return ListView.builder(
      itemCount: totalSem,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: BlocSelector<SelectionCubit, SelectionState, bool>(
            selector: (state) =>
                state.assignedClassesSelectonStates.selectedSem != null &&
                state.assignedClassesSelectonStates.selectedSem == index + 1,
            builder: (context, isSelected) {
              return OutlinedButton.icon(
                icon: Icon(
                  isSelected
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_unchecked_rounded,
                  color: isSelected ? Colors.black : ColorPallet.grey400,
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromWidth(50),
                  side: BorderSide(
                    color: isSelected ? Colors.black : ColorPallet.grey400,
                  ),
                ),
                label: Text(
                  (index + 1).toString(),
                ),
                onPressed: () => cubit.setSelectedAssignedSemester(index + 1),
              );
            },
          ),
        );
      },
    );
  }
}
