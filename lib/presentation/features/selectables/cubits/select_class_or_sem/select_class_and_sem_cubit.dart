import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../utils/utils.dart';

part 'select_class_and_sem_state.dart';

class SelectClassAndSemCubit extends Cubit<SelectClassAndSemState> {
  SelectClassAndSemCubit() : super(SelectClassAndSemInitial());
}
