part of 'add_plate_bloc.dart';

abstract class AddPlateState {}

class ConditionState implements AddPlateState {}

class AddCarPlateFirstStep implements AddPlateState {}

class AddCarThirdStep implements AddPlateState {
  final String? plate;

  AddCarThirdStep({required this.plate});
}

class InformationState implements AddPlateState {
  final String? plate;

  InformationState({required this.plate});
}
