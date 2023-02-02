part of 'profile_bloc.dart';

class ProfileState {}

class LoadingState implements ProfileState {}

class ContentState implements ProfileState {
  final bool isHasPlate;

  ContentState({required this.isHasPlate});
}

class ErrorState implements ProfileState {}
