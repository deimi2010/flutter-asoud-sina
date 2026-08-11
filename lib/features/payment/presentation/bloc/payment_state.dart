part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentCreated extends PaymentState {
  final PaymentModel? payment;

  const PaymentCreated({this.payment});

  @override
  List<Object?> get props => [payment];
}

class PaymentRedirecting extends PaymentState {}

class PaymentRedirectReady extends PaymentState {
  final String? redirectUrl;

  const PaymentRedirectReady({this.redirectUrl});

  @override
  List<Object?> get props => [redirectUrl];
}

class PaymentVerifying extends PaymentState {}

class PaymentVerified extends PaymentState {
  final PaymentModel? payment;

  const PaymentVerified({this.payment});

  @override
  List<Object?> get props => [payment];
}

class PaymentsLoaded extends PaymentState {
  final List<PaymentModel> payments;

  const PaymentsLoaded({required this.payments});

  @override
  List<Object?> get props => [payments];
}

class PaymentDetailLoaded extends PaymentState {
  final PaymentModel? payment;

  const PaymentDetailLoaded({this.payment});

  @override
  List<Object?> get props => [payment];
}

class PaymentError extends PaymentState {
  final String message;

  const PaymentError({required this.message});

  @override
  List<Object?> get props => [message];
}

