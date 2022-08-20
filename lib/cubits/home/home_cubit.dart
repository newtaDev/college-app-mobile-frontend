import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../utils/utils.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
}
