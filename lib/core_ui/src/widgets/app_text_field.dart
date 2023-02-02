import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;

  final bool? isObscure;
  final bool? isEnabled;
  final String? hintText;
  final String? infoText;
  final String? errorText;
  final Color? additionalColor;
  final TextInputType? keyboardType;
  final void Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    required this.controller,
    this.isObscure,
    this.hintText,
    this.onChange,
    this.infoText,
    this.isEnabled,
    this.errorText,
    this.keyboardType,
    this.additionalColor,
    this.inputFormatters,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (infoText != null) ...<Widget>{
          Text(
            infoText!,
            style: AppTextTheme.poppins17SemiBold.copyWith(color: AppTheme.lightColor),
          ),
          const SizedBox(height: 8),
        },
        Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: AppTheme.lightColor,
            ),
            color: AppTheme.lightColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            obscureText: isObscure ?? false,
            obscuringCharacter: '●',
            inputFormatters: inputFormatters,
            keyboardType: keyboardType ?? TextInputType.text,
            onChanged: onChange,
            enabled: isEnabled,
            cursorColor: AppTheme.backgroundColor,
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppTheme.lightColor,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 9,
                horizontal: 12,
              ),
              border: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
