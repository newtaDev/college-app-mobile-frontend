import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styles_lib/theme/themes.dart';

import '../../../../cubits/select_class_and_sem/select_class_and_sem_cubit.dart';

class SelectableSemList extends StatelessWidget {
  final int totalSem;
  const SelectableSemList({
    super.key,
    required this.totalSem,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SelectClassAndSemCubit>();
    return ListView.builder(
      itemCount: totalSem,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: BlocSelector<SelectClassAndSemCubit, SelectClassAndSemState,
              bool>(
            selector: (state) =>
                state.selectedSem != null && state.selectedSem == index + 1,
            builder: (context, isSelected) {
              return OutlinedButton.icon(
                icon: Icon(
                  isSelected
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_unchecked_rounded,
                  color: isSelected ? Colors.black : ColorPallet.grey400,
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: isSelected ? Colors.black : ColorPallet.grey400,
                  ),
                ),
                label: Text(
                  (index + 1).toString(),
                ),
                onPressed: () => cubit.selectSem(index + 1),
              );
            },
          ),
        );
      },
    );
  }
}
