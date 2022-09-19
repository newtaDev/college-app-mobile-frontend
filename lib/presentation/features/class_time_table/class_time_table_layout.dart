

import 'package:college_app/presentation/features/class_time_table/widgets/class_time_table_view_card.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:widgets_lib/widgets/common/doted_lines.dart';

import '../../../data/models/data_class/class_time_table.dart';
import 'cubit/class_time_table_cubit.dart';

class ClassTimeTableDayLayout extends StatelessWidget {
  const ClassTimeTableDayLayout({
    super.key,
    required this.sortedTimetableKeys,
    required this.itemScrollController,
    required this.itemPositionsListener,
    required this.currentTime,
    required this.isToday,
    required Map<TimeTableTimes, List<ClassTimeTable>> timeTable,
    required this.day,
  }) : _timeTable = timeTable;

  final List<TimeTableTimes> sortedTimetableKeys;
  final ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener;
  final TimeTableTimes currentTime;
  final bool isToday;
  final DateTime day;
  final Map<TimeTableTimes, List<ClassTimeTable>> _timeTable;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ScrollablePositionedList.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      physics: const ClampingScrollPhysics(),
      itemCount: sortedTimetableKeys.length,
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
      itemBuilder: (context, index) {
        final times = sortedTimetableKeys.elementAt(index);
        final isCurrentTime =
            currentTime.startTime == times.startTime && isToday;

        return Padding(
          padding: EdgeInsets.only(
            top: index == 0 ? 30 : 0,
            bottom: index == sortedTimetableKeys.length - 1 ? 30 : 0,
            left: 20,
            right: 20,
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Text(
                      times.startTime.format(context),
                      style: isCurrentTime ? textTheme.titleSmall : null,
                    ),
                    if ((_timeTable[times]?.length ?? 0) == 0)
                      const SizedBox(
                        height: 10,
                      ),
                    if ((_timeTable[times]?.length ?? 0) > 0)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: CustomPaint(
                              size: const Size(1, 1),
                              painter:
                                  DottedLines(dashSpace: 5, color: Colors.grey),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          if (isCurrentTime)
                            const CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.black,
                            ),
                          Expanded(
                            child: Divider(
                              height: 1,
                              thickness: isCurrentTime ? 1 : 0.5,
                              color: isCurrentTime ? Colors.black : null,
                            ),
                          ),
                        ],
                      ),
                      ...List.generate(
                        _timeTable[times]?.length ?? 0,
                        (timeTableIndex) => Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 20,
                          ),
                          child: ClassTimeTableViewCard(
                            classTimeTable: _timeTable[times]![timeTableIndex],
                            date: day,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
