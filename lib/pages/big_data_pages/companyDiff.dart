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

class companyDiff extends StatefulWidget {
  String price = "0";
  int buy_count = 0;
  companyDiff({required this.price, required this.buy_count});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dataReport_();
  }
}

class dataReport_ extends State<companyDiff> {
  Color co = Colors.white;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  late ScrollController _scrollController = ScrollController();
  List swiperList = [1, 2, 3];
  List weekList = [];
  List data = [];
  int day_index = 5;
  int page = 1;
  bool is_buy = false;
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

  getIsBuy() {
    G.api.user.getIsBuy({"id": 5}).then((value) {
      setState(() {
        is_buy = value == 1 ? true : false;
      });
    });
  }

  Future getGameList() async {
    return await G.api.game.getCompanyDifference(
        q: {"date": weekList[day_index]["stamp"], "page": page}).then((value) {
      setState(() {
        data.addAll(value["list"]);
        page = value["page"];
      });

      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
                    "机构分歧",
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
                      "assets/images/indexDiffBack.png",
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
                                " 根据福神数据库模型进行分析运算，计算各公司机构的机构分歧差异数值。通过与返还率的对比，反应各项赔率存在的风险和机构态度。机构分歧大于返还率，则不容易打出，小于则容易打出。 ",
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
              color: Color(0xfff5f5f5),
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
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: ListView(
                      children: List.generate(
                          data.length,
                          (index) => payWidget(
                              price: widget.price,
                              button: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: rpx(10)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: rpx(10), vertical: rpx(15)),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(rpx(8)),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            TextWidget(
                                              data[index]["leagues"]
                                                  ["name_short"],
                                              color: hexToColor(data[index]
                                                  ["leagues"]["color"]),
                                            ),
                                            Container(
                                              width: rpx(30),
                                            ),
                                            TextWidget(
                                              data[index]["start_at"],
                                              color: Colors.grey,
                                            ),
                                            Container(
                                              width: rpx(30),
                                            ),
                                            getFootGameStateText(
                                                data[index]["status_id"],
                                                data[index]["elapsed"])
                                          ],
                                        ),
                                        Divider(
                                          color: const Color.fromARGB(
                                              255, 235, 235, 235),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Wrap(
                                              spacing: rpx(10),
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                netImg(
                                                    data[index]["home_team"]
                                                        ["logo"],
                                                    rpx(40),
                                                    rpx(40)),
                                                TextWidget(data[index]
                                                    ["home_team"]["name_short"])
                                              ],
                                            ),
                                            getFootGameScoreText(
                                                data[index]["status_id"],
                                                data[index]["current_score"]
                                                    .toString()),
                                            Wrap(
                                              spacing: rpx(10),
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                Container(
                                                  child: TextWidget(data[index]
                                                          ["away_team"]
                                                      ["name_short"]),
                                                  width: rpx(60),
                                                ),
                                                netImg(
                                                    data[index]["away_team"]
                                                        ["logo"],
                                                    rpx(40),
                                                    rpx(40)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            TextWidget("初指"),
                                            TextWidget("即指"),
                                          ],
                                        ),
                                        Container(
                                          height: rpx(10),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: rpx(160),
                                              child: Wrap(
                                                runSpacing: rpx(5),
                                                children: [
                                                  Container(
                                                    width: rpx(54),
                                                    child: Column(
                                                      children: [
                                                        TextWidget("主胜"),
                                                        TextWidget(data[index][
                                                                    "init_index"]
                                                                ["win"]
                                                            .toString())
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: rpx(54),
                                                    child: Column(
                                                      children: [
                                                        TextWidget("平"),
                                                        TextWidget(data[index][
                                                                    "init_index"]
                                                                ["draw"]
                                                            .toString())
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: rpx(54),
                                                    child: Column(
                                                      children: [
                                                        TextWidget("客胜"),
                                                        TextWidget(data[index][
                                                                    "init_index"]
                                                                ["loss"]
                                                            .toString())
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: rpx(160),
                                              child: Wrap(
                                                runSpacing: rpx(5),
                                                children: [
                                                  Container(
                                                    width: rpx(54),
                                                    child: Column(
                                                      children: [
                                                        TextWidget("主胜"),
                                                        TextWidget(
                                                          data[index]["cur_index"]
                                                                  ["win"]
                                                              .toString(),
                                                          color: getColor(data[
                                                                      index]
                                                                  ["cur_index"]
                                                              ["win_direct"]),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: rpx(54),
                                                    child: Column(
                                                      children: [
                                                        TextWidget("平"),
                                                        TextWidget(
                                                          data[index]["cur_index"]
                                                                  ["draw"]
                                                              .toString(),
                                                          color: getColor(data[
                                                                      index]
                                                                  ["cur_index"]
                                                              ["draw_direct"]),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: rpx(54),
                                                    child: Column(
                                                      children: [
                                                        TextWidget("客胜"),
                                                        TextWidget(
                                                          data[index]["cur_index"]
                                                                  ["loss"]
                                                              .toString(),
                                                          color: getColor(data[
                                                                      index]
                                                                  ["cur_index"]
                                                              ["loss_direct"]),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: rpx(10),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            TextWidget("机构分歧"),
                                            TextWidget("机构分歧"),
                                          ],
                                        ),
                                        Container(
                                          height: rpx(10),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: rpx(160),
                                              child: Wrap(
                                                runSpacing: rpx(5),
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: rpx(54),
                                                    child: TextWidget(data[
                                                                index]
                                                            ["init_win_diff"]
                                                        .toStringAsFixed(2)),
                                                  ),
                                                  Container(
                                                    width: rpx(54),
                                                    child: TextWidget(data[
                                                                index]
                                                            ["init_draw_diff"]
                                                        .toStringAsFixed(2)),
                                                  ),
                                                  Container(
                                                    width: rpx(54),
                                                    child: TextWidget(data[
                                                                index]
                                                            ["init_loss_diff"]
                                                        .toStringAsFixed(2)),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: rpx(160),
                                              child: Wrap(
                                                runSpacing: rpx(5),
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: rpx(54),
                                                    child: TextWidget(
                                                        data[index]
                                                                ["cur_win_diff"]
                                                            .toStringAsFixed(
                                                                2)),
                                                  ),
                                                  Container(
                                                    width: rpx(54),
                                                    child: TextWidget(data[
                                                                index]
                                                            ["cur_draw_diff"]
                                                        .toStringAsFixed(2)),
                                                  ),
                                                  Container(
                                                    width: rpx(54),
                                                    child: TextWidget(data[
                                                                index]
                                                            ["cur_loss_diff"]
                                                        .toStringAsFixed(2)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: rpx(15),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            TextWidget("方差"),
                                            TextWidget("方差"),
                                          ],
                                        ),
                                        Container(
                                          height: rpx(10),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: rpx(160),
                                              child: Wrap(
                                                runSpacing: rpx(5),
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: rpx(54),
                                                    child: TextWidget(data[
                                                                index]
                                                            ["init_win_fangcha"]
                                                        .toStringAsFixed(2)),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: rpx(54),
                                                    child: TextWidget(data[
                                                                index][
                                                            "init_draw_fangcha"]
                                                        .toStringAsFixed(2)),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: rpx(54),
                                                    child: TextWidget(data[
                                                                index][
                                                            "init_loss_fangcha"]
                                                        .toStringAsFixed(2)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: rpx(160),
                                              child: Wrap(
                                                runSpacing: rpx(5),
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: rpx(54),
                                                    child: TextWidget(data[
                                                                index]
                                                            ["cur_win_fangcha"]
                                                        .toStringAsFixed(2)),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: rpx(54),
                                                    child: TextWidget(data[
                                                                index]
                                                            ["cur_draw_fangcha"]
                                                        .toStringAsFixed(2)),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: rpx(54),
                                                    child: TextWidget(data[
                                                                index]
                                                            ["cur_loss_fangcha"]
                                                        .toStringAsFixed(2)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: rpx(15),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            TextWidget("返还率" +
                                                data[index]["init_back_rate"]
                                                    .toStringAsFixed(2)
                                                    .toString() +
                                                "%"),
                                            TextWidget("返还率" +
                                                data[index]["cur_back_rate"]
                                                    .toStringAsFixed(2) +
                                                "%")
                                          ],
                                        ),
                                        Container(
                                          height: rpx(10),
                                        ),
                                        Container(
                                          width: rpx(290),
                                          height: rpx(30),
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: rpx(5)),
                                          color: Color(
                                              0xfff5f5f5), //${data[index]["cur_index_diff"]["jigou_count"]}
                                          child: Row(
                                            children: [
                                              TextWidget(
                                                "查询到",
                                                fontSize: rpx(11),
                                              ),
                                              TextWidget(
                                                data[index]["jigou_count"]
                                                    .toString(),
                                                fontSize: rpx(11),
                                                color: Colors.red,
                                              ),
                                              TextWidget(
                                                "条机构数据;已完成分歧数据运算",
                                                fontSize: rpx(11),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: rpx(8),
                                    color: Color(0xfff5f5f5),
                                  )
                                ],
                              ),
                              pay_after: (Map data) {
                                setState(() {
                                  is_buy = data["is_buy"] == 1 ? true : false;
                                });
                              },
                              map: const {"id": 5},
                              click: is_buy || data[index]["status_id"] == 10
                                  ? () {
                                      G.router.navigateTo(
                                          context,
                                          "/companyDiffDetail" +
                                              G.parseQuery(params: {
                                                "id": data[index]["id"]
                                              }),
                                          routeSettings: RouteSettings(
                                              arguments: data[index]));
                                    }
                                  : null,
                              type: 2)),
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

  Color getColor(int id) {
    Color c = Colors.black;
    if (id == 1) {
      c = Colors.red;
    }
    if (id == 2) {
      c = Colors.green;
    }
    return c;
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
        day_index = index;
        page = 1;
        data = [];
        getGameList();
      });
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
    // monitor network fetch
    setState(() {
      page = 1;
    });
    getGameList();

    refreshController.refreshCompleted();
  }
}
