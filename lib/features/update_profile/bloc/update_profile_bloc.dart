import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core_ui/src/dialogs/android_dialog/dialog_page.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';

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
      emit(ContentState());
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
      emit(ContentState());
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
