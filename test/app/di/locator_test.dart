import 'package:asood/core/config/app_config.dart';
import 'package:asood/core/http_client/api_client.dart';
import 'package:asood/core/storage/token_storage.dart';
import 'package:asood/features/auth/domain/repository/auth_repository.dart';
import 'package:asood/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:asood/features/create_workspace/domain/repository/create_market_repository.dart';
import 'package:asood/features/market/domain/repository/product_repository.dart';
import 'package:asood/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:asood/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:asood/locator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() => locator.reset());
  tearDown(() => locator.reset());

  test('locatorSetup registers core and feature dependencies', () async {
    await locatorSetup();

    expect(locator.isRegistered<TokenStorage>(), isTrue);
    expect(locator.isRegistered<AppConfig>(), isTrue);
    expect(locator.isRegistered<DioClient>(), isTrue);
    expect(locator.isRegistered<AuthRepository>(), isTrue);
    expect(locator.isRegistered<CreateMarketRepository>(), isTrue);
    expect(locator.isRegistered<ProductRepository>(), isTrue);
    expect(locator.isRegistered<CartBloc>(), isTrue);
    expect(locator.isRegistered<WalletBloc>(), isTrue);
    expect(locator.isRegistered<PaymentBloc>(), isTrue);
  });
}
