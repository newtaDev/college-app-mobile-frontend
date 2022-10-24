import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../cubits/selection/selection_cubit.dart';
import '../../../../../data/models/data_class/subject_model.dart';
import '../../../../../domain/entities/attendance_entity.dart';
import '../../../../../domain/entities/user_entity.dart';
import '../../../../../domain/repository/attendance_repository.dart';
import '../../../../../shared/errors/api_errors.dart';
import '../../../../../utils/utils.dart';

part 'create_attendance_state.dart';

class CreateAttendanceCubit extends Cubit<CreateAttendanceState> {
  final AttendanceRepository attendanceRepo;
  final SelectionCubit selectionCubit;

  CreateAttendanceCubit({
    required this.attendanceRepo,
    required this.selectionCubit,
  }) : super(CreateAttendanceState.init());

  Future<void> cretateOrUpdateAttendance(bool isUpdate) async {
    emit(state.copyWith(createStatus: CreateAttendanceStatus.loading));
    try {
      if (isUpdate) {
        await attendanceRepo.updateAttendance(
          UpdateAttendanceReq(
            attendanceId: state.attendanceId,
            collegeId: state.collegeId,
            classId: state.classId,
            currentSem: state.currentSem,
            subjectId: state.selectedSubject!.id,
            classStartTime: state.classStartTime,
            classEndTime: state.classEndTime,
            absentStudents: state.absentStudentIds,
            attendanceTakenOn: state.attendanceTakenOn,
          ),
        );
      } else {
        await attendanceRepo.createAttendance(
          CreateAttendanceReq(
            collegeId: state.collegeId,
            classId: state.classId,
            currentSem: state.currentSem,
            subjectId: state.selectedSubject!.id!,
            classStartTime: state.classStartTime,
            classEndTime: state.classEndTime,
            absentStudents: state.absentStudentIds,
            attendanceTakenOn: state.attendanceTakenOn,
          ),
        );
      }
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

  void setUpdationInitialData(CreateAttendanceState updateState) {
    emit(updateState);
  }

  void setCreationInitialData() {
    final collegeId = selectionCubit
        .state.accessibleSubjectStates.selectedSubject!.collegeId!;
    final classId =
        selectionCubit.state.accessibleSubjectStates.selectedSubject!.classId!;
    final currentSem =
        selectionCubit.state.accessibleSubjectStates.selectedSubject!.semester!;
    emit(
      state.copyWith(
        classId: classId,
        collegeId: collegeId,
        currentSem: currentSem,
      ),
    );
    setSelectedSubject(
      selectionCubit.state.accessibleSubjectStates.selectedSubject,
    );
  }

  void onSubjectsChanged() {
    final collegeId = state.selectedSubject!.collegeId!;
    final classId = state.selectedSubject!.classId!;
    final currentSem = state.selectedSubject!.semester!;
    emit(
      state.copyWith(
        classId: classId,
        collegeId: collegeId,
        currentSem: currentSem,

        /// Clear absent studenta
        absentStudentIds: [],
      ),
    );
    // Invoke API only when classId of subjects changed
    if (state.classId !=
        selectionCubit.state.accessibleSubjectStates.selectedSubject!.classId) {
      getAllStudentsInClass(state.classId);
    }
    selectionCubit.setSelectedSubject(state.selectedSubject!);
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

  CreateAttendanceValidationStatus isValidAttendanceReq() {
    if (state.selectedSubject == null) {
      return CreateAttendanceValidationStatus.issueInSubjects;
    }
    if (state.classEndTime.hour < state.classStartTime.hour) {
      return CreateAttendanceValidationStatus.issueInClassTimings;
    }
    if (state.classEndTime.hour == state.classStartTime.hour) {
      if (state.classStartTime.minute > state.classEndTime.minute) {
        return CreateAttendanceValidationStatus.issueInClassTimings;
      }
    }
    return CreateAttendanceValidationStatus.success;
  }
}
