import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/components/payWidget.dart';

import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/big_data_pages/components/allIndexChangeList.dart';

import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';

import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class indexChange extends StatefulWidget {
  String price = "0";
  int buy_count = 0;
  indexChange({required this.price, required this.buy_count});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dataReport_();
  }
}

class dataReport_ extends State<indexChange> with TickerProviderStateMixin {
  Color co = Colors.white;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  late ScrollController _scrollController = ScrollController();
  List swiperList = [1, 2, 3];
  var tabs = ["全部", "胜平负", "让球", "进球数"];
  late TabController _tabC;
  List<JcFootModel> data = [];
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
    _tabC = TabController(
      length: tabs.length,
      initialIndex: 0,
      vsync: this,
    );
    getGameList();
  }

  getGameList() async {
    // await G.api.game.getBigDataGame().then((value) {
    //   setState(() {
    //     //data = value;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color(0xfff0f0f0), body: _contentView(context, "123"));
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
                    "指数异动",
                    color: co,
                    fontSize: rpx(19),
                  )
                ],
              )),
              expandedHeight: rpx(170),
              backgroundColor: Color(0xfff0f0f0),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Image.asset(
                      "assets/images/index_change_back.png",
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
                                "实时监控指数数据，获取有大幅变动的赛事进行展示，包含胜平负、让球、进球数等指数异动监控。帮助用户即时获取赛事变动数据，发现值得深挖分析的赛事。",
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
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xfff0f0f0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_tabars(), _tarbarview()],
          ),
        ));
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
          indicatorPadding: EdgeInsets.symmetric(horizontal: rpx(25)),

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
                  width: MediaQuery.of(context).size.width * 0.25,
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
        allIndexChangeList(
          type: 1,
          price: widget.price,
        ),
        allIndexChangeList(
          type: 2,
          price: widget.price,
        ),
        allIndexChangeList(
          type: 3,
          price: widget.price,
        ),
        allIndexChangeList(
          type: 4,
          price: widget.price,
        ),
      ]),
    );
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 3000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    refreshController.loadNoData();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }
}
