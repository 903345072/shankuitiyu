import 'package:flutter/material.dart';
import 'package:jingcai_app/model/expert.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';

class target extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return target_();
  }
}

class target_ extends State<target> {
  List data = [];

  @override
  void initState() {
    super.initState();
    G.api.game.getBigDataTargetStatistic({}).then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        SizedBox(
          height: rpx(15),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: rpx(10),
                ),
                Container(
                  color: Colors.red,
                  height: rpx(17),
                  width: rpx(3),
                ),
                Container(
                  width: rpx(10),
                ),
                TextWidget(
                  "大数据命中统计",
                  fontSize: rpx(19),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: rpx(10)),
              child: TextWidget(
                "示例",
                color: Colors.blue,
                fontSize: rpx(13),
              ),
            ),
          ],
        ),
        SizedBox(
          height: rpx(15),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: rpx(10)),
          child: Table(
            children: getTableRow(),
          ),
        )
      ],
    );
  }

  List<TableRow> getTableRow() {
    List<TableRow> s = [];
    s.add(
      TableRow(
          decoration: BoxDecoration(
            color: Color(0xfffde6e6),
          ),
          children: [
            Container(
              alignment: Alignment.center,
              height: rpx(30),
              child: TextWidget(
                "周期",
                fontSize: rpx(13),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: rpx(30),
              child: TextWidget(
                "比分命中",
                fontSize: rpx(13),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: rpx(30),
              child: TextWidget(
                "进球数",
                fontSize: rpx(13),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: rpx(30),
              child: TextWidget(
                "让球",
                fontSize: rpx(13),
              ),
            )
          ]),
    );
    int index = 0;
    data.forEach((element) {
      s.add(TableRow(
          decoration: BoxDecoration(
            color: index % 2 != 0 ? Color(0xfffde6e6) : Colors.white,
          ),
          children: [
            Container(
              alignment: Alignment.center,
              height: rpx(25),
              child: TextWidget(
                element["name"].toString(),
                fontSize: rpx(13),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: rpx(25),
              child: TextWidget(
                element["bf"].toString(),
                fontSize: rpx(13),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: rpx(25),
              child: TextWidget(
                element["dxq"].toString(),
                fontSize: rpx(13),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: rpx(25),
              child: TextWidget(
                element["rq"].toString(),
                fontSize: rpx(13),
              ),
            )
          ]));
      index++;
    });
    return s;
  }
}
