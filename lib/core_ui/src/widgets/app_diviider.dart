import 'package:flutter/material.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      width: double.infinity,
      color: AppTheme.lightColor,
    );
  }
}
