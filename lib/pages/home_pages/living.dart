import 'package:flutter/material.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/big_data_pages/components/gamePieChart.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/pages/home_pages/twoSidePie.dart';
import 'package:jingcai_app/pages/score_pages/foot.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';

class living extends StatefulWidget {
  Map home_data = {};
  Map away_data = {};
  JcFootModel foot = JcFootModel.fromJson({
    "leagues": Map<String, dynamic>.from({}),
    "home_team": Map<String, dynamic>.from({}),
    "away_team": Map<String, dynamic>.from({})
  });

  living(
      {required this.home_data, required this.away_data, required this.foot});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return living_();
  }
}

class living_ extends State<living> {
  List live_data = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    G.api.game.getLiving({"id": widget.foot.id}).then((value) {
      setState(() {
        live_data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var is_empty = widget.away_data.isNotEmpty &&
        widget.home_data.isNotEmpty &&
        live_data.isNotEmpty;
    //is_empty = false;
    // TODO: implement build
    return is_empty == true
        ? ListView(
            children: [
              Container(
                height: rpx(50),
                alignment: Alignment.center,
                color: Color(0xfff0f0f0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      spacing: rpx(5),
                      children: [
                        Container(
                          width: rpx(10),
                        ),
                        Container(
                          width: rpx(2),
                          height: rpx(18),
                          color: Colors.red,
                        ),
                        TextWidget(
                          widget.foot.homeTeam!.nameShort.toString(),
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                    Wrap(
                      spacing: rpx(5),
                      children: [
                        TextWidget(
                          widget.foot.awayTeam!.nameShort.toString(),
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          width: rpx(2),
                          height: rpx(18),
                          color: Color(0xff002868),
                        ),
                        Container(
                          width: rpx(10),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: rpx(0.5),
                            color: const Color.fromARGB(255, 235, 235, 235)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: rpx(80),
                      width: MediaQuery.of(context).size.width * 0.33,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  width: rpx(0.5),
                                  color: const Color.fromARGB(
                                      255, 235, 235, 235)))),
                      child: Row(
                        children: [
                          TextWidget(widget.home_data["attacks"].toString()),
                          Stack(
                            children: [
                              Container(
                                width: rpx(60),
                                height: rpx(60),
                                child: twoSidePie(
                                    pie1: double.parse(
                                        widget.home_data["attacks"]),
                                    pie2: double.parse(
                                        widget.away_data["attacks"])),
                              ),
                              Positioned(
                                top: rpx(23),
                                left: rpx(18),
                                child: TextWidget(
                                  "进攻",
                                  fontSize: rpx(11),
                                ),
                              )
                            ],
                          ),
                          TextWidget(widget.away_data["attacks"].toString()),
                        ],
                      ),
                    ),
                    Container(
                      height: rpx(80),
                      width: MediaQuery.of(context).size.width * 0.33,
                      decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  width: rpx(0.5),
                                  color: const Color.fromARGB(
                                      255, 235, 235, 235)))),
                      child: Row(
                        children: [
                          TextWidget(
                              widget.home_data["dangerous_attacks"].toString()),
                          Stack(
                            children: [
                              Container(
                                width: rpx(60),
                                height: rpx(60),
                                child: twoSidePie(
                                    pie1: double.parse(
                                        widget.home_data["dangerous_attacks"]),
                                    pie2: double.parse(
                                        widget.away_data["dangerous_attacks"])),
                              ),
                              Positioned(
                                  top: rpx(16),
                                  left: rpx(18),
                                  child: Column(
                                    children: [
                                      TextWidget(
                                        "危险",
                                        fontSize: rpx(11),
                                      ),
                                      TextWidget("进攻", fontSize: rpx(11))
                                    ],
                                  ))
                            ],
                          ),
                          TextWidget(
                              widget.away_data["dangerous_attacks"].toString()),
                        ],
                      ),
                    ),
                    widget.home_data["ball_possession"] != null
                        ? Row(
                            children: [
                              TextWidget(widget.home_data["ball_possession"]
                                  .toString()),
                              Stack(
                                children: [
                                  Container(
                                    width: rpx(60),
                                    height: rpx(60),
                                    child: twoSidePie(
                                        pie1: double.parse(widget
                                            .home_data["ball_possession"]),
                                        pie2: double.parse(widget
                                            .away_data["ball_possession"])),
                                  ),
                                  Positioned(
                                    top: rpx(23),
                                    left: rpx(14),
                                    child: TextWidget(
                                      "控球率",
                                      fontSize: rpx(10),
                                    ),
                                  )
                                ],
                              ),
                              TextWidget(widget.away_data["ball_possession"]
                                  .toString()),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(rpx(15)),
                child: Column(
                  children: [
                    Container(
                      child: TextWidget(
                        "射正球门",
                        fontSize: rpx(12),
                      ),
                    ),
                    Container(
                      height: rpx(10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          spacing: rpx(5),
                          children: [
                            Image.asset(
                              "assets/images/corner.png",
                              width: rpx(17),
                            ),
                            Image.asset(
                              "assets/images/yellow_card.png",
                              width: rpx(17),
                            ),
                            Image.asset(
                              "assets/images/red_card.png",
                              width: rpx(17),
                            ),
                            TextWidget(
                                widget.home_data["shots_on_goal"].toString())
                          ],
                        ),
                        Container(
                          width: rpx(10),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: rpx(6)),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(rpx(16)),
                                      topLeft: Radius.circular(rpx(16)))),
                              height: rpx(16),
                              width: getStraitWith() * rpx(150),
                              child: TextWidget(
                                (getStraitWith() * 100).toStringAsFixed(0) +
                                    "%",
                                fontSize: rpx(10),
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: rpx(6)),
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                  color: Color(0xff002868),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(rpx(16)),
                                      topRight: Radius.circular(rpx(16)))),
                              height: rpx(16),
                              width: (1 - getStraitWith()) * rpx(150),
                              child: TextWidget(
                                ((1 - getStraitWith()) * 100)
                                        .toStringAsFixed(0) +
                                    "%",
                                fontSize: rpx(10),
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: rpx(10),
                        ),
                        Wrap(
                          spacing: rpx(5),
                          children: [
                            TextWidget(
                                widget.away_data["shots_on_goal"].toString()),
                            Image.asset(
                              "assets/images/red_card.png",
                              width: rpx(17),
                            ),
                            Image.asset(
                              "assets/images/yellow_card.png",
                              width: rpx(17),
                            ),
                            Image.asset(
                              "assets/images/corner.png",
                              width: rpx(17),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: rpx(10),
                    ),
                    Container(
                      child: TextWidget(
                        "射偏球门",
                        fontSize: rpx(12),
                      ),
                    ),
                    Container(
                      height: rpx(10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          spacing: rpx(5),
                          children: [
                            Container(
                              width: rpx(17),
                              child: TextWidget(
                                  widget.home_data["corner_kicks"].toString()),
                            ),
                            Container(
                              child: TextWidget(
                                  widget.home_data["yellow_cards"].toString()),
                              width: rpx(17),
                            ),
                            Container(
                              child: TextWidget(
                                  widget.home_data["red_cards"] ?? "0"),
                              width: rpx(17),
                            ),
                            Container(
                              child: TextWidget(widget
                                  .home_data["shots_off_goal"]
                                  .toString()),
                            )
                          ],
                        ),
                        Container(
                          width: rpx(10),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: rpx(6)),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(rpx(16)),
                                      topLeft: Radius.circular(rpx(16)))),
                              height: rpx(16),
                              width: getAskewWith() * rpx(150),
                              child: TextWidget(
                                (getAskewWith() * 100).toStringAsFixed(0) + "%",
                                fontSize: rpx(10),
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: rpx(6)),
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                  color: Color(0xff002868),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(rpx(16)),
                                      topRight: Radius.circular(rpx(16)))),
                              height: rpx(16),
                              width: (1 - getAskewWith()) * rpx(150),
                              child: TextWidget(
                                ((1 - getAskewWith()) * 100)
                                        .toStringAsFixed(0) +
                                    "%",
                                fontSize: rpx(10),
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: rpx(10),
                        ),
                        Wrap(
                          spacing: rpx(5),
                          children: [
                            Container(
                              child: TextWidget(
                                  widget.away_data["shots_off_goal"] ?? "0"),
                            ),
                            Container(
                              child: TextWidget(
                                  widget.away_data["red_cards"] ?? "0"),
                              width: rpx(17),
                            ),
                            Container(
                              child: TextWidget(
                                  widget.away_data["yellow_kicks"] ?? "0"),
                              width: rpx(17),
                            ),
                            Container(
                              width: rpx(17),
                              child: TextWidget(
                                  widget.away_data["corner_kicks"] ?? "0"),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: rpx(10),
              ),
              Wrap(
                spacing: rpx(20),
                direction: Axis.vertical,
                children: getChild(),
              )
            ],
          )
        : Container(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/noGameData.png",
                  height: rpx(190),
                  fit: BoxFit.cover,
                ),
              ],
            ),
          );
  }

  Widget GetEvent(int id) {
    Widget c = Container();
    Map events = {
      41: "assets/images/whistle.png",
      42: "assets/images/whistle.png",
      1: "assets/images/have_goal.png",
      6: "assets/images/corner.png",
      22: "assets/images/red_card.png",
      20: "assets/images/yellow_card.png"
    };
    if (events.containsKey(id)) {
      c = Image.asset(
        events[id],
        width: rpx(16),
      );
    }
    return c;
  }

  List<Widget> getChild() {
    List<Widget> c = [];
    c = List.generate(
        live_data.length,
        (index) => Container(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: rpx(8)),
                    width: rpx(16),
                    child: GetEvent(live_data[index]["type_id"]),
                  ),
                  Container(
                    width: rpx(20),
                  ),
                  live_data[index]["type_id"] == 41 ||
                          live_data[index]["type_id"] == 42
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: rpx(6)),
                          height: rpx(50),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(rpx(4)),
                              color: Color(0xfff0f0f0),
                              border: Border.all(
                                  width: rpx(0.5), color: Color(0xffdbdbdb))),
                          width: rpx(290),
                          child: Text(
                            live_data[index]["text"],
                            softWrap: true,
                            style: TextStyle(fontSize: rpx(13)),
                          ),
                        )
                      : Container(
                          width: rpx(290),
                          child: Text(
                            live_data[index]["time"] +
                                "'"
                                    " - " +
                                live_data[index]["text"],
                            softWrap: true,
                            style: TextStyle(fontSize: rpx(13)),
                          ),
                        )
                ],
              ),
            ));
    if (c.isNotEmpty) {
      c.add(Container(
        margin: EdgeInsets.only(left: rpx(8)),
        child: Row(
          children: [
            Image.asset(
              "assets/images/whistle.png",
              width: rpx(16),
            ),
            Container(
              width: rpx(5),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: rpx(15)),
              height: rpx(50),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(rpx(4)),
                  color: Color(0xfff0f0f0),
                  border:
                      Border.all(width: rpx(0.5), color: Color(0xffdbdbdb))),
              child: TextWidget("随着裁判的一声哨响,上半场比赛开始"),
            )
          ],
        ),
      ));
    }
    c.add(Container(
      height: rpx(50),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.95,
      padding: EdgeInsets.symmetric(horizontal: rpx(10)),
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.025),
      decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, .3)),
      child: Row(
        children: [
          Image.asset(
            "assets/images/jingcaizuqiu.png",
            fit: BoxFit.cover,
            width: rpx(70),
          ),
          Container(
            width: rpx(10),
          ),
          Container(
            width: rpx(240),
            child: Text(
              "大家好，欢迎收看本场比赛直播，球员们正在热身，比赛即将开始",
              softWrap: true,
              style: TextStyle(color: Colors.white, fontSize: rpx(13)),
            ),
          )
        ],
      ),
    ));
    return c;
  }

  double getStraitWith() {
    double c = 0;
    double h = widget.home_data["shots_on_goal"] != null
        ? double.parse(widget.home_data["shots_on_goal"])
        : 0;
    double a = widget.away_data["shots_on_goal"] != null
        ? double.parse(widget.away_data["shots_on_goal"])
        : 0;
    if (h + a != 0) {
      c = (h / (h + a));
    }

    return c;
  }

  double getAskewWith() {
    double c = 0;
    double h = widget.home_data["shots_off_goal"] != null
        ? double.parse(widget.home_data["shots_off_goal"])
        : 0;
    double a = widget.away_data["shots_off_goal"] != null
        ? double.parse(widget.away_data["shots_off_goal"])
        : 0;
    if (h + a != 0) {
      c = (h / (h + a));
    }

    return c;
  }
}
