import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/pages/login/userEvent.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cancelAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return cancelAccount_();
  }
}

class cancelAccount_ extends State<cancelAccount> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: appbar("申请注销账号"),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                padding: EdgeInsets.all(rpx(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      "账号注销是不可恢复的操作，为了保证你的账号安全请您谨慎操作",
                      textAlign: TextAlign.left,
                      maxLines: 30,
                    ),
                    SizedBox(
                      height: rpx(15),
                    ),
                    TextWidget(
                      "注销成功后，您将无法登录或使用福神体育账号内的信息，包括但不限于",
                      textAlign: TextAlign.left,
                      maxLines: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: rpx(15),
                    ),
                    TextWidget(
                      "1、无法使用本账号登录、授权登录或跳转第三方及使用服务。手机号绑定的微信账号，注销账号时，手机号关联的微信号账号信息也会一并注销。 ",
                      textAlign: TextAlign.left,
                      maxLines: 30,
                    ),
                    SizedBox(
                      height: rpx(15),
                    ),
                    TextWidget(
                      "2、无法查看账号信息、及账号内的搜索记录。",
                      textAlign: TextAlign.left,
                      maxLines: 11,
                    ),
                    SizedBox(
                      height: rpx(15),
                    ),
                    TextWidget(
                      "   ---包括但不仅限于福神体育购买记录、订单信息、收藏、购买等内容。注销后将被清空且无法恢复。 ",
                      textAlign: TextAlign.left,
                      maxLines: 11,
                    ),
                    SizedBox(
                      height: rpx(15),
                    ),
                    TextWidget(
                      " 3、基于本账号所获得的全部虚拟权益均视为您自行放弃且无法恢复使用。 ",
                      textAlign: TextAlign.left,
                      maxLines: 11,
                    ),
                    SizedBox(
                      height: rpx(15),
                    ),
                    TextWidget(
                      "在你提交的注册申请生效前，需同时满足以下条件:",
                      textAlign: TextAlign.left,
                      maxLines: 11,
                    ),
                    SizedBox(
                      height: rpx(15),
                    ),
                    TextWidget(
                      "1、账号财产已结清:没有资产、欠款、未结清的资金和虚拟权益。注销后红币、积分等将被清零。 ",
                      textAlign: TextAlign.left,
                      maxLines: 11,
                    ),
                    SizedBox(
                      height: rpx(15),
                    ),
                    TextWidget(
                      " 2、账号处于安全状态:账号处于正常使用状态、无被盗风险 ",
                      textAlign: TextAlign.left,
                      maxLines: 11,
                    ),
                    SizedBox(
                      height: rpx(15),
                    ),
                    TextWidget(
                      " 3、账号无任何纠纷，包括投诉举报。本账号及账号接入的第三方中没有未完成或存在争议的服务。 ",
                      textAlign: TextAlign.left,
                      maxLines: 11,
                    ),
                    SizedBox(
                      height: rpx(15),
                    ),
                    TextWidget(
                      " 4、您承诺您的福神体育账号注销申请一经提交，您不会以任何理由要求撤回注销该账号的申请 ",
                      textAlign: TextAlign.left,
                      maxLines: 11,
                    ),
                    SizedBox(
                      height: rpx(15),
                    ),
                    TextWidget(
                      " 5、注销福神体育账号后，我们会根据相关法律法规、福神体育服务协议以及隐私政策，处理该账号的相关个人信息，包括但不限于删除、匿名化处理，或者依约定或法律规定在特定期间内保存等。 ",
                      textAlign: TextAlign.left,
                      maxLines: 11,
                    ),
                    SizedBox(
                      height: rpx(115),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
              bottom: rpx(30),
              left: rpx(50),
              right: rpx(50),
              child: clickBtn("已清楚风险，确认注销", () {
                G.api.user.cancelUser({}).then((value) async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.setString("token", "");
                  sharedPreferences.setBool("is_login", false).whenComplete(() {
                    eventBus.fire(userEvent(false));
                    G.router.pop(context, "logout");
                  });
                });
              }))
        ],
      ),
    );
  }
}
