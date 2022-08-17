import 'dart:io';
import 'package:flutter/foundation.dart';
import '../env_config.dart';

class DevEnvConfig implements BaseEnvConfig {
  const DevEnvConfig();
  @override
  String get name => AppEnvironment.dev.value;

  @override
  String get baseUrl => kIsWeb
      ? 'http://localhost:1377/api/v1/'
      : Platform.isAndroid
          ? 'http://192.168.237.105:1377/api/v1/'
          : 'http://localhost:1377/api/v1/';

  @override
  String get storageHost => throw UnimplementedError();

  @override
  String get oAuthClintIdIos => throw UnimplementedError();

  @override
  String get oAuthClintIdWeb => throw UnimplementedError();

  @override
  String toString() {
    return 'DEVELOPMENT';
  }
}
