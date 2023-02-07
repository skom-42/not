part of 'verify_account_bloc.dart';

abstract class VerifyAccountEvent {}

class VerifyAccount implements VerifyAccountEvent {
  final File? image;

  VerifyAccount(this.image);
}

class RouteBack implements VerifyAccountEvent {}
