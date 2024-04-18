import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/my/page/editAliNo.dart';
import 'package:jingcai_app/pages/botom_pages/my/page/editBank.dart';
import 'package:jingcai_app/pages/botom_pages/my/page/withdrawList.dart';
import 'package:jingcai_app/pages/botom_pages/widget/InputWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/routes.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';

class withdraw extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return witdraw_();
  }
}

class witdraw_ extends State<withdraw> with TickerProviderStateMixin {
  String ali_no = "";
  String bank_card = "";
  String can_tx = "";
  String money = "";
  late TabController c = TabController(length: 2, vsync: this, initialIndex: 0);
  TextEditingController vc = TextEditingController();
  int type = 1;
  bool is_click = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vc.addListener(() {
      setState(() {
        money = vc.value.text;
      });
    });
    getData();
  }

  getData() {
    G.api.user.getUserTxInfo({}).then((value) {
      setState(() {
        ali_no = value["ali_no"];
        bank_card = value["bank_card"];
        can_tx = value["can_tx"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: appbar(
            '提现',
            actions: [
              onClick(
                  Container(
                    margin: EdgeInsets.only(right: rpx(20)),
                    child: TextWidget(
                      "提现记录",
                      color: Colors.red,
                    ),
                  ), () {
                Routes.pushPage(withdrawList());
              })
            ],
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.blue,
              indicatorWeight: 1.5,
              indicatorPadding: EdgeInsets.symmetric(horizontal: rpx(40)),
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black87,
              controller: c,
              onTap: (i) {
                setState(() {
                  if (i == 0) {
                    type = 1;
                  } else {
                    type = 2;
                  }
                });
              },
              tabs: [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "提现到支付宝",
                    ),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "提现到银行卡",
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: c,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 1),
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: Column(
                  children: [
                    onClick(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/alipay.png",
                                  width: rpx(30),
                                ),
                                Container(
                                  width: rpx(15),
                                ),
                                TextWidget(ali_no.isEmpty ? "添加支付宝账号" : ali_no)
                              ],
                            ),
                            Icon(Icons.arrow_right)
                          ],
                        ), () {
                      Routes.pushPage(editAliNo(
                        d: (e) {
                          setState(() {
                            ali_no = e;
                          });
                        },
                      ));
                    }),
                    Container(
                      height: rpx(5),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    getTixian(),
                    Container(
                      height: rpx(15),
                    ),
                    getButton()
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1),
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: Column(
                  children: [
                    onClick(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/yinlian.png",
                                  width: rpx(30),
                                ),
                                Container(
                                  width: rpx(15),
                                ),
                                TextWidget(
                                    bank_card.isEmpty ? "绑定银行卡号" : bank_card)
                              ],
                            ),
                            Icon(Icons.arrow_right)
                          ],
                        ), () {
                      Routes.pushPage(editBank(
                        d: (e) {
                          setState(() {
                            bank_card = e;
                          });
                        },
                      ));
                    }),
                    Container(
                      height: rpx(5),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    getTixian(),
                    Container(
                      height: rpx(15),
                    ),
                    getButton()
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  getButton() {
    Container no_t = Container(
      margin: EdgeInsets.symmetric(horizontal: rpx(40)),
      child: disableBtn("提现", () => null),
    );
    Container can_t = is_click
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: rpx(40)),
            child: clickBtn("提现", () {
              setState(() {
                is_click = false;
              });
              G.api.user
                  .doWithdraw({"money": money, "type": type}).then((value) {
                if (value == "ok") {
                  G.router.pop(context);
                } else {
                  is_click = true;
                }
              });
            }),
          )
        : no_t;

    if (type == 1) {
      if (ali_no.isNotEmpty && money.isNotEmpty) {
        return can_t;
      } else {
        return no_t;
      }
    }

    if (type == 2) {
      if (bank_card.isNotEmpty && money.isNotEmpty) {
        return can_t;
      } else {
        return no_t;
      }
    }
  }

  getTixian() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget("提现金额"),
        InputWidget(
          icon: Image.asset(
            "assets/images/bag.png",
            width: rpx(15),
          ),
          hintText: "可提现金额" + can_tx,
          textInputType: TextInputType.numberWithOptions(decimal: true),
          hintStyle: TextStyle(color: const Color.fromARGB(255, 182, 182, 182)),
          controller: vc,
        ),
        Divider(
          height: rpx(3),
          color: Colors.grey.shade300,
        ),
      ],
    );
  }
}
