import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core/utils/field_validator.dart';
import 'package:noty_mobile/core_ui/src/dialogs/android_dialog/dialog_page.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';
import 'package:noty_mobile/data/custom_exception.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AppRouterDelegate _appRouter;
  final AuthRepository _authRepository;

  ForgotPasswordBloc({
    required AppRouterDelegate appRouter,
    required AuthRepository authRepository,
  })  : _appRouter = appRouter,
        _authRepository = authRepository,
        super(ContentState()) {
    on<ResetPassword>(_onResetPassword);
    on<RouteBack>(_onRouteBack);
  }

  Future<void> _onResetPassword(ResetPassword event, Emitter<ForgotPasswordState> emit) async {
    try {
      final bool isValid = FieldValidator.isResetFormValid(email: event.email);
      if (isValid) {
        await _authRepository.resetPassword(email: event.email);
        _appRouter.push(
          DefaultDialog(
            title: AppLocalizations.ofGlobalContext('Sent 📧'),
            message: AppLocalizations.ofGlobalContext(
              'An email has been sent to you with the instructions for reset your password.',
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

  Future<void> _onRouteBack(RouteBack event, Emitter<ForgotPasswordState> emit) async {
    _appRouter.pop();
  }
}
