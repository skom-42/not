import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/dialogs/android_dialog/dialog_page.dart';
import 'package:noty_mobile/core_ui/src/dialogs/disapearing_dialog/disapearing_dialog_page.dart';
import 'package:noty_mobile/data/repositories/chats_repository.dart';
import 'package:noty_mobile/features/dialog_screen/ui/dialog_page.dart';

part 'chats_event.dart';

part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final AppRouterDelegate _appRouter;
  final ChatRepository _chatRepository;

  ChatsBloc({
    required AppRouterDelegate appRouter,
    required ChatRepository chatRepository,
  })  : _appRouter = appRouter,
        _chatRepository = chatRepository,
        super(LoadingState()) {
    on<AddChat>(_onAddChatEvent);
    on<LoadChatsEvent>(_onLoadChatsEvent);
    on<OpenChat>(_onOpenChat);

    add(LoadChatsEvent());
  }

  Future<void> _onLoadChatsEvent(LoadChatsEvent event, Emitter<ChatsState> emit) async {
    try {
      final List chats = await _chatRepository.getAllChatsList();
      emit(ContentState(chats: chats));
    } on Exception catch (e) {
      _appRouter.push(
        DefaultDialog(
          title: 'Oh oh',
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onAddChatEvent(AddChat event, Emitter<ChatsState> emit) async {
    try {
      _appRouter.push(
        DisapearingDialogPage(
          title: 'Oh oh',
          message: AppLocalizations.ofGlobalContext('You need to set a license plate first.'),
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

  Future<void> _onOpenChat(OpenChat event, Emitter<ChatsState> emit) async {
    _appRouter.push(DialogPage(plate: event.plate));
  }
}
