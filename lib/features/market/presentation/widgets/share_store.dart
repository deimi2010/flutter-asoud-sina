// import 'package:share_plus/share_plus.dart';

import 'package:url_launcher/url_launcher.dart';

class ShareStore {
  static share(String storeLink) {
    launchUrl(Uri.parse('http://$storeLink.asoud.ir/'));
    // SharePlus.instance.share(ShareParams(text: 'http://$storeLink.aosud.ir/'));
    // await SharePlus.instance.share(ShareParams(text: storeLink));
  }
}
