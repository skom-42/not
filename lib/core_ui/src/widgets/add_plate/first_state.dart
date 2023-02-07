import 'package:flutter/material.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_text_field.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../core/localization/localization.dart';
import '../../theme/app_icon_theme.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/app_theme.dart';
import '../app_button.dart';

class FirstState extends StatefulWidget {
  final Function(String) onPressed;

  const FirstState({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<FirstState> createState() => _FirstStateState();
}

final TextEditingController controller = TextEditingController();
bool isNeedButton = false;

class _FirstStateState extends State<FirstState> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(
            AppLocalizations.of(context).value('Add your car'),
            style: AppTextTheme.poppins30SemiBold.copyWith(
              color: AppTheme.lightColor,
            ),
          ),
          const SizedBox(height: 30),
          Image.asset(
            AppIconsTheme.carPlate,
            fit: BoxFit.fill,
            height: 172,
            width: 133,
          ),
          const SizedBox(height: 52),
          Text(
            AppLocalizations.of(context).value('Enter driver`s car plate number'),
            style: AppTextTheme.poppins17SemiBold.copyWith(
              color: AppTheme.lightColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          AppTextField(
            controller: controller,
            onChange: (String value) {
              if (value.isNotEmpty) {
                setState(() {
                  isNeedButton = true;
                });
              } else {
                setState(() {
                  isNeedButton = false;
                });
              }
            },
          ),
          const SizedBox(height: 53),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: StepProgressIndicator(
              padding: 12,
              size: 8,
              totalSteps: 3,
              currentStep: 1,
              unselectedColor: AppTheme.unselectedCursorColor,
              selectedColor: AppTheme.selectedCursorColor,
              roundedEdges: const Radius.circular(10),
            ),
          ),
          const SizedBox(height: 72),
          if (isNeedButton) ...<Widget>{
            AppButton(
              text: AppLocalizations.of(context).value('Continue'),
              backgroundColor: AppTheme.buttonColor,
              onPressed: () {
                widget.onPressed(controller.text);
              },
            ),
          }
        ],
      ),
    );
  }
}
