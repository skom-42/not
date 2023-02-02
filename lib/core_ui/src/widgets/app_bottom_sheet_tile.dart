import 'package:flutter/material.dart';

class AppBottomSheetTile extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final VoidCallback onPressed;

  const AppBottomSheetTile({
    required this.text,
    required this.textStyle,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Ink(
        child: Container(
          height: 56,
          alignment: Alignment.center,
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
