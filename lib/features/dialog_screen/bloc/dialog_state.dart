part of 'dialog_bloc.dart';

class DialogState {
  final String plate;
  final List<ChatMessage> messages;
  final bool isLoading;
  final bool isScrollNeeded;

  DialogState({
    required this.plate,
    required this.messages,
    this.isLoading = false,
    this.isScrollNeeded = false,
  });

  DialogState copyWith({
    String? plate,
    List<ChatMessage>? messages,
    bool? isLoading,
    bool? isScrollNeeded,
  }) {
    return DialogState(
      messages: messages ?? this.messages,
      plate: plate ?? this.plate,
      isLoading: isLoading ?? this.isLoading,
      isScrollNeeded: isScrollNeeded ?? this.isScrollNeeded,
    );
  }
}
