import 'package:share_plus/share_plus.dart';

class ShareStore {
  static Future<void> share(String businessId) async {
    final storeUrl = Uri.https('$businessId.asoud.ir', '/').toString();
    await SharePlus.instance.share(ShareParams(text: storeUrl));
  }
}
