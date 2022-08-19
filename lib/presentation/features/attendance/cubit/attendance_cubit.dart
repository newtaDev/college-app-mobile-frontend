import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/attendance_entity.dart';
import '../../../../domain/repository/attendance_repository.dart';
import '../../../../shared/errors/api_errors.dart';
import '../../../../utils/utils.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final AttendanceRepository attendanceRepo;
  AttendanceCubit({
    required this.attendanceRepo,
  }) : super(AttendanceState.init());

  Future<void> getReportOfSubjectsAndStudents() async {
    emit(state.copyWith(subjectStatus: AttendanceStatus.loading));
    final subjectReq = SubjectReportReq(
      classId: '62fa477900a727733494dc4b',
      currentSem: '1',
    );
    try {
      (await attendanceRepo.getAttendancesReportOfSubjects(subjectReq)).fold(
        (subjectRes) {
          emit(
            state.copyWith(
              subjectStatus: AttendanceStatus.success,
              subjectReports: subjectRes.responseData,
              selectedSubjectId: (subjectRes.responseData?.isNotEmpty ?? false)
                  ? subjectRes.responseData?.first.subjectId
                  : null,
            ),
          );
        },
        (error) {
          emit(
            state.copyWith(
              subjectStatus: AttendanceStatus.failure,
              subjectReports: [],
              error: error,
            ),
          );
        },
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(
        message: 'Attendance report failed',
        devMessage: e.toString(),
      );
      emit(
        state.copyWith(
          subjectStatus: AttendanceStatus.failure,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  Future<void> getAbsentStudentsReportInEachSubject({String? subjectId}) async {
    try {
      final subjectReports = state.subjectReports;
      if (subjectReports.isEmpty && subjectId == null) return;
      if (subjectId == state.selectedSubjectId) return;
      emit(
        state.copyWith(
          studentStatus: AttendanceStatus.loading,
          selectedSubjectId: subjectId,
        ),
      );
      final studentReq = EachStudentReportReq(
        classId: '62fa477900a727733494dc4b',
        currentSem: '1',
        subjectId: state.selectedSubjectId!,
      );
      (await attendanceRepo.getAbsentStudentsReportInEachSubject(studentReq))
          .fold(
        (studentRes) {
          emit(
            state.copyWith(
              studentStatus: AttendanceStatus.success,
              studentReports: studentRes.responseData,
            ),
          );
        },
        (error) {
          emit(
            state.copyWith(
              studentStatus: AttendanceStatus.failure,
              studentReports: [],
              error: error,
            ),
          );
        },
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(
        message: 'Absent Student report failed',
        devMessage: e.toString(),
      );
      emit(
        state.copyWith(
          studentStatus: AttendanceStatus.failure,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }
}
