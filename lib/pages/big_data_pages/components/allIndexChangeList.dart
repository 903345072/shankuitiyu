import 'package:flutter/material.dart';
import 'package:jingcai_app/components/payWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class allIndexChangeList extends StatefulWidget {
  String price = "0";

  int type = 1;
  allIndexChangeList({required this.type, required this.price});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return allIndexChangeList_();
  }
}

class allIndexChangeList_ extends State<allIndexChangeList> {
  int hava_index_change_vip = 1;
  List recommend = [];
  List history = [];

  int state = 1;
  int pageNo = 1;
  bool is_buy = false;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    getData(1);
    getIsBuy();
  }

  getIsBuy() {
    G.api.user.getIsBuy({"id": 2}).then((value) {
      setState(() {
        is_buy = value == 1 ? true : false;
      });
    });
  }

  Future getData(int state) {
    return G.api.game.getIndexChangeData(
        {"state": state, "type": widget.type, "page": pageNo}).then((value) {
      setState(() {
        recommend.addAll(value);
        List new_lsit = recommend
            .where((element) => element["foot"]["status_id"] == 1)
            .toList();
        recommend.removeWhere((element) => element["foot"]["status_id"] == 1);
        recommend.insertAll(0, new_lsit);
      });
      return value;
    });
  }

  void _onRefresh() async {
    // monitor network fetch
    setState(() {
      pageNo = 1;
      recommend = [];
      history = [];
    });
    getData(1).then((value) {
      refreshController.refreshCompleted();
    });

    // if failed,use refreshFailed()
  }

  void _onLoading() async {
    // monitor network fetch
    setState(() {
      pageNo++;
    });
    getData(1).then((value) {
      if (value.isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    });
    // if failed,use loadFailed(),if no data return,use LoadNodata()
  }

  String getMetText(int type) {
    var a = [1, 2, 3];
    var b = [4, 5, 6];
    var c = [7, 8, 9];
    String str = "";
    if (a.contains(type)) {
      str = "胜平负";
    }
    if (b.contains(type)) {
      str = "让球";
    }
    if (c.contains(type)) {
      str = "大小球";
    }
    return str;
  }

  String getInitPl(Map pl, int type) {
    var arr = {
      1: "win",
      2: "draw",
      3: "loss",
      4: "win",
      5: "handicap",
      6: "loss",
      7: "dq",
      8: "handicap",
      9: "xq"
    };

    return pl[arr[type]];
  }

  Color getColor(double cha) {
    Color c = Colors.black54;

    if (cha > 0) {
      c = Colors.red;
    }
    if (cha < 0) {
      c = Colors.green;
    }

    return c;
  }

  Icon getIcon(double cha) {
    Icon c = Icon(
      Icons.trending_flat,
      size: rpx(16),
    );
    if (cha > 0) {
      c = Icon(Icons.arrow_upward, color: Colors.red, size: rpx(16));
    }
    if (cha < 0) {
      c = Icon(Icons.arrow_downward, color: Colors.green, size: rpx(16));
    }

    return c;
  }

  String getIndexDesc(double value, int type) {
    var map = {
      1: "主胜",
      2: "平局",
      3: "客胜",
      4: "让胜",
      5: "让球",
      6: "让负",
      7: "大球",
      8: "大小球",
      9: "小球"
    };
    var str = "";
    var dir = "升";
    if (value <= 0) {
      dir = "降";
    }
    if (type == 5 || type == 8) {
      return map[type]! + "指数" + dir + value.toString() + "个层级";
    } else {
      return map[type]! + "指数" + dir + (value * 100).toStringAsFixed(0) + "%";
    }
  }

  Widget getFirstIndex(Map first, Map init_pl, int type) {
    var a = [1, 2, 3];
    var b = [4, 5, 6];
    var c = [7, 8, 9];

    if (a.contains(type)) {
      return Wrap(
        spacing: rpx(5),
        children: [
          Row(
            children: [
              TextWidget(
                first["win"],
                color: getColor(
                    double.parse(first["win"]) - double.parse(init_pl["win"])),
              ),
              getIcon(
                  double.parse(first["win"]) - double.parse(init_pl["win"])),
            ],
          ),
          Row(
            children: [
              TextWidget(
                first["draw"],
                color: getColor(double.parse(first["draw"]) -
                    double.parse(init_pl["draw"])),
              ),
              getIcon(
                  double.parse(first["draw"]) - double.parse(init_pl["draw"])),
            ],
          ),
          Row(
            children: [
              TextWidget(first["loss"],
                  color: getColor(double.parse(first["loss"]) -
                      double.parse(init_pl["loss"]))),
              getIcon(
                  double.parse(first["loss"]) - double.parse(init_pl["loss"])),
            ],
          ),
        ],
      );
    }
    if (b.contains(type)) {
      return Wrap(
        spacing: rpx(5),
        children: [
          Row(
            children: [
              TextWidget(first["win"],
                  color: getColor(double.parse(first["win"]) -
                      double.parse(init_pl["win"]))),
              getIcon(
                  double.parse(first["win"]) - double.parse(init_pl["win"])),
            ],
          ),
          Row(
            children: [
              TextWidget(
                first["loss"],
                color: getColor(double.parse(first["loss"]) -
                    double.parse(init_pl["loss"])),
              ),
              getIcon(
                  double.parse(first["loss"]) - double.parse(init_pl["loss"])),
            ],
          ),
        ],
      );
    }

    if (c.contains(type)) {
      return Wrap(
        spacing: rpx(5),
        children: [
          Row(
            children: [
              TextWidget(
                first["dq"],
                color: getColor(
                    double.parse(first["dq"]) - double.parse(init_pl["dq"])),
              ),
              getIcon(double.parse(first["dq"]) - double.parse(init_pl["dq"])),
            ],
          ),
          Row(
            children: [
              TextWidget(
                first["xq"],
                color: getColor(
                    double.parse(first["xq"]) - double.parse(init_pl["xq"])),
              ),
              getIcon(double.parse(first["xq"]) - double.parse(init_pl["xq"])),
            ],
          ),
        ],
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: rpx(10)),
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              header: classHeader(),
              footer: classFooter(),
              controller: refreshController,
              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  SizedBox(
                    height: rpx(25),
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.start,
                    spacing: rpx(10),
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: rpx(10)),
                          color: Colors.red,
                          width: rpx(3),
                          height: rpx(16),
                          alignment: Alignment.center),
                      TextWidget(
                        "最新推荐",
                        fontSize: rpx(17),
                        fontWeight: FontWeight.bold,
                      ),
                      // Wrap(
                      //   children: [
                      //     TextWidget(
                      //       "(",
                      //       fontSize: rpx(17),
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //     TextWidget(
                      //       recommend.length.toString(),
                      //       fontSize: rpx(17),
                      //       color: Colors.red,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //     TextWidget(
                      //       "场)",
                      //       fontSize: rpx(17),
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                  SizedBox(
                    height: rpx(10),
                  ),
                  hava_index_change_vip == 0
                      ? Container(
                          margin: EdgeInsets.only(top: rpx(10)),
                          alignment: Alignment.center,
                          height: rpx(30),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(95, 250, 195, 191),
                              borderRadius: BorderRadius.circular(rpx(30))),
                          child: onClick(
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: rpx(3),
                                children: [
                                  Icon(
                                    Icons.lock,
                                    color: Colors.red,
                                    size: rpx(17),
                                  ),
                                  TextWidget("开通后查看指数异动赛事",
                                      color: Color.fromARGB(255, 253, 67, 54))
                                ],
                              ),
                              () => null),
                        )
                      : recommend.isNotEmpty
                          ? Column(
                              children: List.generate(
                                  recommend.length,
                                  (index) => payWidget(
                                      price: widget.price,
                                      button: Container(
                                        padding: EdgeInsets.all(rpx(15)),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(rpx(10))),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: rpx(10),
                                            vertical: rpx(5)),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextWidget(
                                                  recommend[index]["foot"]
                                                      ["leagues"]["name_short"],
                                                  fontSize: rpx(14),
                                                  color: hexToColor(
                                                      recommend[index]["foot"]
                                                          ["color"]),
                                                ),
                                                Wrap(
                                                  spacing: rpx(10),
                                                  children: [
                                                    TextWidget(
                                                      recommend[index]["foot"]
                                                          ["start_at"],
                                                      color: Colors.black54,
                                                    ),
                                                    getFootGameStateText(
                                                        recommend[index]["foot"]
                                                            ["status_id"],
                                                        recommend[index]["foot"]
                                                            ["elapsed"]),
                                                  ],
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: rpx(10)),
                                                  height: rpx(25),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Color(
                                                              0xffef2f2f)),
                                                      color: Color.fromRGBO(
                                                          239, 47, 47, .1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              rpx(6))),
                                                  child: TextWidget(
                                                    getMetText(recommend[index]
                                                        ["type"]),
                                                    color: Colors.red,
                                                    fontSize: rpx(12),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Divider(
                                              height: rpx(25),
                                              color: Color.fromARGB(
                                                  255, 241, 241, 241),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Wrap(
                                                      spacing: rpx(15),
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .center,
                                                      children: [
                                                        netImg(
                                                            recommend[index]
                                                                        ["foot"]
                                                                    [
                                                                    "home_team"]
                                                                ["logo"],
                                                            rpx(25),
                                                            rpx(25)),
                                                        TextWidget(recommend[
                                                                        index]
                                                                    ["foot"]
                                                                ["home_team"]
                                                            ["name_short"])
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: rpx(10),
                                                    ),
                                                    Wrap(
                                                      spacing: rpx(15),
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .center,
                                                      children: [
                                                        netImg(
                                                            recommend[index]
                                                                        ["foot"]
                                                                    [
                                                                    "away_team"]
                                                                ["logo"],
                                                            rpx(25),
                                                            rpx(25)),
                                                        TextWidget(recommend[
                                                                        index]
                                                                    ["foot"]
                                                                ["away_team"]
                                                            ["name_short"])
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Wrap(
                                                  spacing: rpx(5),
                                                  children: [
                                                    TextWidget(
                                                      getInitPl(
                                                          recommend[index]
                                                              ["init_pl"],
                                                          recommend[index]
                                                              ["type"]),
                                                      fontSize: rpx(16),
                                                    ),
                                                    Image.asset(
                                                      recommend[index]
                                                                  ["value"] >
                                                              0
                                                          ? "assets/images/direct_up.png"
                                                          : "assets/images/direct_down.png",
                                                      width: rpx(25),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    TextWidget(
                                                      getInitPl(
                                                          recommend[index]
                                                              ["first_change"],
                                                          recommend[index]
                                                              ["type"]),
                                                      fontSize: rpx(16),
                                                      color: recommend[index]
                                                                  ["value"] >
                                                              0
                                                          ? Colors.red
                                                          : Colors.green,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: rpx(15),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: rpx(10)),
                                                  height: rpx(25),
                                                  alignment: Alignment.center,
                                                  color: Color(0xfff0f0f0),
                                                  child: Wrap(
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center,
                                                    spacing: rpx(10),
                                                    children: [
                                                      TextWidget("首"),
                                                      getFirstIndex(
                                                          recommend[index]
                                                              ["first_change"],
                                                          recommend[index]
                                                              ["init_pl"],
                                                          recommend[index]
                                                              ["type"])
                                                    ],
                                                  ),
                                                ),
                                                TextWidget(getIndexDesc(
                                                    double.parse(
                                                        recommend[index]
                                                                ["value"]
                                                            .toString()),
                                                    recommend[index]["type"]))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      pay_after: (Map data) {
                                        setState(() {
                                          is_buy = data["is_buy"] == 1
                                              ? true
                                              : false;
                                        });
                                      },
                                      click: is_buy ||
                                              recommend[index]["foot"]
                                                      ["statusId"] ==
                                                  10
                                          ? () {
                                              G.router.navigateTo(
                                                  context,
                                                  "/indexChangeDetail" +
                                                      G.parseQuery(params: {
                                                        "id": recommend[index]
                                                            ["match_id"]
                                                      }));
                                            }
                                          : null,
                                      map: {"id": 2},
                                      type: 2)),
                            )
                          : Container(
                              child: Image.asset(
                                "assets/images/noGameData.png",
                                fit: BoxFit.cover,
                                width: rpx(212),
                                height: rpx(176),
                              ),
                            ),
                  SizedBox(
                    height: rpx(10),
                  ),
                ],
              ),
            )),
        !is_buy
            ? Positioned(
                bottom: rpx(40),
                left: 0,
                right: 0,
                child: payWidget(
                  price: widget.price,
                  button: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: rpx(20)),
                    margin: EdgeInsets.symmetric(horizontal: rpx(60)),
                    height: rpx(45),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(rpx(45))),
                    child: TextWidget(
                      "开通即可查看全部比赛模型",
                      color: Colors.white,
                      fontSize: rpx(16),
                    ),
                  ),
                  pay_after: (Map data) {
                    setState(() {
                      is_buy = data["is_buy"] == 1 ? true : false;
                    });
                  },
                  map: {"id": 1},
                  type: 2,
                ))
            : Container(),
      ],
    );
  }
}
