import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';
import 'package:noty_mobile/features/verify_account/bloc/verify_account_bloc.dart';
import 'package:noty_mobile/features/verify_account/ui/verify_account_screen.dart';

class VerifyAccountPage extends PageWithScaffoldKey<bool?> {
  @override
  Route<bool?> createRoute(BuildContext context) => MaterialPageRoute<bool?>(
        builder: (BuildContext context) => BlocProvider<VerifyAccountBloc>(
          create: (BuildContext context) => VerifyAccountBloc(
            appRouter: appLocator<AppRouterDelegate>(),
            authRepository: appLocator<AuthRepository>(),
          ),
          child: ScaffoldMessenger(
            key: scaffoldKey,
            child: const VerifyAccountScreen(),
          ),
        ),
        settings: this,
      );
}
