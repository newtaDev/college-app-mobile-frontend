import '../../../shared/global/constants.dart';
import '../env_config.dart';

class ProdEnvConfig implements BaseEnvConfig {
  const ProdEnvConfig();
  @override
  String get name => AppEnvironment.prod.value;
  @override
  String get baseUrl => 'https://minimal-shop-app.herokuapp.com/api/v1';

  @override
  String get storageHost => throw UnimplementedError();

  @override
  String get oAuthClintIdWeb => kOauthClintidWeb;

  @override
  String get oAuthClintIdIos => kOauthClintidIos;

  @override
  String toString() {
    return 'PRODUCTION';
  }
}
