import 'package:flutter/material.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/theme/app_icon_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_button.dart';

class ConditionStateWidget extends StatelessWidget {
  final Function onTap;

  const ConditionStateWidget({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 70),
        Image.asset(
          AppIconsTheme.shield,
          fit: BoxFit.fill,
          height: 192,
          width: 146,
        ),
        const SizedBox(height: 56),
        Text(
          AppLocalizations.of(context).value(
            'We do not save any data. All photos, chats or ID`s are used only for verification.',
          ),
          style: AppTextTheme.poppins17SemiBold.copyWith(
            color: AppTheme.lightColor,
          ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        AppButton(
          text: AppLocalizations.of(context).value('Continue'),
          backgroundColor: AppTheme.buttonColor,
          onPressed: () {
            onTap();
          },
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
