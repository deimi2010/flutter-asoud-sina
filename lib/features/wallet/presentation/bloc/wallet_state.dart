part of 'wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final WalletModel wallet;
  final List<TransactionModel> transactions;
  final bool loadingTransactions;

  const WalletLoaded({
    required this.wallet,
    this.transactions = const [],
    this.loadingTransactions = false,
  });

  WalletLoaded copyWith({
    WalletModel? wallet,
    List<TransactionModel>? transactions,
    bool? loadingTransactions,
  }) {
    return WalletLoaded(
      wallet: wallet ?? this.wallet,
      transactions: transactions ?? this.transactions,
      loadingTransactions: loadingTransactions ?? this.loadingTransactions,
    );
  }

  @override
  List<Object?> get props => [wallet, transactions, loadingTransactions];
}

class WalletChecking extends WalletState {}

class WalletCheckResult extends WalletState {
  final bool sufficient;

  const WalletCheckResult({required this.sufficient});

  @override
  List<Object?> get props => [sufficient];
}

class WalletTransactionsLoaded extends WalletState {
  final List<TransactionModel> transactions;

  const WalletTransactionsLoaded({required this.transactions});

  @override
  List<Object?> get props => [transactions];
}

class WalletPaying extends WalletState {}

class WalletPaymentSuccess extends WalletState {
  final String message;

  const WalletPaymentSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class WalletPaymentError extends WalletState {
  final String message;

  const WalletPaymentError({required this.message});

  @override
  List<Object?> get props => [message];
}

class WalletError extends WalletState {
  final String message;

  const WalletError({required this.message});

  @override
  List<Object?> get props => [message];
}

