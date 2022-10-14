import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:styles_lib/styles_lib.dart';
import 'package:widgets_lib/widgets_lib.dart';

import '../../../../cubits/selection/selection_cubit.dart';
import '../../../../cubits/user/user_cubit.dart';
import '../../../../data/models/data_class/class_time_table.dart';
import '../../../../domain/entities/attendance_entity.dart';
import '../../../router/routes.dart';

class ClassTimeTableViewCard extends StatelessWidget {
  final ClassTimeTable classTimeTable;
  final DateTime date;
  const ClassTimeTableViewCard({
    super.key,
    required this.classTimeTable,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final TimeOfDay _startTime = classTimeTable.endingTime!;
    final TimeOfDay endTime = classTimeTable.startingTime!;

    final double _doubleYourTime =
        _startTime.hour.toDouble() + (_startTime.minute.toDouble() / 60);
    final double _doubleNowTime =
        endTime.hour.toDouble() + (endTime.minute.toDouble() / 60);

    final double _timeDiff = _doubleYourTime - _doubleNowTime;

    final int _hr = _timeDiff.truncate();
    final int _minute = ((_timeDiff - _timeDiff.truncate()) * 60).toInt();
    final isStudent = context.read<UserCubit>().state.userDetails.isStudent;

    return BorderedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            classTimeTable.subjectId?.name ?? 'N/A',
            style: textTheme.titleLarge,
          ),
          Text(
            'Class: ${classTimeTable.classId?.name ?? 'N/A'} ',
            style: textTheme.bodySmall,
          ),
          Text(
            'Room no: ${classTimeTable.classId?.classNumber} ',
            style: textTheme.bodySmall,
          ),
          if (isStudent)
            Text(
              'By: ${classTimeTable.teacherId?.name}',
              style: textTheme.bodySmall,
            ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(
                Icons.access_time_rounded,
                size: 16,
              ),
              const SizedBox(width: 5),
              Text(
                'Ends at: ${classTimeTable.endingTime?.format(context)}',
                style: textTheme.bodySmall,
              )
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.timer_sharp,
                size: 16,
              ),
              const SizedBox(width: 5),
              Text(
                'Duration: ${_hr == 0 ? '' : '$_hr hours '}$_minute min',
                style: textTheme.bodySmall,
              )
            ],
          ),
          if (!isStudent) const SizedBox(height: 5),
          if (!isStudent)
            ElevatedButton(
              onPressed: () {
                context.read<SelectionCubit>()
                  ..setSelectedSubject(classTimeTable.subjectId!)
                  ..setSelectedAssignedSemester(
                    classTimeTable.subjectId!.semester!,
                  );
                context.pushNamed(
                  Routes.createAttendanceScreen.name,
                  params: RouteParams.withDashboard,
                  extra: AttendanceWithCount(
                    classStartTime: classTimeTable.startingTime,
                    classEndTime: classTimeTable.endingTime,
                    attendanceTakenOn: date,
                    subjectId: classTimeTable.subjectId?.id,
                    subject: classTimeTable.subjectId,
                    currentSem: classTimeTable.classId?.currentSem,
                    collegeId: classTimeTable.collegeId,
                    classId: classTimeTable.classId?.id,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                onPrimary: ColorPallet.primaryBlueDark,
                primary: ColorPallet.primaryBlueDark.withOpacity(0.1),
                elevation: 0,
                minimumSize: const Size.fromHeight(40),
                shadowColor: ColorPallet.primaryBlueDark.withOpacity(0.2),
              ),
              child: const Text(
                'Take Attendance',
              ),
            ),
        ],
      ),
    );
  }
}
