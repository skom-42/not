import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/theme/app_icon_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_button.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_text_field.dart';
import 'package:noty_mobile/core_ui/src/widgets/page_app_bar.dart';
import 'package:noty_mobile/core_ui/src/widgets/unfocuser.dart';
import 'package:noty_mobile/features/update_profile/bloc/update_profile_bloc.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Unfocuser(
      child: Scaffold(
        appBar: PageAppBar(
          color: AppTheme.lightColor,
          title: AppLocalizations.of(context).value('Settings'),
          isNeedLeadingIcon: true,
          onLeadingPressed: () {
            appLocator<AppRouterDelegate>().pop();
          },
        ),
        backgroundColor: AppTheme.backgroundColor,
        body: BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
          builder: (BuildContext context, UpdateProfileState state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(child: AppIconsTheme.notyLogo),
                    const SizedBox(height: 16),
                    AppTextField(
                      infoText: AppLocalizations.of(context).value('Name'),
                      controller: nameController,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      infoText: AppLocalizations.of(context).value('Surname'),
                      controller: surnameController,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      infoText: AppLocalizations.of(context).value('E-mail'),
                      controller: emailController,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      isEnabled: true,
                      isObscure: true,
                      infoText: AppLocalizations.of(context).value('Password'),
                      controller: passwordController,
                    ),
                    const SizedBox(height: 64),
                    AppButton(
                      text: AppLocalizations.of(context).value('Plate'),
                      backgroundColor: AppTheme.buttonColor,
                      onPressed: () {
                        context.read<UpdateProfileBloc>().add(UpdateProfile());
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
