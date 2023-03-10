import 'dart:io';
import 'dart:typed_data';

import 'package:easyqrimage/easyqrimage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/theme/app_icon_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_button.dart';
import 'package:noty_mobile/core_ui/src/widgets/page_app_bar.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';
import 'package:noty_mobile/features/home/profile/bloc/profile_bloc.dart';
import 'package:noty_mobile/features/settings/ui/settings_page.dart';
import 'package:screenshot/screenshot.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 2 - 100;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PageAppBar(
        title: '',
        isNeedLeadingIcon: false,
        onLeadingPressed: () {},
        actions: [
          IconButton(
            onPressed: () {
              appLocator<AppRouterDelegate>().push(SettingsPage());
            },
            icon: const Icon(CupertinoIcons.settings),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocProvider<ProfileBloc>(
        create: (BuildContext context) {
          return ProfileBloc(
            appRouter: appLocator<AppRouterDelegate>(),
            authRepository: appLocator<AuthRepository>(),
          );
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (BuildContext context, ProfileState state) {
            if (state is ContentState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: state.plate != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context).value('Profile'),
                              style: AppTextTheme.poppins30SemiBold
                                  .copyWith(color: AppTheme.lightColor),
                            ),
                          ),
                          const Spacer(),
                          Stack(
                            children: [
                              Image.asset(
                                AppIconsTheme.badge,
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                bottom: 40,
                                left: width,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  child: EasyQRImage(
                                    data: state.plate!,
                                    size: 200,
                                    backgroundColor: AppTheme.lightColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          AppButton(
                            text: AppLocalizations.of(context).value('Share or print your QR'),
                            backgroundColor: AppTheme.buttonColor,
                            onPressed: () async {
                              final Image file = await getFile(state.plate!);
                              context.read<ProfileBloc>().add(
                                    PrintDocument(
                                      image: file,
                                    ),
                                  );
                            },
                          ),
                          const SizedBox(height: 120),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context).value('Profile'),
                              style: AppTextTheme.poppins30SemiBold
                                  .copyWith(color: AppTheme.lightColor),
                            ),
                          ),
                          const Spacer(),
                          AppIconsTheme.car,
                          const SizedBox(height: 24),
                          Text(
                            AppLocalizations.of(context).value('You don\'t have any car here yet.'),
                            style: AppTextTheme.poppins16Regular.copyWith(
                              color: AppTheme.lightColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                          AppButton(
                            text: AppLocalizations.of(context).value('Add your car'),
                            backgroundColor: AppTheme.buttonColor,
                            onPressed: () {
                              context.read<ProfileBloc>().add(
                                    RouteToAddCarPlate(),
                                  );
                            },
                          ),
                          const SizedBox(height: 120),
                        ],
                      ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Future<Image> getFile(String plate) async {
    final Uint8List image = await screenshotController.captureFromWidget(
      EasyQRImage(
        data: plate,
        size: 200,
        backgroundColor: AppTheme.lightColor,
      ),
    );

    return Image.memory(image);
  }
}
