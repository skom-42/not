import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';
import 'package:noty_mobile/features/auth/registration/bloc/registration_bloc.dart';
import 'package:noty_mobile/features/auth/registration/ui/registration_screen.dart';

class RegistrationPage extends Page<void> {
  const RegistrationPage();

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute<void>(
      settings: this,
      builder: (BuildContext context) {
        return BlocProvider<RegistrationBloc>(
          create: (BuildContext context) => RegistrationBloc(
            appRouter: appLocator.get<AppRouterDelegate>(),
            authRepository: appLocator<AuthRepository>(),
          ),
          child: const RegistrationScreen(),
        );
      },
    );
  }
}
