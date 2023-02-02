import 'package:noty_mobile/data/firebase_api_provider.dart';
import 'package:noty_mobile/domain/models/chat_list_item_model.dart';
import 'package:noty_mobile/domain/models/chat_message.dart';
import 'package:noty_mobile/domain/models/chat_model.dart';
import 'package:noty_mobile/domain/models/custom_user.dart';

class ChatRepository {
  final FirebaseApiProvider apiProvider;

  ChatRepository({
    required this.apiProvider,
  });

  Future<Stream<List<ChatListItemModel>>> getAllChatsList() {
    return apiProvider.getAllChats();
  }

  Future<CustomUser?> getChatUser({
    required ChatModel chat,
  }) {
    return apiProvider.getUserInChat(chat: chat);
  }

  Future<Stream<List<ChatMessage>>> getChatMessages(
      {required ChatListItemModel chatListItemModel}) {
    return apiProvider.getChatMessages(chatListItemModel: chatListItemModel);
  }

  Future<ChatListItemModel> createChat({
    required String plate,
  }) {
    return apiProvider.createChat(plate: plate);
  }

  Future<ChatListItemModel?> getChat({
    required String plate,
  }) {
    return apiProvider.getChat(plate: plate);
  }

  Future<void> sendMessage({
    required String message,
    required ChatListItemModel chat,
  }) {
    return apiProvider.sendMessage(
      chat: chat,
      message: message,
    );
  }

  Future<bool> deleteChat(ChatListItemModel chat) async {
    return apiProvider.deleteChat(
      chat,
    );
  }

  Future<void> blockUser({
    required ChatListItemModel chat,
  }) {
    return apiProvider.blockUser(
      chat: chat,
    );
  }
}
