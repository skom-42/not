import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/theme/app_icon_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_background_image.dart';
import 'package:noty_mobile/core_ui/src/widgets/unfocuser.dart';
import 'package:noty_mobile/features/dialog_screen/bloc/dialog_bloc.dart';
import 'package:noty_mobile/features/dialog_screen/ui/widgets/message_widget.dart';

class DialogScreen extends StatefulWidget {
  DialogScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogScreen> createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {
  final TextEditingController messageController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Unfocuser(
        child: AppBackgroundImage(
          image: AppIconsTheme.chatsBackground,
          child: BlocConsumer<DialogBloc, DialogState>(
            listener: (BuildContext context, DialogState state) {
              if (state.isScrollNeeded) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  scrollController.animateTo(0,
                      duration: const Duration(microseconds: 400),
                      curve: Curves.elasticInOut);
                });
                context.read<DialogBloc>().add(NormalEvent());
              }
            },
            builder: (BuildContext context, DialogState state) {
              if (!state.isLoading) {
                return CupertinoPageScaffold(
                  backgroundColor: Colors.transparent,
                  navigationBar: CupertinoNavigationBar(
                    leading: CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.back,
                            color: AppTheme.buttonColor,
                          ),
                          Text(
                            AppLocalizations.of(context).value('Messaggi'),
                            style: TextStyle(color: AppTheme.buttonColor),
                          ),
                        ],
                      ),
                      onPressed: () {
                        appLocator<AppRouterDelegate>().pop();
                      },
                    ),
                    middle: Text(state.plate),
                    trailing: PopupMenuButton(
                      offset: const Offset(0.0, 30),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                      ),
                      child: Icon(
                        CupertinoIcons.ellipsis,
                        color: AppTheme.buttonColor,
                      ),
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry>[
                          PopupMenuItem(
                            height: 30,
                            onTap: () {
                              // context.read<DialogBloc>().add(BlockUser());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(AppLocalizations.of(context).value('Block user')),
                                const Icon(
                                  Icons.back_hand_rounded,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                          const PopupMenuDivider(),
                          PopupMenuItem(
                            height: 30,
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(AppLocalizations.of(context).value('Report chat')),
                                const Icon(
                                  Icons.info_rounded,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ];
                      },
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView.builder(
                              reverse: true,
                              controller: scrollController,
                              itemCount: state.messages.length,
                              itemBuilder: (BuildContext context, int index) {
                                return MessageWidget(
                                  message: state.messages[index],
                                );
                              }),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          color: AppTheme.lightColor,
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 15,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 80,
                                height: 35,
                                child: CupertinoTextField(
                                  controller: messageController,
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    top: 2,
                                    right: 15,
                                  ),
                                  onChanged: (String val) {
                                    setState(() {});
                                  },
                                  onTap: () {
                                    Future.delayed(const Duration(milliseconds: 500), () {
                                      scrollController.animateTo(0,
                                          duration: const Duration(microseconds: 400),
                                          curve: Curves.elasticInOut);
                                    });
                                  },
                                  placeholder:
                                      AppLocalizations.of(context).value('Messaggio'),
                                  style: AppTextTheme.poppins14Regular,
                                  decoration: BoxDecoration(
                                    color: AppTheme.whiteColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              InkWell(
                                onTap: () => _sendMessage(context),
                                splashColor: AppTheme.backgroundColor,
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: messageController.text.isEmpty
                                          ? AppTheme.chatSendButton
                                          : AppTheme.selectedCursorColor,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.arrow_upward_sharp,
                                    color: AppTheme.whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }

  void _sendMessage(BuildContext context) {
    if (messageController.text.isEmpty) {
      return;
    }

    context.read<DialogBloc>().add(
          SendMessage(message: messageController.text),
        );
    messageController.clear();
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 400), curve: Curves.elasticInOut);
    FocusScope.of(context).unfocus();
  }
}
