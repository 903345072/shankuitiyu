import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class teamRank extends StatefulWidget {
  int id;
  int season_id;
  teamRank({super.key, required this.id, required this.season_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return teamRank_();
  }
}

class teamRank_ extends State<teamRank> {
  List<Map<String, String>> rankNames = [
    {"name": "进球", "value": "goals"},
    {"name": "失球", "value": "goals_against"},
    {"name": "点球", "value": "penalty_scored"},
    {"name": "射门", "value": "shots"},
    {"name": "射正", "value": "shots_on_goal"},
    {"name": "成功传球", "value": "passes_accuracy"},
    {"name": "犯规数", "value": "fouls"},
    {"name": "黄牌", "value": "yellow_cards"},
    {"name": "红牌", "value": "red_cards"},
  ];
  int cur_index = 0;
  List data = [];

  @override
  void initState() {
    super.initState();
    getData(season_id: widget.season_id);
  }

  getData({int? season_id}) {
    G.api.gameAdd.getTeamRank({
      "season_id": season_id,
      "sort_str": rankNames[cur_index]["value"],
      "league_id": widget.id
    }).then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: [
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
                width: rpx(50),
                child: TextWidget("排名"),
              ),
              Container(
                width: rpx(70),
                child: TextWidget("球队"),
              ),
              Container(
                width: rpx(140),
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
              height: rpx(400),
              child: ListView(
                children: List.generate(
                    rankNames.length,
                    (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              cur_index = index;
                            });
                            getData(season_id: widget.season_id);
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
                          (index) => onClick(
                                  Container(
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
                                          child: TextWidget(
                                              (index + 1).toString()),
                                        ),
                                        Container(
                                          width: rpx(25),
                                        ),
                                        Container(
                                          child: netImg(
                                              data[index]["team"]["logo"],
                                              rpx(20),
                                              rpx(20)),
                                        ),
                                        Container(
                                          width: rpx(5),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          height: rpx(40),
                                          width: rpx(70),
                                          child: Text(
                                            data[index]["team"]["name_short"],
                                            style: TextStyle(fontSize: rpx(13)),
                                            softWrap: true,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: rpx(55),
                                          child: Text(
                                            data[index][rankNames[cur_index]
                                                    ["value"]]
                                                .toString(),
                                            style: TextStyle(fontSize: rpx(13)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ), () {
                                G.router.navigateTo(
                                    context,
                                    "/teamDetail" +
                                        G.parseQuery(params: {
                                          "name": data[index]["team"]["name"],
                                          "logo": data[index]["team"]["logo"],
                                          "id": data[index]["team"]["id"]
                                        }));
                              })),
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
