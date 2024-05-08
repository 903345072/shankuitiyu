import 'dart:math';

import 'package:date_format/date_format.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:jingcai_app/components/payWidget.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/big_data_pages/components/target.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class boSongDistribute extends StatefulWidget {
  String price = "0";
  int buy_count = 0;
  boSongDistribute({required this.price, required this.buy_count});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dataReport_();
  }
}

class dataReport_ extends State<boSongDistribute> {
  Color co = Colors.white;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  late ScrollController _scrollController = ScrollController();
  List swiperList = [1, 2, 3];
  List weekList = [];
  List data = [];
  int page = 1;
  int day_index = 5;
  bool is_buy = false;

  getIsBuy() {
    G.api.user.getIsBuy({"id": 3}).then((value) {
      setState(() {
        is_buy = value == 1 ? true : false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double alpha = 1 - (offset / rpx(120));

      if (alpha < 0.5) {
        co = Colors.black;
      } else if (alpha >= 1) {
        alpha = 1;
      }
      if (alpha > 0.9) {
        co = Colors.white;
      }
      setState(() {
        co = co;
      });
    });
    var dd_ = DateTime.now();
    var weekday = [" ", "周一", "周二", "周三", "周四", "周五", "周六", "周日"];
    for (var i = 5; i >= 0; i--) {
      DateTime dg = dd_.subtract(Duration(days: i));
      weekList.add({
        "date": formatDate(dg, [m, '-', dd]),
        "week": weekday[dg.weekday],
        "stamp": formatDate(dg, [yyyy, '-', mm, '-', dd]),
      });
      var y_ = formatDate(dg, [yyyy]);
      var m_ = formatDate(dg, [mm]);
      var d_ = formatDate(dg, [dd]);
    }
    var ddd_ = DateTime.now();
    DateTime to = ddd_.add(Duration(days: 1));
    weekList.add({
      "date": formatDate(to, [m, '-', dd]),
      "week": weekday[to.weekday],
      "stamp": formatDate(to, [yyyy, '-', mm, '-', dd]),
    });
    getIsBuy();
    getGameList();
  }

  Future getGameList() async {
    return G.api.game.getBoSongData(
        q: {"date": weekList[day_index]["stamp"], "page": page}).then((value) {
      setState(() {
        data.addAll(value);
      });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: _contentView(context, "123"),
    );
  }

  List<TextWidget> getBfWidget(Map p) {
    Container c = Container();
    List<TextWidget> d = [];

    //  p.values.toList().sort();

    var sortedMap = Map.fromEntries(
      p.entries.toList()
        ..sort(
          (e1, e2) => e2.value.compareTo(e1.value),
        ),
    );
    List keys = sortedMap.keys.toList();

    // 只保留前10个元素
    List topTenKeys = keys.sublist(0, min(3, keys.length));
    for (var element in topTenKeys) {
      var ii = element.toString();
      var ddd = "${(double.parse(sortedMap[ii]) * 100).toStringAsFixed(2)}%";
      d.add(TextWidget(element + "($ddd)"));
    }

    return d;
  }

  List<TextWidget> getGoalWidget(List p) {
    Container c = Container();
    List<TextWidget> d = [];

    p.asMap().values.toList().sort();

    var sortedMap = Map.fromEntries(
      p.asMap().entries.toList()
        ..sort(
          (e1, e2) => e2.value.compareTo(e1.value),
        ),
    );
    List keys = sortedMap.keys.toList();
    String k0 = (p[keys[0]] * 100).toStringAsFixed(2) + "%";
    String k1 = (p[keys[1]] * 100).toStringAsFixed(2) + "%";
    String k2 = (p[keys[2]] * 100).toStringAsFixed(2) + "%";
    d.add(TextWidget(keys[0].toString() + "球" + "($k0)"));
    d.add(TextWidget(keys[1].toString() + "球" + "($k1)"));
    d.add(TextWidget(keys[2].toString() + "球" + "($k2)"));
    // 只保留前10个元素
    // List topTenKeys = keys.sublist(0, min(3, keys.length));
    // for (var element in topTenKeys) {
    //   var ii = element.toString();
    //   var ddd = "${(double.parse(sortedMap[ii]) * 100).toStringAsFixed(2)}%";
    //   d.add(TextWidget(element + "球" + "($ddd)"));
    // }

    return d;
  }

  _contentView(context, title) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    double pinnedHeaderHeight = rpx(60) + rpx(statusBarHeight);
    return ExtendedNestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            //标题

            SliverAppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: co,
                ),
                onPressed: () {
                  G.router.pop(context);
                },
              ),
              title: SizedBox(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    "泊松分布",
                    color: co,
                    fontSize: rpx(19),
                  ),
                ],
              )),
              expandedHeight: rpx(170),
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Image.asset(
                      "assets/images/bsfb_back.png",
                      fit: BoxFit.cover,
                      width: rpx(375),
                    ),
                    Positioned(
                        top: rpx(80),
                        left: rpx(15),
                        child: Wrap(
                          direction: Axis.vertical,
                          spacing: rpx(20),
                          children: [
                            Container(
                              width: rpx(280),
                              child: TextWidget(
                                " 依据近20年的赛事大数据，基于比赛中双方球队进球数的概率符合泊松分布的原理，借助泊松分布数学模型，结合双方的进攻、防守、近期状态等数据进行推算比赛进球数和比分概率。",
                                fontSize: rpx(14),
                                maxLines: 4,
                                color: Colors.white,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      TextWidget(
                                        widget.price,
                                        fontSize: rpx(18),
                                        color: Colors.red,
                                      ),
                                      TextWidget(
                                        "金豆/月",
                                        fontSize: rpx(13),
                                        color: Colors.red,
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: rpx(30)),
                                    child: TextWidget(
                                      "${widget.buy_count}人购买",
                                      color: Colors.white,
                                      fontSize: rpx(14),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
              pinned: true,
              floating: true,
            ),
          ];
        },
        pinnedHeaderSliverHeightBuilder: () {
          return pinnedHeaderHeight;
        },
        onlyOneScrollInBody: true,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                          weekList.length,
                          (index) => day_index == index
                              ? getDateWidget(true, weekList[index]["date"],
                                  weekList[index]["week"], index)
                              : getDateWidget(false, weekList[index]["date"],
                                  weekList[index]["week"], index)),
                    ),
                  ),
                  SizedBox(
                    height: rpx(20),
                  ),
                  Expanded(
                      child: SmartRefresher(
                    controller: refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    footer: classFooter(),
                    header: classHeader(),
                    onLoading: _onLoading,
                    onRefresh: _onRefresh,
                    child: ListView(
                      children: List.generate(
                          data.length,
                          (index) => payWidget(
                                price: widget.price,
                                button: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 12,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: rpx(10)),
                                                  child: Container(
                                                    width: rpx(70),
                                                    child: TextWidget(
                                                      data[index]["leagues"]
                                                              ["name_short"]
                                                          .toString(),
                                                      color: hexToColor(
                                                          data[index]["leagues"]
                                                              ["color"]),
                                                    ),
                                                  ),
                                                ),
                                                TextWidget(data[index]
                                                        ["start_at"]
                                                    .toString()
                                                    .substring(5, 16))
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: getFootGameStateText(
                                                data[index]["status_id"],
                                                data[index]["elapsed"]),
                                          ),
                                          Expanded(
                                              flex: 12, child: Container()),
                                        ],
                                      ),
                                      SizedBox(
                                        height: rpx(20),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: rpx(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 12,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  data[index]["home_team"]
                                                              ["logo"] !=
                                                          null
                                                      ? netImg(
                                                          data[index]
                                                                  ["home_team"]
                                                              ["logo"],
                                                          rpx(30),
                                                          rpx(30))
                                                      : Container(
                                                          width: rpx(30),
                                                          height: rpx(30),
                                                        ),
                                                  Container(
                                                    width: rpx(15),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    width: rpx(90),
                                                    child: TextWidget(
                                                      data[index]["home_team"]
                                                              ["name_short"]
                                                          .toString(),
                                                      fontSize: rpx(14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: getFootGameScoreText(
                                                  data[index]["status_id"],
                                                  data[index]["current_score"]),
                                            ),
                                            Expanded(
                                              flex: 12,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    width: rpx(90),
                                                    child: TextWidget(
                                                      data[index]["away_team"]
                                                              ["name_short"]
                                                          .toString(),
                                                      fontSize: rpx(14),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: rpx(15),
                                                  ),
                                                  data[index]["away_team"]
                                                              ["logo"] !=
                                                          null
                                                      ? netImg(
                                                          data[index]
                                                                  ["away_team"]
                                                              ["logo"],
                                                          rpx(30),
                                                          rpx(30))
                                                      : Container(
                                                          width: rpx(30),
                                                          height: rpx(30),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: rpx(15),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: rpx(10)),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: rpx(55),
                                              height: rpx(25),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Color(0xfffeeaea),
                                                  border: Border.all(
                                                      width: 0.7,
                                                      color: Color(0xffef2f2f)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          rpx(5))),
                                              child: TextWidget(
                                                "比分",
                                                color: Colors.red,
                                              ),
                                            ),
                                            Container(
                                              width: rpx(10),
                                            ),
                                            data[index]["score_guess"]
                                                    .isNotEmpty
                                                ? Container(
                                                    width: rpx(280),
                                                    height: rpx(25),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    rpx(5)),
                                                        color:
                                                            Color(0xfff5f5f5)),
                                                    child: Wrap(
                                                      spacing: rpx(10),
                                                      children: getBfWidget(
                                                          data[index]
                                                              ["score_guess"]),
                                                    ),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: rpx(10),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: rpx(10)),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: rpx(55),
                                              height: rpx(25),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      48, 178, 122, .1),
                                                  border: Border.all(
                                                      width: 0.7,
                                                      color: Color(0xff30b27a)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          rpx(5))),
                                              child: TextWidget(
                                                "进球数",
                                                color: Color(0xff30b27a),
                                              ),
                                            ),
                                            Container(
                                              width: rpx(10),
                                            ),
                                            data[index]["goals_guess"]
                                                    .isNotEmpty
                                                ? Container(
                                                    width: rpx(280),
                                                    height: rpx(25),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    rpx(5)),
                                                        color:
                                                            Color(0xfff5f5f5)),
                                                    child: Wrap(
                                                      spacing: rpx(10),
                                                      children: getGoalWidget(
                                                          data[index]
                                                              ["goals_guess"]),
                                                    ),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: rpx(15),
                                      ),
                                      index <= data.length - 2
                                          ? Divider(
                                              height: rpx(1),
                                              color: Color.fromARGB(
                                                  255, 236, 236, 236),
                                            )
                                          : Container(),
                                      SizedBox(
                                        height: rpx(10),
                                      ),
                                    ],
                                  ),
                                ),
                                pay_after: (Map data) {
                                  setState(() {
                                    is_buy = data["is_buy"] == 1 ? true : false;
                                  });
                                },
                                click: is_buy || data[index]["statusId"] == 10
                                    ? () {
                                        G.router.navigateTo(
                                            context,
                                            "/bsDetail" +
                                                G.parseQuery(params: {
                                                  "id": data[index]["id"]
                                                }));
                                      }
                                    : null,
                                map: {"id": 3},
                                type: 2,
                              )),
                    ),
                  ))
                ],
              ),
            ),
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
        ));
  }

  getDateWidget(bool b, String date, String week, int index) {
    Widget d = Container();

    if (b == false) {
      d = Container(
        padding: EdgeInsets.symmetric(horizontal: rpx(5), vertical: rpx(8)),
        child: Wrap(
          spacing: rpx(3),
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          children: [
            TextWidget(
              date,
              fontSize: rpx(13),
            ),
            TextWidget(
              week,
              fontSize: rpx(13),
              color: const Color.fromARGB(255, 116, 116, 116),
            )
          ],
        ),
      );
    } else {
      d = Container(
        padding: EdgeInsets.symmetric(horizontal: rpx(5), vertical: rpx(8)),
        decoration: BoxDecoration(
            color: Color(0xfffdeaea),
            border: Border.all(width: 1, color: Color(0xffef2f2f)),
            borderRadius: BorderRadius.circular(rpx(5))),
        child: Wrap(
          spacing: rpx(3),
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          children: [
            TextWidget(date, fontSize: rpx(13), color: Color(0xffef2f2f)),
            TextWidget(
              week,
              fontSize: rpx(13),
              color: Color(0xffef2f2f),
            )
          ],
        ),
      );
    }
    return onClick(d, () {
      setState(() {
        data = [];
        day_index = index;
        page = 1;
      });
      getGameList();
    });
  }

  void _onLoading() async {
    setState(() {
      page++;
    });

    getGameList().then((value) {
      if (value.isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    });
  }

  void _onRefresh() async {
    setState(() {
      page = 1;
    });

    // monitor network fetch
    getGameList();

    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }
}
