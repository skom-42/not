part of 'dialog_bloc.dart';

abstract class DialogEvent {}

class LoadData implements DialogEvent {}

class SendMessage implements DialogEvent {
  final String message;

  SendMessage({required this.message});
}
