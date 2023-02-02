import 'package:flutter/material.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_diviider.dart';

import '../theme/app_text_theme.dart';

class SettingsTitle extends StatelessWidget {
  final String title;

  const SettingsTitle({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 22),
        Text(
          title,
          style: AppTextTheme.poppins14Medium.copyWith(color: AppTheme.lightColor),
        ),
        const AppDivider(),
      ],
    );
  }
}
