// This file has the code related to the social media links which will be opening in app in the browser itself.

import 'package:flutter_web_browser/flutter_web_browser.dart';

openWebBroser(url) {
  FlutterWebBrowser.openWebPage(
    url: url,
    safariVCOptions: SafariViewControllerOptions(
      barCollapsingEnabled: true,
      dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
      modalPresentationCapturesStatusBarAppearance: true,
    ),
  );
}
