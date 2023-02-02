import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';
import 'package:noty_mobile/features/auth/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:noty_mobile/features/auth/forgot_password/ui/forgot_password_screen.dart';

class ForgotPasswordPage extends Page<void> {
  const ForgotPasswordPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute<void>(
      settings: this,
      builder: (BuildContext context) {
        return BlocProvider<ForgotPasswordBloc>(
          create: (BuildContext context) => ForgotPasswordBloc(
            authRepository: appLocator<AuthRepository>(),
            appRouter: appLocator.get<AppRouterDelegate>(),
          ),
          child: const ForgotPasswordScreen(),
        );
      },
    );
  }
}
