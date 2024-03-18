import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_auth/extensions/string_extensions.dart';
import 'package:qr_auth/routes/app_router.routes.dart';
import 'package:velocity_x/velocity_x.dart';

import '../global/log/logger.dart';
import 'controllers/main_controller.dart';

class ScanScreen extends StatefulHookConsumerWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return MobileScanner(
          scanWindow: Rect.fromCenter(
            center: Offset(constraints.maxWidth / 2, constraints.maxHeight / 2),
            height: MediaQuery.of(context).size.width * 0.80,
            width: MediaQuery.of(context).size.width * 0.80,
          ),
          controller: MobileScannerController(),
          overlay: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox.square(
                dimension: MediaQuery.of(context).size.width * 0.40,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.white.withOpacity(0.7)),
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              "Scan the QR to share your sign-in data".text.makeCentered(),
            ],
          ),
          onDetect: (capture) async {
            final List<Barcode> barcodes = capture.barcodes;
            for (final barcode in barcodes) {
              final scannedRawData = barcode.rawValue;
              if (scannedRawData == null) {
                return;
              }
              try {
                final jsonData = json.decode(scannedRawData.decrypt()) as Map<String, dynamic>?;
                if (jsonData == null || jsonData.containsKey("id") == false) {
                  return;
                }
                ref.read(authorizeQrSessionProvider(uid: jsonData['id']));
                MainRoute().go(context);
              } catch (e) {
                logger.e(e);
              }
            }
          },
        );
      }),
    );
  }
}
