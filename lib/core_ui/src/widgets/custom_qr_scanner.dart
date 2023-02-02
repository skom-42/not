import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';

class CustomQrScanner extends StatelessWidget {
  final double width;
  final Function(String) onScanDetected;

  const CustomQrScanner({
    required this.width,
    required this.onScanDetected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          height: width,
          width: width,
          child: MobileScanner(
            allowDuplicates: true,
            onDetect: (Barcode barcode, MobileScannerArguments? args) {
              onScanDetected(barcode.rawValue ?? '');
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: AppTheme.lightColor,
              width: 6,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                20,
              ),
            ),
          ),
          height: width,
          width: width,
        ),
      ],
    );
  }
}
