import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets/common/double_circular_border.dart';

import '../../../../cubits/user/user_cubit.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../router/routes.dart';

class QrViewerPage extends StatelessWidget {
  final UserDetails user;
  const QrViewerPage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('Profile QR'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: DoubleCircularBorder(
                        size: size.width * 0.7 > 400 ? 400 : size.width * 0.7,
                        child:
                            // DecoratedBox(
                            //   decoration: BoxDecoration(
                            //     shape: BoxShape.circle,
                            //     image: DecorationImage(
                            //       image: MemoryImage(
                            //         base64Decode(
                            //           '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',
                            //         ),
                            //       ),
                            //       fit: BoxFit.contain,
                            //     ),
                            //   ),
                            // )
                            QrImage(
                          data: json.encode({
                            'id': user.id,
                            'userType': user.userType.value,
                            'navigateTo': Routes.profileScreen.name,
                          }),
                          padding: const EdgeInsets.all(25),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      user.name,
                      style: textTheme.titleLarge,
                    ),
                    Text(
                      'Reg No: 191962707',
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: OutlinedButton.icon(
              icon: const Icon(Icons.qr_code_scanner_sharp),
              onPressed: () {
                context.pushNamed(
                  Routes.qrScannerScreen.name,
                  params: RouteParams.withDashboard,
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: ColorsPallet.grey),
              ),
              label: const Text('Scan qr code'),
            ),
          ),
        ],
      ),
    );
  }
}
