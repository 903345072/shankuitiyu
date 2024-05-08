import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:webview_flutter/webview_flutter.dart';

class userServiceDue extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return userServiceDue_();
  }
  //福神体育服务条款
}

class userServiceDue_ extends State<userServiceDue> {
  WebViewController controller = WebViewController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('http://www.baidu.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse("http://47.122.18.242:83/common/index/userDue"));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: appbar("福神体育服务条款"),
      body: Container(
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
