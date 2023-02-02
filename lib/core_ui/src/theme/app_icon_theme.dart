import 'package:flutter/material.dart';
import 'package:noty_mobile/core_ui/src/theme/app_icon.dart';

class AppIconsTheme {
  static const String _svgPath = 'assets/svg/';
  static const String _navigationPath = 'assets/navigation/';

  //Bottom Navigation Bar
  static const String _homePathKey = '${_navigationPath}home.png';
  static const String _searchPathKey = '${_navigationPath}search.png';
  static const String _profilePathKey = '${_navigationPath}profile.png';
  static const String _notyPathKey = '${_navigationPath}noty.png';
  static const String _chatsPathKey = '${_navigationPath}chats.png';
  static const String _carPath = '${_navigationPath}car.png';
  static const String _shieldPath = '${_navigationPath}shield.png';
  static const String _sovuhPath = '${_navigationPath}sovuh_chats.png';

  static const String _bgIcon = '${_navigationPath}background.png';
  static const String _bgChatIcon = '${_navigationPath}chat_bg.png';
  static const String _carPlatePath = '${_navigationPath}car_plate.png';

  //SignIn keys
  static const String _google = '${_svgPath}google.svg';
  static const String _geerPath = '${_svgPath}geer.svg';
  static const String _chatLogo = '${_svgPath}logo_chat.png';

  static Image get notyLogo => Image.asset(
        _notyPathKey,
        height: 50,
        width: 64,
      );

  //SignIn
  static AppIcon get google => AppIcon(_google);

  /// Bottom Navigation bar
  static AppIcon get geer => AppIcon(_geerPath);

  static AppIcon get dashboardHome => AppIcon(_homePathKey);

  static AppIcon get dashboardSearch => AppIcon(_searchPathKey);

  static AppIcon get dashboardProfile => AppIcon(_profilePathKey);

  static AppIcon get chats => AppIcon(_chatsPathKey);

  static Image get car => Image.asset(_carPath, height: 115, width: 260);

  static String get backgroundIcon => _bgIcon;

  static String get chatsBackground => _bgChatIcon;

  static String get shield => _shieldPath;
  static String get carPlate => _carPlatePath;
  static String get sovuh => _sovuhPath;
  static String get chatLogo => _chatLogo;
}
