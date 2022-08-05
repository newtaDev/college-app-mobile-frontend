import 'dart:developer';

import 'package:get_it/get_it.dart';

import 'dependencies/di.dart';
import 'env/env_config.dart';

/// can access this instance globally
final getIt = GetIt.instance;
final appConfig = AppConfig();
final appEnv = appConfig.appEnv;

class AppConfig {
  static final AppConfig _singleton = AppConfig._internal();
  factory AppConfig() {
    return _singleton;
  }
  AppConfig._internal();

  ///Application Environment
  late final BaseEnvConfig appEnv;

  /// [AppConfig] status
  late final String _configStatus;

  Future<void> config() async {
    appEnv = AppEnv.config(AppEnvironment.dev);
    try {
      /// All Configurations
      await _configDependencies();

      _configStatus = 'OK';
      log(toString());
    } catch (e) {
      _configStatus = 'ERROR';
      log(toString());
      rethrow;
    }
  }

  Future<void> _configDependencies() async {
    /// Configuring get_it dependencies
    registerGetItDependencies(this);
  }

  @override
  String toString() => 'AppConfig:\n -env: $appEnv\n -status: $_configStatus';
}

extension EnvHelpers on BaseEnvConfig {
  bool get isProduction => name == AppEnvironment.prod.value;
  bool get isDevelopment => name == AppEnvironment.dev.value;
  bool get isStaging => name == AppEnvironment.staging.value;
  bool get isTesting => name == AppEnvironment.test.value;
}
