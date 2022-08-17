import 'package:hive_flutter/hive_flutter.dart';

import '../../../domain/entities/auth_entitie.dart';
import '../../../shared/global/hive_keys.dart';

// local db services
class AuthLocalDataSource {
  final box = Hive.box<dynamic>(HiveKeys.authBox);

  /// Save User data
  Future<void> saveAuthRes(AuthRes authRes, SignInReq req) async {
    await Future.wait([
      box.put(HiveKeys.accessToken, authRes.accessToken),
      box.put(HiveKeys.refreshToken, authRes.refreshToken),
      box.put(HiveKeys.email, req.email),
      box.put(HiveKeys.password, req.password),
      box.put(HiveKeys.userType, req.userType.value),
    ]);
  }

  Future<void> clear() async {
    await box.clear();
  }
}
