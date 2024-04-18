import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/big_data_pages/components/matchList.dart';
import 'package:jingcai_app/pages/big_data_pages/components/playerRank.dart';
import 'package:jingcai_app/pages/big_data_pages/components/scoreRank.dart';
import 'package:jingcai_app/pages/big_data_pages/components/teamBaseInfo.dart';
import 'package:jingcai_app/pages/big_data_pages/components/teamLineUp.dart';
import 'package:jingcai_app/pages/big_data_pages/components/teamMatch.dart';
import 'package:jingcai_app/pages/big_data_pages/components/teamPlayerRank.dart';
import 'package:jingcai_app/pages/big_data_pages/components/teamRank.dart';
import 'package:jingcai_app/pages/big_data_pages/components/teamScoreRank.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class teamDetail extends StatefulWidget {
  int id;
  String? name;
  String? logo;
  teamDetail({required this.id, required this.name, required this.logo});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return teamDetail_();
  }
}

class teamDetail_ extends State<teamDetail> with TickerProviderStateMixin {
  late TabController _tabC;
  var tabs = ["基本信息", "积分榜", "比赛", "阵容", "球员榜"];
  late ScrollController _scrollController = ScrollController();
  JcFootModel foot = JcFootModel.fromJson({
    "leagues": Map<String, dynamic>.from({}),
    "home_team": Map<String, dynamic>.from({}),
    "away_team": Map<String, dynamic>.from({})
  });
  Map home_data = {};
  Map away_data = {};
  Map league = {};
  int cur_season_id = 0;
  List pickerData_ = [];
  int select_index = 0;
  List data = [];
  void initState() {
    super.initState();

    _tabC = TabController(
      length: tabs.length,
      initialIndex: 0,
      vsync: this,
    );
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
        title: TextWidget(
          widget.name!,
          color: Colors.white,
          fontSize: rpx(16),
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
            expandedHeight: rpx(115),
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: GestureDetector(
                onTap: () {},
                child: Stack(
                  children: [
                    Positioned(
                        child: Image.asset(
                      "assets/images/game_detail_2.png",
                      width: rpx(375),
                      fit: BoxFit.cover,
                    )),
                    Container(
                      alignment: Alignment.topCenter,
                      child: netImg(widget.logo!, rpx(70), rpx(70)),
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
          tabs: tabs
              .map(
                (label) => Container(
                  height: rpx(35),
                  width: MediaQuery.of(context).size.width * 0.2,
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
        teamBaseInfo(id: widget.id),
        teamScoreRank(id: widget.id),
        teamMatch(id: widget.id),
        teamLineUp(id: widget.id),
        teamPlayerRank(id: widget.id),
      ]),
    );
  }
}
