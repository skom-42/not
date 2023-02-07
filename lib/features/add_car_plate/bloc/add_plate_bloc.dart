import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/dialogs/android_dialog/dialog_page.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';
import 'package:noty_mobile/features/auth/login%20/ui/login_page.dart';
import 'package:noty_mobile/features/home/home_page.dart';
import 'package:noty_mobile/features/image_selector/image_selector_page.dart';

part 'add_plate_event.dart';

part 'add_plate_state.dart';

class AddPlateBloc extends Bloc<AddPlateEvent, AddPlateState> {
  final AppRouterDelegate _appRouter;
  final AuthRepository _authRepository;
  String? updatedPlate;

  static const String firstString = 'VEICOLO IBRIDO A CARICA ESTERNA';
  static const String secondString = 'VEICOLO A TRAZIONE ELETTRICA';

  AddPlateBloc({
    required BuildContext context,
    required AppRouterDelegate appRouter,
    required AuthRepository authRepository,
  })  : _appRouter = appRouter,
        _authRepository = authRepository,
        super(ConditionState()) {
    on<RouteToFirstStep>(_onRouteToFirstStep);
    on<ConfirmPlate>(_onConfirmPlate);
    on<RouteBack>(_onRouteBack);
    on<UploadPhoto>(_onUploadPhoto);
  }

  Future<void> _onRouteToFirstStep(RouteToFirstStep event, Emitter<AddPlateState> emit) async {
    emit(AddCarPlateFirstStep());
  }

  Future<void> _onConfirmPlate(ConfirmPlate event, Emitter<AddPlateState> emit) async {
    try {
      updatedPlate = await _authRepository.updatePlate(plate: event.plate);
      emit(AddCarThirdStep(
        plate: updatedPlate,
      ));
    } on Exception catch (e) {
      _appRouter.push(
        DefaultDialog(
          title: 'Oh oh',
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onUploadPhoto(UploadPhoto event, Emitter<AddPlateState> emit) async {
    try {
      final image = await _appRouter.pushForResult(ImageSelectorPage());
      if (image != null) {
        final inputImage = InputImage.fromFile(image);
        final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
        final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

        if (recognizedText.text.contains(firstString) ||
            recognizedText.text.contains(secondString)) {
          await _authRepository.updateVerification();
        } else if (updatedPlate != null) {
          bool isVerified = await _authRepository.checkForValidXml(plate: updatedPlate!);
          if (isVerified) {
            await _authRepository.updateVerification();
          } else {
            _appRouter.push(
              DefaultDialog(
                  title: 'Oh oh',
                  message: AppLocalizations.ofGlobalContext(
                    'Looks like that this car is not electric or plugin hybrid.',
                  ),
                  onOk: () {
                    onDelete();
                  }),
            );
          }
        }
        emit(InformationState(plate: updatedPlate));
      }
    } on Exception catch (e) {
      _appRouter.push(
        DefaultDialog(
          title: 'Oh oh',
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onRouteBack(RouteBack event, Emitter<AddPlateState> emit) async {
    _appRouter.popWithResult(updatedPlate);
  }

  void onDelete() async {
    await _authRepository.deleteUser();
    _appRouter.pop();
    _appRouter.popUntilPage(DashboardPage());
    _appRouter.replace(LoginPage());
  }
}
