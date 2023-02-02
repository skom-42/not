import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon {
  static const double _defaultIconSize = 24.0;
  static const BoxFit _defaultBoxFit = BoxFit.cover;

  final String iconKey;

  bool get isSVG => iconKey.contains('svg');

  AppIcon(
    this.iconKey,
  );

  SvgPicture svg({
    Color? color,
    double? size,
    BoxFit? fit,
  }) {
    assert(isSVG);

    return SvgPicture.asset(
      iconKey,
      color: color,
      height: size,
      width: size,
      fit: fit ?? BoxFit.contain,
    );
  }

  Widget call({
    Color? color,
    double size = _defaultIconSize,
    BoxFit fit = _defaultBoxFit,
  }) {
    if (isSVG) {
      return SvgPicture.asset(
        iconKey,
        color: color,
        height: size,
        width: size,
        fit: fit,
      );
    }

    return ImageIcon(
      AssetImage(
        iconKey,
      ),
      color: color,
      size: size,
    );
  }
}
