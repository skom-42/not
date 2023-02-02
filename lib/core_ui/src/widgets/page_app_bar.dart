import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';

class PageAppBar extends AppBar {
  final Color? color;

  PageAppBar({
    super.key,
    this.color,
    required String title,
    required void Function() onLeadingPressed,
    List<Widget>? actions,
    bool isNeedLeadingIcon = true,
  }) : super(
          titleSpacing: 0,
          leadingWidth: 30,
          leading: isNeedLeadingIcon
              ? IconButton(
                  icon: Icon(
                    CupertinoIcons.chevron_back,
                    color: color ?? const Color.fromRGBO(41, 120, 119, 1),
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  color: color ?? const Color.fromRGBO(41, 120, 119, 1),
                  onPressed: onLeadingPressed,
                )
              : const SizedBox.shrink(),
          centerTitle: false,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          title: Text(
            title,
            style: AppTextTheme.poppins17Medium.copyWith(
              color: color ?? AppTheme.buttonColor,
            ),
          ),
          actions: actions,
        );
}
