import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';

class DisapearingDialogScreen extends StatefulWidget {
  final String title;
  final String message;

  const DisapearingDialogScreen({
    required this.title,
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  State<DisapearingDialogScreen> createState() => _DisapearingDialogScreenState();
}

class _DisapearingDialogScreenState extends State<DisapearingDialogScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 1), () {
      appLocator<AppRouterDelegate>().pop();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: widget.message.isNotEmpty ? Text(widget.message) : const SizedBox.shrink(),
    );
  }
}
