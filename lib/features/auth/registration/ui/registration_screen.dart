import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_icon_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_button.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_text_field.dart';
import 'package:noty_mobile/core_ui/src/widgets/page_app_bar.dart';
import 'package:noty_mobile/features/auth/registration/bloc/registration_bloc.dart';
import '../../../../core_ui/src/widgets/unfocuser.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
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
        body: BlocBuilder<RegistrationBloc, RegistrationState>(
          builder: (BuildContext context, RegistrationState state) {
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
                      text: AppLocalizations.of(context).value('Register'),
                      backgroundColor: AppTheme.buttonColor,
                      onPressed: () {
                        context.read<RegistrationBloc>().add(
                              RegisterUser(
                                name: nameController.text,
                                surname: surnameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                      },
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          context.read<RegistrationBloc>().add(
                                OpenWebView(),
                              );
                        },
                        child: Text(
                          'Registrand acconsenti alla nostra EULA',
                          style: AppTextTheme.poppins12Regular.copyWith(color: AppTheme.lightColor),
                        ),
                      ),
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
