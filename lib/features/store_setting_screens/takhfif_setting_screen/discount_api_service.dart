import 'package:asood/core/constants/endpoints.dart';
import 'package:asood/core/http_client/api_client.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/features/store_setting_screens/takhfif_setting_screen/discount_model.dart';

class DiscountApiService {
  const DiscountApiService(this._client);

  final DioClient _client;

  Future<List<MarketDiscount>> list(String marketId) async {
    final response = await _client.getData(
      Endpoints.discountOwnerList,
      queryParameters: {'market_id': marketId},
    );
    final result = apiStatus(response);
    if (result is! Success || result.response is! List) {
      throw StateError('دریافت کدهای تخفیف ناموفق بود');
    }
    return (result.response as List<dynamic>)
        .whereType<Map<String, dynamic>>()
        .map(MarketDiscount.fromApi)
        .toList();
  }

  Future<MarketDiscount> create(String marketId, MarketDiscount pending) async {
    final response = await _client.postData(
      Endpoints.discountOwnerCreate,
      pending.toCreatePayload(marketId),
    );
    final result = apiStatus(response);
    if (result is! Success || result.response is! Map) {
      throw StateError('ساخت کد تخفیف ناموفق بود');
    }
    return MarketDiscount.fromApi(
      Map<String, dynamic>.from(result.response as Map),
    );
  }

  Future<MarketDiscount> deactivate(String discountId) async {
    final response = await _client.patchData(
      Endpoints.discountOwnerDetail(discountId),
      {'is_active': false},
    );
    final result = apiStatus(response);
    if (result is! Success || result.response is! Map) {
      throw StateError('غیرفعال‌سازی کد تخفیف ناموفق بود');
    }
    return MarketDiscount.fromApi(
      Map<String, dynamic>.from(result.response as Map),
    );
  }
}
