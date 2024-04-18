import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jingcai_app/components/payWidget.dart';
import 'package:jingcai_app/model/jcFootMetModel.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/model/userModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/pages/home_pages/planPreview.dart';
import 'package:jingcai_app/pages/home_pages/talentBattleChart.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class planDetail extends StatefulWidget {
  int? uid;
  Map plan = {};

  userModel user = userModel.fromJson({"uid": 1, "fans": 0});

  planDetail({required this.user, required this.uid, required this.plan});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return talentDetail_();
  }
}

class talentDetail_ extends State<planDetail> {
  int fans = 0;
  Map games = {};
  Map? mets;
  int is_buy = 0;
  List buy_user = [];
  List payList = [];
  String? _selectedPayment = "pay1";
  double money = 0;
  bool is_click = true;
  Map userBattle = {};
  void initState() {
    super.initState();
    getPlanDetail();
    _startCountdown();
    totalSeconds = widget.plan["rest_time"] > 0 ? widget.plan["rest_time"] : 0;
  }

  getPlanDetail() async {
    G.api.user.getPlanDetail({"id": widget.plan["id"]}).then((value) {
      setState(() {
        games = value["games"];
        is_buy = value["is_buy"];
        buy_user = value["buy_user"];
        money = double.parse(value["money"] ?? "0");
        userBattle["fans_count"] = widget.user.fans;
        userBattle["is_subscribe"] = value["is_subscribe"];
        userBattle["plan_count"] = value["plan_count"];
      });
    });
  }

  void _startCountdown() {
    const oneSec = Duration(seconds: 1);

    _timer = Timer.periodic(oneSec, (Timer t) {
      setState(() {
        if (totalSeconds > 0) {
          totalSeconds--;
        } else {
          t.cancel();

          // 这里可以添加倒计时结束时的处理逻辑
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _timer?.cancel();
  }

  int totalSeconds = 10; // 假设这是你的初始倒计时时间（以秒为单位）

  Timer? _timer;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: TextWidget(
            "方案详情",
            color: Colors.white,
            fontSize: rpx(18),
          ),
          centerTitle: true,
          leading: onClick(
              const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ), () {
            G.router.pop(context);
          }),
          backgroundColor: Colors.red,
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                userBattle.isNotEmpty
                    ? Container(
                        color: Colors.red,
                        padding: EdgeInsets.all(rpx(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: rpx(3)),
                                      child: CircleAvatar(
                                        radius: rpx(25),
                                        backgroundImage: NetworkImage(
                                          widget.user.avatar.toString(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: rpx(18),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          widget.user.realName.toString(),
                                          color: Colors.white,
                                          fontSize: rpx(25),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          spacing: rpx(5),
                                          children: [
                                            TextWidget(
                                              "${userBattle["fans_count"]}粉丝",
                                              color: Colors.white,
                                            ),
                                            TextWidget(
                                              "|",
                                              color: Colors.white,
                                              fontSize: rpx(14),
                                            ),
                                            TextWidget(
                                              "${userBattle["plan_count"]}方案",
                                              color: Colors.white,
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                getFlowButton(userBattle["is_subscribe"])
                              ],
                            ),
                            SizedBox(
                              height: rpx(10),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: rpx(5),
                ),
                widget.plan.isNotEmpty
                    ? Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.all(rpx(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  widget.plan["title"].toString(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: rpx(18),
                                ),
                                SizedBox(
                                  height: rpx(10),
                                ),
                                Text(
                                  widget.plan["introduce"].toString(),
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: rpx(13),
                                  ),
                                ),
                                SizedBox(
                                  height: rpx(10),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      spacing: rpx(15),
                                      children: [
                                        Text(
                                          widget.plan["time_str"],
                                          style: TextStyle(
                                              color: widget.plan["time_str"]
                                                      .toString()
                                                      .contains("发布")
                                                  ? Color(0xff6f6f6f)
                                                  : Colors.red,
                                              fontSize: rpx(12)),
                                        ),
                                        Wrap(
                                          spacing: 3,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Text(widget.plan["fans"].toString(),
                                                style: TextStyle(
                                                    color: Color(0xff6f6f6f),
                                                    fontSize: rpx(12))),
                                            Text("购买",
                                                style: TextStyle(
                                                    color: Color(0xff6f6f6f),
                                                    fontSize: rpx(12)))
                                          ],
                                        ),
                                      ],
                                    ),
                                    widget.plan["is_bd"] == 1
                                        ? Container(
                                            height: rpx(20),
                                            padding: EdgeInsets.only(
                                                left: 3, right: 3),
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(3),
                                                    bottomLeft:
                                                        Radius.circular(3))),
                                            child: Text(
                                              "不中补单",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: rpx(13)),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                              top: rpx(3),
                              right: rpx(5),
                              child: getPlanState(widget.plan["plan_result"]))
                        ],
                      )
                    : Container(),
                Container(
                  height: rpx(4),
                  color: Colors.grey.shade100,
                ),
                games.isNotEmpty
                    ? Container(
                        child: Column(
                          children: List.generate(
                              widget.plan["game_content"].length,
                              (index) => onClick(
                                      Container(
                                        margin: EdgeInsets.all(rpx(10)),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Wrap(
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.center,
                                                  spacing: rpx(5),
                                                  children: [
                                                    TextWidget(games[widget
                                                                    .plan[
                                                                "game_content"]
                                                            [index]["id"]][
                                                        "leagues"]["name_short"]),
                                                    TextWidget(games[widget
                                                                    .plan[
                                                                "game_content"]
                                                            [index]["id"]]
                                                        ["start_at"]),
                                                    getRound(
                                                                games[widget.plan[
                                                                            "game_content"]
                                                                        [index]
                                                                    ["id"]],
                                                                widget.plan[
                                                                    "game_type"])
                                                            .isNotEmpty
                                                        ? TextWidget("|")
                                                        : Container(),
                                                    TextWidget(getRound(
                                                        games[widget.plan[
                                                                "game_content"]
                                                            [index]["id"]],
                                                        widget
                                                            .plan["game_type"]))
                                                  ],
                                                ),
                                                getClassify(widget.plan)
                                              ],
                                            ),
                                            SizedBox(
                                              height: rpx(10),
                                            ),
                                            Container(
                                              child: getLeftWidget(games[
                                                  widget.plan["game_content"]
                                                      [index]["id"]]),
                                            ),
                                            SizedBox(
                                              height: rpx(10),
                                            ),
                                            is_buy == 1 ||
                                                    games[widget.plan[
                                                                    "game_content"]
                                                                [index]["id"]]
                                                            ["is_finish"] ==
                                                        1
                                                ? Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: rpx(10)),
                                                    child: getMet(widget.plan[
                                                            "game_content"]
                                                        [index]["jfm"]),
                                                  )
                                                : Container(),
                                            index + 1 <
                                                    widget.plan["game_content"]
                                                        .length
                                                ? Divider(
                                                    color: Colors.grey.shade300,
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ), () {
                                    G.router.navigateTo(
                                        context,
                                        // ignore: prefer_interpolation_to_compose_strings
                                        "/gameDetail" +
                                            G.parseQuery(params: {
                                              "id": widget.plan["game_content"]
                                                  [index]["id"],
                                              "is_detail": 1
                                            }));
                                  })),
                        ),
                      )
                    : Container(),
                Container(
                  height: rpx(4),
                  color: Colors.grey.shade200,
                ),
                Container(
                    margin: EdgeInsets.all(rpx(10)),
                    child: Row(
                      children: [
                        Container(
                          height: rpx(15),
                          width: rpx(3),
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: rpx(10),
                        ),
                        TextWidget(
                          "方案详情",
                          fontSize: rpx(16),
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    )),
                is_buy == 1
                    ? Container(
                        padding: EdgeInsets.all(rpx(10)),
                        child: Text(
                          widget.plan["desc"],
                          softWrap: true,
                        ),
                      )
                    : Container(
                        child: Column(
                          children: [
                            TextWidget(
                              totalSeconds != 0 ? "购买后可解锁文章" : "售卖已截止,无法购买",
                              fontSize: rpx(16),
                              fontWeight: FontWeight.w700,
                              color: Color(0xffef2f2f),
                            ),
                            SizedBox(
                              height: rpx(15),
                            ),
                            TextWidget(
                              "距售卖截止还有",
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: rpx(15),
                            ),
                            TextWidget(
                              formatTime(),
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: rpx(21),
                            ),
                            SizedBox(
                              height: rpx(5),
                            ),
                            TextWidget(
                              "截止时间: ${widget.plan["stop_time"]}",
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: rpx(15),
                            ),
                            TextWidget("*本文章为比赛分析，仅作参考使用，请理性购买。"),
                            SizedBox(
                              height: rpx(10),
                            ),
                            TextWidget(
                              "非购彩、非合买、非跟单！",
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                Container(
                  padding: EdgeInsets.all(rpx(15)),
                  child: Text(
                    "免责声明：山葵足球仅为信息发布平台，并不对第三方发布的信息真实性及准确性负责，且不提供彩票售卖服务，请您注意投资风险，理性购买！",
                    softWrap: true,
                    style: TextStyle(color: Colors.grey, fontSize: rpx(13)),
                  ),
                ),
                buy_user.length > 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: rpx(10)),
                            alignment: Alignment.center,
                            width: rpx(220),
                            height: rpx(40),
                            child: Stack(
                              children: List.generate(
                                buy_user.length,
                                (index) => index <= 8
                                    ? Positioned(
                                        width: rpx(35),
                                        height: rpx(35),
                                        left: rpx(index * 21),
                                        child: Container(
                                          padding: EdgeInsets.only(top: rpx(3)),
                                          child: CircleAvatar(
                                            radius: rpx(35),
                                            backgroundImage: NetworkImage(
                                              buy_user[index]["avatar"],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ),
                            ),
                          ),
                          Container(
                            width: rpx(140),
                            alignment: Alignment.center,
                            height: rpx(40),
                            child: TextWidget("该文章已有${buy_user.length}人解锁"),
                          )
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: rpx(15),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: rpx(150),
                  color: Colors.grey.shade200,
                )
              ],
            ),
            is_buy == 0
                ? Positioned(
                    bottom: 0,
                    child: Container(
                      color: Colors.white,
                      height: rpx(80),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: rpx(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              TextWidget(
                                "需支付",
                                fontSize: rpx(16),
                                fontWeight: FontWeight.w300,
                              ),
                              TextWidget(
                                double.parse(widget.plan["price"])
                                    .toInt()
                                    .toString(),
                                color: Colors.red,
                                fontSize: rpx(30),
                                fontWeight: FontWeight.bold,
                              ),
                              TextWidget(
                                "红币",
                                fontSize: rpx(16),
                                fontWeight: FontWeight.w300,
                              ),
                            ],
                          ),
                          totalSeconds > 0
                              ? payWidget(
                                  price: widget.plan["price"],
                                  button: Container(
                                    height: rpx(40),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: rpx(15)),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(rpx(40))),
                                    child: TextWidget(
                                      "确认支付",
                                      color: Colors.white,
                                      fontSize: rpx(18),
                                    ),
                                  ),
                                  pay_after: (Map data) {
                                    if (mounted) {
                                      setState(() {
                                        is_buy = data["is_buy"];
                                        buy_user = data["buy_user"];
                                      });
                                    }
                                  },
                                  map: {"id": widget.plan["id"]},
                                  type: 1)
                              : Container(
                                  width: rpx(140),
                                  child: disableBtn("已截止,无法购买", () => null),
                                )
                        ],
                      ),
                    ),
                  )
                : Container()
          ],
        ));
  }

  showPay(BuildContext context) {
    G.api.pay.getPayList({}).then((value) {
      setState(() {
        payList = value;
        _selectedPayment = value.isNotEmpty ? value[0]["pay_name"] : "红币";
      });
      showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (context, setss) {
            return Container(
              padding: EdgeInsets.all(rpx(20)),
              constraints: BoxConstraints(
                  minHeight: 100, // 设置最小高度
                  maxHeight: 160),
              decoration: const BoxDecoration(
                color: Colors.white, // 设置背景颜色为白色
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0), // 设置左上角的圆角大小
                  topRight: Radius.circular(10.0), // 设置右上角的圆角大小
                ),
              ),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Container(
                              margin: EdgeInsets.only(left: rpx(10)),
                              child: TextWidget(
                                "订单确认",
                                fontSize: rpx(18),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onClick(
                                Container(
                                  margin: EdgeInsets.only(right: rpx(10)),
                                  child: Icon(
                                    Icons.close,
                                    size: rpx(25),
                                  ),
                                ), () {
                              G.router.pop(context);
                            })
                          ],
                        ),
                      ),
                      SizedBox(
                        height: rpx(20),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/wallet.png",
                                    width: rpx(25),
                                  ),
                                  SizedBox(
                                    width: rpx(10),
                                  ),
                                  TextWidget("支付方式")
                                ],
                              ),
                              onClick(
                                  Row(
                                    children: [
                                      _selectedPayment.toString() != "红币"
                                          ? TextWidget("$_selectedPayment支付")
                                          : Row(
                                              children: [
                                                const TextWidget("红币支付"),
                                                SizedBox(
                                                  width: rpx(10),
                                                ),
                                                TextWidget(
                                                  "(余额:$money)",
                                                  color: Colors.grey,
                                                )
                                              ],
                                            ),
                                      SizedBox(
                                        width: rpx(10),
                                      ),
                                      Icon(Icons.arrow_right_sharp)
                                    ],
                                  ), () {
                                showPaymentList(context, (value) {
                                  setss(() {
                                    _selectedPayment = value;
                                  });
                                });
                              }),
                            ],
                          ),
                          SizedBox(
                            height: rpx(15),
                          ),
                          Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    TextWidget(
                                      "需支付",
                                      fontSize: rpx(16),
                                      fontWeight: FontWeight.w300,
                                    ),
                                    TextWidget(
                                      double.parse(widget.plan["price"])
                                          .toInt()
                                          .toString(),
                                      color: Colors.red,
                                      fontSize: rpx(30),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    TextWidget(
                                      "红币",
                                      fontSize: rpx(16),
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ],
                                ),
                                is_click
                                    ? Container(
                                        width: rpx(120),
                                        child: clickBtn("确认支付", () {
                                          setss(() {
                                            is_click = false;
                                          });
                                          if (_selectedPayment == "红币") {
                                            if (money <
                                                double.parse(
                                                    widget.plan["price"])) {
                                              setss(() {
                                                is_click = true;
                                              });
                                              showConfirmationDialog(
                                                  context, () {},
                                                  title: "红币数量不足,请换个支付方式",
                                                  rightTxt: "前往充值");
                                              return;
                                            }
                                            G.api.pay.payOrderWithHongBi({
                                              "id": widget.plan["id"]
                                            }).then((value) {
                                              if (value == "余额不足") {
                                                setss(() {
                                                  is_click = true;
                                                });
                                                showConfirmationDialog(
                                                    context, () {},
                                                    title: "红币数量不足,请换个支付方式",
                                                    rightTxt: "前往充值");
                                                return;
                                              }
                                              setState(() {
                                                money = double.parse(
                                                    value["money"]);
                                                is_buy = 1;
                                                buy_user = value["buy_user"];
                                              });
                                              Navigator.of(context).pop();
                                            });
                                          }
                                        }),
                                      )
                                    : Container(
                                        width: rpx(120),
                                        child: disableBtn("确认支付", () {}),
                                      )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )

                  // 更多支付方式...
                ],
              ),
            );
          });
        },
      );
    });
  }

  showPaymentList(BuildContext context, Function d) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(builder: (context, setss) {
          return Container(
            constraints: BoxConstraints(
                minHeight: 100, // 设置最小高度
                maxHeight: 200 + payList.length * 30),
            decoration: const BoxDecoration(
              color: Colors.white, // 设置背景颜色为白色
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0), // 设置左上角的圆角大小
                topRight: Radius.circular(10.0), // 设置右上角的圆角大小
              ),
            ),
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: rpx(15),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Container(
                            margin: EdgeInsets.only(left: rpx(10)),
                            child: TextWidget(
                              "请选择支付方式",
                              fontSize: rpx(18),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onClick(
                              Container(
                                margin: EdgeInsets.only(right: rpx(10)),
                                child: Icon(
                                  Icons.close,
                                  size: rpx(25),
                                ),
                              ), () {
                            G.router.pop(context);
                          })
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Column(
                          children: List.generate(
                            payList.length,
                            (index) => RadioListTile<String>(
                              title: Row(
                                children: [
                                  TextWidget(
                                    payList[index]["pay_name"],
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    width: rpx(10),
                                  ),
                                  netImg(
                                      payList[index]["icon"], rpx(25), rpx(25)),
                                ],
                              ),
                              value: payList[index]["pay_name"],
                              groupValue: _selectedPayment,
                              onChanged: (String? newValue) {
                                setss(() {
                                  _selectedPayment = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                        RadioListTile<String>(
                          title: Row(
                            children: [
                              TextWidget(
                                "红币支付",
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                width: rpx(10),
                              ),
                              Image.asset(
                                "assets/images/hongbi.png",
                                width: rpx(25),
                              ),
                              SizedBox(
                                width: rpx(10),
                              ),
                              Wrap(
                                spacing: rpx(10),
                                children: [
                                  const TextWidget(
                                    "余额",
                                    color: Colors.grey,
                                  ),
                                  TextWidget(
                                    "$money红币",
                                    color: Colors.grey,
                                  ),
                                  const TextWidget(
                                    "充值",
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              )
                            ],
                          ),
                          value: "红币",
                          groupValue: _selectedPayment,
                          onChanged: (String? newValue) {
                            setss(() {
                              _selectedPayment = newValue;
                            });
                          },
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: rpx(10)),
                      child: clickBtn("确认", () {
                        d(_selectedPayment);
                        G.router.pop(context);
                      }),
                    )
                  ],
                )

                // 更多支付方式...
              ],
            ),
          );
        });
      },
    );
  }

  String formatTime() {
    int hours = totalSeconds ~/ 3600;

    int minutes = (totalSeconds % 3600) ~/ 60;

    int seconds = totalSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  getRq(String s, Map d) {
    String pre = "0";
    if (s == "rq" || s == "footrq" || s == "rfsf") {
      pre = d["rq"];
    }
    if (s == "daxiaoqiu" || s == "dxf") {
      pre = d["dxq"];
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: rpx(10)),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(rpx(30)),
      ),
      height: rpx(30),
      child: TextWidget(pre),
    );
  }

  Widget getMet(Map d) {
    Widget c = Container();
    Map met = d["met"];

    c = Wrap(
        direction: Axis.vertical,
        spacing: rpx(10),
        children: met.entries.map((entry) {
          Map mets = entry.value;

          return Row(
            children: [
              getRq(entry.key, d),
              Row(
                children: mets.entries
                    .map((e1) => Container(
                          width: rpx(90),
                          height: rpx(30),
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: rpx(10)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(rpx(30)),
                              border: Border.all(
                                  color: e1.value["check"] == "true"
                                      ? Colors.red
                                      : Colors.grey.shade300)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              e1.value["is_right"] != null
                                  ? Image.asset(
                                      "assets/images/is_right.png",
                                      fit: BoxFit.cover,
                                      width: rpx(12),
                                    )
                                  : Container(),
                              TextWidget(e1.value["name"] + e1.value["pl"])
                            ],
                          ),
                        ))
                    .toList(),
              )
            ],
          );
        }).toList());
    return c;
  }

  Widget getLeftWidget(Map<String, dynamic> plan) {
    JcFootModel foot = JcFootModel.fromJson(plan);
    Widget c = Container();
    if (widget.plan["game_type"] == "rfsf" ||
        widget.plan["game_type"] == "dxf") {
      c = Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              netImg(plan["away_team"]["logo"], rpx(40), rpx(40)),
              SizedBox(
                height: rpx(6),
              ),
              TextWidget(plan["away_team"]["name_short"].toString())
            ],
          ),
          Column(
            children: [
              getBasketGameStateText(foot, size: rpx(18)),
              SizedBox(
                height: rpx(6),
              ),
              getBasketGameScoreTextWithWhite(foot.statusId, foot.currentScore,
                  size: rpx(18), color: Colors.red)
            ],
          ),
          Column(
            children: [
              netImg(plan["home_team"]["logo"], rpx(40), rpx(40)),
              SizedBox(
                height: rpx(6),
              ),
              TextWidget(plan["home_team"]["name_short"].toString())
            ],
          )
        ],
      );
    } else {
      c = Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              netImg(plan["home_team"]["logo"], rpx(40), rpx(40)),
              SizedBox(
                height: rpx(6),
              ),
              TextWidget(plan["home_team"]["name_short"].toString())
            ],
          ),
          Column(
            children: [
              getFootGameStateText(foot.statusId, foot.elapsed, size: rpx(18)),
              SizedBox(
                height: rpx(6),
              ),
              getFootGameScoreText(foot.statusId, foot.currentScore,
                  size: rpx(18))
            ],
          ),
          Column(
            children: [
              netImg(plan["away_team"]["logo"], rpx(40), rpx(40)),
              SizedBox(
                height: rpx(6),
              ),
              TextWidget(plan["away_team"]["name_short"].toString())
            ],
          )
        ],
      );
    }
    return c;
  }

  String getRound(Map d, String type) {
    String c = "";
    if (d["num"].isNotEmpty && (type == "jc_foot" || type == "jc_basket")) {
      c = d["num"];
    } else {
      if (d["round"] != null) {
        c = d["round"]["name"];
      }
    }
    return c;
  }

  Widget getCon(String num, String title) {
    return Container(
      color: Color.fromRGBO(0, 0, 0, .04),
      width: MediaQuery.of(context).size.width * 0.215,
      padding: EdgeInsets.symmetric(vertical: rpx(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextWidget(
            num,
            fontSize: rpx(18),
            color: Colors.red,
          ),
          SizedBox(
            height: rpx(5),
          ),
          TextWidget(
            title,
          ),
        ],
      ),
    );
  }

  Widget getFlowButton(int i) {
    return onClick(
        i == 1
            ? Container(
                alignment: Alignment.center,
                width: rpx(70),
                height: rpx(30),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15)),
                child: const Text(
                  "已关注",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                alignment: Alignment.center,
                width: rpx(70),
                height: rpx(30),
                child: const Text(
                  "+关注",
                  style: TextStyle(color: Colors.red),
                ),
              ), () {
      G.api.user.flowUser({"uid": widget.uid}).then((value) {
        setState(() {
          userBattle["is_subscribe"] = userBattle["is_subscribe"] == 1 ? 0 : 1;
          if (userBattle["is_subscribe"] == 0) {
            userBattle["fans_count"]--;
          } else {
            userBattle["fans_count"]++;
          }
        });
      });
    });
  }
}
