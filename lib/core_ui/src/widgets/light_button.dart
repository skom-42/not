import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';

class LightButton extends StatefulWidget {
  const LightButton({Key? key}) : super(key: key);

  @override
  State<LightButton> createState() => _LightButtonState();
}

bool isLightOn = false;

class _LightButtonState extends State<LightButton> {
  final MobileScannerController scannerController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: AppTheme.lightColor,
        shape: const CircleBorder(),
      ),
      child: isLightOn
          ? Icon(
              size: 60,
              Icons.flashlight_off_outlined,
              color: AppTheme.black,
            )
          : Icon(
              size: 60,
              Icons.flashlight_on_outlined,
              color: AppTheme.black,
            ),
      onPressed: () {
        setState(() {
          isLightOn = !isLightOn;
        });
        scannerController.toggleTorch();
      },
    );
  }
}
