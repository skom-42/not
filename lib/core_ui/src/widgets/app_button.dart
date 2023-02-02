import 'package:flutter/material.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import '../theme/app_theme.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;

  final Color backgroundColor;
  final String text;
  final Widget? image;

  const AppButton({
    required this.text,
    required this.backgroundColor,
    this.image,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          backgroundColor: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return backgroundColor;
              } else {
                return backgroundColor;
              }
            },
          ),
        ),
        onPressed: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (image != null) ...<Widget>{
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: image,
              ),
            },
            Flexible(
              child: Text(
                text,
                style: AppTextTheme.poppins17SemiBold.copyWith(
                  color: AppTheme.lightColor,
                ),
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
