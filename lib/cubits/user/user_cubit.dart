import 'package:bloc/bloc.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repository/common_repository.dart';
import '../../shared/global/enums.dart';
import '../../utils/utils.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final CommonRepository commonRepo;
  UserCubit({required this.commonRepo}) : super(UserState.init());

  void setUserData(UserDetails userDetails) {
    emit(state.copyWith(userDetails: userDetails));
  }

  Future<void> setUpInitialUserData() async {
    try {
      final res = await commonRepo.getUserDetails();
      setUserData(res.responseData!);
    } catch (e) {
      rethrow;
    }
  }
}
