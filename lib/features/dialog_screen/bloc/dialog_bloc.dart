import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core_ui/src/dialogs/android_dialog/dialog_page.dart';
import 'package:noty_mobile/data/repositories/chats_repository.dart';

part 'dialog_event.dart';

part 'dialog_state.dart';

class DialogBloc extends Bloc<DialogEvent, DialogState> {
  final String _plate;
  final AppRouterDelegate _appRouter;
  final ChatRepository _chatRepository;

  DialogBloc({
    required String plate,
    required AppRouterDelegate appRouter,
    required ChatRepository chatRepository,
  })  : _plate = plate,
        _appRouter = appRouter,
        _chatRepository = chatRepository,
        super(LoadingState()) {
    on<LoadData>(_onLoadData);

    add(LoadData());
  }

  Future<void> _onLoadData(LoadData event, Emitter<DialogState> emit) async {
    try {
      //TODO: LoadData
      emit(ContentState(plate: _plate));
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
