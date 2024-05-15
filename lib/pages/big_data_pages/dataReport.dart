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

class dataReport extends StatefulWidget {
  String price = "0";
  int buy_count = 0;
  dataReport({required this.price, required this.buy_count});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dataReport_();
  }
}

class dataReport_ extends State<dataReport> {
  Color co = Colors.white;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  late ScrollController _scrollController = ScrollController();
  List<JcFootModel> swiperList = [];
  List weekList = [];
  List<JcFootModel> data = [];
  List<JcFootModel> act_data = [];
  int day_index = 5;
  int page = 1;
  int offset = 0;
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
    getGameList();
    getIsBuy();
  }

  getIsBuy() {
    G.api.user.getIsBuy({"id": 1}).then((value) {
      setState(() {
        is_buy = value == 1 ? true : false;
      });
    });
  }

  Future getGameList() async {
    return G.api.game.getBigDataGame(q: {
      "date": weekList[day_index]["stamp"],
      "page": page,
      "offset": offset
    }).then((value) {
      setState(() {
        if (value["act"]!.isNotEmpty) {
          data.addAll(value["act"]!);
        }

        if (value["exp"]!.isNotEmpty) {
          swiperList = value["exp"]!;
        }
        offset = value["offset"];
      });
      return value["act"];
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
                  "福神大数据报告",
                  color: co,
                  fontSize: rpx(19),
                ),
                // Opacity(
                //   opacity: 0.8,
                //   child: Container(
                //     alignment: Alignment.center,
                //     width: rpx(22),
                //     height: rpx(22),
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(3),
                //         color: Color.fromARGB(255, 173, 173, 173)),
                //     child: Icon(
                //       Icons.search_outlined,
                //       color: co,
                //       size: rpx(17),
                //     ),
                //   ),
                // )
              ],
            )),
            expandedHeight: rpx(200),
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Image.asset(
                    "assets/images/bigDataBack.jpg",
                    height: rpx(330),
                    fit: BoxFit.fitHeight,
                  ),
                  Positioned(
                      bottom: rpx(20),
                      left: rpx(15),
                      child: Wrap(
                        direction: Axis.vertical,
                        spacing: rpx(20),
                        children: [
                          Container(
                            width: rpx(280),
                            child: TextWidget(
                              "根据对阵双方的实力、状态、交战、战绩、指数等多重数据进行分析，给出各种玩法（比分、胜平负、进球数）的预测概率，辅助用户进行赛事分析和判断。",
                              fontSize: rpx(14),
                              maxLines: 4,
                              color: Colors.white,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: rpx(10),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: rpx(15), right: rpx(10)),
                  width: MediaQuery.of(context).size.width,
                  height: rpx(35),
                  child: Row(
                    children: [
                      Wrap(
                        direction: Axis.vertical,
                        children: [
                          TextWidget(
                            "预测",
                            color: Colors.red,
                            fontSize: rpx(14),
                          ),
                          TextWidget(
                            "已出",
                            color: Colors.red,
                            fontSize: rpx(14),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: rpx(10)),
                        color: Colors.black12,
                        width: rpx(1),
                        height: rpx(35),
                      ),
                      Expanded(
                          child: Swiper(
                              index: 0,
                              controller: SwiperController(),
                              scrollDirection: Axis.vertical,
                              autoplay: true,
                              loop: false,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Wrap(
                                        spacing: rpx(1),
                                        children: [
                                          Container(
                                            width: rpx(50),
                                            child: TextWidget(
                                              swiperList[index]
                                                  .leagues!
                                                  .nameShort
                                                  .toString(),
                                            ),
                                          ),
                                          TextWidget(
                                            swiperList[index]
                                                .startAt
                                                .toString()
                                                .substring(5),
                                          ),
                                          Container(
                                            width: rpx(75),
                                            child: TextWidget(
                                              swiperList[index]
                                                  .homeTeam!
                                                  .nameShort
                                                  .toString(),
                                            ),
                                          ),
                                          TextWidget(
                                            "vs",
                                            color: Colors.red,
                                          ),
                                          Container(
                                            width: rpx(75),
                                            child: TextWidget(
                                              swiperList[index]
                                                  .awayTeam!
                                                  .nameShort
                                                  .toString(),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                              itemCount: swiperList.length))
                    ],
                  ),
                ),
                // Container(
                //   color: Color.fromARGB(255, 240, 240, 240),
                //   height: rpx(4),
                // ),
                // target(),
                SizedBox(
                  height: rpx(10),
                ),
                Container(
                  color: Color.fromARGB(255, 240, 240, 240),
                  height: rpx(4),
                ),
                SizedBox(
                  height: rpx(10),
                ),
                Container(
                  margin: EdgeInsets.only(left: rpx(10)),
                  alignment: Alignment.bottomLeft,
                  color: Colors.white,
                  child: Wrap(
                    spacing: rpx(10),
                    children: [
                      Container(
                        color: Colors.red,
                        height: rpx(17),
                        width: rpx(3),
                      ),
                      TextWidget(
                        "比赛列表",
                        fontSize: rpx(19),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: rpx(10),
                ),
              ],
            ),
          )
        ];
      },
      pinnedHeaderSliverHeightBuilder: () {
        return pinnedHeaderHeight;
      },
      onlyOneScrollInBody: true,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Stack(
            children: [
              Column(
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
                    onLoading: _onLoading,
                    child: ListView(children: [
                      Column(
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
                                                    width: rpx(60),
                                                    child: TextWidget(
                                                      data[index]
                                                          .leagues!
                                                          .nameShort
                                                          .toString(),
                                                      color: hexToColor(
                                                          data[index]
                                                              .leagues!
                                                              .color),
                                                    ),
                                                  ),
                                                ),
                                                TextWidget(data[index]
                                                    .startAt
                                                    .toString()
                                                    .substring(5, 16))
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: getFootGameStateText(
                                                data[index].statusId,
                                                data[index].elapsed),
                                          ),
                                          Expanded(
                                            flex: 12,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: rpx(10)),
                                                  child: TextWidget(
                                                    data[index].round != null
                                                        ? data[index]
                                                            .round!
                                                            .name
                                                            .toString()
                                                        : "",
                                                    textAlign: TextAlign.right,
                                                    fontSize: rpx(11),
                                                  ),
                                                ),
                                                data[index].plan_num! > 0
                                                    ? Container(
                                                        margin: EdgeInsets.only(
                                                            right: rpx(10)),
                                                        width: rpx(45),
                                                        alignment:
                                                            Alignment.center,
                                                        height: rpx(18),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                width: 1,
                                                                color:
                                                                    Colors.red),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        rpx(9))),
                                                        child: TextWidget(
                                                          "${data[index].plan_num}方案",
                                                          color: Colors.red,
                                                          fontSize: rpx(12),
                                                        ),
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: rpx(10),
                                      ),
                                      data[index].homeTeam != null &&
                                              data[index].awayTeam != null
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 12,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        width: rpx(100),
                                                        child: TextWidget(
                                                            data[index]
                                                                .homeTeam!
                                                                .nameShort
                                                                .toString()),
                                                      ),
                                                      Container(
                                                        width: rpx(10),
                                                      ),
                                                      netImg(
                                                          data[index]
                                                              .homeTeam!
                                                              .logo
                                                              .toString(),
                                                          rpx(20),
                                                          rpx(20))
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: getFootGameScoreText(
                                                      data[index].statusId,
                                                      data[index].currentScore),
                                                ),
                                                Expanded(
                                                  flex: 12,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      netImg(
                                                          data[index]
                                                              .awayTeam!
                                                              .logo
                                                              .toString(),
                                                          rpx(20),
                                                          rpx(20)),
                                                      Container(
                                                        width: rpx(10),
                                                      ),
                                                      Container(
                                                        width: rpx(120),
                                                        child: TextWidget(
                                                            data[index]
                                                                .awayTeam!
                                                                .nameShort
                                                                .toString()),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      SizedBox(
                                        height: rpx(10),
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
                                map: {"id": 1},
                                click: is_buy || data[index].statusId == 10
                                    ? () {
                                        G.router.navigateTo(
                                            context,
                                            "/gameBigData" +
                                                G.parseQuery(params: {
                                                  "id": data[index].id
                                                }));
                                      }
                                    : null,
                                type: 2)),
                      )
                    ]),
                  ))
                ],
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
          )),
    );
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
      refreshController.loadComplete();
      setState(() {
        day_index = index;
        setState(() {
          page = 1;
          data = [];
          offset = 0;
          act_data = [];
          data = [];
        });
        getGameList();
      });
    });
  }

  void _onLoading() async {
    // monitor network fetch
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

    // if failed,use loadFailed(),if no data return,use LoadNodata()
  }

  void _onRefresh() async {
    setState(() {
      page = 1;
    });
    getGameList();
  }
}
