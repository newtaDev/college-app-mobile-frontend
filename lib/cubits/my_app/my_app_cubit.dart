import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_app_state.dart';

class MyAppCubit extends Cubit<AppState> {
  MyAppCubit() : super(AppInitial()) {
    _splashInit();
  }

  Future<void> _splashInit() async {
    emit(SplashLoading());
    await Future<void>.delayed(const Duration(seconds: 3));
    emit(SplashLoadingDone());
  }
}
