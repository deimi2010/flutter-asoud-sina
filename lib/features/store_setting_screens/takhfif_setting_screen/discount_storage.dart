import 'dart:convert';

import 'package:asood/features/store_setting_screens/takhfif_setting_screen/discount_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiscountStorage {
  const DiscountStorage();

  static const _prefix = 'market_discount_pending_v1_';

  Future<List<MarketDiscount>> load(String marketId) async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString('$_prefix$marketId');
    if (raw == null || raw.isEmpty) return [];
    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .whereType<Map<String, dynamic>>()
          .map(MarketDiscount.fromPendingJson)
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> save(String marketId, List<MarketDiscount> discounts) async {
    final preferences = await SharedPreferences.getInstance();
    final key = '$_prefix$marketId';
    if (discounts.isEmpty) {
      await preferences.remove(key);
      return;
    }
    await preferences.setString(
      key,
      jsonEncode(discounts.map((item) => item.toPendingJson()).toList()),
    );
  }
}
