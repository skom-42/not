import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';
import 'package:noty_mobile/features/update_profile/bloc/update_profile_bloc.dart';
import 'package:noty_mobile/features/update_profile/ui/update_account_screen.dart';

class UpdateProfilePage extends PageWithScaffoldKey<dynamic> {
  @override
  Route<dynamic> createRoute(BuildContext context) => MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => BlocProvider<UpdateProfileBloc>(
          create: (BuildContext context) => UpdateProfileBloc(
            appRouter: appLocator<AppRouterDelegate>(),
            authRepository: appLocator<AuthRepository>(),
          ),
          child: ScaffoldMessenger(
            key: scaffoldKey,
            child: UpdateProfileScreen(),
          ),
        ),
        settings: this,
      );
}
