import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_background_image.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_button.dart';
import 'package:noty_mobile/core_ui/src/widgets/unfocuser.dart';
import 'package:noty_mobile/features/home/new_chat/cubit/new_chat_cubit.dart';
import 'package:noty_mobile/features/home/new_chat/cubit/new_chat_state.dart';

class NewChatsScreen extends StatelessWidget {
  NewChatsScreen({Key? key}) : super(key: key);

  final TextEditingController plateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewChatCubit, NewChatState>(
      builder: (BuildContext context, NewChatState state) {
        return AppBackgroundImage(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              leading: CupertinoButton(
                padding: const EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      CupertinoIcons.back,
                      color: AppTheme.whiteColor,
                    ),
                    Text(
                      AppLocalizations.of(context).value('Messaggi'),
                      style: TextStyle(color: AppTheme.whiteColor),
                    ),
                  ],
                ),
                onPressed: () {
                  appLocator<AppRouterDelegate>().pop();
                },
              ),
              leadingWidth: 150,
              backgroundColor: Colors.transparent,
            ),
            body: Unfocuser(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Center(
                    child: Text(
                      AppLocalizations.of(context).value('Enter driver`s car plate number'),
                      style: AppTextTheme.poppins17SemiBold
                          .copyWith(color: AppTheme.whiteColor),
                    ),
                  ),
                  Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: CupertinoTextField(
                      style: AppTextTheme.poppins20Regular,
                      textAlignVertical: TextAlignVertical.center,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      controller: plateController,
                    ),
                  ),
                  const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: AppButton(
                        onPressed: () =>
                            context.read<NewChatCubit>().createChat(plateController.text),
                        text: AppLocalizations.of(context).value("Send message"),
                        backgroundColor: AppTheme.buttonColor),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
