import 'src/dev_config.dart';
import 'src/prod_config.dart';
import 'src/staging_config.dart';
import 'src/test_config.dart';

enum AppEnvironment {
  dev('Dev'),
  prod('Prod'),
  staging('Staging'),
  test('Test');

  const AppEnvironment(this.value);
  final String value;
}

abstract class BaseEnvConfig {
  String get name;
  String get baseUrl;
  String get storageHost;
  String get oAuthClintIdWeb;
  String get oAuthClintIdIos;
}

class AppEnv {
  static BaseEnvConfig config(AppEnvironment env) {
    switch (env) {
      case AppEnvironment.dev:
        return const DevEnvConfig();
      case AppEnvironment.prod:
        return const ProdEnvConfig();
      case AppEnvironment.staging:
        return const StagingEnvConfig();
      case AppEnvironment.test:
        return const TestEnvConfig();
    }
  }
}
