import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core_ui/src/dialogs/android_dialog/dialog_page.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';
import 'package:noty_mobile/domain/models/custom_user.dart';
import 'package:noty_mobile/features/home/home_page.dart';
import 'package:noty_mobile/features/image_selector/image_selector_page.dart';

part 'verify_account_event.dart';

part 'verify_account_state.dart';

class VerifyAccountBloc extends Bloc<VerifyAccountEvent, VerifyAccountState> {
  final AppRouterDelegate _appRouter;
  final AuthRepository _authRepository;
  final bool? isNeedVerify;

  static const String firstString = 'VEICOLO IBRIDO A CARICA ESTERNA';
  static const String secondString = 'VEICOLO A TRAZIONE ELETTRICA';

  VerifyAccountBloc({
    required AppRouterDelegate appRouter,
    required AuthRepository authRepository,
    this.isNeedVerify,
  })  : _appRouter = appRouter,
        _authRepository = authRepository,
        super(ContentState()) {
    on<VerifyAccount>(_onVerifyAccount);
    on<RouteBack>(_onRouteBack);
  }

  Future<void> _onVerifyAccount(VerifyAccount event, Emitter<VerifyAccountState> emit) async {
    try {
      final image = await _appRouter.pushForResult(ImageSelectorPage());
      if (image != null) {
        final inputImage = InputImage.fromFile(image);
        final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
        final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

        if (recognizedText.text.contains(firstString) ||
            recognizedText.text.contains(secondString)) {
          await _authRepository.updateVerification();
          if (isNeedVerify != null && isNeedVerify!) {
            _appRouter.replace(DashboardPage());
          } else {
            _appRouter.popWithResult(true);
          }
        } else {
          final CustomUser? customUser = await _authRepository.getUserAttributes();
          if (customUser?.plate != null) {
            final bool isHybridCar =
                await _authRepository.checkForValidXml(plate: customUser!.plate!);
            if (isHybridCar) {
              await _authRepository.updateVerification();
              if (isNeedVerify != null && isNeedVerify!) {
                _appRouter.replace(DashboardPage());
              } else {
                _appRouter.popWithResult(true);
              }
            } else {
              _appRouter.popWithResult(false);
            }
          }
        }
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

  Future<void> _onRouteBack(RouteBack event, Emitter<VerifyAccountState> emit) async {
    if (isNeedVerify == null) {
      _appRouter.pop();
    }
  }
}
