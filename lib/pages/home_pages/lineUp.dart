import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';

class lineUp extends StatefulWidget {
  int? id;
  lineUp({required this.id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return lineUp_();
  }
}

class lineUp_ extends State<lineUp> {
  Map home_player = {};
  Map away_player = {};
  Map foot = {};

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    G.api.gameAdd.getLineUp({"id": widget.id}).then((value) {
      setState(() {
        home_player = value["homes"];

        away_player = value["aways"];
        foot = value["foot"];
      });
    });
  }

  Widget getSMY(Map player, String field) {
    Widget c = Container();

    if (player.isNotEmpty) {
      if (player[field] != null) {
        List data = [];
        List s = player[field];
        s.forEach((element) {
          if (element["is_substitute"] == "0") {
            data.add(element);
          }
        });

        if (data.isNotEmpty) {
          c = Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(data.length, (index) {
                Map smy = data[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        smy['player'] != null
                            ? Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(rpx(40)),
                                    border: Border.all(
                                        width: rpx(1), color: Colors.white)),
                                width: rpx(40),
                                height: rpx(40),
                                child: smy['player']["logo"] != null
                                    ? Image.network(
                                        smy['player']["logo"],
                                        fit: BoxFit.cover,
                                      )
                                    : SizedBox(
                                        width: rpx(40),
                                        height: rpx(40),
                                      ),
                              )
                            : SizedBox(
                                width: rpx(50),
                                height: rpx(50),
                              ),
                        Positioned(
                            bottom: 0,
                            child: Container(
                              padding: EdgeInsets.all(rpx(1)),
                              color: Colors.white,
                              child: TextWidget(smy["shirt_number"].toString()),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: rpx(5),
                    ),
                    TextWidget(
                      smy['player'] != null ? smy['player']["name_short"] : "",
                      color: Colors.white,
                    )
                  ],
                );
              }),
            ),
          );
        }
      }
    }
    return c;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(rpx(5)),
              child: Image.asset(
                "assets/images/lineupBack.png",
                height: rpx(750),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(top: rpx(10), child: getSMY(home_player, "5")),
            Positioned(top: rpx(100), child: getSMY(home_player, "4")),
            Positioned(top: rpx(200), child: getSMY(home_player, "3")),
            Positioned(top: rpx(300), child: getSMY(home_player, "1")),
            Positioned(top: rpx(400), child: getSMY(away_player, "1")),
            Positioned(top: rpx(500), child: getSMY(away_player, "3")),
            Positioned(top: rpx(600), child: getSMY(away_player, "4")),
            Positioned(top: rpx(690), child: getSMY(away_player, "5")),
          ],
        ),
        Container(
          height: rpx(3),
          color: Color(0xfff0f0f0),
        ),
        Container(
          height: rpx(10),
        ),
        Container(
          margin: EdgeInsets.only(left: rpx(10), bottom: rpx(10)),
          alignment: Alignment.centerLeft,
          child: TextWidget("首发阵容"),
        ),
        foot.isNotEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.46,
                    child: Table(
                      border: TableBorder.all(width: rpx(0.5)),
                      children: getChild(home_player, "home_team", "0"),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.46,
                    child: Table(
                      border: TableBorder.all(width: rpx(0.5)),
                      children: getChild(away_player, "away_team", "0"),
                    ),
                  )
                ],
              )
            : Container(),
        Container(
          height: rpx(3),
          color: Color(0xfff0f0f0),
        ),
        Container(
          height: rpx(10),
        ),
        Container(
          margin: EdgeInsets.only(left: rpx(10), bottom: rpx(10)),
          alignment: Alignment.centerLeft,
          child: TextWidget("替补"),
        ),
        foot.isNotEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.46,
                    child: Table(
                      border: TableBorder.all(width: rpx(0.5)),
                      children: getChild(home_player, "home_team", "1"),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.46,
                    child: Table(
                      border: TableBorder.all(width: rpx(0.5)),
                      children: getChild(away_player, "away_team", "1"),
                    ),
                  )
                ],
              )
            : Container(),
      ],
    );
  }

  List<TableRow> getChild(Map player, String team, String tibu) {
    List<TableRow> c = [];

    c.add(TableRow(
        decoration: BoxDecoration(color: Color(0xfff0f0f0)),
        children: [
          Container(
            alignment: Alignment.center,
            height: rpx(40),
            child: TextWidget(foot[team]["name_short"]),
          ),
        ]));

    player.forEach((key, value) {
      List d = value;
      d.forEach((element) {
        if (element["is_substitute"] == tibu) {
          bool hava_pic = false;
          if (element["player"] != null) {
            if (element["player"]["logo"] != null) {
              hava_pic = true;
            }
          }

          c.add(TableRow(children: [
            Container(
              alignment: Alignment.center,
              height: rpx(40),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: rpx(10),
                children: [
                  TextWidget(element["shirt_number"].toString()),
                  hava_pic
                      ? Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              element["player"]["logo"],
                              width: rpx(30),
                              height: rpx(30),
                            ),
                          ),
                        )
                      : Container(
                          width: rpx(30),
                          height: rpx(30),
                        ),
                  element["player"] != null
                      ? Container(
                          width: rpx(50),
                          child: TextWidget(
                            element["player"]["name_short"].toString(),
                            fontSize: rpx(12),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ]));
        }
      });
    });
    return c;
  }
}
