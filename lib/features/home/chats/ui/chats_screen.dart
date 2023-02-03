import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_background_image.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_diviider.dart';
import 'package:noty_mobile/core_ui/src/widgets/chats_list_item.dart';
import 'package:noty_mobile/core_ui/src/widgets/page_app_bar.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';
import 'package:noty_mobile/data/repositories/chats_repository.dart';
import 'package:noty_mobile/features/home/chats/bloc/chats_bloc.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatsBloc>(
      create: (BuildContext context) {
        return ChatsBloc(
          appRouter: appLocator<AppRouterDelegate>(),
          chatRepository: appLocator<ChatRepository>(),
          authRepository: appLocator<AuthRepository>(),
        );
      },
      child: BlocBuilder<ChatsBloc, ChatsState>(
        builder: (BuildContext context, ChatsState state) {
          if (state is ContentState) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: PageAppBar(
                title: '',
                isNeedLeadingIcon: false,
                onLeadingPressed: () {},
                actions: [
                  IconButton(
                    onPressed: () {
                      context.read<ChatsBloc>().add(AddChat());
                    },
                    icon: const Icon(CupertinoIcons.plus),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context).value('Messaggi'),
                        style: AppTextTheme.poppins30SemiBold
                            .copyWith(color: AppTheme.lightColor),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return ChatsListItem(
                            name: state.chats[index].plate,
                            isUnread: !state.chats[index].readReceiptUsers
                                .contains(state.chats[index].user?.email),
                            onTap: () {
                              context.read<ChatsBloc>().add(
                                    OpenChat(
                                      chatModel: state.chats[index],
                                    ),
                                  );
                            },
                            onDelete: () {
                              context.read<ChatsBloc>().add(
                                    DeleteChat(
                                      state.chats[index],
                                    ),
                                  );
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const AppDivider();
                        },
                        itemCount: state.chats.length,
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state is LoadingState) {
            return AppBackgroundImage(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: PageAppBar(
                  title: '',
                  onLeadingPressed: () {},
                ),
                body: Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.lightColor,
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
