import 'package:bloc/bloc.dart';
import '../../../../../domain/entities/attendance_entity.dart';
import '../../../../../domain/repository/attendance_repository.dart';
import '../../../../../shared/errors/api_errors.dart';
import '../../../../../utils/utils.dart';

part 'view_attendance_state.dart';

class ViewAttendanceCubit extends Cubit<ViewAttendanceState> {
  final AttendanceRepository attendanceRepo;
  ViewAttendanceCubit({required this.attendanceRepo})
      : super(const ViewAttendanceState.init());

  Future<void> getSubjectAttendances(SubjectAttendanceWithQueryReq req) async {
    emit(state.copyWith(status: ViewAttendanceStatus.loading));
    try {
      final res = await attendanceRepo.getSubjectAttendanceList(req);
      emit(
        state.copyWith(
          status: ViewAttendanceStatus.success,
          attendanceWithCount: res.responseData,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          status: ViewAttendanceStatus.error,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes =
          ApiErrorRes(devMessage: 'Fetching subject attendance failed');
      emit(
        state.copyWith(
          status: ViewAttendanceStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  Future<void> getClassAttendances(ClassAttendanceWithQueryReq req) async {
    emit(state.copyWith(status: ViewAttendanceStatus.loading));
    try {
      final res = await attendanceRepo.getClassAttendanceList(req);
      emit(
        state.copyWith(
          status: ViewAttendanceStatus.success,
          attendanceWithCount: res.responseData,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          status: ViewAttendanceStatus.error,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes =
          ApiErrorRes(devMessage: 'Fetching class attendance failed');
      emit(
        state.copyWith(
          status: ViewAttendanceStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }
}
