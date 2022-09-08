import 'package:flutter/foundation.dart';
import '../../../shared/helpers/network/device_ip.dart';
import '../env_config.dart';

class DevEnvConfig implements BaseEnvConfig {
  const DevEnvConfig();
  @override
  String get name => AppEnvironment.dev.value;

  @override
  String get baseUrl => kIsWeb
      ? 'http://localhost:1377/api/v1'
      : 'http://${DeviceIp.ipAddress}:1377/api/v1';

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
