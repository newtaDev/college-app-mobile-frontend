import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets/cards/src/selectable_side_bar_card.dart';

import '../../../../cubits/selection/selection_cubit.dart';

class SelectableClassesList extends StatelessWidget {
  const SelectableClassesList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SelectionCubit>();

    return ListView.builder(
      itemCount: cubit.state.classes.length,
      itemBuilder: (context, index) {
        final _class = cubit.state.classes[index];
        return BlocSelector<SelectionCubit, SelectionState,
            bool>(
          selector: (state) =>
              state.selectedClass != null &&
              state.selectedClass!.id == _class.id,
          builder: (context, isSelected) {
            return IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SelectableSideBarCard(
                  barColor: isSelected ? Colors.black : ColorsPallet.grey200,
                  bgColor: isSelected ? ColorsPallet.grey100 : null,
                  title: _class.name ?? 'N/A',
                  subtitles: [
                    'Class No: ${_class.classNumber}',
                    'Batch: ${_class.batch}',
                    'Total semesters: ${_class.course?.totalSem}',
                  ],
                  onTap: () => cubit.setSelectedClass(_class),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
