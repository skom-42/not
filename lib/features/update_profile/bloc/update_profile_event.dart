part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent {}

class LoadData implements UpdateProfileEvent {}

class UpdateProfile implements UpdateProfileEvent {
  final String name;
  final String surname;
  final String plate;

  UpdateProfile({
    required this.name,
    required this.surname,
    required this.plate,
  });
}
