import 'package:flutter/material.dart';
import 'package:noty_mobile/core_ui/src/dialogs/dialog_for_result/dialog_for_result_screen.dart';

class DialogForResultPage extends Page<bool?> {
  final String title;
  final String message;

  const DialogForResultPage({
    required this.title,
    required this.message,
  });

  @override
  Route<bool?> createRoute(BuildContext context) {
    return DialogRoute<bool?>(
      settings: this,
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return DialogForResultScreen(
          title: title,
          message: message,
        );
      },
    );
  }
}
