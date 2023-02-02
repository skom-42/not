import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';

class DefaultDialogScreen extends StatelessWidget {
  final String title;
  final String message;
  final Function? onOk;

  const DefaultDialogScreen({
    required this.title,
    required this.message,
    this.onOk,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [_submitButton(onOk)],
    );
  }
}

Widget _submitButton(Function? onOk) {
  return TextButton(
    child: const Text("OK"),
    onPressed: () {
      if (onOk != null) {
        onOk();
      } else {
        appLocator<AppRouterDelegate>().pop();
      }
    },
  );
}
