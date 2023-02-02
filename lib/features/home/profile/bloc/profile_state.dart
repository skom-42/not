part of 'profile_bloc.dart';

class ProfileState {}

class LoadingState implements ProfileState {}

class ContentState implements ProfileState {
  final String? plate;

  ContentState({required this.plate});
}

class ErrorState implements ProfileState {}
