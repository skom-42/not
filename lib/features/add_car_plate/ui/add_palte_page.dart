import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/features/add_car_plate/bloc/add_plate_bloc.dart';
import 'package:noty_mobile/features/add_car_plate/ui/add_plate_screen.dart';

class AddPlatePage extends PageWithScaffoldKey<dynamic> {
  @override
  Route<dynamic> createRoute(BuildContext context) => MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => BlocProvider<AddPlateBloc>(
          create: (BuildContext context) => AddPlateBloc(
            appRouter: appLocator<AppRouterDelegate>(),
          ),
          child: ScaffoldMessenger(
            key: scaffoldKey,
            child: AddPlateScreen(),
          ),
        ),
        settings: this,
      );
}
