import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';

import '../../../widget/InputWidget.dart';
import '../../../widget/PreferredSizeWidget.dart';
import '../../../widget/colors.dart';
import '../../../widget/textWidget.dart';

class PasswordSettingsPage extends StatefulWidget {
  const PasswordSettingsPage({Key? key}) : super(key: key);

  @override
  State<PasswordSettingsPage> createState() => _PasswordSettingsPageState();
}

class _PasswordSettingsPageState extends State<PasswordSettingsPage> {
  final TextEditingController _phoneEC = TextEditingController();
  final TextEditingController _captchaEC = TextEditingController();
  String pass = "";
  String repass = "";
  @override
  void initState() {
    super.initState();
    _phoneEC.addListener(() {
      setState(() {
        pass = _phoneEC.value.text;
      });
    });
    _captchaEC.addListener(() {
      setState(() {
        repass = _captchaEC.value.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('设置密码'),
      body: Container(
        color: MyColors.grey_f5,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10.w),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              alignment: Alignment.centerLeft,
              color: MyColors.white,
              child: const TextWidget('您还未设置密码，请设置'),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color(0xFFF6F6F6),
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 100,
                    child: TextWidget(
                      '新密码',
                      color: MyColors.black_33,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                      child: InputWidget(
                          hintText: '请输入新密码',
                          hintStyle: const TextStyle(
                              color: MyColors.tip, fontSize: 14),
                          textStyle: const TextStyle(
                              color: MyColors.black_33, fontSize: 14),
                          textInputType: TextInputType.number,
                          controller: _phoneEC)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: MyColors.white,
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 100,
                    child: TextWidget(
                      '确认新密码',
                      color: MyColors.black_33,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: InputWidget(
                      hintText: '请再次确认新密码',
                      hintStyle:
                          const TextStyle(color: MyColors.tip, fontSize: 14),
                      textStyle: const TextStyle(
                          color: MyColors.black_33, fontSize: 14),
                      textInputType: TextInputType.number,
                      controller: _captchaEC,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100.w,
            ),
            pass.isNotEmpty && repass.isNotEmpty && pass == repass
                ? clickBtn('提交', () {
                    G.api.user.editPass({"pass": pass, "repass": repass}).then(
                        (value) {
                      if (value == "yes") {
                        tipSucess("修改成功");
                      }
                    });
                  })
                : disableBtn("提交", () => null),
          ],
        ),
      ),
    );
  }
}
