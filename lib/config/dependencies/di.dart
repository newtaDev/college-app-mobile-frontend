library app_dependencies;

import '../../cubits/auth/auth_cubit.dart';
import '../../cubits/home/home_cubit.dart';
import '../../cubits/my_app/my_app_cubit.dart';
import '../../cubits/selection/selection_cubit.dart';
import '../../cubits/user/user_cubit.dart';
import '../../data/data_source/local/auth_lds.dart';
import '../../data/data_source/remote/attendance_rds.dart';
import '../../data/data_source/remote/auth_rds.dart';
import '../../data/data_source/remote/common_rds.dart';
import '../../data/data_source/remote/user_rds.dart';
import '../../data/data_source/remote/token_rds.dart';
import '../../data/repositories/attendance_repo_impl.dart';
import '../../data/repositories/auth_repo_impl.dart';
import '../../data/repositories/common_repo_impl.dart';
import '../../data/repositories/profile_repo_impl.dart';
import '../../data/repositories/token_repo_impl.dart';
import '../../domain/repository/profile_repository.dart';
import '../../presentation/features/attendance/create_attendance/cubit/create_attendance_cubit.dart';
import '../../presentation/features/attendance/view_attendance/cubit/view_attendance_cubit.dart';
import '../../presentation/features/profile/my_profile/edit/cubit/my_profile_edit_cubit.dart';
import '../../presentation/features/profile/my_profile/view/cubit/profile_view_cubit.dart';
import '../../presentation/features/reports/attendance/cubit/attendance_report_cubit.dart';
import '../app_config.dart';

part 'src/rds_di.dart';
part 'src/repo_di.dart';
part 'src/cubits_di.dart';

/// Manual `GetIt` dependency injection
void registerGetItDependencies(AppConfig appConfig) {
  getIt.registerSingleton<AppConfig>(appConfig);
  registerRemoteDataSourceDependencies();
  registerRepositoryDependencies();
  registerCubitsDependencies();
}
