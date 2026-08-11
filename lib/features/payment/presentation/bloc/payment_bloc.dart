import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/features/payment/data/data_source/payment_api_service.dart';
import 'package:asood/features/payment/domain/models/payment_model.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentApiService paymentApiService;

  PaymentBloc({required this.paymentApiService}) : super(PaymentInitial()) {
    on<CreatePayment>(_onCreatePayment);
    on<RedirectToPayment>(_onRedirectToPayment);
    on<VerifyPayment>(_onVerifyPayment);
    on<LoadPayments>(_onLoadPayments);
    on<LoadPaymentDetail>(_onLoadPaymentDetail);
  }

  Future<void> _onCreatePayment(
    CreatePayment event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final result = await paymentApiService.createPayment(event.data);
      if (result is Success) {
        final data = result.response;
        PaymentModel? payment;
        
        if (data is Map && data.containsKey('success')) {
          final paymentData = data['data'] ?? data;
          if (paymentData is Map) {
            payment = PaymentModel.fromJson(paymentData);
          }
        } else if (data is Map) {
          payment = PaymentModel.fromJson(data);
        }
        
        emit(PaymentCreated(payment: payment));
      } else if (result is Failure) {
        emit(PaymentError(message: result.errorResponse?.toString() ?? 'Failed to create payment'));
      }
    } catch (e) {
      emit(PaymentError(message: e.toString()));
    }
  }

  Future<void> _onRedirectToPayment(
    RedirectToPayment event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentRedirecting());
    try {
      final result = await paymentApiService.redirectToPayment(event.data);
      if (result is Success) {
        final data = result.response;
        String? redirectUrl;
        
        if (data is Map && data.containsKey('success')) {
          redirectUrl = data['data']?['redirect_url']?.toString() ??
              data['redirect_url']?.toString();
        } else if (data is Map) {
          redirectUrl = data['redirect_url']?.toString();
        }
        
        emit(PaymentRedirectReady(redirectUrl: redirectUrl));
      } else if (result is Failure) {
        emit(PaymentError(message: result.errorResponse?.toString() ?? 'Failed to redirect'));
      }
    } catch (e) {
      emit(PaymentError(message: e.toString()));
    }
  }

  Future<void> _onVerifyPayment(
    VerifyPayment event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentVerifying());
    try {
      final result = await paymentApiService.verifyPayment(event.data);
      if (result is Success) {
        final data = result.response;
        PaymentModel? payment;
        
        if (data is Map && data.containsKey('success')) {
          final paymentData = data['data'] ?? data;
          if (paymentData is Map) {
            payment = PaymentModel.fromJson(paymentData);
          }
        } else if (data is Map) {
          payment = PaymentModel.fromJson(data);
        }
        
        emit(PaymentVerified(payment: payment));
      } else if (result is Failure) {
        emit(PaymentError(message: result.errorResponse?.toString() ?? 'Payment verification failed'));
      }
    } catch (e) {
      emit(PaymentError(message: e.toString()));
    }
  }

  Future<void> _onLoadPayments(
    LoadPayments event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final result = await paymentApiService.getPayments();
      if (result is Success) {
        final data = result.response;
        List<PaymentModel> payments = [];
        
        if (data is Map && data.containsKey('success')) {
          final items = data['data'] ?? [];
          if (items is List) {
            payments = items
                .map((item) => PaymentModel.fromJson(item))
                .toList();
          }
        } else if (data is List) {
          payments = data
              .map((item) => PaymentModel.fromJson(item))
              .toList();
        }
        
        emit(PaymentsLoaded(payments: payments));
      } else if (result is Failure) {
        emit(PaymentError(message: result.errorResponse?.toString() ?? 'Failed to load payments'));
      }
    } catch (e) {
      emit(PaymentError(message: e.toString()));
    }
  }

  Future<void> _onLoadPaymentDetail(
    LoadPaymentDetail event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final result = await paymentApiService.getPaymentDetail(event.paymentId);
      if (result is Success) {
        final data = result.response;
        PaymentModel? payment;
        
        if (data is Map && data.containsKey('success')) {
          final paymentData = data['data'] ?? data;
          if (paymentData is Map) {
            payment = PaymentModel.fromJson(paymentData);
          }
        } else if (data is Map) {
          payment = PaymentModel.fromJson(data);
        }
        
        emit(PaymentDetailLoaded(payment: payment));
      } else if (result is Failure) {
        emit(PaymentError(message: result.errorResponse?.toString() ?? 'Failed to load payment detail'));
      }
    } catch (e) {
      emit(PaymentError(message: e.toString()));
    }
  }
}

