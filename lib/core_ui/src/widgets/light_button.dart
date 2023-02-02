import 'package:flutter/material.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';

class LightButton extends StatelessWidget {
  final Function onToggleSwitch;
  final bool isLightOn;

  const LightButton({
    required this.onToggleSwitch,
    required this.isLightOn,
    Key? key,
  }) : super(key: key);

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
        onToggleSwitch();
      },
    );
  }
}
