import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets/cards/src/selectable_side_bar_card.dart';

import '../../../../cubits/select_class_and_sem/select_class_and_sem_cubit.dart';

class SelectableClassesList extends StatelessWidget {
  const SelectableClassesList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SelectClassAndSemCubit>();

    return ListView.builder(
      itemCount: cubit.state.classes.length,
      itemBuilder: (context, index) {
        final _class = cubit.state.classes[index];
        return BlocSelector<SelectClassAndSemCubit, SelectClassAndSemState,
            bool>(
          selector: (state) =>
              state.selectedClass != null &&
              state.selectedClass!.id == _class.id,
          builder: (context, isSelected) {
            return IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SelectableSideBarCard(
                  barColor: isSelected ? Colors.black : ColorPallet.grey200,
                  bgColor: isSelected ? ColorPallet.grey100 : null,
                  title: _class.name ?? 'N/A',
                  subtitles: [
                    'Class No: ${_class.classNumber}',
                    'Batch: ${_class.batch}',
                    'Total semesters: ${_class.course?.totalSem}',
                  ],
                  onTap: () => cubit.setClass(_class),
                ),
              ),
            );
          },
        );
      },
    );
  }
}