import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class DetailNews extends StatelessWidget {
  final String newsUrl;
  DetailNews(this.newsUrl);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebviewScaffold(
        url: newsUrl,
      ),
    );
  }
}
