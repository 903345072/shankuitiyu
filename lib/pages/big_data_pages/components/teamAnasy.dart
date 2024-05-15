import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/big_data_pages/components/gamePieChart.dart';
import 'package:jingcai_app/pages/big_data_pages/components/spfTrendChart.dart';
import 'package:jingcai_app/pages/big_data_pages/components/teamTenTrend.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';

class teamAnasy extends StatefulWidget {
  int? id;
  teamAnasy({required this.id});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return teamAnasy_();
  }
}

class teamAnasy_ extends State<teamAnasy> {
  List<dynamic> homes = [];
  List<dynamic> aways = [];
  String home_name = "";
  String away_name = "";
  double home_get_balls = 0;
  double home_loss_balls = 0;
  double away_get_balls = 0;
  double away_loss_balls = 0;
  @override
  void initState() {
    super.initState();
    G.api.game.getHistoryTeamRecorde({"id": widget.id}).then((value) {
      setState(() {
        homes = value["home_rate"];
        aways = value["away_rate"];
        home_name = value["home_name"];
        away_name = value["away_name"];

        home_get_balls = double.parse(value["home_get_balls"].toString());
        home_loss_balls = double.parse(value["home_loss_balls"].toString());
        away_get_balls = double.parse(value["away_get_balls"].toString());
        away_loss_balls = double.parse(value["away_loss_balls"].toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: rpx(15)),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: rpx(10),
            children: [
              Container(
                color: Colors.red,
                width: rpx(3),
                height: rpx(16),
              ),
              TextWidget(
                "球队分析",
                fontSize: rpx(17),
                fontWeight: FontWeight.bold,
              )
            ],
          ),
        ),
        SizedBox(
          height: rpx(15),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: rpx(15)),
          padding: EdgeInsets.symmetric(horizontal: rpx(15), vertical: rpx(6)),
          color: Color.fromRGBO(0, 40, 104, .06),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget("近10场战绩"),
              Wrap(
                spacing: rpx(10),
                children: [
                  Row(
                    children: [
                      Container(
                        width: rpx(10),
                        height: rpx(10),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(rpx(10))),
                      ),
                      TextWidget("胜")
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: rpx(10),
                        height: rpx(10),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(rpx(10))),
                      ),
                      TextWidget("平")
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: rpx(10),
                        height: rpx(10),
                        decoration: BoxDecoration(
                            color: Color(0xff002868),
                            borderRadius: BorderRadius.circular(rpx(10))),
                      ),
                      TextWidget("负")
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        homes.length > 0
            ? teamTenTrend(
                homes: homes,
                name: home_name,
              )
            : Container(),
        aways.length > 0
            ? teamTenTrend(
                homes: aways,
                name: away_name,
              )
            : Container(),
        homes.length > 0 && aways.length > 0
            ? Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(
                        horizontal: rpx(15), vertical: rpx(15)),
                    padding: EdgeInsets.symmetric(
                        horizontal: rpx(15), vertical: rpx(6)),
                    color: Color.fromRGBO(0, 40, 104, .06),
                    child: TextWidget("近10场均入场&失球数"),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: rpx(15)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget("场入球数"),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: rpx(10),
                                      height: rpx(10),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(rpx(10))),
                                    ),
                                    TextWidget("$home_name$home_get_balls")
                                  ],
                                ),
                                Container(
                                  width: rpx(10),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: rpx(10),
                                      height: rpx(10),
                                      decoration: BoxDecoration(
                                          color: Color(0xff002868),
                                          borderRadius:
                                              BorderRadius.circular(rpx(10))),
                                    ),
                                    TextWidget("$away_name$away_get_balls")
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              color: Colors.red,
                              height: rpx(20),
                              width: getHomeGetWidh(),
                            ),
                            Container(
                              color: Color(0xff002868),
                              height: rpx(20),
                              width: getAwayGetWidh(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: rpx(20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget("场失球数"),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: rpx(10),
                                      height: rpx(10),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(rpx(10))),
                                    ),
                                    TextWidget("$home_name$home_loss_balls")
                                  ],
                                ),
                                Container(
                                  width: rpx(10),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: rpx(10),
                                      height: rpx(10),
                                      decoration: BoxDecoration(
                                          color: Color(0xff002868),
                                          borderRadius:
                                              BorderRadius.circular(rpx(10))),
                                    ),
                                    TextWidget("$away_name$away_loss_balls")
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              color: Colors.red,
                              height: rpx(20),
                              width: getHomeLossWidh(),
                            ),
                            Container(
                              color: Color(0xff002868),
                              height: rpx(20),
                              width: getAwayLossWidh(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: rpx(10),
                        ),
                        SizedBox(
                          height: rpx(10),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Container()
      ],
    );
  }

  double getHomeGetWidh() {
    if (home_get_balls + away_get_balls > 0) {
      return (MediaQuery.of(context).size.width - rpx(50)) *
          (home_get_balls / (home_get_balls + away_get_balls));
    } else {
      return (MediaQuery.of(context).size.width - rpx(50)) * 0.5;
    }
  }

  double getAwayGetWidh() {
    if (home_get_balls + away_get_balls > 0) {
      return (MediaQuery.of(context).size.width - rpx(50)) *
          (away_get_balls / (home_get_balls + away_get_balls));
    } else {
      return (MediaQuery.of(context).size.width - rpx(50)) * 0.5;
    }
  }

  double getHomeLossWidh() {
    if (home_loss_balls + away_loss_balls > 0) {
      return (MediaQuery.of(context).size.width - rpx(50)) *
          (home_loss_balls / (home_loss_balls + away_loss_balls));
    } else {
      return (MediaQuery.of(context).size.width - rpx(50)) * 0.5;
    }
  }

  double getAwayLossWidh() {
    if (home_loss_balls + away_loss_balls > 0) {
      return (MediaQuery.of(context).size.width - rpx(50)) *
          (away_loss_balls / (home_loss_balls + away_loss_balls));
    } else {
      return (MediaQuery.of(context).size.width - rpx(50)) * 0.5;
    }
  }
}
