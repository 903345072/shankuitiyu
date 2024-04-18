import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/InputWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';

class editBank extends StatefulWidget {
  Function d;
  editBank({required this.d});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return editAliNo_();
  }
}

class editAliNo_ extends State<editBank> {
  String bank_card = "";
  String bank_user = "";
  String bank_name = "";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: appbar("编辑银行卡账号"),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(rpx(15)),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: rpx(8)),
                      color: Colors.blue,
                      height: rpx(13),
                      width: rpx(3),
                    ),
                    TextWidget(
                      "编辑提现银行卡账号",
                      fontSize: rpx(15),
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
                Container(
                  height: rpx(15),
                ),
                Row(
                  children: [
                    TextWidget("姓名"),
                    Container(
                      width: rpx(10),
                    ),
                    Container(
                        width: rpx(200),
                        child: InputWidget(
                          hintText: "请输入姓名",
                          onChanged: (e) {
                            setState(() {
                              bank_user = e;
                            });
                          },
                          hintStyle: TextStyle(
                            fontSize: rpx(13),
                          ),
                          textStyle: TextStyle(
                              fontSize: rpx(13),
                              textBaseline: TextBaseline.alphabetic),
                        ))
                  ],
                ),
                Divider(
                  height: rpx(2),
                  color: Colors.grey.shade200,
                ),
                Row(
                  children: [
                    TextWidget("银行卡名称"),
                    Container(
                      width: rpx(10),
                    ),
                    Container(
                        width: rpx(200),
                        child: InputWidget(
                          hintText: "请输入银行卡名称",
                          onChanged: (e) {
                            setState(() {
                              bank_name = e;
                            });
                          },
                          hintStyle: TextStyle(
                            fontSize: rpx(13),
                          ),
                          textStyle: TextStyle(
                              fontSize: rpx(13),
                              textBaseline: TextBaseline.alphabetic),
                        ))
                  ],
                ),
                Divider(
                  height: rpx(2),
                  color: Colors.grey.shade200,
                ),
                Row(
                  children: [
                    TextWidget("银行卡账号"),
                    Container(
                      width: rpx(10),
                    ),
                    Container(
                        width: rpx(200),
                        child: InputWidget(
                          hintText: "请输入银行卡账号",
                          onChanged: (e) {
                            setState(() {
                              bank_card = e;
                            });
                          },
                          hintStyle: TextStyle(
                            fontSize: rpx(13),
                          ),
                          textStyle: TextStyle(
                              fontSize: rpx(13),
                              textBaseline: TextBaseline.alphabetic),
                        ))
                  ],
                ),
                Divider(
                  height: rpx(2),
                  color: Colors.grey.shade200,
                ),
                Container(
                  height: rpx(15),
                ),
                clickBtn("提交", () {
                  G.api.user.editBank({
                    "bank_name": bank_name,
                    "bank_card": bank_card,
                    "bank_user": bank_user
                  }).then((value) {
                    if (value == "ok") {
                      widget.d(bank_card);
                      G.router.pop(context);
                    }
                  });
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
