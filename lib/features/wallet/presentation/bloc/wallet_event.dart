part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object?> get props => [];
}

class LoadWalletBalance extends WalletEvent {
  const LoadWalletBalance();
}

class CheckWalletBalance extends WalletEvent {
  final double amount;

  const CheckWalletBalance(this.amount);

  @override
  List<Object?> get props => [amount];
}

class LoadTransactions extends WalletEvent {
  const LoadTransactions();
}

class PayWithWallet extends WalletEvent {
  final Map<String, dynamic> data;

  const PayWithWallet(this.data);

  @override
  List<Object?> get props => [data];
}

