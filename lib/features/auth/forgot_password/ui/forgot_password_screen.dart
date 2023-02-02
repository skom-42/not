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
import 'package:noty_mobile/features/auth/forgot_password/bloc/forgot_password_bloc.dart';
import '../../../../core_ui/src/widgets/unfocuser.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String email = '';

  @override
  Widget build(BuildContext context) {
    return Unfocuser(
      child: Scaffold(
        appBar: PageAppBar(
          title: AppLocalizations.of(context).value('Back'),
          isNeedLeadingIcon: true,
          onLeadingPressed: () {
            appLocator<AppRouterDelegate>().pop();
          },
        ),
        backgroundColor: AppTheme.backgroundColor,
        body: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
          builder: (BuildContext context, ForgotPasswordState state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(child: AppIconsTheme.notyLogo),
                    const SizedBox(height: 16),
                    AppTextField(
                      infoText: AppLocalizations.of(context).value('E-mail'),
                      controller: emailController,
                    ),
                    const SizedBox(height: 64),
                    AppButton(
                      text: AppLocalizations.of(context).value('Reset password'),
                      backgroundColor: AppTheme.buttonColor,
                      onPressed: () {
                        context.read<ForgotPasswordBloc>().add(
                              ResetPassword(
                                email: emailController.text,
                              ),
                            );
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
