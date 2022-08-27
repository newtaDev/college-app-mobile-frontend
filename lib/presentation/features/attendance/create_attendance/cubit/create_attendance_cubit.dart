import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/data_class/student_model.dart';
import '../../../../../data/models/data_class/subject_model.dart';
import '../../../../../domain/entities/attendance_entity.dart';
import '../../../../../domain/entities/user_entity.dart';
import '../../../../../domain/repository/attendance_repository.dart';
import '../../../../../shared/errors/api_errors.dart';
import '../../../../../utils/utils.dart';

part 'create_attendance_state.dart';

class CreateAttendanceCubit extends Cubit<CreateAttendanceState> {
  final AttendanceRepository attendanceRepo;

  CreateAttendanceCubit({required this.attendanceRepo})
      : super(CreateAttendanceState.init());

  Future<void> cretateAttendance(CreateAttendanceReq req) async {
    emit(state.copyWith(createStatus: CreateAttendanceStatus.loading));
    try {
      await attendanceRepo.createAttendance(req);
      emit(
        state.copyWith(
          createStatus: CreateAttendanceStatus.success,
          isCreated: true,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          createStatus: CreateAttendanceStatus.error,
          isCreated: false,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Creating attendance failed');
      emit(
        state.copyWith(
          createStatus: CreateAttendanceStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  Future<void> getAllStudentsInClass(String classId) async {
    emit(state.copyWith(studentsInClasStatus: StudentsInClasStatus.loading));
    try {
      final res = await attendanceRepo.getAllStudentInClass(classId);
      emit(
        state.copyWith(
          studentsInClasStatus: StudentsInClasStatus.success,
          studentsInClass: res.responseData,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          studentsInClasStatus: StudentsInClasStatus.error,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Fetching Students failed');
      emit(
        state.copyWith(
          studentsInClasStatus: StudentsInClasStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  bool addOrRemoveAbsentStudents(String studentId) {
    final List<String> updatedAbsentStudentIds =
        List.from(state.absentStudentIds);
    if (updatedAbsentStudentIds.contains(studentId)) {
      updatedAbsentStudentIds.removeWhere((id) => id == studentId);
      emit(state.copyWith(absentStudentIds: updatedAbsentStudentIds));
      return false;
    }
    updatedAbsentStudentIds.add(studentId);
    emit(state.copyWith(absentStudentIds: updatedAbsentStudentIds));
    return true;
  }

  void setInitialData(String classId, String collegeId, int currentSem) {
    emit(
      state.copyWith(
        classId: classId,
        collegeId: collegeId,
        currentSem: currentSem,
      ),
    );
  }

  void setClassStartTime(TimeOfDay? startTime) {
    emit(state.copyWith(classStartTime: startTime));
  }

  void setSelectedSubject(Subject? subject) {
    emit(state.copyWith(selectedSubject: subject));
  }

  void setClassEndTime(TimeOfDay? endTime) {
    emit(state.copyWith(classEndTime: endTime));
  }

  void setAttendanceTakenOn(DateTime? date) {
    emit(state.copyWith(attendanceTakenOn: date));
  }

  CreateValidationStatus isValidAttendanceReq() {
    if (state.selectedSubject == null) {
      return CreateValidationStatus.issueInSubjects;
    }
    if (state.classEndTime.hour < state.classStartTime.hour) {
      return CreateValidationStatus.issueInClassTimings;
    }
    if (state.classEndTime.hour == state.classStartTime.hour) {
      if (state.classStartTime.minute > state.classEndTime.minute) {
        return CreateValidationStatus.issueInClassTimings;
      }
    }
    return CreateValidationStatus.success;
  }
}
