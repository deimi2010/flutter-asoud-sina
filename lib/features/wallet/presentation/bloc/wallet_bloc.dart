import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/features/wallet/data/data_source/wallet_api_service.dart';
import 'package:asood/features/wallet/domain/models/wallet_model.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletApiService walletApiService;

  WalletBloc({required this.walletApiService}) : super(WalletInitial()) {
    on<LoadWalletBalance>(_onLoadWalletBalance);
    on<CheckWalletBalance>(_onCheckWalletBalance);
    on<LoadTransactions>(_onLoadTransactions);
    on<PayWithWallet>(_onPayWithWallet);
  }

  Future<void> _onLoadWalletBalance(
    LoadWalletBalance event,
    Emitter<WalletState> emit,
  ) async {
    emit(WalletLoading());
    try {
      final result = await walletApiService.getBalance();
      if (result is Success) {
        final data = result.response;
        WalletModel wallet;
        
        if (data is Map && data.containsKey('success')) {
          wallet = WalletModel.fromJson(data['data'] ?? data);
        } else {
          wallet = WalletModel.fromJson(data);
        }
        
        emit(WalletLoaded(wallet: wallet));
      } else if (result is Failure) {
        emit(WalletError(message: result.errorResponse?.toString() ?? 'Failed to load wallet'));
      }
    } catch (e) {
      emit(WalletError(message: e.toString()));
    }
  }

  Future<void> _onCheckWalletBalance(
    CheckWalletBalance event,
    Emitter<WalletState> emit,
  ) async {
    emit(WalletChecking());
    try {
      final result = await walletApiService.checkBalance(event.amount);
      if (result is Success) {
        final data = result.response;
        bool sufficient = false;
        
        if (data is Map) {
          sufficient = data['success'] == true;
        }
        
        emit(WalletCheckResult(sufficient: sufficient));
      } else if (result is Failure) {
        emit(WalletCheckResult(sufficient: false));
      }
    } catch (e) {
      emit(WalletError(message: e.toString()));
    }
  }

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<WalletState> emit,
  ) async {
    if (state is WalletLoaded) {
      emit((state as WalletLoaded).copyWith(loadingTransactions: true));
    }
    
    try {
      final result = await walletApiService.getTransactions();
      if (result is Success) {
        final data = result.response;
        List<TransactionModel> transactions = [];
        
        if (data is Map && data.containsKey('success')) {
          final items = data['data'] ?? [];
          if (items is List) {
            transactions = items
                .map((item) => TransactionModel.fromJson(item))
                .toList();
          }
        } else if (data is List) {
          transactions = data
              .map((item) => TransactionModel.fromJson(item))
              .toList();
        }
        
        if (state is WalletLoaded) {
          emit((state as WalletLoaded).copyWith(
            transactions: transactions,
            loadingTransactions: false,
          ));
        } else {
          emit(WalletTransactionsLoaded(transactions: transactions));
        }
      } else if (result is Failure) {
        if (state is WalletLoaded) {
          emit((state as WalletLoaded).copyWith(loadingTransactions: false));
        }
        emit(WalletError(message: result.errorResponse?.toString() ?? 'Failed to load transactions'));
      }
    } catch (e) {
      if (state is WalletLoaded) {
        emit((state as WalletLoaded).copyWith(loadingTransactions: false));
      }
      emit(WalletError(message: e.toString()));
    }
  }

  Future<void> _onPayWithWallet(
    PayWithWallet event,
    Emitter<WalletState> emit,
  ) async {
    emit(WalletPaying());
    try {
      final result = await walletApiService.payWithWallet(event.data);
      if (result is Success) {
        emit(WalletPaymentSuccess(message: result.message ?? 'Payment successful'));
        add(const LoadWalletBalance());
      } else if (result is Failure) {
        emit(WalletPaymentError(message: result.errorResponse?.toString() ?? 'Payment failed'));
      }
    } catch (e) {
      emit(WalletPaymentError(message: e.toString()));
    }
  }
}

