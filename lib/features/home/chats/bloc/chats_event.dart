part of 'chats_bloc.dart';

abstract class ChatsEvent {}

class AddChat implements ChatsEvent {}

class LoadChatsEvent implements ChatsEvent {}

class DeleteChat implements ChatsEvent {
  final ChatListItemModel chat;

  DeleteChat(this.chat);
}

class UpdateChat implements ChatsEvent {
  final List<ChatListItemModel> chats;

  UpdateChat({required this.chats});
}

class OpenChat implements ChatsEvent {
  final ChatListItemModel chatModel;

  OpenChat({required this.chatModel});
}
