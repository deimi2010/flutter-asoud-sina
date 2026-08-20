import 'dart:convert';

import 'package:asood/core/models/theme_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarketCustomizationStorage {
  static const _themePrefix = 'market_customization_theme_v1_';
  static const _themePendingPrefix = 'market_customization_theme_pending_v1_';
  static const _templatePrefix = 'market_customization_template_v1_';
  static const _templatePendingPrefix =
      'market_customization_template_pending_v1_';

  static Future<ThemeModel?> loadTheme(String marketId) async {
    final preferences = await SharedPreferences.getInstance();
    final value = preferences.getString('$_themePrefix$marketId');
    if (value == null) return null;

    try {
      return ThemeModel.fromJson(jsonDecode(value) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  static Future<void> saveTheme(
    String marketId,
    ThemeModel theme, {
    required bool pendingSync,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(
      '$_themePrefix$marketId',
      jsonEncode(theme.toJson()),
    );
    await preferences.setBool('$_themePendingPrefix$marketId', pendingSync);
  }

  static Future<bool> isThemePending(String marketId) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool('$_themePendingPrefix$marketId') ?? false;
  }

  static Future<int?> loadTemplateIndex(String marketId) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getInt('$_templatePrefix$marketId');
  }

  static Future<void> saveTemplateIndex(
    String marketId,
    int templateIndex, {
    required bool pendingSync,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt('$_templatePrefix$marketId', templateIndex);
    await preferences.setBool('$_templatePendingPrefix$marketId', pendingSync);
  }

  static Future<bool> isTemplatePending(String marketId) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool('$_templatePendingPrefix$marketId') ?? false;
  }
}
