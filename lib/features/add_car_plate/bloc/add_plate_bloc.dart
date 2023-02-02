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

part 'add_plate_event.dart';

part 'add_plate_state.dart';

class AddPlateBloc extends Bloc<AddPlateEvent, AddPlateState> {
  final AppRouterDelegate _appRouter;

  AddPlateBloc({
    required AppRouterDelegate appRouter,
  })  : _appRouter = appRouter,
        super(ConditionState()) {
    on<RouteToFirstStep>(_onRouteToFirstStep);
    on<ConfirmPlate>(_onConfirmPlate);
  }

  Future<void> _onRouteToFirstStep(RouteToFirstStep event, Emitter<AddPlateState> emit) async {
    emit(AddCarPlateFirstStep());
  }

  Future<void> _onConfirmPlate(ConfirmPlate event, Emitter<AddPlateState> emit) async {
    //TODO: AddThomething
    //  emit()
  }
}
