import '../../../shared/global/constants.dart';
import '../env_config.dart';

class StagingEnvConfig implements BaseEnvConfig {
  const StagingEnvConfig();
  @override
  String get name => AppEnvironment.staging.value;

  @override
  String get baseUrl => 'https://minimal-shop-app.herokuapp.com/api/v1';

  @override
  String get storageHost => throw UnimplementedError();

  @override
  String get oAuthClintIdIos => kOauthClintidIos;

  @override
  String toString() {
    return 'STAGING';
  }

  @override
  String get oAuthClintIdWeb => kOauthClintidWeb;
}
