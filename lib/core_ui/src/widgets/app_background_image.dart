import 'package:flutter/material.dart';
import 'package:noty_mobile/core_ui/src/theme/app_icon_theme.dart';

class AppBackgroundImage extends StatelessWidget {
  final String? image;

  const AppBackgroundImage({
    this.image,
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            image ?? AppIconsTheme.backgroundIcon,
            fit: BoxFit.fill,
          ),
        ),
        child,
      ],
    );
  }
}
