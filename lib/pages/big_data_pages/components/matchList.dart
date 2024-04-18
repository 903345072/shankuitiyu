import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class matchList extends StatefulWidget {
  int id;
  int season_id;

  matchList({super.key, required this.id, required this.season_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return matchList_();
  }
}

class matchList_ extends State<matchList> {
  @override
  void initState() {
    super.initState();
    getLeagueRounds(seson_id: widget.season_id);
  }

  List foot = [];
  List rounds = [];
  List pickerData_ = [];
  int select_index = 0;
  getData({int? seson_id, int? round_id}) {
    G.api.gameAdd.getLeagueMatch({
      "id": widget.id,
      "season_id": seson_id,
      "round_id": round_id
    }).then((value) {
      setState(() {
        foot = value["foot"];
      });
    });
  }

  Future getLeagueRounds({int? seson_id}) async {
    G.api.gameAdd.getLeagueRounds(
        {"id": widget.id, "season_id": seson_id}).then((value) {
      setState(() {
        pickerData_ = [];
        List da = value;
        rounds = value;
        da.asMap().forEach((key, value) {
          if (value["is_current"] == 1) {
            select_index = key;
          }
          pickerData_.add(value["name"]);
        });
      });
      getData(seson_id: seson_id, round_id: rounds[select_index]["id"]);

      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(padding: EdgeInsets.all(0), children: [
      Container(
        width: rpx(40),
        margin: EdgeInsets.only(left: rpx(290), right: rpx(10), top: rpx(10)),
        child: onClick(
            Container(
              padding: EdgeInsets.only(left: rpx(10)),
              height: rpx(30),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(rpx(30))),
              child: Row(
                children: [
                  rounds.isNotEmpty
                      ? TextWidget(
                          rounds[select_index]["name"],
                          color: Colors.white,
                          fontSize: rpx(11),
                        )
                      : Container(),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                    size: rpx(19),
                  )
                ],
              ),
            ), () async {
          Picker picker = Picker(
              cancelText: "取消",
              confirmText: "确认",
              selecteds: [select_index],
              adapter: PickerDataAdapter<String>(pickerData: pickerData_),
              changeToFirst: true,
              textAlign: TextAlign.left,
              columnPadding: const EdgeInsets.all(8.0),
              onConfirm: (Picker picker, List value) {
                setState(() {
                  select_index = value.first;
                });

                getData(
                    seson_id: widget.season_id,
                    round_id: rounds[select_index]["id"]);
              });

          picker.showBottomSheet(context);
        }),
      ),
      foot.isNotEmpty
          ? Column(
              children: List.generate(
                  foot.length,
                  (index) => Container(
                        margin: EdgeInsets.symmetric(vertical: rpx(10)),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              color: Color(0xff002868),
                              padding: EdgeInsets.symmetric(
                                  vertical: rpx(5), horizontal: rpx(10)),
                              child: TextWidget(
                                foot[index]["home_team"]["name_short"] +
                                    "vs" +
                                    foot[index]["away_team"]["name_short"],
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: rpx(10)),
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
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: rpx(120),
                                        child:
                                            TextWidget(foot[index]["start_at"]),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: rpx(40),
                                        child: getFootGameStateText(
                                            foot[index]["status_id"],
                                            foot[index]["elapsed"]),
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
                                              child: TextWidget(foot[index]
                                                  ["home_team"]["name_short"]),
                                            ),
                                            SizedBox(
                                              width: rpx(10),
                                            ),
                                            netImg(
                                                foot[index]["home_team"]
                                                    ["logo"],
                                                rpx(20),
                                                rpx(20))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: rpx(40),
                                        child: getFootGameScoreText(
                                          foot[index]["status_id"],
                                          foot[index]["current_score"],
                                        ),
                                      ),
                                      Container(
                                        width: rpx(120),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            netImg(
                                                foot[index]["away_team"]
                                                    ["logo"],
                                                rpx(20),
                                                rpx(20)),
                                            SizedBox(
                                              width: rpx(10),
                                            ),
                                            Container(
                                              width: rpx(80),
                                              child: TextWidget(foot[index]
                                                  ["away_team"]["name_short"]),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
            )
          : Container(
              alignment: Alignment.center,
              child: TextWidget("暂无数据"),
            )
    ]);
  }
}
