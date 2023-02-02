part of 'chats_bloc.dart';

abstract class ChatsState {}

class LoadingState implements ChatsState {}

class ContentState implements ChatsState {
  final List chats;

  ContentState({required this.chats});
}
