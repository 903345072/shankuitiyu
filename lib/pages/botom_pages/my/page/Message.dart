import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import '../../widget/PreferredSizeWidget.dart';
import '../../widget/colors.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  List data = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    G.api.user.getNoticeList({}).then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      appBar: appbar('消息中心'),
      body: data.length == 0
          ? Container(
              color: MyColors.white,
              padding: const EdgeInsets.fromLTRB(30, 90, 30, 200),
              child: Image.asset('assets/images/message_empty.png'),
            )
          : ListView(
              children: List.generate(
                  data.length,
                  (index) => Container(
                        margin: EdgeInsets.all(rpx(10)),
                        padding: EdgeInsets.all(rpx(10)),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(rpx(10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  color: Colors.red,
                                  width: rpx(3),
                                  height: rpx(15),
                                ),
                                SizedBox(
                                  width: rpx(10),
                                ),
                                TextWidget(
                                  data[index]["title"].toString(),
                                  fontSize: rpx(16),
                                  fontWeight: FontWeight.bold,
                                )
                              ],
                            ),
                            SizedBox(
                              height: rpx(10),
                            ),
                            Text(
                              data[index]["content"],
                              softWrap: true,
                              style: TextStyle(fontSize: rpx(13)),
                            ),
                            SizedBox(
                              height: rpx(10),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                data[index]["img"] != null
                                    ? netImg(
                                        data[index]["img"], rpx(80), rpx(80))
                                    : Container(),
                                data[index]["type"] == 1
                                    ? onClick(
                                        TextWidget(
                                          "前往查看",
                                          color: Colors.blue,
                                        ), () {
                                        G.router.navigateTo(
                                            context, "/applyTalent",
                                            routeSettings: RouteSettings(
                                                arguments: Map()));
                                      })
                                    : Container()
                              ],
                            )
                          ],
                        ),
                      )),
            ),
    );
  }
}
