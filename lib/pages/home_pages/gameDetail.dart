import 'package:dio/dio.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/components/gameDetail.dart/gameDetailPlan.dart';
import 'package:jingcai_app/model/footMatchModel.dart';
import 'package:jingcai_app/model/footModel.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/my/page/WebViewPage.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/pages/home_pages/gameIndex.dart';
import 'package:jingcai_app/pages/home_pages/historyData.dart';
import 'package:jingcai_app/pages/home_pages/lineUp.dart';
import 'package:jingcai_app/pages/home_pages/living.dart';
import 'package:jingcai_app/pages/home_pages/vipModel.dart';
import 'package:jingcai_app/styles/gameDetailStyle.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:webview_flutter/webview_flutter.dart';

class gameDetail extends StatefulWidget {
  int id;
  int is_detail;
  gameDetail({super.key, required this.id, required this.is_detail});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return gameDetail_();
  }
}

class gameDetail_ extends State<gameDetail> with TickerProviderStateMixin {
  late TabController _tabC;
  var tabs = ["方案", "直播", "情报", "指数", "阵容", "数据", "模型", "视频"];
  //var easy_tabs = ["直播", "情报", "指数", "阵容", "数据"];
  var easy_tabs = ["方案", "直播", "情报", "指数", "阵容", "数据", "模型", "视频"];
  late ScrollController _scrollController = ScrollController();
  JcFootModel foot = JcFootModel.fromJson({
    "leagues": Map<String, dynamic>.from({}),
    "home_team": Map<String, dynamic>.from({}),
    "away_team": Map<String, dynamic>.from({})
  });
  String url = "";
  Map home_data = {};
  Map away_data = {};
  int is_ani = 0;
  bool show_head = false;
  int have_jc = 0;
  int have_bd = 0;
  WebViewController controller = WebViewController();
  // ..setJavaScriptMode(JavaScriptMode.unrestricted)
  // ..setBackgroundColor(const Color(0x00000000))
  // ..setNavigationDelegate(
  //   NavigationDelegate(
  //     onProgress: (int progress) {
  //       // Update loading bar.
  //     },
  //     onPageStarted: (String url) {},
  //     onPageFinished: (String url) {},
  //     onWebResourceError: (WebResourceError error) {},
  //     onNavigationRequest: (NavigationRequest request) {
  //       if (request.url.startsWith('https://www.baidu.com/')) {
  //         return NavigationDecision.prevent;
  //       }
  //       return NavigationDecision.navigate;
  //     },
  //   ),
  // )
  // ..loadRequest(Uri.parse(''));
  void initState() {
    super.initState();
    _tabC = TabController(
      length: widget.is_detail == 1 ? tabs.length : easy_tabs.length,
      initialIndex: 0,
      vsync: this,
    );

    // _scrollController.addListener(() {
    //   double offset = _scrollController.offset;
    //   double alpha = 1 - (offset / rpx(150));

    //   setState(() {
    //     if (alpha < -0.2) {
    //       show_head = true;
    //     } else {
    //       show_head = false;
    //     }
    //   });

    //   //animation = Tween(begin: 0.0, end: 1) as Animation<double>;
    // });

    getGameDetail();
  }

  getGameDetail() {
    G.api.game.getGameDetail({"id": widget.id}).then((value) {
      setState(() {
        foot =
            JcFootModel.fromJson((value["footData"] as Map<String, dynamic>));
        home_data = value["home_detail"] ?? {};
        away_data = value["away_detail"] ?? {};
        have_jc = value["have_jc"];
        have_bd = value["have_bd"];
        controller
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                // Update loading bar.
              },
              onPageStarted: (String url) {},
              onPageFinished: (String url) {},
              onWebResourceError: (WebResourceError error) {},
              onNavigationRequest: (NavigationRequest request) {
                if (request.url.startsWith('https://www.baidu.com/')) {
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(value["url"]));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          primary: false,
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                if (is_ani == 0) {
                  G.router.pop(context);
                } else {
                  setState(() {
                    is_ani = 0;
                  });
                }
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: rpx(18),
              ),
            ),
            centerTitle: true,
            title: Wrap(
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
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: GestureDetector(
                onTap: () {},
                child: Image.asset(
                  "assets/images/game_detail_1.png",
                  width: rpx(375),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            toolbarHeight: rpx(80),
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
        ),
      ],
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
            expandedHeight: is_ani == 1 ? rpx(210) : rpx(150),
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: is_ani == 0
                  ? GestureDetector(
                      onTap: () {},
                      child: Stack(
                        children: [
                          Positioned(
                              child: Image.asset(
                            "assets/images/game_detail_2.png",
                            width: rpx(375),
                            height: rpx(150),
                            fit: BoxFit.cover,
                          )),
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Wrap(
                                  spacing: rpx(25),
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  direction: Axis.vertical,
                                  children: [
                                    netImg(foot.homeTeam!.logo.toString(),
                                        rpx(40), rpx(40)),
                                    Container(
                                      width: rpx(120),
                                      child: TextWidget(
                                        foot.homeTeam!.nameShort.toString(),
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    getFootGameStateTextWhite(
                                        foot.statusId, foot.elapsed,
                                        size: rpx(18)),
                                    SizedBox(
                                      height: rpx(10),
                                    ),
                                    getFootGameScoreTextWithWhite(
                                        foot.statusId, foot.currentScore,
                                        size: rpx(18)),
                                    SizedBox(
                                      height: rpx(10),
                                    ),
                                    foot.halfScore != null
                                        ? Text(
                                            "(${'半场' + foot.halfScore.toString()})",
                                            style:
                                                gameDetailStyle.half_bf_style,
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: rpx(5),
                                    ),
                                    foot.has_ani == 1
                                        ? onClick(
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: rpx(9), right: rpx(9)),
                                              alignment: Alignment.center,
                                              height: rpx(26),
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, .3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          rpx(26))),
                                              child: Wrap(
                                                spacing: rpx(3),
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/football_field.png",
                                                    width: rpx(16),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Text(
                                                    "动画直播",
                                                    style: TextStyle(
                                                        fontSize: rpx(12),
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ), () {
                                            setState(() {
                                              is_ani = 1;
                                            });
                                          })
                                        : Container(),
                                    SizedBox(
                                      height: rpx(10),
                                    ),
                                    home_data.isNotEmpty && away_data.isNotEmpty
                                        ? Text(
                                            "角球${home_data['corner_kicks']}:${away_data['corner_kicks']}",
                                            style: TextStyle(
                                                fontSize: rpx(12),
                                                color: Colors.white),
                                          )
                                        : Container()
                                  ],
                                ),
                                Wrap(
                                  spacing: rpx(25),
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  direction: Axis.vertical,
                                  children: [
                                    netImg(foot.awayTeam!.logo.toString(),
                                        rpx(40), rpx(40)),
                                    Container(
                                      width: rpx(120),
                                      child: TextWidget(
                                        foot.awayTeam!.nameShort.toString(),
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
                    )
                  : Container(
                      child: WebViewWidget(controller: controller),
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
          home_data.isNotEmpty
              ? living(home_data: home_data, away_data: away_data, foot: foot)
              : Container(),
          Container(
            alignment: Alignment.center,
            child: const Text(
              "暂无情报",
              style: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
          ),
          gameIndex(
            id: foot.id,
            have_bd: have_bd,
            have_jc: have_jc,
          ),
          lineUp(
            id: foot.id,
          ),
          historyData(id: foot.id, foot: foot),
          vipModel(id: foot.id, foot: foot),
          Container(
            alignment: Alignment.center,
            child: const Text(
              "暂无视频",
              style: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
          ),
        ]),
      );
    } else {
      return Expanded(
        child: TabBarView(controller: _tabC, children: [
          //因为有两个tabar所以写死了两个Container
          //在实际开发中我们通过接口获取tabar和children的数量 用list存储

          home_data.isNotEmpty
              ? living(home_data: home_data, away_data: away_data, foot: foot)
              : Container(),
          Container(
            alignment: Alignment.center,
            child: const Text(
              "暂无情报",
              style: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
          ),
          gameIndex(
            id: foot.id,
            have_bd: have_bd,
            have_jc: have_jc,
          ),
          lineUp(
            id: foot.id,
          ),
          historyData(id: foot.id, foot: foot),
        ]),
      );
    }
  }
}
