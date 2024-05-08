import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class payWidget extends StatefulWidget {
  String price = "0";
  Widget button;
  Function pay_after;
  int type = 1; //1:买方案 2:买大数据模块
  Map<String, dynamic> map = {};
  Function? click;
  payWidget(
      {required this.price,
      required this.button,
      required this.pay_after,
      required this.map,
      this.click,
      required this.type});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return payWidget_();
  }
}

class payWidget_ extends State<payWidget> {
  List payList = [];
  String? _selectedPayment = "pay1";
  double money = 0;
  bool is_click = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future getUser() async {
    return G.api.user.getUserIfno({}).then((value) {
      if (mounted) {
        setState(() {
          money = value.money!;
        });
        return value.money!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return onClick(widget.button, () {
      if (widget.click != null) {
        widget.click!();
      } else {
        showPay(context);
      }
    });
  }

  showPay(BuildContext context) {
    getUser().then((value) {
      G.api.pay.getPayList({}).then((value) {
        setState(() {
          payList = value;
          _selectedPayment = value.isNotEmpty ? value[0]["pay_name"] : "金豆";
        });
        showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return StatefulBuilder(builder: (context, setss) {
              return Container(
                padding: EdgeInsets.all(rpx(20)),
                constraints: BoxConstraints(
                    minHeight: rpx(120), // 设置最小高度
                    maxHeight: rpx(180)),
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
                                        _selectedPayment.toString() != "金豆"
                                            ? TextWidget("$_selectedPayment支付")
                                            : Row(
                                                children: [
                                                  const TextWidget("金豆支付"),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      TextWidget(
                                        "需支付",
                                        fontSize: rpx(16),
                                        fontWeight: FontWeight.w300,
                                      ),
                                      TextWidget(
                                        double.parse(widget.price.toString())
                                            .toInt()
                                            .toString(),
                                        color: Colors.red,
                                        fontSize: rpx(30),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      TextWidget(
                                        "金豆",
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
                                            if (_selectedPayment == "金豆") {
                                              if (money <
                                                  double.parse(widget.price
                                                      .toString())) {
                                                setss(() {
                                                  is_click = true;
                                                });
                                                showConfirmationDialog(
                                                    context, () {},
                                                    title: "金豆数量不足,请换个支付方式",
                                                    rightTxt: "前往充值");
                                                return;
                                              }

                                              if (widget.type == 1) {
                                                G.api.pay
                                                    .payOrderWithHongBi(
                                                        widget.map)
                                                    .then((value) {
                                                  if (value == "余额不足") {
                                                    setss(() {
                                                      is_click = true;
                                                    });
                                                    showConfirmationDialog(
                                                        context, () {},
                                                        title: "金豆数量不足,请换个支付方式",
                                                        rightTxt: "前往充值");
                                                    return;
                                                  }

                                                  widget.pay_after({
                                                    "is_buy": 1,
                                                    "buy_user":
                                                        value["buy_user"]
                                                  });
                                                  Navigator.of(context).pop();
                                                });
                                              }

                                              if (widget.type == 2) {
                                                G.api.pay
                                                    .payDataModelWithHongBi(
                                                        widget.map)
                                                    .then((value) {
                                                  if (value == "余额不足") {
                                                    setss(() {
                                                      is_click = true;
                                                    });
                                                    showConfirmationDialog(
                                                        context, () {},
                                                        title: "金豆数量不足,请换个支付方式",
                                                        rightTxt: "前往充值");
                                                    return;
                                                  }
                                                  getUser();
                                                  widget.pay_after({
                                                    "is_buy": 1,
                                                  });
                                                  Navigator.of(context).pop();
                                                });
                                              }
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
                        ),
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
                                "金豆支付",
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
                                    "$money金豆",
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
                          value: "金豆",
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
}
