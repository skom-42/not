import 'package:flutter/material.dart';
import 'package:noty_mobile/core_ui/src/theme/app_icon_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';

class ChatsListItem extends StatelessWidget {
  final String name;
  final Function onTap;

  const ChatsListItem({
    required this.name,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onTap();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              AppIconsTheme.sovuh,
              fit: BoxFit.fill,
              height: 42,
              width: 42,
            ),
            const SizedBox(width: 12),
            Text(
              name,
              style: AppTextTheme.poppins17SemiBold.copyWith(
                color: AppTheme.lightColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
