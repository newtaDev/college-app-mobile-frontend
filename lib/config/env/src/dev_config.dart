import '../../../shared/global/constants.dart';
import '../env_config.dart';

class DevEnvConfig implements BaseEnvConfig {
  const DevEnvConfig();
  @override
  String get name => AppEnvironment.dev.value;

  @override
  String get baseUrl => 'https://minimal-shop-app.herokuapp.com/api/v1';

  @override
  String get storageHost => throw UnimplementedError();

  @override
  String get oAuthClintIdIos => kOauthClintidIos;

  @override
  String get oAuthClintIdWeb => kOauthClintidWeb;

  @override
  String toString() {
    return 'DEVELOPMENT';
  }
}
