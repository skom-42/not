import 'package:flutter/cupertino.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_diviider.dart';

class SettingSubTile extends StatelessWidget {
  final String title;
  final Function onPressed;
  final IconData? leadingIcon;
  final bool? isNeedChevron;

  const SettingSubTile({
    required this.title,
    required this.onPressed,
    this.leadingIcon,
    this.isNeedChevron,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onPressed();
      },
      child: Column(
        children: [
          Row(
            children: <Widget>[
              leadingIcon != null
                  ? Icon(leadingIcon, color: AppTheme.lightColor, size: 17)
                  : const SizedBox(width: 17, height: 17),
              const SizedBox(width: 18),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  title,
                  style: AppTextTheme.poppins15Regular.copyWith(
                    color: AppTheme.lightColor,
                  ),
                ),
              ),
              if (isNeedChevron != null && isNeedChevron!) ...<Widget>{
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    CupertinoIcons.chevron_right,
                    color: AppTheme.lightColor,
                    size: 18,
                  ),
                ),
              }
            ],
          ),
          const AppDivider(),
        ],
      ),
    );
  }
}
