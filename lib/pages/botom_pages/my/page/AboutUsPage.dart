import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

import '../../widget/PreferredSizeWidget.dart';
import '../../widget/colors.dart';
import '../../widget/textWidget.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  String? logo;
  String content = "";
  List gzh = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUrl();
  }

  getUrl() {
    G.api.user.getgzh({}).then((value) {
      setState(() {
        logo = value["logo"];
        gzh = value["gzh"];
        content = value["content"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: appbar('关于我们'),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                child: netImg(logo, rpx(100), rpx(100)),
              ),
            ],
          ),
          SizedBox(
            height: 30.w,
          ),
          TextWidget(
            '福神体育',
            fontWeight: FontWeight.bold,
            fontSize: rpx(25),
          ),
          SizedBox(
            height: 20.w,
          ),
          const TextWidget('版本号：1.1.0'),
          SizedBox(
            height: 30.w,
          ),
          Container(
            padding: EdgeInsets.all(rpx(10)),
            child: TextWidget(
              content,
              maxLines: 10,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: rpx(10)),
          Container(
            height: 1,
            color: MyColors.grey_6f6,
          ),
          SizedBox(
            height: rpx(30),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: List.generate(
          //     gzh.length,
          //     (index) => Column(
          //       children: [
          //         Container(
          //           child: netImg(gzh[index]["url"], rpx(100), rpx(100)),
          //         ),
          //         SizedBox(
          //           height: rpx(15),
          //         ),
          //         const TextWidget('微信公众号：'),
          //         TextWidget(gzh[index]["name"]),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
