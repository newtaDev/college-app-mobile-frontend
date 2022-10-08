import 'dart:io';

import 'package:flutter/material.dart';

class DeviceIp {
  static String ipAddress = '192.168.17.105';

  static Future<String> getDeviceIpAddress() async {
    try {
      for (final interface in await NetworkInterface.list()) {
        ipAddress = interface.addresses
            .where(
              (element) =>
                  element.address.startsWith('10.0.') ||
                  element.address.startsWith('192.'),
            )
            .first
            .address;

        /// Them condition exectutes for android emulators
        if (ipAddress.startsWith('10.0.')) {
          ipAddress = '10.0.2.2';
        }
        debugPrint(ipAddress);
      }
    } catch (e) {
      ipAddress = ipAddress;
    }
    return ipAddress;
  }
}
