import 'package:dio/dio.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:jingcai_app/components/bigData/historyPlan.dart';
import 'package:jingcai_app/components/bigData/sellhistoryPlan.dart';
import 'package:jingcai_app/model/aiSwiperModel.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/model/profitIndexModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class aiGuess extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return aiGuess_();
  }
}

class aiGuess_ extends State<aiGuess> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  GlobalKey<sellhistoryPlan_> sellsonWidgetState =
      GlobalKey<sellhistoryPlan_>();
  GlobalKey<historyPlan_> sonWidgetState = GlobalKey<historyPlan_>();
  var tabs = ["在售方案", "历史方案"];
  late TabController _tabC;
  List<JcFootModel> swiperList = [];
  List<Jq>? rq = [];
  List<Jq>? jqs = [];
  late SwiperControl _swiperController;
  int type = 0;

  String rq_month_count = "0";
  String rq_week_count = "0";
  String rq_month_rate = "0";
  String rq_week_rate = "0";

  String dxq_month_count = "0";
  String dxq_week_count = "0";
  String dxq_month_rate = "0";
  String dxq_week_rate = "0";

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _swiperController = const SwiperControl(key: GlobalObjectKey(1));
    _tabC = TabController(
      length: tabs.length,
      initialIndex: 0,
      vsync: this,
    );

    getprofitList();
  }

  getprofitList() {
    G.api.game.AiRate({}).then((value) {
      setState(() {
        rq_month_count = value["rq_month_count"].toString();
        rq_week_count = value["rq_week_count"].toString();
        rq_month_rate = value["rq_month_rate"].toString();
        rq_week_rate = value["rq_week_rate"].toString();

        dxq_month_count = value["dxq_month_count"].toString();
        dxq_week_count = value["dxq_week_count"].toString();
        dxq_month_rate = value["dxq_month_rate"].toString();
        dxq_week_rate = value["dxq_week_rate"].toString();
        List d = value["target"];
        swiperList = d
            .map((e) => JcFootModel.fromJson((e as Map<String, dynamic>)))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    double pinnedHeaderHeight = rpx(50) + rpx(statusBarHeight);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: ExtendedNestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              " 山葵AI",
                              style: TextStyle(fontSize: rpx(20)),
                            ),
                            Container(
                              width: rpx(175),
                              child: Text(
                                  " 山葵AI运用大数据算法，通过对比赛球队的各项数据、关键指标进行多维度、智能分析，预测得出各种玩法的结果！ "),
                            )
                          ],
                        ),
                        Image.asset(
                          "assets/images/jingcaiai.png",
                          width: rpx(160),
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: rpx(15), right: rpx(10)),
                    width: MediaQuery.of(context).size.width,
                    height: rpx(40),
                    child: Swiper(
                        index: 0,
                        controller: SwiperController(),
                        scrollDirection: Axis.vertical,
                        autoplay: true,
                        loop: false,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  spacing: rpx(3),
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
                                    getFootGameScoreText(
                                        swiperList[index].statusId,
                                        swiperList[index].currentScore),
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
                                ),
                                Text("命中",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: rpx(16)))
                              ],
                            ),
                          );
                        },
                        itemCount: swiperList.length),
                  ),
                  Container(
                    height: rpx(4),
                    color: Color.fromARGB(255, 241, 241, 241),
                  ),
                  Container(
                    height: rpx(10),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: rpx(15)),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: rpx(5),
                            children: [
                              Container(
                                color: Colors.red,
                                width: rpx(2),
                                height: rpx(20),
                              ),
                              Text(
                                "盈利指数",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: rpx(18)),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: rpx(10),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: rpx(15)),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: rpx(15),
                            children: [
                              Image.asset(
                                "assets/images/rangqiu.png",
                                fit: BoxFit.cover,
                                width: rpx(70),
                              ),
                              Wrap(
                                direction: Axis.vertical,
                                spacing: 2,
                                children: [
                                  Wrap(
                                    spacing: rpx(5),
                                    children: [
                                      Row(
                                        children: [
                                          TextWidget("近一周预测"),
                                          TextWidget(
                                            rq_week_count,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          TextWidget("场"),
                                        ],
                                      ),
                                      int.parse(rq_week_rate) > 0
                                          ? Row(
                                              children: [
                                                TextWidget("盈利"),
                                                TextWidget(
                                                  rq_week_rate + "%",
                                                  color: Colors.red,
                                                ),
                                              ],
                                            )
                                          : TextWidget(
                                              "亏损中",
                                              color: Colors.green,
                                            )
                                    ],
                                  ),
                                  Wrap(
                                    spacing: rpx(5),
                                    children: [
                                      Row(
                                        children: [
                                          TextWidget("近一月预测"),
                                          TextWidget(
                                            rq_month_count,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          TextWidget("场"),
                                        ],
                                      ),
                                      int.parse(rq_month_rate) > 0
                                          ? Row(
                                              children: [
                                                TextWidget("盈利"),
                                                TextWidget(
                                                  rq_month_rate + "%",
                                                  color: Colors.red,
                                                ),
                                              ],
                                            )
                                          : TextWidget(
                                              "亏损中",
                                              color: Colors.green,
                                            )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: rpx(10),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: rpx(1),
                                      color:
                                          Color.fromARGB(255, 240, 240, 240)))),
                        ),
                        Container(
                          height: rpx(10),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: rpx(15)),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: rpx(15),
                            children: [
                              Image.asset(
                                "assets/images/jinqiu.png",
                                fit: BoxFit.cover,
                                width: rpx(70),
                              ),
                              Wrap(
                                direction: Axis.vertical,
                                spacing: 2,
                                children: [
                                  Wrap(
                                    spacing: rpx(5),
                                    children: [
                                      Row(
                                        children: [
                                          TextWidget("近一周预测"),
                                          TextWidget(
                                            dxq_week_count,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          TextWidget("场"),
                                        ],
                                      ),
                                      int.parse(dxq_week_rate) > 0
                                          ? Row(
                                              children: [
                                                TextWidget("盈利"),
                                                TextWidget(
                                                  dxq_week_rate + "%",
                                                  color: Colors.red,
                                                ),
                                              ],
                                            )
                                          : TextWidget(
                                              "亏损中",
                                              color: Colors.green,
                                            )
                                    ],
                                  ),
                                  Wrap(
                                    spacing: rpx(5),
                                    children: [
                                      Row(
                                        children: [
                                          TextWidget("近一月预测"),
                                          TextWidget(
                                            dxq_month_count,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          TextWidget("场"),
                                        ],
                                      ),
                                      int.parse(dxq_month_rate) > 0
                                          ? Row(
                                              children: [
                                                TextWidget("盈利"),
                                                TextWidget(
                                                  dxq_month_rate + "%",
                                                  color: Colors.red,
                                                ),
                                              ],
                                            )
                                          : TextWidget(
                                              "亏损中",
                                              color: Colors.green,
                                            )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _tabBar(),
                  Container(
                    margin: EdgeInsets.only(right: rpx(20)),
                    child: Wrap(
                      spacing: rpx(10),
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (type == 0 || type == 2) {
                                type = 1;
                              } else {
                                type = 0;
                              }
                            });

                            if (sonWidgetState.currentState != null) {
                              sonWidgetState.currentState!
                                  .getExpertInfo(type, true);
                            }
                            if (sellsonWidgetState.currentState != null) {
                              sellsonWidgetState.currentState!
                                  .getExpertInfo(type, true);
                            }
                          },
                          child: Text(
                            "让球",
                            style: TextStyle(
                                color: type == 1 ? Colors.red : Colors.black),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (type == 0 || type == 1) {
                                type = 2;
                              } else {
                                type = 0;
                              }
                            });

                            if (sonWidgetState.currentState != null) {
                              sonWidgetState.currentState!
                                  .getExpertInfo(type, true);
                            }
                            if (sellsonWidgetState.currentState != null) {
                              sellsonWidgetState.currentState!
                                  .getExpertInfo(type, true);
                            }
                          },
                          child: Text(
                            "进球数",
                            style: TextStyle(
                                color: type == 2 ? Colors.red : Colors.black),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              _tarbarview()
            ],
          ),
        ),
      ),
    );
  }

  _tarbarview() {
    return Expanded(
      child: TabBarView(controller: _tabC, children: [
        //因为有两个tabar所以写死了两个Container
        //在实际开发中我们通过接口获取tabar和children的数量 用list存储

        sellhistoryPlan(
          state: 1,
          type: type,
          key: sellsonWidgetState,
        ),
        historyPlan(
          state: 2,
          type: type,
          key: sonWidgetState,
        ),
      ]),
    );
  }

  _tabBar() {
    return TabBar(
      physics: NeverScrollableScrollPhysics(),
      tabAlignment: TabAlignment.start,
      padding: EdgeInsets.all(0),

      labelPadding: EdgeInsets.all(0),
      indicatorPadding: EdgeInsets.only(left: rpx(15), right: rpx(15)),
      labelColor: Colors.red,
      unselectedLabelColor: Colors.black,
      indicatorColor: Colors.red,

      // 选择的样式
      labelStyle: TextStyle(
        fontSize: rpx(13),
        fontWeight: FontWeight.bold,
      ),
      // 未选中的样式
      unselectedLabelStyle: TextStyle(
        fontSize: rpx(13),
      ),
      indicatorWeight: 3.0,
      isScrollable: true,
      indicatorSize: TabBarIndicatorSize.label,

      controller: _tabC,
      tabs: tabs
          .map(
            (label) => Container(
              width: MediaQuery.of(context).size.width * 0.23,
              child: Tab(text: "$label"),
            ),
          )
          .toList(),
    );
  }
}
