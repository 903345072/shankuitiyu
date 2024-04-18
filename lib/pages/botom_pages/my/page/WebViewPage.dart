import 'package:flutter/material.dart';
import '../../widget/PreferredSizeWidget.dart';

class WebViewPage extends StatelessWidget {
  final String title;
  const WebViewPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title),
      body: Text("123"),
    );
  }
}
