import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jingcai_app/model/userModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';

import 'package:jingcai_app/pages/login/userEvent.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widget/routes.dart';
import '../../../widget/textWidget.dart';
import 'AvatarSettingsPage.dart';
import 'ChangeThePhoneBindingPage.dart';
import 'NicknameSettingsPage.dart';
import 'PasswordSettingsPage.dart';

class AccountSettingsPage extends StatefulWidget {
  userModel? user;
  Function d;
  AccountSettingsPage({Key? key, required this.user, required this.d})
      : super(key: key);

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('账户设置'),
      body: Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: <Widget>[
            buildRow(
              '头像',
              () {
                Routes.pushPage(AvatarSettingsPage(
                  url: widget.user?.avatar,
                  dd: (e) {
                    setState(() {
                      widget.user?.avatar = e;
                    });
                    widget.d(widget.user);
                  },
                ));
              },
              widget: Container(
                alignment: Alignment.centerRight,
                width: rpx(50),
                height: rpx(50),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    rpx(50),
                  ),
                  child: netImg(widget.user?.avatar, rpx(50), rpx(50)),
                ),
              ),
            ),
            buildRow(
              '昵称',
              () {
                Routes.pushPage(NicknameSettingsPage(
                  name: widget.user?.realName,
                  dd: (e) {
                    setState(() {
                      widget.user?.realName = e;
                    });
                    widget.d(widget.user);
                  },
                ));
              },
              text: "${widget.user?.realName.toString()}",
            ),
            buildRow(
              '手机',
              () {
                Routes.pushPage(ChangeThePhoneBindingPage(
                  phone: widget.user!.phone,
                  dd: (e) {
                    setState(() {
                      widget.user?.phone = e;
                    });
                    widget.d(widget.user);
                  },
                ));
              },
              text: widget.user!.phone!.substring(0, 3) +
                  "****" +
                  widget.user!.phone!.substring(7),
            ),
            buildRow(
              '修改密码',
              () {
                Routes.pushPage(const PasswordSettingsPage());
              },
            ),
            // buildRow(
            //   '注销账户',
            //   () {},
            // ),
            onClick(
                Container(
                  margin: EdgeInsets.only(top: 30.w),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  color: Colors.white,
                  child: const TextWidget(
                    '退出账户',
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ), () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.setString("token", "");
              sharedPreferences.setBool("is_login", false).whenComplete(() {
                eventBus.fire(userEvent(false));
                G.router.pop(context);
              });
            })
          ],
        ),
      ),
    );
  }
}
