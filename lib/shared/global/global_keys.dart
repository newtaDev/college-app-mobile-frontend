import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GlobalKeys {
//  Navigator key

//  Scaffold key
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
// Widget keys

// .env
  static String jwtQrCode =
      'pre_encoder_refresh_token${dotenv.env['JWT_QR_KEY']}';
}
