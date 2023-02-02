import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/data/repositories/chats_repository.dart';
import 'package:noty_mobile/features/dialog_screen/bloc/dialog_bloc.dart';
import 'package:noty_mobile/features/dialog_screen/ui/dialog_screen.dart';

class DialogPage extends PageWithScaffoldKey<dynamic> {
  final String plate;

  DialogPage({
    required this.plate,
  });

  @override
  Route<dynamic> createRoute(BuildContext context) => MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => BlocProvider<DialogBloc>(
          create: (BuildContext context) => DialogBloc(
            plate: plate,
            appRouter: appLocator<AppRouterDelegate>(),
            chatRepository: appLocator<ChatRepository>(),
          ),
          child: ScaffoldMessenger(
            key: scaffoldKey,
            child: const DialogScreen(),
          ),
        ),
        settings: this,
      );
}
