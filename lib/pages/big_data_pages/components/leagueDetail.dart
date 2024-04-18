import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/big_data_pages/components/matchList.dart';
import 'package:jingcai_app/pages/big_data_pages/components/playerRank.dart';
import 'package:jingcai_app/pages/big_data_pages/components/scoreRank.dart';
import 'package:jingcai_app/pages/big_data_pages/components/teamRank.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class leagueDetail extends StatefulWidget {
  int id;
  String? name;
  String? logo;
  leagueDetail({required this.id, required this.name, required this.logo});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return gameDetail_();
  }
}

class gameDetail_ extends State<leagueDetail> with TickerProviderStateMixin {
  GlobalKey<scoreRank_> scoreRankKey = GlobalKey<scoreRank_>();
  GlobalKey<matchList_> matchKey = GlobalKey<matchList_>();
  GlobalKey<playerRank_> playerRankKey = GlobalKey<playerRank_>();
  GlobalKey<teamRank_> teamRankKey = GlobalKey<teamRank_>();
  late TabController _tabC;
  var tabs = ["方案", "积分榜", "比赛", "球员榜", "球队榜"];
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
    getLeagueSeaSons();
  }

  getLeagueSeaSons() {
    G.api.gameAdd.getLeagueSeaSons({"id": widget.id}).then((value) {
      setState(() {
        List da = value;
        data = value;
        da.asMap().forEach((key, value) {
          if (value["is_current"] == 1) {
            select_index = key;
          }
          pickerData_.add(value["name"]);
        });
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
        title: TextWidget(
          widget.name!,
          color: Colors.white,
          fontSize: rpx(16),
        ),
        actions: [
          Builder(builder: (BuildContext context) {
            return onClick(
                Container(
                  margin: EdgeInsets.only(right: rpx(10)),
                  height: rpx(30),
                  padding: EdgeInsets.symmetric(horizontal: rpx(5)),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(rpx(30))),
                  child: Row(
                    children: [
                      data.isNotEmpty
                          ? TextWidget(
                              data[select_index]["name"],
                              color: Colors.white,
                              fontSize: rpx(11),
                            )
                          : Container(),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                        size: rpx(19),
                      )
                    ],
                  ),
                ), () async {
              Picker picker = Picker(
                  cancelText: "取消",
                  confirmText: "确认",
                  selecteds: [select_index],
                  adapter: PickerDataAdapter<String>(pickerData: pickerData_),
                  changeToFirst: true,
                  textAlign: TextAlign.left,
                  columnPadding: const EdgeInsets.all(8.0),
                  onConfirm: (Picker picker, List value) {
                    setState(() {
                      select_index = value.first;
                      if (scoreRankKey.currentState != null) {
                        scoreRankKey.currentState!
                            .getData(seson_id: data[select_index]["id"]);
                      }
                      if (matchKey.currentState != null) {
                        matchKey.currentState!.getLeagueRounds(
                            seson_id: data[select_index]["id"]);
                      }
                      if (playerRankKey.currentState != null) {
                        playerRankKey.currentState!
                            .getData(season_id: data[select_index]["id"]);
                      }

                      if (teamRankKey.currentState != null) {
                        teamRankKey.currentState!
                            .getData(season_id: data[select_index]["id"]);
                      }
                    });
                  });

              picker.showBottomSheet(context);
            });
          }),
        ],
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
        Container(
          alignment: Alignment.center,
          child: const Text(
            "暂无情报",
            style: TextStyle(fontSize: 18.0, color: Colors.grey),
          ),
        ),
        data.isNotEmpty
            ? scoreRank(
                key: scoreRankKey,
                id: widget.id,
                season_id: data[select_index]["id"],
              )
            : Container(),
        data.isNotEmpty
            ? matchList(
                key: matchKey,
                id: widget.id,
                season_id: data[select_index]["id"],
              )
            : Container(),
        data.isNotEmpty
            ? playerRank(
                id: widget.id,
                season_id: data[select_index]["id"],
                key: playerRankKey,
              )
            : Container(),
        data.isNotEmpty
            ? teamRank(
                id: widget.id,
                season_id: data[select_index]["id"],
                key: teamRankKey,
              )
            : Container(),
      ]),
    );
  }
}
