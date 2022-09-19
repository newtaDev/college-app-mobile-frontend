import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../router/routes.dart';
import '../widget/qr_overlay_shap.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  Barcode? result;
  late final MobileScannerController cameraController;

  @override
  void initState() {
    cameraController = MobileScannerController(
      formats: [BarcodeFormat.qrCode],
      torchEnabled: false,
    );

    super.initState();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 350.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Scan Qr code',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                if (state == null) {
                  return const Icon(Icons.flash_off, color: Colors.grey);
                }
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.blue);
                }
              },
            ),
            onPressed: cameraController.toggleTorch,
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (barcode, args) {
              if (barcode.rawValue == null) {
                debugPrint('Failed to scan Barcode');
              } else {
                final data = json.decode(barcode.rawValue!);
                final id = data['id'];
                final userType = data['userType'];
                final navigateTo = data['navigateTo'];
                if (id != null &&
                    userType != null &&
                    navigateTo == Routes.profileScreen.name) {
                  context
                    ..pop()
                    ..goNamed(
                      Routes.profileScreen.name,
                      params: {'profile_id': id, ...RouteParams.withDashboard},
                      queryParams: {'userType': userType},
                    );
                }
              }
            },
          ),
          DecoratedBox(
            decoration: ShapeDecoration(
              shape: QrScannerOverlayShape(
                borderColor: Colors.white,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 5,
                cutOutSize: scanArea,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
