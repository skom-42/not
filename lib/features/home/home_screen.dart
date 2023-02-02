import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_background_image.dart';
import 'package:noty_mobile/features/home/bloc/home_bloc.dart';
import 'package:noty_mobile/features/home/chats/ui/chats_screen.dart';
import 'package:noty_mobile/features/home/profile/ui/profile_screen.dart';
import 'package:noty_mobile/features/home/scan/ui/scan_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, HomeState state) {
          if (state is ContentState) {
            return CupertinoTabScaffold(
              tabBar: CupertinoTabBar(
                border: const Border.fromBorderSide(
                  BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: const Icon(
                      CupertinoIcons.person_circle_fill,
                      size: 25,
                    ),
                    label: AppLocalizations.of(context).value('Profile'),
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(
                      CupertinoIcons.chat_bubble,
                      size: 25,
                    ),
                    label: AppLocalizations.of(context).value('Chats'),
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(
                      CupertinoIcons.qrcode_viewfinder,
                      size: 25,
                    ),
                    label: AppLocalizations.of(context).value('Scan'),
                  ),
                ],
                activeColor: Colors.white,
                backgroundColor: Colors.transparent,
                inactiveColor: AppTheme.inactiveBottomBarColor,
              ),
              tabBuilder: (BuildContext context, int index) {
                switch (index) {
                  case 0:
                    return CupertinoTabView(
                      builder: (BuildContext context) {
                        return const CupertinoPageScaffold(
                          child: AppBackgroundImage(
                            child: ProfileScreen(),
                          ),
                        );
                      },
                    );
                  case 1:
                    return CupertinoTabView(
                      builder: (BuildContext context) {
                        return const CupertinoPageScaffold(
                          child: AppBackgroundImage(
                            child: ChatsScreen(),
                          ),
                        );
                      },
                    );
                  case 2:
                    return CupertinoTabView(
                      builder: (BuildContext context) {
                        return const CupertinoPageScaffold(
                          child: AppBackgroundImage(
                            child: ScanScreen(),
                          ),
                        );
                      },
                    );
                  default:
                    return const CupertinoTabView();
                }
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
