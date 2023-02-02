import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/theme/app_icon_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_button.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_text_field.dart';
import 'package:noty_mobile/core_ui/src/widgets/unfocuser.dart';
import 'package:noty_mobile/features/auth/login%20/bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Unfocuser(
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: BlocBuilder<LoginBloc, LoginState>(
          builder: (BuildContext context, LoginState state) {
            if (state is ContentState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 63),
                      Center(child: AppIconsTheme.notyLogo),
                      const SizedBox(height: 16),
                      AppTextField(
                        infoText: AppLocalizations.of(context).value('E-mail'),
                        controller: emailController,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        infoText: AppLocalizations.of(context).value('Password'),
                        isObscure: true,
                        controller: passwordController,
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          context.read<LoginBloc>().add(ForgotPassword());
                        },
                        child: Text(
                          AppLocalizations.of(context).value('Forgot your password?'),
                          style: AppTextTheme.poppins14Medium.copyWith(
                            color: AppTheme.lightColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),
                      AppButton(
                        text: AppLocalizations.of(context).value('Log in'),
                        backgroundColor: AppTheme.buttonColor,
                        onPressed: () {
                          context.read<LoginBloc>().add(
                                LoginViaEmail(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                        },
                      ),
                      const SizedBox(height: 16),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: AppLocalizations.of(context)
                                  .value('Don\'t have an account? Go to Register'),
                              style: AppTextTheme.poppins13Medium.copyWith(
                                color: AppTheme.lightColor,
                              ),
                            ),
                            TextSpan(
                              text: AppLocalizations.of(context).value('registraty'),
                              style: AppTextTheme.poppins13Medium.copyWith(
                                color: AppTheme.lightColor,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.read<LoginBloc>().add(RouteToRegistration());
                                },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: AppTheme.lightColor,
                      ),
                      const SizedBox(height: 36),
                      AppButton(
                        text: AppLocalizations.of(context).value('Sign in with Google'),
                        image: AppIconsTheme.google.call(size: 24),
                        backgroundColor: AppTheme.buttonColor,
                        onPressed: () {
                          context.read<LoginBloc>().add(LoginViaGoogle());
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
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
}
