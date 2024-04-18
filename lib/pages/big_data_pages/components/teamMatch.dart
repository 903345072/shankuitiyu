import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class teamMatch extends StatefulWidget {
  int id;

  teamMatch({super.key, required this.id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return teamMatch_();
  }
}

class teamMatch_ extends State<teamMatch> {
  @override
  void initState() {
    super.initState();

    getData();
  }

  Map foot = {};
  List rounds = [];
  List pickerData_ = [];
  int select_index = 0;
  getData() {
    G.api.gameAdd.getTeamMatch({
      "id": widget.id,
    }).then((value) {
      setState(() {
        foot = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(padding: EdgeInsets.all(0), children: [
      foot.isNotEmpty
          ? Column(
              children: foot.entries
                  .map((e) => Container(
                        margin: EdgeInsets.symmetric(vertical: rpx(10)),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              color: Color(0xff002868),
                              padding: EdgeInsets.symmetric(
                                  vertical: rpx(5), horizontal: rpx(10)),
                              child: TextWidget(
                                e.key.toString(),
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: rpx(10), horizontal: rpx(5)),
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26
                                        .withOpacity(0.1), // 阴影的颜色
                                    offset: Offset(1, 2), // 阴影与容器的距离
                                    blurRadius: 5.0, // 高斯的标准偏差与盒子的形状卷积。
                                    spreadRadius: 0.0, // 在应用模糊之前，框应该膨胀的量。
                                  ),
                                ],
                              ),
                              child: Column(
                                children: List.generate(
                                    e.value.length >= 10 ? 10 : e.value.length,
                                    (index) => Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  width: rpx(120),
                                                  child: TextWidget(
                                                      e.value[index]
                                                          ["start_at"]),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  width: rpx(40),
                                                  child: getFootGameStateText(
                                                      e.value[index]
                                                          ["status_id"],
                                                      e.value[index]
                                                          ["elapsed"]),
                                                ),
                                                Container(
                                                  width: rpx(120),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: rpx(10),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  width: rpx(120),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        width: rpx(80),
                                                        child: TextWidget(
                                                            e.value[index][
                                                                    "home_team"]
                                                                ["name_short"]),
                                                      ),
                                                      SizedBox(
                                                        width: rpx(10),
                                                      ),
                                                      netImg(
                                                          e.value[index]
                                                                  ["home_team"]
                                                              ["logo"],
                                                          rpx(20),
                                                          rpx(20))
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: rpx(40),
                                                  child: getFootGameScoreText(
                                                    e.value[index]["status_id"],
                                                    e.value[index]
                                                        ["current_score"],
                                                  ),
                                                ),
                                                Container(
                                                  width: rpx(120),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      netImg(
                                                          e.value[index]
                                                                  ["away_team"]
                                                              ["logo"],
                                                          rpx(20),
                                                          rpx(20)),
                                                      SizedBox(
                                                        width: rpx(10),
                                                      ),
                                                      Container(
                                                        width: rpx(80),
                                                        child: TextWidget(
                                                            e.value[index][
                                                                    "away_team"]
                                                                ["name_short"]),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider()
                                          ],
                                        )),
                              ),
                            )
                          ],
                        ),
                      ))
                  .toList(),
            )
          : Container(
              alignment: Alignment.center,
              child: TextWidget("暂无数据"),
            )
    ]);
  }
}
