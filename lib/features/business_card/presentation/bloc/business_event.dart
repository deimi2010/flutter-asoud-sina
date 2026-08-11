part of 'business_bloc.dart';

abstract class BusinessEvent {}

class DetermineCurrentPosition extends BusinessEvent {}

class UpdateSelectedLocation extends BusinessEvent {
  final LatLng location;

  UpdateSelectedLocation(this.location);
}

class SaveLocation extends BusinessEvent {}

class ReadSavedLocation extends BusinessEvent {}
