import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/theme/app_icon_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_background_image.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_button.dart';
import 'package:noty_mobile/core_ui/src/widgets/page_app_bar.dart';
import 'package:noty_mobile/features/image_selector/image_selector_screen.dart';
import 'package:noty_mobile/features/verify_account/bloc/verify_account_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class VerifyAccountScreen extends StatelessWidget {
  const VerifyAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<VerifyAccountBloc, VerifyAccountState>(
        builder: (BuildContext context, VerifyAccountState state) {
          if (state is ContentState) {
            return AppBackgroundImage(
              child: Scaffold(
                appBar: PageAppBar(
                  title: '',
                  onLeadingPressed: () {},
                ),
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).value('Add your car'),
                        style: AppTextTheme.poppins30SemiBold.copyWith(
                          color: AppTheme.lightColor,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Image.asset(
                        AppIconsTheme.check,
                        fit: BoxFit.fill,
                        height: 163,
                        width: 125,
                      ),
                      const SizedBox(height: 70),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: Text(
                          AppLocalizations.of(context).value(
                            'Take a picture of your technical paper',
                          ),
                          style: AppTextTheme.poppins17SemiBold.copyWith(
                            color: AppTheme.lightColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: StepProgressIndicator(
                          padding: 12,
                          size: 8,
                          totalSteps: 3,
                          currentStep: 2,
                          unselectedColor: AppTheme.unselectedCursorColor,
                          selectedColor: AppTheme.selectedCursorColor,
                          roundedEdges: const Radius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 32),
                      AppButton(
                        image: Icon(
                          CupertinoIcons.photo_camera,
                          color: AppTheme.lightColor,
                        ),
                        text: AppLocalizations.of(context).value('Take a photo'),
                        backgroundColor: AppTheme.buttonColor,
                        onPressed: () {
                          showModalBottomSheet(
                            context: context, isScrollControlled: false,backgroundColor: Colors.transparent,
                            builder: (BuildContext _) {
                              return ImageSelectorScreen(
                                onClose: (File? image) {
                                  context.read<VerifyAccountBloc>().add(VerifyAccount(image));
                                },
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 18),
                      GestureDetector(
                        onTap: () {
                          context.read<VerifyAccountBloc>().add(RouteBack());
                        },
                        child: Text(
                          AppLocalizations.of(context).value('Verify next time'),
                          style: AppTextTheme.poppins14Regular.copyWith(
                            color: AppTheme.lightColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
