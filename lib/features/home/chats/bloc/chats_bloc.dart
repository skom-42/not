import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/dialogs/android_dialog/dialog_page.dart';
import 'package:noty_mobile/core_ui/src/dialogs/disapearing_dialog/disapearing_dialog_page.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';
import 'package:noty_mobile/data/repositories/chats_repository.dart';
import 'package:noty_mobile/domain/models/chat_list_item_model.dart';
import 'package:noty_mobile/features/dialog_screen/ui/dialog_page.dart';
import 'package:noty_mobile/features/home/new_chat/ui/new_chat_page.dart';

part 'chats_event.dart';

part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final AppRouterDelegate _appRouter;
  final ChatRepository _chatRepository;
  final AuthRepository _authRepository;

  ChatsBloc({
    required AppRouterDelegate appRouter,
    required ChatRepository chatRepository,
    required AuthRepository authRepository,
  })  : _appRouter = appRouter,
        _authRepository = authRepository,
        _chatRepository = chatRepository,
        super(LoadingState()) {
    on<AddChat>(_onAddChatEvent);
    on<LoadChatsEvent>(_onLoadChatsEvent);
    on<OpenChat>(_onOpenChat);
    on<UpdateChat>(_onUpdateChat);

    add(LoadChatsEvent());
  }

  Stream<List<ChatListItemModel>>? chatListStream;

  Future<void> _onLoadChatsEvent(LoadChatsEvent event, Emitter<ChatsState> emit) async {
    try {
      chatListStream = await _chatRepository.getAllChatsList();
      chatListStream?.listen((event) {
        add(UpdateChat(chats: event));
      });

      emit(ContentState(chats: []));
    } on Exception catch (e) {
      _appRouter.push(
        DefaultDialog(
          title: 'Oh oh',
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdateChat(UpdateChat event, Emitter<ChatsState> emit) async {
    emit(ContentState(chats: event.chats));
  }

  Future<void> _onAddChatEvent(AddChat event, Emitter<ChatsState> emit) async {
    try {
      final user = await _authRepository.getUserAttributes();
      final plate = user?.plate;
      if (plate != null) {
        _appRouter.push(
          NewChatPage(),
        );
      } else {
        _appRouter.push(
          DisapearingDialogPage(
            title: 'Oh oh',
            message: AppLocalizations.ofGlobalContext(
              'You need to set a license plate first.',
            ),
          ),
        );
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

  Future<void> _onOpenChat(OpenChat event, Emitter<ChatsState> emit) async {
    _appRouter.push(DialogPage(chatModel: event.chatModel));
  }
}
