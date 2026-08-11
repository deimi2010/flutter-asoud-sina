part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class CreatePayment extends PaymentEvent {
  final Map<String, dynamic> data;

  const CreatePayment(this.data);

  @override
  List<Object?> get props => [data];
}

class RedirectToPayment extends PaymentEvent {
  final Map<String, dynamic> data;

  const RedirectToPayment(this.data);

  @override
  List<Object?> get props => [data];
}

class VerifyPayment extends PaymentEvent {
  final Map<String, dynamic> data;

  const VerifyPayment(this.data);

  @override
  List<Object?> get props => [data];
}

class LoadPayments extends PaymentEvent {
  const LoadPayments();
}

class LoadPaymentDetail extends PaymentEvent {
  final String paymentId;

  const LoadPaymentDetail(this.paymentId);

  @override
  List<Object?> get props => [paymentId];
}

