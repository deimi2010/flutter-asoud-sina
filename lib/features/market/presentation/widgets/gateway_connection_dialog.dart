import 'dart:async';
import 'dart:convert';

import 'package:asood/core/constants/endpoints.dart';
import 'package:asood/core/http_client/api_client.dart';
import 'package:asood/core/http_client/api_status.dart';
import 'package:asood/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum MarketGatewayType { asoud, personal }

class MarketGatewayDraft {
  const MarketGatewayDraft({
    required this.type,
    this.userCode = '',
    this.pendingSync = true,
  });

  final MarketGatewayType type;
  final String userCode;
  final bool pendingSync;

  Map<String, dynamic> toJson() => {
    'gateway_type': type.name,
    'pending_sync': pendingSync,
  };

  factory MarketGatewayDraft.fromJson(
    Map<String, dynamic> json, {
    String userCode = '',
  }) {
    return MarketGatewayDraft(
      type:
          json['gateway_type'] == MarketGatewayType.personal.name
              ? MarketGatewayType.personal
              : MarketGatewayType.asoud,
      userCode: userCode,
      pendingSync: json['pending_sync'] != false,
    );
  }
}

class MarketGatewayStorage {
  static const _keyPrefix = 'market_gateway_request_v1_';
  static const _codeKeyPrefix = 'market_gateway_user_code_v1_';
  static const _secureStorage = FlutterSecureStorage();

  static Future<MarketGatewayDraft?> load(String marketId) async {
    final preferences = await SharedPreferences.getInstance();
    final value = preferences.getString('$_keyPrefix$marketId');
    if (value == null) return null;
    try {
      return MarketGatewayDraft.fromJson(
        jsonDecode(value) as Map<String, dynamic>,
        userCode:
            await _secureStorage.read(key: '$_codeKeyPrefix$marketId') ?? '',
      );
    } catch (_) {
      return null;
    }
  }

  static Future<void> save(String marketId, MarketGatewayDraft draft) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(
      '$_keyPrefix$marketId',
      jsonEncode(draft.toJson()),
    );
    if (draft.type == MarketGatewayType.personal && draft.userCode.isNotEmpty) {
      await _secureStorage.write(
        key: '$_codeKeyPrefix$marketId',
        value: draft.userCode,
      );
    } else {
      await _secureStorage.delete(key: '$_codeKeyPrefix$marketId');
    }
  }
}

enum _GatewayChoice { asoud, personal }

Future<void> showGatewayConnectionDialog(
  BuildContext context, {
  required String marketId,
}) async {
  if (marketId.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('شناسه فروشگاه در دسترس نیست.')),
    );
    return;
  }

  final previousDraft = await MarketGatewayStorage.load(marketId);
  if (previousDraft?.pendingSync == true) {
    unawaited(_syncGatewayDraft(marketId, previousDraft!));
  }
  if (!context.mounted) return;

  final choice = await showDialog<_GatewayChoice>(
    context: context,
    builder:
        (dialogContext) => AlertDialog(
          title: const Text('درخواست اتصال به درگاه'),
          content: const Text(
            'درگاه موردنظر را انتخاب کنید. اتصال به درگاه مستلزم احراز شرایط درج‌شده در قوانین سایت است.',
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('بعداً'),
            ),
            OutlinedButton(
              onPressed:
                  () => Navigator.pop(dialogContext, _GatewayChoice.personal),
              child: const Text('درگاه شخصی'),
            ),
            FilledButton(
              onPressed:
                  () => Navigator.pop(dialogContext, _GatewayChoice.asoud),
              child: const Text('درگاه آسود'),
            ),
          ],
        ),
  );

  if (choice == null || !context.mounted) return;
  if (choice == _GatewayChoice.personal) {
    final userCode = await _requestPersonalGatewayCode(context);
    if (userCode == null || !context.mounted) return;
    await _saveGatewayDraft(
      context,
      marketId,
      MarketGatewayDraft(type: MarketGatewayType.personal, userCode: userCode),
    );
    return;
  }

  await _saveGatewayDraft(
    context,
    marketId,
    const MarketGatewayDraft(type: MarketGatewayType.asoud),
  );
}

Future<String?> _requestPersonalGatewayCode(BuildContext context) async {
  final controller = TextEditingController();
  String? errorText;
  final result = await showDialog<String>(
    context: context,
    builder:
        (dialogContext) => StatefulBuilder(
          builder:
              (context, setState) => AlertDialog(
                title: const Text('ثبت درگاه شخصی'),
                content: TextField(
                  controller: controller,
                  autofocus: true,
                  maxLength: 255,
                  textDirection: TextDirection.ltr,
                  decoration: InputDecoration(
                    labelText: 'کد کاربری درگاه خود را وارد کنید',
                    errorText: errorText,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text('بعداً'),
                  ),
                  FilledButton(
                    onPressed: () {
                      final value = controller.text.trim();
                      if (value.isEmpty) {
                        setState(() {
                          errorText = 'وارد کردن کد کاربری درگاه الزامی است.';
                        });
                        return;
                      }
                      Navigator.pop(dialogContext, value);
                    },
                    child: const Text('ثبت'),
                  ),
                ],
              ),
        ),
  );
  controller.dispose();
  return result;
}

Future<void> _saveGatewayDraft(
  BuildContext context,
  String marketId,
  MarketGatewayDraft draft,
) async {
  await MarketGatewayStorage.save(marketId, draft);
  unawaited(_syncGatewayDraft(marketId, draft));
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        'درخواست اتصال درگاه ذخیره شد و پس از دسترسی به سرور برای بررسی ارسال می‌شود.',
      ),
    ),
  );
}

Future<void> _syncGatewayDraft(
  String marketId,
  MarketGatewayDraft draft,
) async {
  try {
    final response = await locator<DioClient>()
        .postData('${Endpoints.ownerGateway}/$marketId/', {
          'gateway_type': draft.type.name,
          if (draft.type == MarketGatewayType.personal)
            'user_code': draft.userCode,
        });
    if (apiStatus(response) is Success) {
      await MarketGatewayStorage.save(
        marketId,
        MarketGatewayDraft(
          type: draft.type,
          userCode: draft.userCode,
          pendingSync: false,
        ),
      );
    }
  } catch (_) {
    // The local request remains pending and will be retried next time.
  }
}
