part of 'dialog_bloc.dart';

abstract class DialogState {}

class LoadingState implements DialogState {}

class ContentState implements DialogState {
  final String plate;

  ContentState({required this.plate});
}
