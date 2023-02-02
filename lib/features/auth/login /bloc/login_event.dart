part of 'login_bloc.dart';

abstract class LoginEvent {}

class InitData implements LoginEvent {}

class LoginViaEmail implements LoginEvent {
  final String email;
  final String password;

  LoginViaEmail({
    required this.email,
    required this.password,
  });
}

class LoginViaGoogle implements LoginEvent {}

class RouteToRegistration implements LoginEvent {}

class ForgotPassword implements LoginEvent {}
