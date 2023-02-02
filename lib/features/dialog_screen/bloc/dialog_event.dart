part of 'dialog_bloc.dart';

abstract class DialogEvent {}

class LoadData implements DialogEvent {}

class BlockUser implements DialogEvent {}

class ReportChat implements DialogEvent {}

class NormalEvent implements DialogEvent {}

class UpdatedData implements DialogEvent {
  final List<ChatMessage> messages;

  UpdatedData(this.messages);
}

class SendMessage implements DialogEvent {
  final String message;

  SendMessage({required this.message});
}
