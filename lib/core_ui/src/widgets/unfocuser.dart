import 'package:flutter/material.dart';

class Unfocuser extends StatelessWidget {
  final Widget child;

  const Unfocuser({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}
