import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YoutubeWebView extends StatefulWidget {
  @override
  YoutubeWebViewState createState() => YoutubeWebViewState();
}

class YoutubeWebViewState extends State<YoutubeWebView> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://www.youtube.com/',
    );
  }
}
