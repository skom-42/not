part of 'chats_bloc.dart';

abstract class ChatsState {}

class LoadingState implements ChatsState {}

class ContentState implements ChatsState {
  final List<ChatListItemModel> chats;

  ContentState({required this.chats});
}
