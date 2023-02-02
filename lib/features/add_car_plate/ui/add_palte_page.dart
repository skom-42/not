import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';
import 'package:noty_mobile/features/add_car_plate/bloc/add_plate_bloc.dart';
import 'package:noty_mobile/features/add_car_plate/ui/add_plate_screen.dart';

class AddPlatePage extends PageWithScaffoldKey<String?> {
  @override
  Route<String?> createRoute(BuildContext context) => MaterialPageRoute<String?>(
        builder: (BuildContext context) => BlocProvider<AddPlateBloc>(
          create: (BuildContext context) => AddPlateBloc(
            context: context,
            appRouter: appLocator<AppRouterDelegate>(),
            authRepository: appLocator<AuthRepository>(),
          ),
          child: ScaffoldMessenger(
            key: scaffoldKey,
            child: AddPlateScreen(),
          ),
        ),
        settings: this,
      );
}
