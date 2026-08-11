import 'package:asood/core/http_client/api_client.dart';
import 'package:asood/features/cart/data/data_source/cart_api_service.dart';
import 'package:asood/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:asood/features/payment/data/data_source/payment_api_service.dart';
import 'package:asood/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:asood/features/wallet/data/data_source/wallet_api_service.dart';
import 'package:asood/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:get_it/get_it.dart';

void registerCommerceModule(GetIt locator) {
  locator.registerFactory(
    () => CartApiService(dioClient: locator<DioClient>()),
  );
  locator.registerFactory(
    () => WalletApiService(dioClient: locator<DioClient>()),
  );
  locator.registerFactory(
    () => PaymentApiService(dioClient: locator<DioClient>()),
  );
  locator.registerFactory(
    () => CartBloc(cartApiService: locator<CartApiService>()),
  );
  locator.registerFactory(
    () => WalletBloc(walletApiService: locator<WalletApiService>()),
  );
  locator.registerFactory(
    () => PaymentBloc(paymentApiService: locator<PaymentApiService>()),
  );
}
