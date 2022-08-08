library app_dependencies;

import '../../cubits/auth/auth_cubit.dart';
import '../../cubits/home/home_cubit.dart';
import '../../cubits/my_app/my_app_cubit.dart';
import '../../data/data_source/remote/auth_rds.dart';
import '../../data/repositories/auth_repo_impl.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/use_cases/auth_use_case.dart';
import '../../presentation/features/auth/sign_in/cubit/signin_cubit.dart';
import '../../presentation/features/auth/sign_up/cubit/signup_cubit.dart';
import '../app_config.dart';

part 'src/auth_di.dart';
part 'src/home_di.dart';

/// Manual `GetIt` dependency injection
void registerGetItDependencies(AppConfig appConfig) {
  getIt
    ..registerSingleton<AppConfig>(appConfig)
    ..registerFactory<MyAppCubit>(MyAppCubit.new);
  registerAuthDependencies();
  registerHomeDependecies();
}
