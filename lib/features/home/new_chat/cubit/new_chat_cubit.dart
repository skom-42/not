import 'package:bloc/bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/dialogs/android_dialog/dialog_page.dart';
import 'package:noty_mobile/data/repositories/chats_repository.dart';
import 'package:noty_mobile/domain/models/chat_list_item_model.dart';
import 'package:noty_mobile/features/dialog_screen/ui/dialog_page.dart';

import 'new_chat_state.dart';

class NewChatCubit extends Cubit<NewChatState> {
  NewChatCubit({
    required AppRouterDelegate appRouter,
    required ChatRepository chatRepository,
  })  : _appRouter = appRouter,
        _chatRepository = chatRepository,
        super(NewChatState().init());

  final AppRouterDelegate _appRouter;
  final ChatRepository _chatRepository;

  Future<void> createChat(String plate) async {
    try {
      final ChatListItemModel chat = await _chatRepository.createChat(plate: plate);
      _appRouter.replace(DialogPage(chatModel: chat));
    } on Exception catch (e) {
      _appRouter.push(
        DefaultDialog(
          title: 'Oh oh',
          message: AppLocalizations.ofGlobalContext('This driver is not part of our community.'),
        ),
      );
    }
  }
}
