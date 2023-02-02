import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';

class AppButtonBar extends StatelessWidget {
  final int selected;

  const AppButtonBar({
    super.key,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            child: Column(
              children: <Widget>[
                Icon(
                  CupertinoIcons.person_circle_fill,
                  size: 25,
                  color: selected == 0
                      ? AppTheme.whiteColor
                      : AppTheme.inactiveBottomBarColor,
                ),
                Text(
                  AppLocalizations.of(context).value('Profile'),
                  style: AppTextTheme.poppins12Medium.copyWith(
                      color: selected == 0
                          ? AppTheme.whiteColor
                          : AppTheme.inactiveBottomBarColor),
                ),
              ],
            ),
          ),
          InkWell(
            child: Column(
              children: <Widget>[
                Icon(
                  CupertinoIcons.chat_bubble,
                  size: 25,
                  color: selected == 1
                      ? AppTheme.whiteColor
                      : AppTheme.inactiveBottomBarColor,
                ),
                Text(
                  AppLocalizations.of(context).value('Chats'),
                  style: AppTextTheme.poppins12Medium.copyWith(
                      color: selected == 1
                          ? AppTheme.whiteColor
                          : AppTheme.inactiveBottomBarColor),
                ),
              ],
            ),
          ),
          InkWell(
            child: Column(
              children: <Widget>[
                Icon(
                  CupertinoIcons.qrcode_viewfinder,
                  size: 25,
                  color: selected == 2
                      ? AppTheme.whiteColor
                      : AppTheme.inactiveBottomBarColor,
                ),
                Text(
                  AppLocalizations.of(context).value('Scan'),
                  style: AppTextTheme.poppins12Medium.copyWith(
                      color: selected == 2
                          ? AppTheme.whiteColor
                          : AppTheme.inactiveBottomBarColor),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        // activeColor: Colors.white,
        // backgroundColor: Colors.transparent,
        // inactiveColor: AppTheme.inactiveBottomBarColor,
        ;
  }
}
