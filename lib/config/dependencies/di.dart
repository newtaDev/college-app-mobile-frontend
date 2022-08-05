library app_dependencies;

import '../../data/data_source/remote/auth_rds.dart';
import '../../data/repositories/auth_repo_impl.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/use_cases/auth_use_case.dart';
import '../../presentation/views/auth/sign_in/cubit/signin_cubit.dart';
import '../../presentation/views/auth/sign_up/cubit/signup_cubit.dart';
import '../app_config.dart';

part 'auth_di.dart';

/// Manual `GetIt` dependency injection
void registerGetItDependencies(AppConfig appConfig) {
  getIt.registerSingleton<AppConfig>(appConfig);
  registerAuthDependencies();
}
