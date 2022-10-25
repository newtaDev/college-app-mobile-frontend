import 'package:hive_flutter/hive_flutter.dart';

import '../../../domain/entities/auth_entitie.dart';
import '../../../shared/global/enums.dart';
import '../../../shared/global/hive_boxes.dart';
import '../../../shared/global/hive_keys.dart';
import '../../../utils/utils.dart';

// local db services
class AuthLocalDataSource {
  final box = Hive.box<dynamic>(HiveBoxes.auth.name);

  bool get isLogedIn => box.containsKey(HiveKeys.accessToken);

  String? get accessToken => box.get(HiveKeys.accessToken);
  String? get refreshToken => box.get(HiveKeys.refreshToken);
  String? get userId => box.get(HiveKeys.userId);
  String? get email => box.get(HiveKeys.email);
  String? get collegeId => box.get(HiveKeys.collegeId);
  UserType? get userType => UserType.fromName(box.get(HiveKeys.userType));

  bool get isAccessTokenExpired {
    if (accessToken == null) return true;
    return JwtDecoder.isExpired(accessToken!);
  }

  bool get isRefreshTokenExpired {
    if (refreshToken == null) return true;
    return JwtDecoder.isExpired(refreshToken!, checkIsSystemValid: false);
  }

  /// Save User data
  Future<void> saveAuthRes(AuthRes authRes) async {
    await Future.wait([
      setTokens(
        accessToken: authRes.accessToken,
        refreshToken: authRes.refreshToken,
      ),
      box.put(HiveKeys.userId, authRes.user?.id),
      box.put(HiveKeys.email, authRes.user?.email),
      box.put(HiveKeys.collegeId, authRes.user?.collegeId),
      box.put(HiveKeys.userType, authRes.user?.userType.value),
    ]);
  }

  Future<void> setTokens({
    required String? accessToken,
    required String? refreshToken,
  }) async {
    await box.put(HiveKeys.accessToken, accessToken);
    await box.put(HiveKeys.refreshToken, refreshToken);
  }

  Future<void> clear() async {
    await box.clear();
  }
}
