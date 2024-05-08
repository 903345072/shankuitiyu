import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/model/footModel.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class footGame extends StatefulWidget {
  JcFootModel footListElement;

  footGame({super.key, required this.footListElement});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _footGame();
  }
}

class _footGame extends State<footGame> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return onClick(
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1,
                      color: const Color.fromARGB(31, 104, 103, 103)))),
          padding: EdgeInsets.all(rpx(10)),
          child: Column(
            children: [
              Container(
                height: rpx(50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        flex: 5,
                        child: Container(
                          padding: EdgeInsets.only(right: rpx(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: rpx(70),
                                    child: TextWidget(
                                      widget.footListElement.leagues!.nameShort
                                          .toString(),
                                      color: hexToColor(widget
                                          .footListElement.leagues!.color),
                                    ),
                                  ),
                                  Text(
                                    widget.footListElement.startAt.toString(),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: rpx(13)),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      widget.footListElement.hasLiveScore == 1
                                          ? Image.asset(
                                              "assets/images/live.png",
                                              width: rpx(18),
                                            )
                                          : Container(),
                                      2 > 1
                                          ? Image.asset(
                                              "assets/images/bigdata.png",
                                              width: rpx(18))
                                          : Container()
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      widget.footListElement.homeTeam!
                                                      .teamData !=
                                                  null &&
                                              widget.footListElement.homeTeam!
                                                      .teamData!.yellowCards
                                                      .toString() !=
                                                  "0" &&
                                              widget.footListElement.homeTeam!
                                                      .teamData!.yellowCards !=
                                                  null
                                          ? Container(
                                              padding: EdgeInsets.only(
                                                  right: 2, left: 2),
                                              color: Color(0xffef9f30),
                                              child: Text(
                                                widget.footListElement.homeTeam!
                                                    .teamData!.yellowCards
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: rpx(13)),
                                              ),
                                            )
                                          : Container(),
                                      widget.footListElement.homeTeam!
                                                      .teamData !=
                                                  null &&
                                              widget.footListElement.homeTeam!
                                                      .teamData!.redCards !=
                                                  "0" &&
                                              widget.footListElement.homeTeam!
                                                      .teamData!.redCards !=
                                                  null
                                          ? Container(
                                              margin:
                                                  EdgeInsets.only(left: rpx(3)),
                                              padding: EdgeInsets.only(
                                                  right: 2, left: 2),
                                              color: Colors.red,
                                              child: Text(
                                                widget.footListElement.homeTeam!
                                                    .teamData!.redCards
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: rpx(13)),
                                              ),
                                            )
                                          : Container(),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        width: rpx(65),
                                        child: Text(
                                          widget.footListElement.homeTeam!
                                              .nameShort
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: rpx(14)),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            getFootGameStateText(
                                widget.footListElement.statusId,
                                widget.footListElement.elapsed),
                            getFootGameScoreText(
                                widget.footListElement.statusId,
                                widget.footListElement.currentScore)
                          ],
                        )),
                    Expanded(
                        flex: 5,
                        child: Container(
                          padding: EdgeInsets.only(left: rpx(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextWidget(
                                        widget.footListElement.jc != null
                                            ? widget
                                                .footListElement.jc!.matchNumStr
                                                .toString()
                                            : "",
                                        color: Colors.grey),
                                    Container(
                                      width: rpx(15),
                                    ),
                                    widget.footListElement.plan_num! > 0
                                        ? Container(
                                            height: rpx(20),
                                            padding: EdgeInsets.only(
                                                left: 3, right: 3),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.red,
                                                    width: 1)),
                                            child: Text(
                                              widget.footListElement.plan_num
                                                      .toString() +
                                                  "方案",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: rpx(11)),
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: rpx(65),
                                        child: Text(
                                          widget.footListElement.awayTeam!
                                              .nameShort
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: rpx(14)),
                                        ),
                                      ),
                                      widget.footListElement.awayTeam!
                                                      .teamData !=
                                                  null &&
                                              widget.footListElement.awayTeam!
                                                      .teamData!.yellowCards
                                                      .toString() !=
                                                  "0" &&
                                              widget.footListElement.awayTeam!
                                                      .teamData!.yellowCards !=
                                                  null
                                          ? Container(
                                              margin: EdgeInsets.only(
                                                  right: rpx(3)),
                                              padding: EdgeInsets.only(
                                                  right: 2, left: 2),
                                              color: Color(0xffef9f30),
                                              child: Text(
                                                widget.footListElement.awayTeam!
                                                    .teamData!.yellowCards
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: rpx(13)),
                                              ),
                                            )
                                          : Container(),
                                      widget.footListElement.awayTeam!
                                                      .teamData !=
                                                  null &&
                                              widget.footListElement.awayTeam!
                                                      .teamData!.redCards
                                                      .toString() !=
                                                  "0" &&
                                              widget.footListElement.awayTeam!
                                                      .teamData!.redCards !=
                                                  null
                                          ? Container(
                                              padding: EdgeInsets.only(
                                                  right: 2, left: 2),
                                              color: Colors.red,
                                              child: Text(
                                                widget.footListElement.awayTeam!
                                                    .teamData!.redCards
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: rpx(13)),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  onClick(
                                      Icon(
                                        widget.footListElement.flow == 0
                                            ? Icons.favorite_border
                                            : Icons.favorite,
                                        color: Colors.red,
                                        size: rpx(20),
                                      ), () {
                                    G.api.gameAdd.collectMatch({
                                      "id": widget.footListElement.id
                                    }).then((value) async {
                                      setState(() {
                                        widget.footListElement.flow =
                                            widget.footListElement.flow == 0
                                                ? 1
                                                : 0;
                                      });
                                      SharedPreferences sharedPreferences =
                                          await SharedPreferences.getInstance();
                                      List<String>? dd = sharedPreferences
                                          .getStringList("flows");
                                      if (widget.footListElement.flow == 0) {
                                        dd!.remove(widget.footListElement.id
                                            .toString());
                                      } else {
                                        dd!.add(widget.footListElement.id
                                            .toString());
                                      }
                                      sharedPreferences.setStringList(
                                          "flows", dd);
                                    });
                                  })
                                ],
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              getBottom(widget.footListElement)
            ],
          ),
        ), () {
      G.router.navigateTo(
          context,
          // ignore: prefer_interpolation_to_compose_strings
          "/gameDetail" +
              G.parseQuery(
                  params: {"id": widget.footListElement.id, "is_detail": 0}),
          transition: TransitionType.inFromRight);
    });
  }

  getBottom(JcFootModel e) {
    var c = [2, 3, 4, 5, 7, 10];
    if (c.contains(e.statusId)) {
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: rpx(6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              spacing: rpx(3),
              children: [
                Text(
                  "半(${e.halfScore})",
                  style: TextStyle(fontSize: rpx(12), color: Colors.black54),
                ),
                e.homeTeam!.teamData != null &&
                        e.homeTeam!.teamData!.cornerKicks != null
                    ? Text(
                        "角(${"${e.homeTeam!.teamData!.cornerKicks!}:${e.awayTeam!.teamData!.cornerKicks!}"})",
                        style:
                            TextStyle(fontSize: rpx(12), color: Colors.black54),
                      )
                    : Container(),
              ],
            ),
            Container()
          ],
        ),
      );
    }
    return Container();
  }
}
