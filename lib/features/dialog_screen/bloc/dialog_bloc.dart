import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core_ui/src/dialogs/android_dialog/dialog_page.dart';
import 'package:noty_mobile/data/repositories/chats_repository.dart';
import 'package:noty_mobile/domain/models/chat_list_item_model.dart';
import 'package:noty_mobile/domain/models/chat_message.dart';

part 'dialog_event.dart';
part 'dialog_state.dart';

class DialogBloc extends Bloc<DialogEvent, DialogState> {
  final ChatListItemModel _chatModel;
  final AppRouterDelegate _appRouter;
  final ChatRepository _chatRepository;

  DialogBloc({
    required ChatListItemModel chatModel,
    required AppRouterDelegate appRouter,
    required ChatRepository chatRepository,
  })  : _chatModel = chatModel,
        _appRouter = appRouter,
        _chatRepository = chatRepository,
        super(DialogState(plate: '', isLoading: true, messages: [])) {
    on<LoadData>(_onLoadData);
    on<UpdatedData>(_onUpdatedData);
    on<SendMessage>(_onSendMessage);
    on<NormalEvent>(_toNormalState);
    on<BlockUser>(_blockUser);
    on<ReportChat>(_reportChat);
    add(LoadData());
  }

  Future<void> _onLoadData(LoadData event, Emitter<DialogState> emit) async {
    try {
      final messages =
          await _chatRepository.getChatMessages(chatListItemModel: _chatModel);

      messages.listen((e) {
        print('%messages% ${e}');
        add(UpdatedData(e));
      });
      emit(DialogState(plate: _chatModel.plate, messages: []));
    } on Exception catch (e) {
      _appRouter.push(
        DefaultDialog(
          title: 'Oh oh',
          message: e.toString(),
        ),
      );
    }
  }

  void _toNormalState(NormalEvent event, Emitter<DialogState> emit) {
    emit(state.copyWith(
      isScrollNeeded: false,
    ));
  }

  Future<void> _onUpdatedData(UpdatedData event, Emitter<DialogState> emit) async {
    emit(state.copyWith(
      isLoading: false,
      messages: [...event.messages],
      isScrollNeeded: true,
    ));
  }

  Future<void> _onSendMessage(SendMessage event, Emitter<DialogState> emit) async {
    await _chatRepository.sendMessage(
      chat: _chatModel,
      message: event.message,
    );
  }

  Future<void> _blockUser(BlockUser event, Emitter<DialogState> emit) async {
    await _chatRepository.blockUser(
      chat: _chatModel,
    );
    _appRouter.pop();
  }

  Future<void> _reportChat(ReportChat event, Emitter<DialogState> emit) async {}
}
