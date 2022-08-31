import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../global/global_keys.dart';

class JwtServices {
  static JWT decodeQrJwt(String token) {
    return JWT.verify(
      token,
      SecretKey('pre_encoder_qr_token${GlobalKeys.jwtQrCode}'),
    );
  }
}
