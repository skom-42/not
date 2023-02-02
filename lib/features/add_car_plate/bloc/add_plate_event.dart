part of 'add_plate_bloc.dart';

abstract class AddPlateEvent {}

class RouteToFirstStep implements AddPlateEvent {}

class ConfirmPlate implements AddPlateEvent {
  final String plate;

  ConfirmPlate({required this.plate});
}
