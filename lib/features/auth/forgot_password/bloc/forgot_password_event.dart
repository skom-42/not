part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent {}

class ResetPassword implements ForgotPasswordEvent {
  final String email;

  ResetPassword({
    required this.email,
  });
}

class RouteBack implements ForgotPasswordEvent {}
