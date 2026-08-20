import 'package:asood/core/helper/market_customization_storage.dart';
import 'package:asood/core/helper/theme_color.dart';
import 'package:asood/core/models/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('keeps theme and template settings isolated by market id', () async {
    await MarketCustomizationStorage.saveTheme(
      'market-a',
      ThemeModel(color: '#112233', font: 'irs'),
      pendingSync: true,
    );
    await MarketCustomizationStorage.saveTheme(
      'market-b',
      ThemeModel(color: '#AABBCC', font: 'yekan'),
      pendingSync: false,
    );
    await MarketCustomizationStorage.saveTemplateIndex(
      'market-a',
      4,
      pendingSync: true,
    );
    await MarketCustomizationStorage.saveTemplateIndex(
      'market-b',
      9,
      pendingSync: false,
    );

    expect(
      (await MarketCustomizationStorage.loadTheme('market-a'))?.font,
      'irs',
    );
    expect(
      (await MarketCustomizationStorage.loadTheme('market-b'))?.color,
      '#AABBCC',
    );
    expect(await MarketCustomizationStorage.loadTemplateIndex('market-a'), 4);
    expect(await MarketCustomizationStorage.loadTemplateIndex('market-b'), 9);
    expect(await MarketCustomizationStorage.isThemePending('market-a'), true);
    expect(
      await MarketCustomizationStorage.isTemplatePending('market-b'),
      false,
    );
  });

  test('theme colors accept backend hashes and serialize consistently', () {
    const fallback = Colors.white;

    expect(themeColorFromHex('#112233', fallback), const Color(0xFF112233));
    expect(themeColorFromHex('AABBCC', fallback), const Color(0xFFAABBCC));
    expect(themeColorFromHex('invalid', fallback), fallback);
    expect(themeColorToHex(const Color(0xFF0A1B2C)), '#0A1B2C');
  });
}
