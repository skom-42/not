import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';
import 'package:noty_mobile/features/settings/bloc/settings_bloc.dart';
import 'package:noty_mobile/features/settings/ui/settings_screen.dart';

class SettingsPage extends PageWithScaffoldKey<dynamic> {
  @override
  Route<dynamic> createRoute(BuildContext context) => MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => BlocProvider<SettingsBloc>(
          create: (BuildContext context) => SettingsBloc(
            appRouter: appLocator.get<AppRouterDelegate>(),
            authRepository: appLocator<AuthRepository>(),
          ),
          child: const SettingsScreen(),
        ),
        settings: this,
      );
}
