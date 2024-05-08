import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';
import '../../widget/PreferredSizeWidget.dart';

class WebViewPage extends StatelessWidget {
  final String title;
  const WebViewPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("福神体育隐私协议"),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(rpx(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  "尊敬的用户： ",
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: rpx(10),
                ),
                TextWidget(
                  "鲸猜足球应用是由厦门精彩智胜体育有限公司(以下简称“精彩智胜公司”)提供的一款供球迷交流沟通的体育社区服务平台产品。精彩智胜公司尊重和保护用户的隐私。本隐私政策将告诉您鲸猜足球应用如何收集和使用有关您的信息，以及我们如何保护这些信息的安全。 您成为鲸猜足球用户前务必仔细阅读本隐私条款并同意所有隐私条款。本隐私政策条款在您注册成为鲸猜足球用户后立即生效，并对您及鲸猜足球应用产生约束力。 ",
                  maxLines: 20,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: rpx(10),
                ),
                TextWidget(
                  "鲸猜足球应用可能收集的用户信息  ",
                  maxLines: 20,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
