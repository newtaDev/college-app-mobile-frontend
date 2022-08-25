import 'package:bloc/bloc.dart';

import '../../../../../domain/entities/attendance_entity.dart';
import '../../../../../domain/repository/attendance_repository.dart';
import '../../../../../shared/errors/api_errors.dart';
import '../../../../../utils/utils.dart';

part 'create_attendance_state.dart';

class CreateAttendanceCubit extends Cubit<CreateAttendanceState> {
  final AttendanceRepository attendanceRepo;

  CreateAttendanceCubit({required this.attendanceRepo})
      : super(const CreateAttendanceState.init());

  Future<void> cretateAttendance(CreateAttendanceReq req) async {
    emit(state.copyWith(status: CreateAttendanceStatus.loading));
    try {
      await attendanceRepo.createAttendance(req);
      emit(
        state.copyWith(status: CreateAttendanceStatus.success, isCreated: true),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          status: CreateAttendanceStatus.error,
          isCreated: false,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Creating attendance failed');
      emit(
        state.copyWith(
          status: CreateAttendanceStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }
}
