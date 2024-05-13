import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:jingcai_app/components/homes/dry_news.dart';
import 'package:jingcai_app/components/homes/hot_expert.dart';
import 'package:jingcai_app/components/homes/hot_game.dart';
import 'package:jingcai_app/components/homes/recommend.dart';
import 'package:jingcai_app/components/homes/sys_news.dart';
import 'package:jingcai_app/model/HotGameModel.dart';
import 'package:jingcai_app/model/expert.dart';
import 'package:jingcai_app/model/recommendModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/loading.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Home();
  }
}

class _Home extends State<Home>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabC;
  //var tabs = ["关注", "推荐", "临场", "干货", "情报"];
  var tabs = ["关注", "推荐", "临场"];
  late ScrollController _scrollController;
  late AnimationController controller;
  var headLogo = "assets/images/headLogo.png";
  double op = 1;
  double scrolly = 0;
  Color default_c = Colors.transparent;
  bool show_state = true;
  // Animation<double> animation;
  List<expert> expert_data = [];
  List<List<HotGameModel>> hot_data = [];
  List<recommendModel> recmmend_data = [];

  late StreamSubscription<List<ConnectivityResult>> subscription;
  @override
  void initState() {
    if (Platform.isIOS) {
      subscription = Connectivity()
          .onConnectivityChanged
          .listen((List<ConnectivityResult> connectivityResult) {
        if (connectivityResult.contains(ConnectivityResult.mobile)) {
          // Mobile network available.
          print("脸上无线");
        } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
          getData();
          // Wi-fi is available.
          // Note for Android:
          // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
        } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
          // Ethernet connection available.
        } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
          // Vpn connection active.
          // Note for iOS and macOS:
          // There is no separate network interface type for [vpn].
          // It returns [other] on any device (also simulator)
        } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
          // Bluetooth connection available.
        } else if (connectivityResult.contains(ConnectivityResult.other)) {
          // Connected to a network which is not in the above mentioned networks.
        } else if (connectivityResult.contains(ConnectivityResult.none)) {
          // No available network types
        }
      });
    }
    var headLogo_ = "assets/images/headLogo.png";
    controller = AnimationController(vsync: this);
    Color c = Colors.transparent;
    _tabController();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double alpha = 1 - (offset / rpx(120));
      bool show_state_ = true;

      if (alpha < 0.5) {
        alpha = 0;
        headLogo_ = "assets/images/headLogo_red.png";
        c = Colors.white;
        show_state_ = false;
      } else if (alpha >= 1) {
        alpha = 1;
      }
      if (alpha > 0.9) {
        headLogo_ = "assets/images/headLogo.png";
        c = Colors.transparent;
        show_state_ = true;
      }
      setState(() {
        op = alpha;
        headLogo = headLogo_;
        default_c = c;
        show_state = show_state_;
      });
      //animation = Tween(begin: 0.0, end: 1) as Animation<double>;
    });
    // getData();
    //animation = Tween(begin: 0.0, end: 1) as Animation<double>;

    getPerMission();
    getData();
    super.initState();
  }

  getData() {
    getHotGameData();
    getExpertData();
  }

  getPerMission() async {}

  Future getExpertData() async {
    G.api.game.getHotTalent({}).then((value) {
      List d = value;
      expert_data =
          d.map((e) => expert.fromJson((e as Map<String, dynamic>))).toList();
    });
  }

  Future getHotGameData() async {
    G.api.game.getHotGame({}).then((value) {
      setState(() {
        final List dd = value;
        hot_data = dd
            .map((e) => List.from(e)
                .map(
                    (e1) => HotGameModel.fromJson((e1 as Map<String, dynamic>)))
                .toList())
            .toList();
      });
    });
  }

  void _tabController() {
    _tabC = TabController(
      length: tabs.length,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            getData();
            //返回值以结束刷新
            return Future.value(true);
          }),
    );
  }

  getTextInputWidget() {
    if (show_state) {
      return Image.asset(
        "assets/images/search.png",
        width: rpx(30),
        fit: BoxFit.cover,
      );
    } else {
      return SizedBox(
        height: 30,
        width: rpx(200),
        child: const TextField(
          enabled: false,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              fillColor: Color(0x30cccccc),
              filled: true,
              prefixIcon: Icon(
                Icons.search,
                size: 19,
              ),
              prefixIconColor: Colors.grey,
              hintStyle: TextStyle(fontSize: 12),
              hintText: "搜索方案、专家、达人",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)))),
        ),
      );
    }
  }

  _contentView(context, title) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    double pinnedHeaderHeight = rpx(45) + rpx(statusBarHeight);
    return ExtendedNestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          //标题

          SliverAppBar(
            title: SizedBox(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Image.asset(
                //   headLogo,
                //   width: rpx(100),
                //   fit: BoxFit.cover,
                // ),
                Container(
                  width: rpx(1),
                ),
                onClick(getTextInputWidget(), () {
                  G.router.navigateTo(context, "/talentSearch");
                }),
              ],
            )),
            expandedHeight: rpx(170),
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: GestureDetector(
                onTap: () {
                  // G.router.navigateTo(context, "/basketSubject",
                  //     transition: TransitionType.inFromRight);
                },
                child: Image.asset(
                  "assets/images/HomeBanner.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            pinned: true,
            floating: true,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "热门达人",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: rpx(18)),
                      ),
                      onClick(const TextWidget("查看更多"), () {
                        var p = {"index": 0, "is_flow": 0};
                        G.router.navigateTo(
                            context, "/expertTalent" + G.parseQuery(params: p),
                            transition: TransitionType.inFromRight);
                      })
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  alignment: Alignment.topLeft,
                  child: hotExpert(data: expert_data),
                  height: rpx(180),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 4,
                              color:
                                  const Color.fromARGB(255, 238, 238, 238)))),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "热门赛事",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: rpx(18)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  alignment: Alignment.center,
                  child: HotGame(data: hot_data),
                  height: rpx(170),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 4,
                              color:
                                  const Color.fromARGB(255, 238, 238, 238)))),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_tabars(), _tarbarview()],
        ),
      ),
    );
  }

  _tabars() {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        TabBar(
          physics: NeverScrollableScrollPhysics(),
          tabAlignment: TabAlignment.start,
          padding: EdgeInsets.all(0),

          labelPadding: EdgeInsets.all(0),
          indicatorPadding: EdgeInsets.symmetric(horizontal: rpx(30)),
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
                  height: rpx(35),
                  width: MediaQuery.of(context).size.width * (1 / tabs.length),
                  child: Tab(text: "$label"),
                ),
              )
              .toList(),
        )
      ],
    );
  }

  _tarbarview() {
    return Expanded(
      child: TabBarView(controller: _tabC, children: [
        //因为有两个tabar所以写死了两个Container
        //在实际开发中我们通过接口获取tabar和children的数量 用list存储
        recommend(
          type: 1,
        ),
        recommend(
          type: 2,
        ),
        recommend(
          type: 3,
        ),
        // dryNews(),
        // sysNews(),
      ]),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
