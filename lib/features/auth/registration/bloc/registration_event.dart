part of 'registration_bloc.dart';

abstract class RegistrationEvent {}

class RegisterUser implements RegistrationEvent {
  final String name;
  final String surname;
  final String email;
  final String password;

  RegisterUser({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });
}

class OpenWebView implements RegistrationEvent {}
