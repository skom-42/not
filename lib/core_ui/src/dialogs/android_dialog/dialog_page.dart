import 'package:flutter/material.dart';
import 'package:noty_mobile/core_ui/src/dialogs/android_dialog/dialog_screen.dart';

class DefaultDialog extends Page<void> {
  final String title;
  final String message;
  final Function? onOk;

  const DefaultDialog({
    required this.title,
    required this.message,
    this.onOk,
  });

  @override
  Route<void> createRoute(BuildContext context) {
    return DialogRoute<void>(
      settings: this,
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DefaultDialogScreen(
          title: title,
          message: message,
          onOk: onOk,
        );
      },
    );
  }
}
