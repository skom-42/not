import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AppRouterDelegate _appRouter;
  final AuthRepository _authRepository;

  HomeBloc({
    required AppRouterDelegate appRouter,
    required AuthRepository authRepository,
  })  : _appRouter = appRouter,
        _authRepository = authRepository,
        super(LoadingState()) {
    on<UpdateToken>(_onUpdateToken);

    add(UpdateToken());
  }

  Future<void> _onUpdateToken(UpdateToken event, Emitter<HomeState> emit) async {
    await _authRepository.updateToken();
    emit(ContentState());
  }
}
