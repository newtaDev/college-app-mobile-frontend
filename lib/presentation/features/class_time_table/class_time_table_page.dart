import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:widgets_lib/widgets_lib.dart';

import '../../../cubits/user/user_cubit.dart';
import '../../../shared/helpers/helpers.dart';
import '../../../shared/global/enums.dart';
import 'class_time_table_layout.dart';
import 'cubit/class_time_table_cubit.dart';
import 'widgets/time_table_week_box.dart';

class ClassTimeTablePage extends StatefulWidget {
  const ClassTimeTablePage({super.key});

  @override
  State<ClassTimeTablePage> createState() => _ClassTimeTablePageState();
}

class _ClassTimeTablePageState extends State<ClassTimeTablePage> {
  late final PageController pageCtr;

  @override
  void initState() {
    final timeTableCubit = context.read<ClassTimeTableCubit>();

    pageCtr = PageController(
      initialPage: timeTableCubit.state.thisWeekDates
          .indexWhere((element) => element.day == DateTime.now().day),
    );
    final user = context.read<UserCubit>().state.userDetails;
    if (user.isStudent) {
      timeTableCubit.getClassTimeTableForStudent(user.asStudent!.classId);
    } else {
      timeTableCubit.getClassTimeTableForTeacher(user.asTeacher!.id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final timeTableCubit = context.read<ClassTimeTableCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class time table'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: FittedBox(
              child: Row(
                children: List.generate(
                  timeTableCubit.state.thisWeekDates.length,
                  (index) {
                    final _date = timeTableCubit.state.thisWeekDates[index];
                    return BlocSelector<ClassTimeTableCubit,
                        ClassTimeTableState, bool>(
                      selector: (state) {
                        return state.selectedDay == _date;
                      },
                      builder: (context, selectedDay) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TimeTableDateAndWeekBox(
                            day: _date.day.toString(),
                            week: Week.values[_date.weekday - 1].value,
                            isSelected: selectedDay,
                            onTap: () {
                              timeTableCubit.setSelectedDate(_date);
                              if (!pageCtr.hasClients) return;
                              pageCtr.animateToPage(
                                index,
                                duration: Helpers.minDuration,
                                curve: Curves.decelerate,
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<ClassTimeTableCubit, ClassTimeTableState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status.isInitial || state.status.isLoading) {
            return const LoadingIndicator();
          }
          if (state.status.isError) {
            return const Center(child: Text('Somting went wrong'));
          }
          return PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.thisWeekDates.length,
            controller: pageCtr,
            itemBuilder: (context, weekIndex) {
              final day = state.thisWeekDates[weekIndex];
              final ItemScrollController itemScrollController =
                  ItemScrollController();
              final ItemPositionsListener itemPositionsListener =
                  ItemPositionsListener.create();
              final timeTable =
                  context.read<ClassTimeTableCubit>().getDayTimeTable(
                        Week.values[day.weekday - 1],
                      );
              final sortedTimetableKeys = timeTable.keys.toList()
                ..sort(
                  (a, b) {
                    if (a.startTime.hour > b.startTime.hour) return 1;
                    if (a.startTime.hour == b.startTime.hour &&
                        a.startTime.minute > b.startTime.minute) return 1;
                    return -1;
                  },
                );
              final isToday = day.day == DateTime.now().day;

              final currentTimes = sortedTimetableKeys.where(
                (element) => element.startTime.hour == TimeOfDay.now().hour,
              );
              final currentTime = currentTimes.lastWhere(
                (element) => element.startTime.minute <= TimeOfDay.now().minute,
                orElse: () => currentTimes.last,
              );

              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                if (!isToday || !itemScrollController.isAttached) return;
                Future<void>.delayed(const Duration(milliseconds: 400))
                    .then((value) {
                  itemScrollController.scrollTo(
                    index: sortedTimetableKeys.indexWhere(
                      (element) => element.startTime == currentTime.startTime,
                    ),
                    duration: Helpers.maxDuration,
                    curve: Curves.decelerate,
                  );
                });
              });
              return ClassTimeTableDayLayout(
                sortedTimetableKeys: sortedTimetableKeys,
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
                currentTime: currentTime,
                isToday: isToday,
                timeTable: timeTable,
                day: day,
              );
            },
          );
        },
      ),
    );
  }
}
