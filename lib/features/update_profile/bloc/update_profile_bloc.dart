import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/dialogs/android_dialog/dialog_page.dart';
import 'package:noty_mobile/core_ui/src/dialogs/disapearing_dialog/disapearing_dialog_page.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';
import 'package:noty_mobile/domain/models/custom_user.dart';

part 'update_profile_event.dart';

part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final AppRouterDelegate _appRouter;
  final AuthRepository _authRepository;

  UpdateProfileBloc({
    required AppRouterDelegate appRouter,
    required AuthRepository authRepository,
  })  : _appRouter = appRouter,
        _authRepository = authRepository,
        super(LoadingState()) {
    on<LoadData>(_onLoadData);
    on<UpdateProfile>(_onUpdate);

    add(LoadData());
  }

  Future<void> _onLoadData(LoadData event, Emitter<UpdateProfileState> emit) async {
    try {
      final CustomUser? user = await _authRepository.getUserAttributes();
      emit(ContentState(customUser: user));
    } on Exception catch (e) {
      _appRouter.push(
        DefaultDialog(
          title: 'Oh oh',
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdate(UpdateProfile event, Emitter<UpdateProfileState> emit) async {
    try {
      await _authRepository.updateUser(
        name: event.name,
        sName: event.surname,
        plate: event.plate,
      );
      _appRouter.push(
        DisapearingDialogPage(
          title: AppLocalizations.ofGlobalContext('Done'),
          message: AppLocalizations.ofGlobalContext(
            'Your info have been updated!',
          ),
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
}
