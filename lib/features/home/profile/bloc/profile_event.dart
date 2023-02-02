part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class LoadData implements ProfileEvent {}

class RouteToAddCarPlate implements ProfileEvent {}

class PrintDocument implements ProfileEvent {
  final Image image;

  PrintDocument({required this.image});
}
