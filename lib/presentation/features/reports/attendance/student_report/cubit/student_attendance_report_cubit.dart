import 'package:bloc/bloc.dart';

import '../../../../../../data/models/data_class/class_with_details.dart';
import '../../../../../../domain/entities/reports_entity.dart';
import '../../../../../../domain/repository/attendance_repository.dart';
import '../../../../../../shared/errors/api_errors.dart';
import '../../../../../../utils/utils.dart';

part 'student_attendance_report_state.dart';

class StudentAttendanceReportCubit extends Cubit<StudentAttendanceReportState> {
  final AttendanceRepository attendanceRepo;

  StudentAttendanceReportCubit({required this.attendanceRepo})
      : super(StudentAttendanceReportState.init());

  Future<void> getStudentSubjectReportReport(
    AbsentClassReportOfStudentReq req,
  ) async {
    emit(state.copyWith(status: StudentAttendanceReportStatus.loading));
    try {
      final res = await attendanceRepo.getAbsentClassReportOfStudent(req);
      emit(
        state.copyWith(
          status: StudentAttendanceReportStatus.success,
          report: res.reports,
          userClass: res.userClass,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          status: StudentAttendanceReportStatus.error,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(
        devMessage: 'Fetching student attendance report failed',
      );
      emit(
        state.copyWith(
          status: StudentAttendanceReportStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }
}
