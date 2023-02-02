part of 'update_profile_bloc.dart';

abstract class UpdateProfileState {}

class LoadingState implements UpdateProfileState {}

class ContentState implements UpdateProfileState {
  final CustomUser? customUser;

  ContentState({
    required this.customUser,
  });
}
