import 'package:flutter/material.dart';
import 'package:flutter_picker/picker.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class teamScoreRank extends StatefulWidget {
  int id;

  teamScoreRank({super.key, required this.id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return teamScoreRank_();
  }
}

class teamScoreRank_ extends State<teamScoreRank> {
  List pickerData_ = [];
  List rounds = [];
  int select_index = 0;

  getData({int? rank_id}) {
    G.api.gameAdd.getTeamScoreRank({"rank_id": rank_id}).then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // print(widget.id);
    getSeaons();
  }

  getSeaons() {
    G.api.gameAdd.getTeamSeasonAndRound({"id": widget.id}).then((value) {
      setState(() {
        pickerData_ = [];
        List da = value;
        rounds = value;
        da.asMap().forEach((key, value) {
          if (value["stage_cur"] == 1 && value["season_cur"] == 1) {
            select_index = key;
          }
          String names = value["season_name"].toString() +
              value["league_name"].toString() +
              value["stage_name"].toString();
          pickerData_.add(names);
        });
      });
      getData(rank_id: rounds[select_index]["id"]);
    });
  }

  Map data = {};

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(children: [
      Container(
        margin: EdgeInsets.only(left: rpx(150), right: rpx(10), top: rpx(10)),
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
                          rounds[select_index]["season_name"].toString() +
                              rounds[select_index]["league_name"].toString() +
                              rounds[select_index]["stage_name"].toString(),
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

                getData(rank_id: rounds[select_index]["id"]);
              });

          picker.showBottomSheet(context);
        }),
      ),
      data.isNotEmpty
          ? Column(
              children: data.entries
                  .map((entry) => Container(
                        margin: EdgeInsets.symmetric(vertical: rpx(10)),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              color: Color(0xff002868),
                              padding: EdgeInsets.symmetric(
                                  vertical: rpx(5), horizontal: rpx(10)),
                              child: TextWidget(
                                entry.key,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              color: Color(0xfff0f0f0),
                              padding: EdgeInsets.symmetric(
                                  vertical: rpx(5), horizontal: rpx(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: rpx(30),
                                    alignment: Alignment.center,
                                    child: TextWidget("排名"),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: rpx(100),
                                    child: TextWidget("球队"),
                                  ),
                                  Container(
                                    width: rpx(35),
                                    alignment: Alignment.center,
                                    child: TextWidget("场次"),
                                  ),
                                  Container(
                                    width: rpx(55),
                                    alignment: Alignment.center,
                                    child: TextWidget("胜/平/负"),
                                  ),
                                  Container(
                                    width: rpx(45),
                                    alignment: Alignment.center,
                                    child: TextWidget("进/失"),
                                  ),
                                  Container(
                                    width: rpx(35),
                                    alignment: Alignment.center,
                                    child: TextWidget("积分"),
                                  )
                                ],
                              ),
                            ),
                            Container(
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
                              width: MediaQuery.of(context).size.width * 0.9,
                              padding: EdgeInsets.symmetric(
                                  vertical: rpx(5), horizontal: rpx(10)),
                              child: Column(
                                children: List.generate(
                                    entry.value.length,
                                    (index) => Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: rpx(10)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: rpx(30),
                                                alignment: Alignment.center,
                                                child: TextWidget(entry
                                                    .value[index]["position"]
                                                    .toString()),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: rpx(100),
                                                child: Wrap(
                                                  spacing: rpx(5),
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.center,
                                                  children: [
                                                    entry.value[index]["team"]
                                                                ["logo"] !=
                                                            null
                                                        ? netImg(
                                                            entry.value[index]
                                                                    ["team"]
                                                                ["logo"],
                                                            rpx(20),
                                                            rpx(20))
                                                        : Container(
                                                            width: rpx(20),
                                                          ),
                                                    Container(
                                                      width: rpx(50),
                                                      child: TextWidget(
                                                        entry.value[index]
                                                                ["team"]
                                                            ["name_short"],
                                                        fontSize: rpx(12),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: rpx(35),
                                                alignment: Alignment.center,
                                                child: TextWidget(entry
                                                    .value[index]["matches"]
                                                    .toString()),
                                              ),
                                              Container(
                                                width: rpx(55),
                                                alignment: Alignment.center,
                                                child: TextWidget(
                                                    "${entry.value[index]["wins"].toString()}/${entry.value[index]["draws"].toString()}/${entry.value[index]["losses"].toString()}"),
                                              ),
                                              Container(
                                                width: rpx(45),
                                                alignment: Alignment.center,
                                                child: TextWidget(
                                                    "${entry.value[index]["goals_for"].toString()}/${entry.value[index]["goals_against"].toString()}"),
                                              ),
                                              Container(
                                                width: rpx(35),
                                                alignment: Alignment.center,
                                                child: TextWidget(
                                                    "${entry.value[index]["points"].toString()}"),
                                              )
                                            ],
                                          ),
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
