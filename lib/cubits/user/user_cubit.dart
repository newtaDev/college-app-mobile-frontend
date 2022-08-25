import 'package:bloc/bloc.dart';

import '../../data/data_source/local/auth_lds.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/user_repository.dart';
import '../../shared/global/enums.dart';
import '../../utils/utils.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepo;
  UserCubit({required this.userRepo})
      : super(UserState.init());


  void setUserData(UserDetails userDetails) {
    emit(state.copyWith(userDetails: userDetails));
  }

  Future<void> setUpInitialUserData() async {
    try {
      final res = await userRepo.getUserDetails();
      setUserData(res.responseData!);
    } catch (e) {
      rethrow;
    }
  }
}
