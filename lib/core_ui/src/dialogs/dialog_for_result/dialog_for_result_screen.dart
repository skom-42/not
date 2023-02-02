import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/core/localization/localization.dart';

class DialogForResultScreen extends StatelessWidget {
  final String title;
  final String message;

  const DialogForResultScreen({
    required this.title,
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [_rejectButton(), _submitButton()],
    );
  }

  Widget _submitButton() {
    return TextButton(
      child: Text(
        AppLocalizations.ofGlobalContext('Yes'),
        style: const TextStyle(color: Colors.red),
      ),
      onPressed: () {
        appLocator<AppRouterDelegate>().popWithResult(true);
      },
    );
  }

  Widget _rejectButton() {
    return TextButton(
      child: const Text("No"),
      onPressed: () {
        appLocator<AppRouterDelegate>().popWithResult(false);
      },
    );
  }
}
