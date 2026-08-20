import 'package:asood/features/market/presentation/widgets/gateway_connection_dialog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
  });

  test('keeps gateway requests isolated by market id', () async {
    await MarketGatewayStorage.save(
      'market-a',
      const MarketGatewayDraft(type: MarketGatewayType.asoud),
    );
    await MarketGatewayStorage.save(
      'market-b',
      const MarketGatewayDraft(
        type: MarketGatewayType.personal,
        userCode: 'merchant-b',
        pendingSync: false,
      ),
    );

    final first = await MarketGatewayStorage.load('market-a');
    final second = await MarketGatewayStorage.load('market-b');

    expect(first?.type, MarketGatewayType.asoud);
    expect(first?.pendingSync, true);
    expect(second?.type, MarketGatewayType.personal);
    expect(second?.userCode, 'merchant-b');
    expect(second?.pendingSync, false);
  });
}
