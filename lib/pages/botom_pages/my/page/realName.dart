import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/InputWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/colors.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/loading.dart';
import 'package:jingcai_app/util/rpx.dart';

class realName extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return realName_();
  }
}

class realName_ extends State<realName> {
  String name = "";
  String card_no = "";
  bool is_click = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: appbar("实名认证"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: rpx(15)),
            child: Column(
              children: [
                InputWidget(
                  hintText: '请输入真实姓名',
                  hintStyle: const TextStyle(color: MyColors.tip, fontSize: 14),
                  textStyle:
                      const TextStyle(color: MyColors.black_33, fontSize: 14),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                Divider(
                  height: rpx(2),
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: rpx(15)),
            child: Column(
              children: [
                InputWidget(
                  hintText: '请输入身份证号',
                  hintStyle: const TextStyle(color: MyColors.tip, fontSize: 14),
                  textStyle:
                      const TextStyle(color: MyColors.black_33, fontSize: 14),
                  onChanged: (value) {
                    setState(() {
                      card_no = value;
                    });
                  },
                ),
                Divider(
                  height: rpx(2),
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          ),
          SizedBox(
            height: rpx(15),
          ),
          Container(
            width: rpx(250),
            child: is_click
                ? clickBtn("提交", () {
                    setState(() {
                      is_click = false;
                    });
                    if (name.isEmpty || card_no.isEmpty) {
                      Loading.tip("urixx", "请输入完整信息");
                      setState(() {
                        is_click = true;
                      });
                      return;
                    }
                    G.api.user.realName(
                        {"name": name, "card_no": card_no}).then((value) {
                      if (value != "ok") {
                        setState(() {
                          is_click = true;
                        });
                        Loading.tip("urixxx", value);
                      } else {
                        tipSucess("实名成功");
                      }
                    });
                  })
                : Container(
                    width: rpx(250),
                    child: disableBtn("提交", () => null),
                  ),
          )
        ],
      ),
    );
  }
}
