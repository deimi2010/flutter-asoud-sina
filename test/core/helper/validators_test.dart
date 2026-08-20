import 'package:asood/core/helper/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('businessId', () {
    test('accepts a valid subdomain label', () {
      expect(Validators.businessId('my-shop2'), isNull);
    });

    test('rejects Persian characters and whitespace', () {
      expect(Validators.businessId('فروشگاه'), isNotNull);
      expect(Validators.businessId('my shop'), isNotNull);
    });

    test('rejects invalid hyphen placement and short values', () {
      expect(Validators.businessId('-shop'), isNotNull);
      expect(Validators.businessId('shop-'), isNotNull);
      expect(Validators.businessId('my--shop'), isNotNull);
      expect(Validators.businessId('shop'), isNotNull);
    });
  });
}
