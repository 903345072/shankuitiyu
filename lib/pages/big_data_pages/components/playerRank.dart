import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class playerRank extends StatefulWidget {
  int id;
  int season_id;
  playerRank({super.key, required this.id, required this.season_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return playerRank_();
  }
}

class playerRank_ extends State<playerRank> {
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
    {"name": "出场时间", "value": "minutes"},
  ];
  int cur_index = 0;
  List data = [];

  @override
  void initState() {
    super.initState();
    getData(season_id: widget.season_id);
  }

  getData({int? season_id}) {
    G.api.gameAdd.getPlayerRank({
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
    return Column(
      children: [
        Container(
          height: rpx(40),
          color: Color.fromARGB(255, 238, 238, 238),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: TextWidget("类别"),
              ),
              Container(
                child: TextWidget("排名"),
              ),
              Container(
                child: TextWidget("球员"),
              ),
              Container(
                child: TextWidget("球队"),
              ),
              Container(
                child: TextWidget("总数"),
              ),
            ],
          ),
        ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
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
                ? Expanded(
                    flex: 6,
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
                                      width: rpx(70),
                                      child: Text(
                                        data[index]["player"] != null
                                            ? data[index]["player"]["name"]
                                            : "",
                                        style: TextStyle(fontSize: rpx(13)),
                                        softWrap: true,
                                      ),
                                    ),
                                    Container(
                                      width: rpx(20),
                                    ),
                                    Container(
                                      child: netImg(
                                          data[index]["team"] != null
                                              ? data[index]["team"]["logo"]
                                                  .toString()
                                              : "null",
                                          rpx(20),
                                          rpx(20)),
                                    ),
                                    Container(
                                      width: rpx(5),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: rpx(40),
                                      width: rpx(50),
                                      child: Text(
                                        data[index]["team"] != null
                                            ? data[index]["team"]["name_short"]
                                            : "",
                                        style: TextStyle(fontSize: rpx(13)),
                                        softWrap: true,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: rpx(38),
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
        ))
      ],
    );
  }
}
