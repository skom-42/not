import 'package:flutter/material.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';

class ModalAppBar extends StatelessWidget {
  final Color backgroundColor;
  final Widget leading;
  final String title;
  final Widget trailing;
  final void Function()? onLeadingPressed;
  final void Function()? onTrailingPressed;

  const ModalAppBar({
    required this.leading,
    required this.title,
    required this.trailing,
    this.backgroundColor = Colors.greenAccent,
    this.onLeadingPressed,
    this.onTrailingPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            child: leading,
            onTap: onLeadingPressed,
          ),
          Text(
            title,
            style: AppTextTheme.poppins17SemiBold.copyWith(
              color: Colors.red,
            ),
          ),
          GestureDetector(
            child: trailing,
            onTap: onTrailingPressed,
          ),
        ],
      ),
    );
  }
}
