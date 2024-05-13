import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jingcai_app/pages/botom_pages/widget/InputWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/routes.dart';
import 'package:jingcai_app/pages/login/purchase.dart';
import 'package:jingcai_app/pages/login/userEvent.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/loading.dart';
import 'package:jingcai_app/util/rpx.dart';
import '../../widget/PreferredSizeWidget.dart';
import '../../widget/colors.dart';
import '../../widget/textWidget.dart';
import 'buyEngin.dart';

class RechargePage extends StatefulWidget {
  const RechargePage({Key? key}) : super(key: key);

  @override
  State<RechargePage> createState() => _RechargePageState();
}

class _RechargePageState extends State<RechargePage> {
  int groupValue = 0;
  List data = [];
  double money = 0.0;
  double pay_money = 0.0;
  int cur_index = 0;
  String? _selectedxy = "0";
  bool _isChecked = false;
  List payList = [];
  String? _selectedPayment = "pay1";
  StreamSubscription? loginSubscription;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loginSubscription = eventBus.on<userEvent>().listen((event) {
      if (mounted) {
        if (event.is_login == true) {
          getData();
        }
      }
    });
    getPayList();
    getData();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          cur_index = -1;
        });
      }
    });
  }

  getPayList() {
    G.api.pay.getPayList({"is_real": 1}).then((value) {
      setState(() {
        payList = value;
        _selectedPayment = value.isNotEmpty ? value[0]["pay_name"] : "无";
      });
    });
  }

  getData() {
    G.api.pay.getPriceList({}).then((value) {
      setState(() {
        data = value["data"] ?? [];
        money = value["money"] != null ? double.parse(value["money"]) : 0.0;
        if (data.isNotEmpty) {
          _controller.text = data[0]["price"].toString();
        }
      });
    });
  }

  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: appbar('充值'),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(rpx(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TextWidget(
                      '余额：',
                      fontSize: rpx(15),
                    ),
                    TextWidget(
                      money.toString(),
                      fontSize: rpx(22),
                      color: MyColors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    TextWidget(
                      ' 金豆',
                      color: MyColors.red,
                      fontSize: rpx(15),
                    ),
                  ],
                ),
                onClick(
                    Container(
                      height: rpx(30),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: rpx(15)),
                      decoration: BoxDecoration(color: Colors.blue),
                      child: TextWidget(
                        "提现",
                        color: Colors.white,
                      ),
                    ), () {
                  G.router.navigateTo(context, "/withdraw");
                })
              ],
            ),
          ),
          Container(
            height: rpx(10),
            color: MyColors.grey_6f6,
          ),
          Container(
            padding: EdgeInsets.all(rpx(10)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: rpx(2),
                          height: rpx(16),
                          color: MyColors.red,
                        ),
                        SizedBox(
                          width: rpx(16),
                        ),
                        const TextWidget("充值金额"),
                      ],
                    ),
                    TextWidget(
                      "1元=1金豆",
                      fontSize: rpx(14),
                      color: MyColors.grey_33,
                    ),
                  ],
                ),
                SizedBox(
                  height: rpx(20),
                ),
                Container(
                  child: Column(
                    children: [
                      Wrap(
                        spacing: rpx(15),
                        runSpacing: rpx(10),
                        children: List.generate(
                            data.length, (index) => getCont(index)),
                      ),
                      SizedBox(
                        height: 16.w,
                      ),
                    ],
                  ),
                ),
                Platform.isAndroid
                    ? InputWidget(
                        hintText: "自定义充值金额",
                        focusNode: focusNode,
                        controller: _controller,
                        textInputType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            pay_money = double.parse(value);
                          });
                        },
                      )
                    : Container(),
                Platform.isAndroid
                    ? Divider(
                        height: rpx(1),
                      )
                    : Container()
              ],
            ),
          ),
          Container(
            height: rpx(10),
            color: MyColors.grey_6f6,
          ),
          Platform.isAndroid
              ? Container(
                  padding: EdgeInsets.all(rpx(10)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: rpx(2),
                            height: rpx(16),
                            color: MyColors.red,
                          ),
                          SizedBox(
                            width: rpx(16),
                          ),
                          const TextWidget(
                            "选择充值方式",
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
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
                              setState(() {
                                _selectedPayment = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ))
              : Container(),
          Container(
            padding: EdgeInsets.all(rpx(10)),
            alignment: Alignment.centerLeft,
            color: MyColors.grey_6f6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(
                  '温馨提示:',
                  color: MyColors.grey_33,
                ),
                SizedBox(
                  height: rpx(12),
                ),
                const TextWidget(
                  '1、福神体育非购彩平台，金豆一经充值成功，只用于购买专家方案，不支持提现、购彩等操作',
                  color: MyColors.grey_33,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),
                SizedBox(
                  height: rpx(5),
                ),
                const TextWidget(
                  '2、金豆充值和消费过程上遇到问题，请及时联系客服。',
                  color: MyColors.grey_33,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),
                SizedBox(
                  height: rpx(5),
                ),
                const TextWidget(
                  '3、严禁未满18周岁的未成年人参与购买方案。',
                  color: MyColors.grey_33,
                ),
                SizedBox(
                  height: rpx(10),
                ),
                onClick(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: _handleCheckboxChanged,
                        ),
                        const TextWidget(
                          '支付即表示同意',
                          color: MyColors.grey_99,
                        ),
                        onClick(
                            TextWidget(
                              '《福神体育用户购买协议》',
                              color: Colors.blue,
                            ), () {
                          Routes.pushPage(purchase());
                        }),
                      ],
                    ), () {
                  setState(() {
                    _selectedxy = _selectedxy == "1" ? "0" : "1";
                  });
                }),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: rpx(20)),
            color: MyColors.white,
            alignment: Alignment.center,
            height: rpx(80),
            child: clickBtn('下一步', () {
              if (!_isChecked) {
                Loading.tip("not", "请同意支付协议");
                return;
              }
              if (Platform.isIOS) {
                //调起Ios支付
                BuyEngin _buyEngin = BuyEngin();
                _buyEngin.initializeInAppPurchase();
                _buyEngin.buyProduct("60");
              } else {}
            }),
          )
        ],
      ),
    );
  }

  void _handleCheckboxChanged(bool? newValue) {
    setState(() {
      _isChecked = newValue!;
    });
  }

  Widget getCont(int index) {
    Widget c = Container();
    c = onClick(
        cur_index == index
            ? Container(
                width: rpx(100),
                height: rpx(80),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: MyColors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(rpx(8)),
                    border: Border.all(width: 1, color: MyColors.red)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      "${data[index]["price"]}元",
                      fontSize: rpx(20),
                      fontWeight: FontWeight.w500,
                      color: MyColors.red,
                    ),
                    TextWidget(
                      '${data[index]["price"]}金豆',
                      fontSize: rpx(13),
                      color: MyColors.red,
                    ),
                  ],
                ),
              )
            : Container(
                width: rpx(100),
                height: rpx(80),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xfff0f0f0),
                  borderRadius: BorderRadius.circular(rpx(8)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      "${data[index]["price"]}元",
                      fontSize: rpx(20),
                      fontWeight: FontWeight.w500,
                      color: MyColors.black_00,
                    ),
                    TextWidget(
                      '${data[index]["price"]}金豆',
                      fontSize: rpx(13),
                      color: MyColors.grey_33,
                    ),
                  ],
                ),
              ), () {
      setState(() {
        cur_index = index;
        focusNode.unfocus();
        _controller.text = data[index]["price"].toString();
      });
    });
    return c;
  }
}
