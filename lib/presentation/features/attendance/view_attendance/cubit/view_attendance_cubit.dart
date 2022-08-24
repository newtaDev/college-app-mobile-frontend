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

  Future<void> getAllAttendance(AllAttendanceWithQueryReq req) async {
    emit(state.copyWith(status: ViewAttendanceStatus.loading));
    try {
      (await attendanceRepo.getAllAttendanceList(req)).fold(
        (res) {
          emit(
            state.copyWith(
              status: ViewAttendanceStatus.success,
              attendanceWithCount: res.responseData,
            ),
          );
        },
        (error) {
          emit(
            state.copyWith(
              status: ViewAttendanceStatus.error,
              error: error,
            ),
          );
        },
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Fetching attendance failed');
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