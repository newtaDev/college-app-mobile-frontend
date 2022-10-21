import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/user/user_cubit.dart';
import '../../../../../data/models/data_class/subject_model.dart';
import '../../../../../domain/repository/class_room_repository.dart';
import '../../../../../shared/errors/api_errors.dart';

part 'class_room_state.dart';

class ClassRoomCubit extends Cubit<ClassRoomState> {
  final ClassRoomRepository classRoomRepo;
  final UserCubit userCubit;
  ClassRoomCubit({
    required this.classRoomRepo,
    required this.userCubit,
  }) : super(const ClassRoomState.init());

  Future<void> getMySubjectsForStudents() async {
    emit(state.copyWith(status: ClassRoomStatus.loading));
    try {
      final res = await classRoomRepo.getSubjectsOfClass(
        userCubit.state.userAsStudent!.classId,
      );
      emit(
        state.copyWith(
          status: ClassRoomStatus.success,
          mySubjects: res.responseData,
        ),
      );
    } on ApiErrorRes catch (apiError) {
      emit(
        state.copyWith(
          status: ClassRoomStatus.error,
          error: apiError,
        ),
      );
    } catch (e) {
      final apiErrorRes = ApiErrorRes(devMessage: 'Fetching Students failed');
      emit(
        state.copyWith(
          status: ClassRoomStatus.error,
          error: apiErrorRes,
        ),
      );
      rethrow;
    }
  }

  void setSubjectsForTeacher() {
    emit(
      state.copyWith(
        mySubjects: userCubit.state.userAsTeacher?.assignedSubjects,
        status: ClassRoomStatus.success,
      ),
    );
  }
}
