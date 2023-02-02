import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/theme/app_icon_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_background_image.dart';
import 'package:noty_mobile/core_ui/src/widgets/unfocuser.dart';
import 'package:noty_mobile/features/dialog_screen/bloc/dialog_bloc.dart';

class DialogScreen extends StatelessWidget {
  const DialogScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Unfocuser(
      child: AppBackgroundImage(
        image: AppIconsTheme.chatsBackground,
        child: BlocBuilder<DialogBloc, DialogState>(
          builder: (BuildContext context, DialogState state) {
            if (state is ContentState) {
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
                    onPressed: () {},
                  ),
                  middle: Text(state.plate),
                  trailing: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      CupertinoIcons.ellipsis,
                      color: AppTheme.buttonColor,
                    ),
                    onPressed: () {},
                  ),
                ),
                child: SafeArea(
                  child: Container(),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
