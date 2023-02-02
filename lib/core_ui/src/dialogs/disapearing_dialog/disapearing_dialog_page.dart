import 'package:flutter/material.dart';
import 'package:noty_mobile/core_ui/src/dialogs/disapearing_dialog/disapearing_dialog_screen.dart';

class DisapearingDialogPage extends Page<void> {
  final String title;
  final String message;

  const DisapearingDialogPage({
    required this.title,
    required this.message,
  });

  @override
  Route<void> createRoute(BuildContext context) {
    return DialogRoute<void>(
      settings: this,
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DisapearingDialogScreen(
          title: title,
          message: message,
        );
      },
    );
  }
}
