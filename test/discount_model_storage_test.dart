import 'package:asood/features/store_setting_screens/takhfif_setting_screen/discount_model.dart';
import 'package:asood/features/store_setting_screens/takhfif_setting_screen/discount_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('API status and counters are parsed from real discount data', () {
    final discount = MarketDiscount.fromApi({
      'id': 'discount-1',
      'title': 'تابستانه',
      'description': 'برای مشتریان فروشگاه',
      'code': 'ABC123XYZ',
      'percentage': 20,
      'limitation': 10,
      'consumed': 4,
      'reserved': 0,
      'remaining': 6,
      'status': 'active',
      'created_at': '2026-08-20T10:00:00Z',
    });

    expect(discount.status, MarketDiscountStatus.active);
    expect(discount.canShare, isTrue);
    expect(discount.remaining, 6);
  });

  test('pending discounts are stored separately for each market', () async {
    SharedPreferences.setMockInitialValues({});
    const storage = DiscountStorage();
    final pending = MarketDiscount(
      id: 'request-1',
      clientRequestId: 'request-1',
      title: 'افتتاحیه',
      description: 'ویژه افتتاحیه',
      percentage: 15,
      limitation: 5,
      consumed: 0,
      reserved: 0,
      createdAt: DateTime.utc(2026, 8, 20),
      status: MarketDiscountStatus.pending,
    );

    await storage.save('market-a', [pending]);

    expect(await storage.load('market-a'), hasLength(1));
    expect(await storage.load('market-b'), isEmpty);
    expect((await storage.load('market-a')).single.canShare, isFalse);
  });
}
