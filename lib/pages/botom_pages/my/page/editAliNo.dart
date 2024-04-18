import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/InputWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';

class editAliNo extends StatefulWidget {
  Function d;
  editAliNo({required this.d});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return editAliNo_();
  }
}

class editAliNo_ extends State<editAliNo> {
  String ali_no = "";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: appbar("编辑支付宝账号"),
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
                      "编辑提现支付宝账号",
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
                    TextWidget("支付宝账号"),
                    Container(
                      width: rpx(10),
                    ),
                    Container(
                        width: rpx(200),
                        child: InputWidget(
                          hintText: "请输入支付宝账号",
                          onChanged: (e) {
                            setState(() {
                              ali_no = e;
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
                Container(
                  height: rpx(15),
                ),
                clickBtn("提交", () {
                  G.api.user.editAliNo({"ali_no": ali_no}).then((value) {
                    if (value == "ok") {
                      widget.d(ali_no);
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
