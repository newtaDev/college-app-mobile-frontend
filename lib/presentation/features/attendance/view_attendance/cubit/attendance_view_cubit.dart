import 'package:bloc/bloc.dart';
import '../../../../../domain/entities/attendance_entity.dart';
import '../../../../../domain/repository/attendance_repository.dart';
import '../../../../../shared/errors/api_errors.dart';
import '../../../../../utils/utils.dart';

part 'attendance_view_state.dart';

class AttendanceViewCubit extends Cubit<AttendanceViewState> {
  final AttendanceRepository attendanceRepo;
  AttendanceViewCubit({required this.attendanceRepo})
      : super(const AttendanceViewState.init());

  Future<void> getAllAttendance(AllAttendanceWithQueryReq req) async {
    emit(state.copyWith(status: AttendanceViewStatus.loading));
    try {
      (await attendanceRepo.getAllAttendanceList(req)).fold(
        (res) {
          emit(
            state.copyWith(
              status: AttendanceViewStatus.success,
              attendanceWithCount: res.responseData,
            ),
          );
        },
        (error) {
          emit(
            state.copyWith(
              status: AttendanceViewStatus.error,
              error: error,
            ),
          );
        },
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Fetching attendance failed');
      emit(
        state.copyWith(
          status: AttendanceViewStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }
}
