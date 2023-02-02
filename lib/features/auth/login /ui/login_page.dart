import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';
import 'package:noty_mobile/features/auth/login%20/bloc/login_bloc.dart';
import 'package:noty_mobile/features/auth/login%20/ui/login_screen.dart';

class LoginPage extends PageWithScaffoldKey<dynamic> {
  @override
  Route<dynamic> createRoute(BuildContext context) => MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(
            appRouter: appLocator<AppRouterDelegate>(),
            authRepository: appLocator<AuthRepository>(),
          ),
          child: ScaffoldMessenger(
            key: scaffoldKey,
            child: const LoginScreen(),
          ),
        ),
        settings: this,
      );
}
