import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_picker/picker.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class teamPlayerRank extends StatefulWidget {
  int id;

  teamPlayerRank({super.key, required this.id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return teamPlayerRank_();
  }
}

class teamPlayerRank_ extends State<teamPlayerRank> {
  List<Map<String, String>> rankNames = [
    {"name": "射手榜", "value": "goals"},
    {"name": "助攻榜", "value": "assists"},
    {"name": "射门", "value": "shots"},
    {"name": "射正", "value": "shots_on_goal"},
    {"name": "传球", "value": "passes"},
    {"name": "成功传球", "value": "passes_accuracy"},
    {"name": "关键传球", "value": "key_passes"},
    {"name": "拦截", "value": "interceptions"},
    {"name": "封堵", "value": "blocked_shots"},
    {"name": "解围", "value": "clearances"},
    {"name": "扑救", "value": "saves"},
    {"name": "黄牌", "value": "yellow_cards"},
    {"name": "红牌", "value": "red_cards"},
  ];
  int cur_index = 0;
  List data = [];

  List pickerData_ = [];
  List rounds = [];
  List<int> select_index = [0, 0];

  @override
  void initState() {
    super.initState();
    getSeaons();
  }

  getData({int? league_id, int? season_id}) {
    G.api.gameAdd.getPlayerRank({
      "season_id": season_id,
      "sort_str": rankNames[cur_index]["value"],
      "team_id": widget.id,
      "league_id": league_id
    }).then((value) {
      setState(() {
        data = value;
      });
    });
  }

  getSeaons() {
    G.api.gameAdd.getTeamSeasonAndLeague({"id": widget.id}).then((value) {
      setState(() {
        pickerData_ = [];
        List da = value;
        rounds = value;

        da.asMap().forEach((key, value) {
          List ss = value["seasons"];

          ss.asMap().forEach((key1, value1) {
            if (value1["is_current"] == 1) {
              select_index = [key, key1];
            }
          });
          List dd = ss.map((e) => e["name"]).toList();
          pickerData_.add({value["name_short"]: dd});
        });
      });
      getData(
          league_id: rounds[select_index[0]]["id"],
          season_id: rounds[select_index[0]]["seasons"][select_index[1]]["id"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: [
        rounds.isNotEmpty
            ? Container(
                margin: EdgeInsets.only(
                    right: rpx(10),
                    top: rpx(10),
                    left: rpx(10),
                    bottom: rpx(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                        rounds[select_index[0]]["name_short"].toString()),
                    onClick(
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
                                      rounds[select_index[0]]["seasons"]
                                              [select_index[1]]["name"]
                                          .toString(),
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
                          selecteds: select_index,
                          adapter: PickerDataAdapter<String>(
                              pickerData: pickerData_),
                          changeToFirst: true,
                          textAlign: TextAlign.left,
                          columnPadding: const EdgeInsets.all(8.0),
                          onConfirm: (Picker picker, List<int> value) {
                            setState(() {
                              select_index = value;
                            });

                            getData(
                                league_id: rounds[select_index[0]]["id"],
                                season_id: rounds[select_index[0]]["seasons"]
                                    [select_index[1]]["id"]);
                          });

                      picker.showBottomSheet(context);
                    })
                  ],
                ),
              )
            : Container(),
        Container(
          height: rpx(40),
          color: Color.fromARGB(255, 238, 238, 238),
          child: Row(
            children: [
              Container(
                width: rpx(90),
                child: TextWidget("类别"),
              ),
              Container(
                width: rpx(40),
                child: TextWidget("排名"),
              ),
              Container(
                width: rpx(80),
                child: TextWidget("球员"),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: rpx(125),
                child: TextWidget("总数"),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              color: Color.fromARGB(255, 247, 247, 247),
              width: rpx(95),
              height: rpx(370),
              child: ListView(
                children: List.generate(
                    rankNames.length,
                    (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              cur_index = index;
                            });

                            getData(
                                league_id: rounds[select_index[0]]["id"],
                                season_id: rounds[select_index[0]]["seasons"]
                                    [select_index[1]]["id"]);
                          },
                          child: Container(
                            color: cur_index == index
                                ? Colors.white
                                : Color.fromARGB(255, 247, 247, 247),
                            height: rpx(50),
                            alignment: Alignment.center,
                            child: Text(
                              rankNames[index]["name"].toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: cur_index == index
                                      ? Colors.red
                                      : Colors.black),
                            ),
                          ),
                        )),
              ),
            ),
            data.isNotEmpty
                ? Container(
                    height: rpx(370),
                    margin: EdgeInsets.only(bottom: rpx(30)),
                    padding: EdgeInsets.only(left: rpx(5), top: 10),
                    width: MediaQuery.of(context).size.width - rpx(95),
                    child: ListView(
                      children: List.generate(
                          data.length,
                          (index) => Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: rpx(1),
                                            color: Colors.grey.shade200))),
                                child: Row(
                                  children: [
                                    Container(
                                      width: rpx(30),
                                      alignment: Alignment.center,
                                      child: TextWidget((index + 1).toString()),
                                    ),
                                    Container(
                                      width: rpx(10),
                                    ),
                                    Container(
                                      width: rpx(20),
                                      alignment: Alignment.center,
                                      child:
                                          data[index]["player"]["logo"] != null
                                              ? netImg(
                                                  data[index]["player"]["logo"],
                                                  rpx(20),
                                                  rpx(20))
                                              : Container(
                                                  width: rpx(20),
                                                  height: rpx(20),
                                                ),
                                    ),
                                    Container(
                                      width: rpx(5),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: rpx(40),
                                      width: rpx(130),
                                      child: Text(
                                        data[index]["player"]["name"],
                                        style: TextStyle(fontSize: rpx(13)),
                                        softWrap: true,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: rpx(30),
                                      child: Text(
                                        data[index]
                                                [rankNames[cur_index]["value"]]
                                            .toString(),
                                        style: TextStyle(fontSize: rpx(13)),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.all(rpx(80)),
                    alignment: Alignment.center,
                    child: TextWidget("暂无数据"),
                  )
          ],
        )
      ],
    );
  }
}
