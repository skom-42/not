import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';

class DefaultDialogScreen extends StatelessWidget {
  final String title;
  final String message;

  const DefaultDialogScreen({
    required this.title,
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [_submitButton()],
    );
  }
}

Widget _submitButton() {
  return TextButton(
    child: const Text("OK"),
    onPressed: () {
      appLocator<AppRouterDelegate>().pop();
    },
  );
}
