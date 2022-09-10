import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../cubits/selection/selection_cubit.dart';
import '../../../shared/global/enums.dart';
import '../../router/route_names.dart';
import 'widgets/selectable_classes_list.dart';
import 'widgets/selectable_sem_list.dart';

class SelectableLayout extends StatelessWidget {
  const SelectableLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select a class', style: textTheme.titleLarge),
          const SizedBox(height: 20),
          const Expanded(child: SelectableClassesList()),
          BlocSelector<SelectionCubit, SelectionState, int>(
            selector: (state) => state.totalSem ?? 0,
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
                    Text(
                      'Select a semester',
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
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
                state.selectedClass != null && state.selectedSem != null,
            builder: (context, isTapabled) {
              return ElevatedButton(
                onPressed: !isTapabled
                    ? null
                    : () {
                        context.goNamed(
                          Routes.viewAttendanceScreen.name,
                          params: {
                            'tab_name': DashboardPageTabs.home.name,
                          },
                        );
                      },
                child: const Text('Continue'),
              );
            },
          ),
        ],
      ),
    );
  }
}
