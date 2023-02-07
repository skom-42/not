import 'package:easyqrimage/easyqrimage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';
import 'package:noty_mobile/core_ui/src/widgets/add_plate/condition_state.dart';
import 'package:noty_mobile/core_ui/src/widgets/add_plate/first_state.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_background_image.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_button.dart';
import 'package:noty_mobile/core_ui/src/widgets/page_app_bar.dart';
import 'package:noty_mobile/features/add_car_plate/bloc/add_plate_bloc.dart';
import 'package:noty_mobile/features/image_selector/image_selector_page.dart';
import 'package:noty_mobile/features/image_selector/image_selector_screen.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../../core_ui/src/theme/app_icon_theme.dart';
import '../../../core_ui/src/widgets/unfocuser.dart';

class AddPlateScreen extends StatefulWidget {
  AddPlateScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPlateScreen> createState() => _AddPlateScreenState();
}

class _AddPlateScreenState extends State<AddPlateScreen> {
  String? currentPlate;

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
              appLocator<AppRouterDelegate>().popWithResult(currentPlate);
            },
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: BlocConsumer<AddPlateBloc, AddPlateState>(
              listener: (BuildContext context, AddPlateState state) {
                if (state is AddCarThirdStep) {
                  setState(() {
                    currentPlate = state.plate;
                  });
                }
              },
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
                        context.read<AddPlateBloc>().add(ConfirmPlate(
                          plate: value.trim().toUpperCase(),
                        ));
                        showDialog(context);
                      }
                    },
                  );
                } else if (state is AddCarThirdStep) {
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).value('Add your car'),
                          style: AppTextTheme.poppins30SemiBold.copyWith(
                            color: AppTheme.lightColor,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Image.asset(
                          AppIconsTheme.check,
                          fit: BoxFit.fill,
                          height: 163,
                          width: 125,
                        ),
                        const SizedBox(height: 70),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60),
                          child: Text(
                            AppLocalizations.of(context).value(
                              'Take a picture of your technical paper',
                            ),
                            style: AppTextTheme.poppins17SemiBold.copyWith(
                              color: AppTheme.lightColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: StepProgressIndicator(
                            padding: 12,
                            size: 8,
                            totalSteps: 3,
                            currentStep: 2,
                            unselectedColor: AppTheme.unselectedCursorColor,
                            selectedColor: AppTheme.selectedCursorColor,
                            roundedEdges: const Radius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 32),
                        AppButton(
                          image: Icon(
                            CupertinoIcons.photo_camera,
                            color: AppTheme.lightColor,
                          ),
                          text: AppLocalizations.of(context).value('Take a photo'),
                          backgroundColor: AppTheme.buttonColor,
                          onPressed: () {
                            showModalBottomSheet(context: context, isScrollControlled: false,backgroundColor: Colors.transparent, builder: (BuildContext _) {
                              return ImageSelectorScreen(onClose: (image) {
                                context.read<AddPlateBloc>().add(UploadPhoto(image));

                              },);
                            });
                          },
                        ),
                        const SizedBox(height: 18),
                        GestureDetector(
                          onTap: () {
                            appLocator<AppRouterDelegate>().popWithResult(currentPlate);
                          },
                          child: Text(
                            AppLocalizations.of(context).value('Verify next time'),
                            style: AppTextTheme.poppins14Regular.copyWith(
                              color: AppTheme.lightColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else if (state is InformationState) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context).value('Add your car'),
                          style: AppTextTheme.poppins30SemiBold.copyWith(
                            color: AppTheme.lightColor,
                          ),
                        ),
                        const SizedBox(height: 40),
                        EasyQRImage(
                          data: state.plate!,
                          size: 180,
                          backgroundColor: AppTheme.lightColor,
                        ),
                        const SizedBox(height: 70),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26),
                          child: Text(
                            AppLocalizations.of(context).value(
                              'This is your QR code which will show to other drivers if they want to contact you.',
                            ),
                            style: AppTextTheme.poppins14Regular.copyWith(
                              color: AppTheme.lightColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: StepProgressIndicator(
                            padding: 12,
                            size: 8,
                            totalSteps: 3,
                            currentStep: 3,
                            unselectedColor: AppTheme.unselectedCursorColor,
                            selectedColor: AppTheme.selectedCursorColor,
                            roundedEdges: const Radius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 40),
                        AppButton(
                          text: AppLocalizations.of(context).value('Finish'),
                          backgroundColor: AppTheme.buttonColor,
                          onPressed: () {
                            appLocator<AppRouterDelegate>().popWithResult(state.plate!);
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

showDialog(BuildContext context) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.0),
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.90,
          child: AppBackgroundImage(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                    width: double.infinity,
                  ),
                  Image.asset(
                    AppIconsTheme.paper,
                    fit: BoxFit.fill,
                    height: 176,
                    width: 140,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Per verificarsi occorre scattare una foto solo della '
                        'sezione 3 del libretto. Dove non contiene nessuna '
                        'informazione personale ma solo quelle necessarie al '
                        'corretto funzionamento all\'app. Nota: Non salviamo o '
                        'condividiamo la foto del libretto. La verifica viene '
                        'effettuata direttamente sul dispositivo stesso.',
                    style: AppTextTheme.poppins17SemiBold.copyWith(
                      color: AppTheme.lightColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
