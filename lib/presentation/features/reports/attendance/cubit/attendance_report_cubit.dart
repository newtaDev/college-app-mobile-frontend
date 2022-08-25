import 'package:bloc/bloc.dart';

import '../../../../../domain/entities/reports_entity.dart';
import '../../../../../domain/repository/attendance_repository.dart';
import '../../../../../shared/errors/api_errors.dart';
import '../../../../../utils/utils.dart';

part 'attendance_report_state.dart';

class AttendanceReportCubit extends Cubit<AttendanceReportState> {
  final AttendanceRepository attendanceRepo;
  AttendanceReportCubit({
    required this.attendanceRepo,
  }) : super(AttendanceReportState.init());

  Future<void> getReportOfSubjectsAndStudents() async {
    emit(state.copyWith(subjectStatus: AttendanceReportStatus.loading));
    final subjectReq = SubjectReportReq(
      classId: '62fa477900a727733494dc4b',
      currentSem: '1',
    );
    try {
      final subjectRes =
          await attendanceRepo.getAttendancesReportOfSubjects(subjectReq);

      emit(
        state.copyWith(
          subjectStatus: AttendanceReportStatus.success,
          subjectReports: subjectRes.responseData,
          selectedSubjectId: (subjectRes.responseData?.isNotEmpty ?? false)
              ? subjectRes.responseData?.first.subjectId
              : null,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          subjectStatus: AttendanceReportStatus.failure,
          subjectReports: [],
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(
        message: 'Attendance report failed',
        devMessage: e.toString(),
      );
      emit(
        state.copyWith(
          subjectStatus: AttendanceReportStatus.failure,
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
          studentStatus: AttendanceReportStatus.loading,
          selectedSubjectId: subjectId,
        ),
      );
      final studentReq = EachStudentReportReq(
        classId: '62fa477900a727733494dc4b',
        currentSem: '1',
        subjectId: state.selectedSubjectId!,
      );
      final studentRes =
          await attendanceRepo.getAbsentStudentsReportInEachSubject(studentReq);
      emit(
        state.copyWith(
          studentStatus: AttendanceReportStatus.success,
          studentReports: studentRes.responseData,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          studentStatus: AttendanceReportStatus.failure,
          studentReports: [],
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(
        message: 'Absent Student report failed',
        devMessage: e.toString(),
      );
      emit(
        state.copyWith(
          studentStatus: AttendanceReportStatus.failure,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }
}
