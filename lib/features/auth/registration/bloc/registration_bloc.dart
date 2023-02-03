import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core/utils/field_validator.dart';
import 'package:noty_mobile/core_ui/src/dialogs/android_dialog/dialog_page.dart';
import 'package:noty_mobile/data/custom_exception.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';
import 'package:noty_mobile/features/home/home_page.dart';

import '../../../../core/utils/url_launcher.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AppRouterDelegate _appRouter;
  final AuthRepository _authRepository;

  RegistrationBloc({
    required AppRouterDelegate appRouter,
    required AuthRepository authRepository,
  })  : _appRouter = appRouter,
        _authRepository = authRepository,
        super(ContentState()) {
    on<RegisterUser>(_onRegisterUser);
    on<OpenWebView>(_onOpenWebView);
  }

  Future<void> _onRegisterUser(RegisterUser event, Emitter<RegistrationState> emit) async {
    try {
      final isValidated = FieldValidator.isRegistrationFormValid(
        name: event.name,
        surname: event.surname,
        email: event.email,
        password: event.password,
      );
      if (isValidated) {
        await _authRepository.createUser(
          email: event.email,
          password: event.password,
          name: event.name,
          surName: event.surname,
        );
        _appRouter.push(DashboardFeature.page());
      } else {
        _appRouter.push(
          DefaultDialog(
            title: 'Oh oh',
            message: AppLocalizations.ofGlobalContext('All fields are mandatory fields.'),
          ),
        );
      }
    } on CustomException catch (e) {
      _appRouter.push(
        DefaultDialog(
          title: 'Oh oh',
          message: e.errorMessage,
        ),
      );
    } on Exception catch (e) {
      _appRouter.push(
        DefaultDialog(
          title: 'Oh oh',
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onOpenWebView(OpenWebView event, Emitter<RegistrationState> emit) async {
    try {
      await UrlLauncher.openLink(url: 'https://www.notyapp.it/eula');
    } on Exception catch (e) {
      _appRouter.push(
        DefaultDialog(
          title: 'Oh oh',
          message: e.toString(),
        ),
      );
    }
  }
}
