part of 'customer_bloc.dart';

sealed class CustomerEvent {
  const CustomerEvent();
}

class GetCusomerStors extends CustomerEvent {}

class GetCusomerRequest extends CustomerEvent {}

class GetCusomerOrders extends CustomerEvent {}

class AcceptPayment extends CustomerEvent {
  final int id;
  const AcceptPayment(this.id);
}

class TrackPayment extends CustomerEvent {
  final int id;
  const TrackPayment(this.id);
}
