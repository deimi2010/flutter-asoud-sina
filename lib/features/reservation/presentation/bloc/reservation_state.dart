part of 'reservation_bloc.dart';

sealed class ReservationState {
  const ReservationState();
}

final class ReservationInitial extends ReservationState {}
