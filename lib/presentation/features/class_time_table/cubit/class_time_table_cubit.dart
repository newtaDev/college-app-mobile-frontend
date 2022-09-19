import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/data_class/class_time_table.dart';
import '../../../../domain/repository/time_table_repo.dart';
import '../../../../shared/errors/api_errors.dart';
import '../../../../shared/global/enums.dart';
import '../../../../utils/utils.dart';

part 'class_time_table_state.dart';

class ClassTimeTableCubit extends Cubit<ClassTimeTableState> {
  final TimeTableRepository timeTableRepo;
  ClassTimeTableCubit({required this.timeTableRepo})
      : super(ClassTimeTableState.init()) {
    setUpOnWeek();
    setSelectedDate(
      state.thisWeekDates.firstWhere(
        (element) => element.day == DateTime.now().day,
      ),
    );
  }

  void setSelectedDate(DateTime date) {
    emit(state.copyWith(selectedDay: date));
  }

  void setUpOnWeek() {
    for (var i = 0; i < 4; i++) {
      state.thisWeekDates.add(DateTime.now().subtract(Duration(days: i)));
    }
    for (var i = 1; i < 4; i++) {
      state.thisWeekDates.add(DateTime.now().add(Duration(days: i)));
    }
    state.thisWeekDates.sort((a, b) {
      return a.compareTo(b);
    });
  }

  Map<TimeTableTimes, List<ClassTimeTable>> getDayTimeTable(Week week) {
    final Map<TimeTableTimes, List<ClassTimeTable>> _dayTimeTable = {};

    final _timeTableTimes = state.clasTimeTables
        .where((element) => element.week == week)
        .map(
          (e) => TimeTableTimes(startTime: e.startingTime!, timeTableId: e.id!),
        )
        .toList();

    for (final time in _timeTableTimes) {
      final _timeTable = state.clasTimeTables.firstWhere(
        (element) => element.id == time.timeTableId,
      );
      if (_dayTimeTable.containsKey(time)) {
        _dayTimeTable[time]?.add(_timeTable);
      } else {
        _dayTimeTable.putIfAbsent(time, () => [_timeTable]);
      }
    }
    for (int i = 0; i < 24; i++) {
      _dayTimeTable.putIfAbsent(
        TimeTableTimes(
          startTime: TimeOfDay(hour: i, minute: 00),
          timeTableId: '',
        ),
        () => [],
      );
    }

    return _dayTimeTable;
  }

  Future<void> getClassTimeTableForStudent(String classId) async {
    emit(state.copyWith(status: ClassTimeTableStatus.loading));
    try {
      final res = await timeTableRepo.getClassTimeTableForStudent(classId);
      emit(
        state.copyWith(
          status: ClassTimeTableStatus.success,
          clasTimeTables: res.responseData,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          status: ClassTimeTableStatus.error,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(
        devMessage: 'Fetching Student class time table failed',
      );
      emit(
        state.copyWith(
          status: ClassTimeTableStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  Future<void> getClassTimeTableForTeacher(String teacherId) async {
    emit(state.copyWith(status: ClassTimeTableStatus.loading));
    try {
      final res = await timeTableRepo.getClassTimeTableForTeacher(teacherId);
      emit(
        state.copyWith(
          status: ClassTimeTableStatus.success,
          clasTimeTables: res.responseData,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          status: ClassTimeTableStatus.error,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(
        devMessage: 'Fetching Teacher class time table failed',
      );
      emit(
        state.copyWith(
          status: ClassTimeTableStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }
}
