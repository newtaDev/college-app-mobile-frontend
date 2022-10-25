import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/models/local/downloads.dart';
import '../shared/global/hive_boxes.dart';
import '../shared/global/hive_keys.dart';
import '../shared/helpers/network/device_ip.dart';
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
      await dotenv.load();
      await DeviceIp.getDeviceIpAddress();
      await _registerHive();

      /// register `isar` Schemas
      await _resisterIsarDbSchema();

      /// Configuring get_it dependencies
      registerGetItDependencies(this);

      _configStatus = 'OK';
      log(toString());
    } catch (e) {
      _configStatus = 'ERROR';
      log(toString());
      rethrow;
    }
  }

  Future<void> _resisterIsarDbSchema() async {
    try {
      // await Isar.open([DownloadsSchema]);
    } catch (e) {
      log('Error: isar schema registration');
      rethrow;
    }
  }

  Future<void> _registerHive() async {
    await Hive.initFlutter();
    _registerHiveAdapters();
    await Hive.openBox<dynamic>(HiveBoxes.auth.name);
    await Hive.openBox<Downloads>(HiveBoxes.downloads.name);
  }

  void _registerHiveAdapters() {
    Hive
      ..registerAdapter(DownloadsAdapter())
      ..registerAdapter(DownloadedFromAdapter());
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
