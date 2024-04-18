import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class planPreview extends StatelessWidget {
  Map data = {};
  bool show_head = false;
  planPreview({super.key, required this.data, required this.show_head});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return data.isNotEmpty
        ? Container(
            margin: EdgeInsets.symmetric(vertical: rpx(10)),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade200))),
            padding:
                EdgeInsets.only(bottom: rpx(10), left: rpx(10), right: rpx(10)),
            child: Column(
              children: [
                show_head
                    ? Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: rpx(3)),
                              child: CircleAvatar(
                                radius: rpx(25),
                                backgroundImage: NetworkImage(
                                  data["user"]["avatar"].toString(),
                                ),
                              ),
                            ),
                            Container(
                              width: rpx(10),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: rpx(10),
                                ),
                                TextWidget(data["user"]["real_name"]),
                                Container(
                                  height: rpx(5),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: rpx(3), horizontal: rpx(6)),
                                  decoration:
                                      BoxDecoration(color: Color(0xffffece8)),
                                  child: TextWidget(
                                    data["user"]["lable"],
                                    color: Color(0xffef2f2f),
                                    fontSize: rpx(12),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: rpx(10),
                ),
                Container(
                  width: rpx(350),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data["title"].toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: rpx(14), fontWeight: FontWeight.bold),
                      ),
                      getPlanState(data["plan_result"])
                    ],
                  ),
                ),
                SizedBox(
                  height: rpx(5),
                ),
                Container(
                  child: Column(
                    children: List.generate(
                      data["game_content"].length,
                      (index) => Container(
                        color: Color(0xfff0f0f0),
                        margin: EdgeInsets.only(bottom: rpx(5)),
                        padding: EdgeInsets.only(right: rpx(5)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 14, right: 12, top: 6, bottom: 6),
                              width: rpx(300),
                              child: Text(
                                data["game_content"][index]["match_txt"]
                                    .toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: rpx(13),
                                ),
                              ),
                            ),
                            getClassify(data)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: rpx(10),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        direction: Axis.horizontal,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: rpx(15),
                        children: [
                          Text(
                            data["time_str"],
                            style: TextStyle(
                                color:
                                    data["time_str"].toString().contains("发布")
                                        ? Color(0xff6f6f6f)
                                        : Colors.red,
                                fontSize: rpx(12)),
                          ),
                          Wrap(
                            spacing: 3,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(data["fans"].toString(),
                                  style: TextStyle(
                                      color: Color(0xff6f6f6f),
                                      fontSize: rpx(12))),
                              Text("购买",
                                  style: TextStyle(
                                      color: Color(0xff6f6f6f),
                                      fontSize: rpx(12)))
                            ],
                          )
                        ],
                      ),
                      getPlanPrice(data)
                    ],
                  ),
                )
              ],
            ),
          )
        : Container();
  }

  Widget getPlanPrice(Map data) {
    Widget c = Container();
    if (double.parse(data["price"]) > 0) {
      c = Wrap(
        spacing: 3,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(double.parse(data["price"].toString()).toStringAsFixed(0),
              style: TextStyle(color: Colors.red)),
          Text("红币", style: TextStyle(color: Colors.red)),
        ],
      );
    }
    if (double.parse(data["price"]) == 0) {
      c = Wrap(
        spacing: 3,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [Text("免费", style: TextStyle(color: Colors.blue))],
      );
    }

    if (data["is_buy"] == 1) {
      c = Wrap(
        spacing: 3,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [Text("已购", style: TextStyle(color: Colors.blue))],
      );
    }
    return c;
  }
}
