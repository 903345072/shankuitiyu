import 'package:dio/dio.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/components/gameDetail.dart/gameDetailPlan.dart';
import 'package:jingcai_app/model/footMatchModel.dart';
import 'package:jingcai_app/model/footModel.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/pages/home_pages/basketLiving.dart';
import 'package:jingcai_app/pages/home_pages/basketPlayerData.dart';
import 'package:jingcai_app/pages/home_pages/basketgameIndex.dart';
import 'package:jingcai_app/pages/home_pages/gameIndex.dart';
import 'package:jingcai_app/pages/home_pages/historyData.dart';
import 'package:jingcai_app/pages/home_pages/lineUp.dart';
import 'package:jingcai_app/pages/home_pages/living.dart';
import 'package:jingcai_app/pages/home_pages/vipModel.dart';
import 'package:jingcai_app/styles/gameDetailStyle.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class BasketGameDetail extends StatefulWidget {
  int id;
  int is_detail;
  BasketGameDetail({super.key, required this.id, required this.is_detail});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return gameDetail_();
  }
}

class gameDetail_ extends State<BasketGameDetail>
    with TickerProviderStateMixin {
  late TabController _tabC;
  var tabs = ["方案", "直播", "统计", "指数"];
  var easy_tabs = ["方案", "直播", "统计", "指数"];
  late ScrollController _scrollController = ScrollController();
  JcFootModel foot = JcFootModel.fromJson({
    "leagues": Map<String, dynamic>.from({}),
    "home_team": Map<String, dynamic>.from({}),
    "away_team": Map<String, dynamic>.from({})
  });
  List home_player = [];
  List away_player = [];
  Map home_team = {};
  Map away_team = {};
  void initState() {
    super.initState();
    _tabC = TabController(
      length: widget.is_detail == 1 ? tabs.length : easy_tabs.length,
      initialIndex: 0,
      vsync: this,
    );
    getGameDetail();
  }

  getGameDetail() {
    G.api.game.getBasketGameDetail({"id": widget.id}).then((value) {
      setState(() {
        foot =
            JcFootModel.fromJson((value["footData"] as Map<String, dynamic>));
        home_player = value["home_player"];
        away_player = value["away_player"];
        home_team = value["home_team"] ?? {};
        away_team = value["away_team"] ?? {};
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: false,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            G.router.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: rpx(18),
          ),
        ),
        centerTitle: true,
        title: foot != null
            ? Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                children: [
                  foot.round != null
                      ? Text(
                          foot!.leagues!.nameShort.toString() +
                              " "
                                  "|" +
                              " " +
                              foot.round!.name!.toString(),
                          style:
                              TextStyle(color: Colors.white, fontSize: rpx(12)),
                        )
                      : Container(),
                  Text(
                    foot!.startAt.toString(),
                    style: TextStyle(color: Colors.white, fontSize: rpx(12)),
                  ),
                ],
              )
            : Container(),
        flexibleSpace: FlexibleSpaceBar(
          background: GestureDetector(
            onTap: () {},
            child: Image.asset(
              "assets/images/basket_top.png",
              width: rpx(375),
              fit: BoxFit.cover,
            ),
          ),
        ),
        toolbarHeight: rpx(85),
      ),
      body: RefreshIndicator(
          color: Colors.blue,
          notificationPredicate: (ScrollNotification notifation) {
            //该属性包含当前ViewPort及滚动位置等信息
            ScrollMetrics scrollMetrics = notifation.metrics;
            if (scrollMetrics.minScrollExtent == 0) {
              return true;
            } else {
              return false;
            }
          },
          child: _contentView(context, "123"),
          onRefresh: () async {
            await Future.delayed(Duration(milliseconds: 1000));
            //返回值以结束刷新
            return Future.value(true);
          }),
    );
  }

  _contentView(context, title) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    double pinnedHeaderHeight = rpx(statusBarHeight) - rpx(30);
    return ExtendedNestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          //标题

          SliverAppBar(
            primary: false,
            leading: Container(),
            expandedHeight: rpx(150),
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: GestureDetector(
                onTap: () {},
                child: Stack(
                  children: [
                    Positioned(
                        child: Image.asset(
                      "assets/images/basketBack.png",
                      width: rpx(375),
                      fit: BoxFit.cover,
                    )),
                    Container(
                      margin: EdgeInsets.only(top: rpx(15)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Wrap(
                            spacing: rpx(15),
                            crossAxisAlignment: WrapCrossAlignment.center,
                            direction: Axis.vertical,
                            children: [
                              netImg(foot.awayTeam!.logo.toString(), rpx(40),
                                  rpx(40)),
                              Container(
                                width: rpx(120),
                                child: TextWidget(
                                  foot.awayTeam!.nameShort.toString(),
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              getBasketGameStateText(foot,
                                  size: rpx(18), is_white: true),
                              SizedBox(
                                height: rpx(20),
                              ),
                              getBasketGameScoreTextWithWhite(
                                  foot.statusId, foot.currentScore,
                                  size: rpx(18)),
                              SizedBox(
                                height: rpx(10),
                              ),
                              SizedBox(
                                height: rpx(5),
                              ),
                            ],
                          ),
                          Wrap(
                            spacing: rpx(15),
                            crossAxisAlignment: WrapCrossAlignment.center,
                            direction: Axis.vertical,
                            children: [
                              netImg(foot.homeTeam!.logo.toString(), rpx(40),
                                  rpx(40)),
                              Container(
                                width: rpx(120),
                                child: TextWidget(
                                  foot.homeTeam!.nameShort.toString(),
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            pinned: false,
            floating: true,
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
          children: [_tabars(), _tarbarview()],
        ),
      ),
    );
  }

  _tabars() {
    List tabss = widget.is_detail == 1 ? tabs : easy_tabs;
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        TabBar(
          physics: NeverScrollableScrollPhysics(),
          tabAlignment: TabAlignment.start,
          padding: EdgeInsets.all(0),

          labelPadding: EdgeInsets.all(0),

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
          tabs: tabss
              .map(
                (label) => Container(
                  height: rpx(35),
                  width: MediaQuery.of(context).size.width * (1 / tabss.length),
                  child: Tab(text: "$label"),
                ),
              )
              .toList(),
        )
      ],
    );
  }

  _tarbarview() {
    if (1 > 0) {
      return Expanded(
        child: TabBarView(controller: _tabC, children: [
          //因为有两个tabar所以写死了两个Container
          //在实际开发中我们通过接口获取tabar和children的数量 用list存储
          gameDetailPlan(id: widget.id),
          basketLiving(home_data: home_team, away_data: away_team, foot: foot),
          basketPlayerData(
            foot: foot,
            id: foot.id,
            away_player: away_player,
            away_team: away_team,
            home_player: home_player,
            home_team: home_team,
          ),
          basketgameIndex(
            id: foot.id,
          ),
        ]),
      );
    } else {
      return Expanded(
        child: TabBarView(controller: _tabC, children: [
          //因为有两个tabar所以写死了两个Container
          //在实际开发中我们通过接口获取tabar和children的数量 用list存储
          gameDetailPlan(id: widget.id),
          basketLiving(home_data: home_team, away_data: away_team, foot: foot),
          Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                Table(
                  children: [
                    TableRow(children: [
                      Container(
                        child: TextWidget("球员"),
                      )
                    ])
                  ],
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: const Text(
              "暂无视频",
              style: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
          ),
        ]),
      );
    }
  }
}
