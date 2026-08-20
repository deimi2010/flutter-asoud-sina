import 'package:asood/core/formatters/lowercase_text_formatter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('converts input to lowercase without moving the selection', () {
    const formatter = LowerCaseTextFormatter();
    const value = TextEditingValue(
      text: 'My-Shop',
      selection: TextSelection.collapsed(offset: 7),
    );

    final result = formatter.formatEditUpdate(TextEditingValue.empty, value);

    expect(result.text, 'my-shop');
    expect(result.selection, value.selection);
  });
}
