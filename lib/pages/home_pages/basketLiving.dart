import 'package:flutter/material.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/big_data_pages/components/gamePieChart.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/pages/home_pages/twoSidePie.dart';
import 'package:jingcai_app/pages/score_pages/foot.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';

class basketLiving extends StatefulWidget {
  Map home_data = {};
  Map away_data = {};
  JcFootModel foot = JcFootModel.fromJson({
    "leagues": Map<String, dynamic>.from({}),
    "home_team": Map<String, dynamic>.from({}),
    "away_team": Map<String, dynamic>.from({})
  });

  basketLiving(
      {required this.home_data, required this.away_data, required this.foot});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return living_();
  }
}

class living_ extends State<basketLiving> {
  List live_data = [];
  @override
  void initState() {
    super.initState();
  }

  double getWidth(double? l1, double? t) {
    double c = 0;
    if (t == 0) {
      return 50;
    } else {
      c = (l1! / t!) * rpx(250);
    }

    return c;
  }

  Widget getBatleWidget(String title, String field) {
    Widget c = Container();
    if (widget.away_data![field] != null) {
      c = c = Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          direction: Axis.vertical,
          children: [
            TextWidget(title),
            Row(
              children: [
                Container(
                  width: rpx(50),
                  child: TextWidget(widget.away_data![field].toString()),
                ),
                Container(
                  width: rpx(5),
                ),
                Row(
                  children: [
                    Container(
                      height: rpx(10),
                      width: getWidth(
                          double.parse(widget.away_data![field] ?? "0"),
                          double.parse(widget.away_data![field] ?? "0") +
                              double.parse(widget.home_data![field] ?? "0")),
                      decoration: BoxDecoration(color: Colors.yellow),
                    ),
                    Container(
                      height: rpx(10),
                      width: 250 -
                          getWidth(
                              double.parse(widget.away_data![field] ?? "0"),
                              double.parse(widget.away_data![field] ?? "0") +
                                  double.parse(
                                      widget.home_data![field] ?? "0")),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: rpx(5),
                ),
                Container(
                  width: rpx(50),
                  child: TextWidget(widget.home_data![field].toString()),
                ),
              ],
            )
          ]);
    }

    return c;
  }

  getScore(String field, int d) {
    List s = field.split(":");
    if (s.length > 1) {
      if (d == 1) {
        return s[0];
      } else {
        return s[1];
      }
    } else {
      return "";
    }
  }

  getTotalScore(int d) {
    double f = 0;
    List q1 = widget.foot.q1_score.toString().split(":");
    List q2 = widget.foot.q2_score.toString().split(":");
    List q3 = widget.foot.q3_score.toString().split(":");
    List q4 = widget.foot.q4_score.toString().split(":");
    List q5 = widget.foot.extraScore.toString().split(":");
    if (q1.length > 1) {
      f += double.parse(q1[d]);
    }
    if (q2.length > 1) {
      f += double.parse(q2[d]);
    }
    if (q3.length > 1) {
      f += double.parse(q3[d]);
    }
    if (q4.length > 1) {
      f += double.parse(q4[d]);
    }
    if (q5.length > 1) {
      f += double.parse(q5[d]);
    }
    return f.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    var is_empty = widget.away_data.isNotEmpty &&
        widget.home_data.isNotEmpty &&
        live_data.isNotEmpty;
    is_empty = true;
    // TODO: implement build
    return is_empty == true
        ? ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: rpx(15)),
                padding: EdgeInsets.symmetric(horizontal: rpx(15)),
                child: Table(
                  border: const TableBorder(
                      left: BorderSide(width: 0.1, color: Colors.grey),
                      right: BorderSide(width: 0.1, color: Colors.grey),
                      bottom: BorderSide(width: 0.1, color: Colors.grey)),
                  children: [
                    TableRow(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                        ),
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: rpx(30),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: rpx(30),
                            child: TextWidget("一"),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: rpx(30),
                            child: TextWidget("二"),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: rpx(30),
                            child: TextWidget("三"),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: rpx(30),
                            child: TextWidget("四"),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: rpx(30),
                            child: TextWidget("OT"),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: rpx(30),
                            child: TextWidget("总分"),
                          )
                        ]),
                    TableRow(children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right:
                                    BorderSide(color: Colors.grey.shade200))),
                        alignment: Alignment.center,
                        height: rpx(30),
                        child: TextWidget(
                            widget.foot.awayTeam!.nameShort.toString()),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey.shade200),
                                right:
                                    BorderSide(color: Colors.grey.shade200))),
                        alignment: Alignment.center,
                        height: rpx(30),
                        child: TextWidget(
                            getScore(widget.foot.q1_score.toString(), 0)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey.shade200),
                                right:
                                    BorderSide(color: Colors.grey.shade200))),
                        alignment: Alignment.center,
                        height: rpx(30),
                        child: TextWidget(
                            getScore(widget.foot.q2_score.toString(), 0)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey.shade200),
                                right:
                                    BorderSide(color: Colors.grey.shade200))),
                        alignment: Alignment.center,
                        height: rpx(30),
                        child: TextWidget(
                            getScore(widget.foot.q3_score.toString(), 0)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey.shade200),
                                right:
                                    BorderSide(color: Colors.grey.shade200))),
                        alignment: Alignment.center,
                        height: rpx(30),
                        child: TextWidget(
                            getScore(widget.foot.q4_score.toString(), 0)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey.shade200),
                                right:
                                    BorderSide(color: Colors.grey.shade200))),
                        alignment: Alignment.center,
                        height: rpx(30),
                        child: TextWidget(
                            getScore(widget.foot.extraScore.toString(), 0)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: rpx(30),
                        child: TextWidget(getTotalScore(1)),
                      )
                    ]),
                    TableRow(children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right:
                                    BorderSide(color: Colors.grey.shade200))),
                        alignment: Alignment.center,
                        height: rpx(30),
                        child: TextWidget(
                            widget.foot.homeTeam!.nameShort.toString()),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right:
                                    BorderSide(color: Colors.grey.shade200))),
                        alignment: Alignment.center,
                        height: rpx(30),
                        child: TextWidget(
                            getScore(widget.foot.q1_score.toString(), 1)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right:
                                    BorderSide(color: Colors.grey.shade200))),
                        alignment: Alignment.center,
                        height: rpx(30),
                        child: TextWidget(
                            getScore(widget.foot.q2_score.toString(), 1)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right:
                                    BorderSide(color: Colors.grey.shade200))),
                        alignment: Alignment.center,
                        height: rpx(30),
                        child: TextWidget(
                            getScore(widget.foot.q3_score.toString(), 1)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right:
                                    BorderSide(color: Colors.grey.shade200))),
                        alignment: Alignment.center,
                        height: rpx(30),
                        child: TextWidget(
                            getScore(widget.foot.q4_score.toString(), 1)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right:
                                    BorderSide(color: Colors.grey.shade200))),
                        alignment: Alignment.center,
                        height: rpx(30),
                        child: TextWidget(
                            getScore(widget.foot.extraScore.toString(), 1)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: rpx(30),
                        child: TextWidget(getTotalScore(0)),
                      )
                    ])
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(rpx(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: rpx(10),
                              children: [
                                Container(
                                  height: rpx(14),
                                  width: rpx(2),
                                  color: Colors.yellow,
                                ),
                                TextWidget(
                                    widget.foot.awayTeam!.nameShort!.toString())
                              ],
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: rpx(10),
                              children: [
                                TextWidget(widget.foot.homeTeam!.nameShort!
                                    .toString()),
                                Container(
                                  height: rpx(14),
                                  width: rpx(2),
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [getBatleWidget("3分球得分", "points3")],
                        ),
                        Column(
                          children: [getBatleWidget("2分球得分", "points2")],
                        ),
                        Column(
                          children: [
                            getBatleWidget("罚球得分", "free_throws_made")
                          ],
                        ),
                        Column(
                          children: [
                            getBatleWidget("罚球命中率", "free_throws_percent")
                          ],
                        ),
                      ],
                    ),
                  )
                ],
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
