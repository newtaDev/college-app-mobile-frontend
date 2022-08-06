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
  String get oAuthClintIdWeb => throw UnimplementedError();

  @override
  String get oAuthClintIdIos => throw UnimplementedError();

  @override
  String toString() {
    return 'PRODUCTION';
  }
}
