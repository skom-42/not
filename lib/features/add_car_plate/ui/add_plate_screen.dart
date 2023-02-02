import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';
import 'package:noty_mobile/core_ui/src/widgets/add_plate/condition_state.dart';
import 'package:noty_mobile/core_ui/src/widgets/add_plate/first_state.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_background_image.dart';
import 'package:noty_mobile/core_ui/src/widgets/page_app_bar.dart';
import 'package:noty_mobile/features/add_car_plate/bloc/add_plate_bloc.dart';
import '../../../core_ui/src/widgets/unfocuser.dart';

class AddPlateScreen extends StatelessWidget {
  const AddPlateScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBackgroundImage(
      child: Unfocuser(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PageAppBar(
            title: AppLocalizations.of(context).value('Profile'),
            color: AppTheme.lightColor,
            onLeadingPressed: () {
              appLocator<AppRouterDelegate>().pop();
            },
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: BlocBuilder<AddPlateBloc, AddPlateState>(
              builder: (BuildContext context, AddPlateState state) {
                if (state is ConditionState) {
                  return ConditionStateWidget(
                    onTap: () {
                      context.read<AddPlateBloc>().add(RouteToFirstStep());
                    },
                  );
                } else if (state is AddCarPlateFirstStep) {
                  return FirstState(
                    onPressed: (String value) {
                      if (value.isNotEmpty) {
                        context.read<AddPlateBloc>().add(ConfirmPlate(plate: value));
                      }
                    },
                  );
                } else if (state is AddCarSecondStep) {
                  return Container();
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
