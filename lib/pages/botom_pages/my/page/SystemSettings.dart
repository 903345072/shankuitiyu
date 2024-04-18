import 'package:flutter/material.dart';
import '../../widget/PreferredSizeWidget.dart';
import '../../widget/colors.dart';
import '../../widget/routes.dart';
import '../../widget/textWidget.dart';
import 'GoalReminderSettingsPage.dart';
import 'InformationProtectionSettingsPage.dart';
import 'PushSettingsPage.dart';
import 'WebViewPage.dart';

class SystemSettings extends StatefulWidget {
  const SystemSettings({Key? key}) : super(key: key);

  @override
  State<SystemSettings> createState() => _SystemSettingsState();
}

class _SystemSettingsState extends State<SystemSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('系统设置'),
      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: <Widget>[
            buildRow('隐私协议', () {
              Routes.pushPage(const WebViewPage(
                title: '隐私协议',
              ));
            }),
            buildRow('用户服务条款', () {
              Routes.pushPage(const WebViewPage(
                title: '用户服务条款',
              ));
            }),
            buildRow('推送设置', () {
              Routes.pushPage(const PushSettingsPage());
            }),
            buildRow('进球提醒设置', () {
              Routes.pushPage(const GoalReminderSettingsPage());
            }),
            buildRow('个人信息保护设置', () {
              Routes.pushPage(const InformationProtectionSettingsPage());
            }),
          ],
        ),
      ),
    );
  }
}
