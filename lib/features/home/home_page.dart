import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';
import 'package:noty_mobile/features/home/bloc/home_bloc.dart';
import 'package:noty_mobile/features/home/home_screen.dart';

class DashboardFeature {
  static Page<dynamic> page() => DashboardPage();
}

class DashboardPage extends PageWithScaffoldKey<dynamic> {
  @override
  Route<dynamic> createRoute(BuildContext context) => MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => ScaffoldMessenger(
          key: scaffoldKey,
          child: BlocProvider<HomeBloc>(
            create: (BuildContext context) => HomeBloc(
              appRouter: appLocator<AppRouterDelegate>(),
              authRepository: appLocator<AuthRepository>(),
            ),
            child: const DashboardScreen(),
          ),
        ),
        settings: this,
      );
}
