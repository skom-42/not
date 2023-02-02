import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core/utils/field_validator.dart';
import 'package:noty_mobile/core_ui/src/dialogs/android_dialog/dialog_page.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';
import 'package:noty_mobile/data/custom_exception.dart';
import 'package:noty_mobile/features/auth/forgot_password/ui/forgot_password_page.dart';
import 'package:noty_mobile/features/auth/registration/ui/registration_page.dart';
import 'package:noty_mobile/features/home/home_page.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppRouterDelegate _appRouter;
  final AuthRepository _authRepository;

  LoginBloc({
    required AppRouterDelegate appRouter,
    required AuthRepository authRepository,
  })  : _appRouter = appRouter,
        _authRepository = authRepository,
        super(LoadingState()) {
    on<LoginViaEmail>(_onLoginViaEmailEvent);
    on<LoginViaGoogle>(_onLoginViaGoogleEvent);
    on<ForgotPassword>(_onForgotPassword);
    on<RouteToRegistration>(_onRouteToRegistration);
    on<InitData>(_onInitData);

    add(InitData());
  }

  Future<void> _onInitData(InitData event, Emitter<LoginState> emit) async {
    try {
      // await _authRepository.logOut();
      final bool isLoggedIn = _authRepository.isUserLoggedIn();
      if (isLoggedIn) {
        _appRouter.replace(
          DashboardFeature.page(),
        );
      } else {
        emit(ContentState());
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

  Future<void> _onLoginViaEmailEvent(LoginViaEmail event, Emitter<LoginState> emit) async {
    try {
      final bool isValid = FieldValidator.isLoginFormValid(
        email: event.email,
        password: event.password,
      );
      if (isValid) {
        await _authRepository.logIn(
          email: event.email,
          password: event.password,
        );
        _appRouter.replace(DashboardFeature.page());
      } else {
        _appRouter.push(
          DefaultDialog(
            title: 'Oh oh',
            message: AppLocalizations.ofGlobalContext('Email and Password are mandatory fields.'),
          ),
        );
      }
    } on CustomException catch (e) {
      _appRouter.push(DefaultDialog(
        title: 'Oh oh',
        message: e.errorMessage,
      ));
    }
  }

  Future<void> _onLoginViaGoogleEvent(LoginViaGoogle event, Emitter<LoginState> emit) async {
    try {
      final bool isLogined = await _authRepository.signInWithGoogle();
      if (isLogined) {
        _appRouter.replace(DashboardFeature.page());
      } else {
        _appRouter.push(
          DefaultDialog(
            title: 'Oh oh',
            message: AppLocalizations.ofGlobalContext(
              'Something went wrong while creating the account.',
            ),
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
    }
  }

  Future<void> _onForgotPassword(ForgotPassword event, Emitter<LoginState> emit) async {
    _appRouter.push(const ForgotPasswordPage());
  }

  Future<void> _onRouteToRegistration(RouteToRegistration event, Emitter<LoginState> emit) async {
    _appRouter.push(const RegistrationPage());
  }
}
