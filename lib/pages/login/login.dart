import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/InputWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/MyContainerNoLG.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/colors.dart';
import 'package:jingcai_app/pages/botom_pages/widget/routes.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/pages/login/login_back.dart';
import 'package:jingcai_app/pages/login/privacy.dart';
import 'package:jingcai_app/pages/login/userServiceDue.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/loading.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'userEvent.dart';

class login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return login_();
  }
}

class login_ extends State<login> {
  final TextEditingController codeCtr = TextEditingController();
  final TextEditingController passCtr = TextEditingController();
  late bool _showCountDown = false;
  late int _countDownNum;
  Timer? _countdownTimer;
  String phone = "";
  int type = 1;
  String code = "";
  bool is_gree = false;
  String password = "";
  bool can_click = true;
  String invite_code = "";
  bool obscure = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeCtr.addListener(() {
      setState(() {
        code = codeCtr.value.text;
      });
    });

    passCtr.addListener(() {
      setState(() {
        password = passCtr.value.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset(
                "assets/images/login_logo.jpg",
                height: rpx(300),
                fit: BoxFit.cover,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: rpx(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(Icons.phone_android),
                          Container(
                            width: rpx(5),
                          ),
                          Expanded(
                              child: InputWidget(
                            hintText: '请输入手机号码',
                            hintStyle: const TextStyle(
                                color: MyColors.tip, fontSize: 14),
                            textStyle: const TextStyle(
                                color: MyColors.black_33, fontSize: 14),
                            textInputType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                phone = value;
                              });
                            },
                          )),
                        ],
                      ),
                    ),
                    Divider(
                      height: rpx(2),
                      color: Colors.grey.shade300,
                    ),
                    type == 1
                        ? Container(
                            child: Row(
                              children: [
                                Expanded(
                                    child: InputWidget(
                                  hintText: '输入验证码',
                                  hintStyle: const TextStyle(
                                      color: MyColors.tip, fontSize: 14),
                                  textStyle: const TextStyle(
                                      color: MyColors.black_33, fontSize: 14),
                                  textInputType: TextInputType.number,
                                  controller: codeCtr,
                                )),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (phone == "") {
                                        Loading.tip("uri", "请输入完整信息");
                                        return;
                                      }
                                      if (!_showCountDown) {
                                        _showCountDown = true;
                                        _countDownNum = 60;
                                        sendCode();
                                        _countdownTimer = Timer.periodic(
                                            const Duration(seconds: 1),
                                            (timer) {
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            child: Row(
                              children: [
                                Expanded(
                                    child: InputWidget(
                                  hintText: '请输入登录密码',
                                  hintStyle: const TextStyle(
                                      color: MyColors.tip, fontSize: 14),
                                  textStyle: const TextStyle(
                                      color: MyColors.black_33, fontSize: 14),
                                  obscureText: obscure,
                                  controller: passCtr,
                                )),
                                onClick(
                                    Icon(obscure
                                        ? Icons.visibility_off
                                        : Icons.visibility), () {
                                  setState(() {
                                    obscure = obscure ? false : true;
                                  });
                                })
                              ],
                            ),
                          ),
                    Divider(
                      height: rpx(2),
                      color: Colors.grey.shade300,
                    ),
                    type == 1
                        ? Container(
                            child: Row(
                              children: [
                                Expanded(
                                    child: InputWidget(
                                  hintText: '邀请码(选填)',
                                  hintStyle: const TextStyle(
                                      color: MyColors.tip, fontSize: 14),
                                  textStyle: const TextStyle(
                                      color: MyColors.black_33, fontSize: 14),
                                  onChanged: (value) {
                                    setState(() {
                                      invite_code = value;
                                      print(invite_code);
                                    });
                                  },
                                )),
                              ],
                            ),
                          )
                        : Container(),
                    type == 1
                        ? Divider(
                            height: rpx(2),
                            color: Colors.grey.shade300,
                          )
                        : Container(),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: rpx(10)),
                      child: TextWidget(
                        type == 1 ? "若该手机未注册，我们将自动为您注册" : "",
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: rpx(30),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !is_gree
                        ? onClick(
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(rpx(15)),
                                  border: Border.all(
                                      width: rpx(2), color: Colors.grey)),
                              width: rpx(15),
                              height: rpx(15),
                            ), () {
                            setGree();
                          })
                        : onClick(
                            Stack(
                              children: [
                                Container(
                                  width: rpx(15),
                                  height: rpx(15),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.red, width: rpx(1)),
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(rpx(15)),
                                  ),
                                ),
                                Positioned(
                                  left: rpx(3.5),
                                  top: rpx(3.5),
                                  child: Container(
                                    width: rpx(8),
                                    height: rpx(8),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                          BorderRadius.circular(rpx(8)),
                                    ),
                                  ),
                                )
                              ],
                            ), () {
                            setGree();
                          }),
                    Container(
                      width: rpx(5),
                    ),
                    TextWidget("我已阅读并同意"),
                    Container(
                      width: rpx(5),
                    ),
                    onClick(
                        TextWidget(
                          "《用户服务条款》",
                          color: Colors.blue,
                        ), () {
                      Routes.pushPage(userServiceDue());
                    }),
                    Container(
                      width: rpx(5),
                    ),
                    TextWidget("和"),
                    Container(
                      width: rpx(5),
                    ),
                    onClick(
                        TextWidget(
                          "隐私协议",
                          color: Colors.blue,
                        ), () {
                      Routes.pushPage(privacy());
                    })
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(rpx(25)),
                child: getBtn(),
              ),
              Container(
                child: onClick(
                    TextWidget(
                      type == 1 ? "切换为密码登录" : "切换为短信登录",
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: rpx(15),
                    ), () {
                  setState(() {
                    type = type == 1 ? 2 : 1;
                    can_click = true;
                  });
                }),
              )
            ],
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            top: rpx(10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: rpx(15)),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            "登录",
                            color: Colors.white,
                            fontSize: rpx(18),
                          ),
                          Container()
                        ],
                      ),
                      Positioned(
                          left: rpx(10),
                          child: onClick(
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ), () {
                            G.router.pop(context);
                            eventlog.fire(loginBack(false));
                          }))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getBtn() {
    if (type == 1) {
      if (phone != "" && code != "" && is_gree) {
        return can_click
            ? clickBtn("登录/注册", () {
                setState(() {
                  can_click = false;
                });
                login();
              })
            : disableBtn("登录/注册", () => null);
      } else {
        return disableBtn("登录/注册", () => null);
      }
    } else {
      if (phone != "" && password != "" && is_gree) {
        return can_click
            ? clickBtn("登录/注册", () {
                setState(() {
                  can_click = false;
                });
                login();
              })
            : disableBtn("登录/注册", () => null);
      } else {
        return disableBtn("登录/注册", () => null);
      }
    }
  }

  login() {
    G.api.user.login({
      "type": type,
      "password": password,
      "code": code,
      "phone": phone,
      "invite_code": invite_code
    }).then((value) async {
      if (value["msg"] != "ok") {
        setState(() {
          can_click = true;
        });
      } else {
        tipSucess("登录成功");
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("token", value["data"]).whenComplete(() {
          sharedPreferences.setBool("is_login", true).whenComplete(() {
            eventBus.fire(userEvent(true));
            G.router.pop(context);
          });
        });
      }
    });
  }

  setGree() {
    setState(() {
      is_gree = is_gree == true ? false : true;
    });
  }

  sendCode() {
    G.api.user.sendCode({"phone": phone, "type": "login"});
  }
}
