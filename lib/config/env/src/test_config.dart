import '../../../shared/global/constants.dart';
import '../env_config.dart';

class TestEnvConfig implements BaseEnvConfig {
  const TestEnvConfig();
  @override
  String get name => AppEnvironment.test.value;

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
    return 'TEST';
  }
}
