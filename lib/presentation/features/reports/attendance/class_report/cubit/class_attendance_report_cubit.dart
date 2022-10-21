import 'package:bloc/bloc.dart';

import '../../../../../../cubits/selection/selection_cubit.dart';
import '../../../../../../domain/entities/reports_entity.dart';
import '../../../../../../domain/repository/attendance_repository.dart';
import '../../../../../../shared/errors/api_errors.dart';
import '../../../../../../utils/utils.dart';

part 'class_attendance_report_state.dart';

class ClassAttendanceReportCubit extends Cubit<ClassAttendanceReportState> {
  final AttendanceRepository attendanceRepo;
  final SelectionCubit selectionCubit;
  ClassAttendanceReportCubit({
    required this.attendanceRepo,
    required this.selectionCubit,
  }) : super(ClassAttendanceReportState.init());

  Future<void> getReportOfSubjectsAndStudents() async {
    emit(state.copyWith(subjectStatus: ClassAttendanceReportStatus.loading));
    final subjectReq = SubjectReportReq(
      classId:
          selectionCubit.state.accessibleClassesStates.selectedClass!.id!,
      currentSem:
          selectionCubit.state.accessibleClassesStates.selectedSem!,
    );
    try {
      final subjectRes =
          await attendanceRepo.getAttendancesReportOfSubjects(subjectReq);

      emit(
        state.copyWith(
          subjectStatus: ClassAttendanceReportStatus.success,
          subjectReports: subjectRes.responseData,
          selectedSubjectId: (subjectRes.responseData?.isNotEmpty ?? false)
              ? subjectRes.responseData?.first.subjectId
              : null,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          subjectStatus: ClassAttendanceReportStatus.failure,
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
          subjectStatus: ClassAttendanceReportStatus.failure,
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
          studentStatus: ClassAttendanceReportStatus.loading,
          selectedSubjectId: subjectId,
        ),
      );
      final studentReq = EachStudentReportReq(
        classId: selectionCubit
            .state.accessibleClassesStates.selectedClass!.id!,
        currentSem:
            selectionCubit.state.accessibleClassesStates.selectedSem!,
        subjectId: state.selectedSubjectId!,
      );
      final studentRes =
          await attendanceRepo.getAbsentStudentsReportInEachSubject(studentReq);
      emit(
        state.copyWith(
          studentStatus: ClassAttendanceReportStatus.success,
          studentReports: studentRes.responseData,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          studentStatus: ClassAttendanceReportStatus.failure,
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
          studentStatus: ClassAttendanceReportStatus.failure,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }
}
