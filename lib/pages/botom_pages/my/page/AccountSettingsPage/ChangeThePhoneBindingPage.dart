import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/loading.dart';

import '../../../widget/InputWidget.dart';
import '../../../widget/MyContainerNoLG.dart';
import '../../../widget/PreferredSizeWidget.dart';
import '../../../widget/colors.dart';
import '../../../widget/textWidget.dart';

class ChangeThePhoneBindingPage extends StatefulWidget {
  String? phone;
  Function dd;
  ChangeThePhoneBindingPage({Key? key, required this.phone, required this.dd})
      : super(key: key);

  @override
  State<ChangeThePhoneBindingPage> createState() =>
      _ChangeThePhoneBindingPageState();
}

class _ChangeThePhoneBindingPageState extends State<ChangeThePhoneBindingPage> {
  final TextEditingController _phoneEC = TextEditingController();
  final TextEditingController _captchaEC = TextEditingController();
  late bool _showCountDown = false;
  late int _countDownNum;
  Timer? _countdownTimer;
  String phone = "";
  String code = "";
  @override
  void initState() {
    if (widget.phone != null) {
      _phoneEC.text = widget.phone!;
      setState(() {
        phone = widget.phone!;
      });
    }

    super.initState();
    _phoneEC.addListener(() {
      setState(() {
        phone = _phoneEC.value.text;
      });
    });
    _captchaEC.addListener(() {
      setState(() {
        code = _captchaEC.value.text;
      });
    });
  }

  sendCode() {
    G.api.user.sendCode({"phone": _phoneEC.text, "type": "changePhone"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('换绑手机'),
      body: Container(
        color: MyColors.grey_f5,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: MyColors.white,
              child: Row(
                children: <Widget>[
                  const TextWidget(
                    '手机号',
                    color: MyColors.black_33,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                      child: InputWidget(
                          hintText: '请输入手机号码',
                          hintStyle: const TextStyle(
                              color: MyColors.tip, fontSize: 14),
                          textStyle: const TextStyle(
                              color: MyColors.black_33, fontSize: 14),
                          textInputType: TextInputType.number,
                          controller: _phoneEC)),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (!_showCountDown) {
                          _showCountDown = true;
                          _countDownNum = 60;
                          sendCode();
                          _countdownTimer = Timer.periodic(
                              const Duration(seconds: 1), (timer) {
                            if (mounted) {
                              setState(() {
                                if (_countDownNum > 1) {
                                  _countDownNum--;
                                } else {
                                  _showCountDown = false;
                                  if (_countdownTimer != null) {
                                    _countdownTimer?.cancel();
                                    _countdownTimer = null;
                                  }
                                }
                              });
                            }
                          });
                        }
                      });
                    },
                    child: MyContainerNoLG(
                      _showCountDown
                          ? (_countDownNum.toString() + '秒后重发')
                          : "获取验证码",
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: MyColors.white,
              child: Row(
                children: <Widget>[
                  const TextWidget(
                    '验证码',
                    color: MyColors.black_33,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InputWidget(
                      hintText: '请输入验证码',
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
            phone.isNotEmpty && code.isNotEmpty
                ? clickBtn('验证后绑定新手机', () {
                    G.api.user.editPhone({"phone": phone, "code": code}).then(
                        (value) {
                      if (value == "yes") {
                        tipSucess("修改成功");
                        widget.dd(phone);
                      }
                    });
                  })
                : disableBtn("验证后绑定手机", () => null),
          ],
        ),
      ),
    );
  }
}
