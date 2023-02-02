import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';
import 'package:noty_mobile/domain/models/custom_user.dart';
import 'package:noty_mobile/features/add_car_plate/ui/add_palte_page.dart';
import 'package:noty_mobile/features/auth/login%20/ui/login_page.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AppRouterDelegate _appRouter;
  final AuthRepository _authRepository;

  ProfileBloc({
    required AppRouterDelegate appRouter,
    required AuthRepository authRepository,
  })  : _appRouter = appRouter,
        _authRepository = authRepository,
        super(LoadingState()) {
    on<LoadData>(_onLoadData);
    on<RouteToAddCarPlate>(_onRouteToAddCarPlate);

    add(LoadData());
  }

  Future<void> _onLoadData(LoadData event, Emitter<ProfileState> emit) async {
    final CustomUser? user = await _authRepository.getUserAttributes();

    if (user == null) {
      await _authRepository.logOut();
      _appRouter.push(LoginPage());
    }

    emit(ContentState(isHasPlate: user?.plate != null));
  }

  Future<void> _onRouteToAddCarPlate(
      RouteToAddCarPlate event, Emitter<ProfileState> emit) async {
    _appRouter.push(AddPlatePage());
  }
}
