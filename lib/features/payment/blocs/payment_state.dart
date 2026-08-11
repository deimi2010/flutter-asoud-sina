part of 'payment_bloc.dart';

sealed class PaymentState {
  const PaymentState();
}

final class PaymentInitial extends PaymentState {}
