part of 'chats_bloc.dart';

abstract class ChatsEvent {}

class AddChat implements ChatsEvent {}

class LoadChatsEvent implements ChatsEvent {}

class OpenChat implements ChatsEvent {
  final String plate;

  OpenChat({required this.plate});
}
