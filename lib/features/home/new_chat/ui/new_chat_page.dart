import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/data/repositories/chats_repository.dart';
import 'package:noty_mobile/features/home/new_chat/cubit/new_chat_cubit.dart';
import 'package:noty_mobile/features/home/new_chat/ui/new_chat_screen.dart';

class NewChatPage extends PageWithScaffoldKey<dynamic> {
  NewChatPage();

  @override
  Route<dynamic> createRoute(BuildContext context) => MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => BlocProvider<NewChatCubit>(
          create: (BuildContext context) => NewChatCubit(
            appRouter: appLocator<AppRouterDelegate>(),
            chatRepository: appLocator<ChatRepository>(),
          ),
          child: ScaffoldMessenger(
            key: scaffoldKey,
            child: NewChatsScreen(),
          ),
        ),
        settings: this,
      );
}
