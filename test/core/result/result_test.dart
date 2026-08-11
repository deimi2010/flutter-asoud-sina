import 'package:asood/core/error/failure.dart';
import 'package:asood/core/result/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Result', () {
    test('fold returns the success branch value', () {
      const result = SuccessResult<int>(42);

      final value = result.fold(
        onSuccess: (value) => 'value:$value',
        onFailure: (_) => 'failure',
      );

      expect(value, 'value:42');
    });

    test('fold returns the failure branch value', () {
      const failure = NetworkFailure(message: 'offline');
      const result = FailureResult<int>(failure);

      final value = result.fold(
        onSuccess: (value) => 'value:$value',
        onFailure: (failure) => failure.message,
      );

      expect(value, 'offline');
    });
  });
}
