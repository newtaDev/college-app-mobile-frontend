library app_dependencies;

import '../../cubits/auth/auth_cubit.dart';
import '../../cubits/home/home_cubit.dart';
import '../../cubits/my_app/my_app_cubit.dart';
import '../../cubits/select_class_and_sem/select_class_and_sem_cubit.dart';
import '../../data/data_source/local/auth_lds.dart';
import '../../data/data_source/remote/auth_rds.dart';
import '../../data/data_source/remote/common_rds.dart';
import '../../data/data_source/remote/reports_rds.dart';
import '../../data/data_source/remote/token_rds.dart';
import '../../data/repositories/auth_repo_impl.dart';
import '../../data/repositories/common_repo_impl.dart';
import '../../data/repositories/reports_impl.dart';
import '../../data/repositories/token_repo_impl.dart';
import '../../presentation/features/reports/attendance/cubit/attendance_report_cubit.dart';
import '../app_config.dart';

part 'src/attendance_di.dart';
part 'src/auth_di.dart';
part 'src/home_di.dart';
part 'src/common_di.dart';

/// Manual `GetIt` dependency injection
void registerGetItDependencies(AppConfig appConfig) {
  getIt.registerSingleton<AppConfig>(appConfig);

  registerAuthDependencies();
  registerHomeDependecies();
  registerReportsDependencies();
  registerCommonDependencies();
}
