import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jingcai_app/components/homes/expertPreview.dart';
import 'package:jingcai_app/model/userModel.dart';
import 'package:jingcai_app/model/expert.dart';
import 'package:jingcai_app/model/recommendModel.dart';
import 'package:jingcai_app/model/talentModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/pages/home_pages/planDetail.dart';
import 'package:jingcai_app/pages/home_pages/planPreview.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'talentPlanPreview.dart';

class talent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return talent_();
  }
}

class talent_ extends State<talent> with TickerProviderStateMixin {
  List<expert> expert_info = [];
  List expert_list = [];
  var tabs = ["命中率榜", "盈利率榜", "连红榜"];
  int page = 1;
  var talent_tabs = [
    {"type_id": 1, "value": "全部", "tag": "all"},
    {"type_id": 2, "value": "竞足", "tag": "jc_foot"},
    {"type_id": 3, "value": "让球", "tag": "rq"},
    {"type_id": 4, "value": "进球数", "tag": "dxq"},
    {"type_id": 5, "value": "让分", "tag": "rfsf"},
    {"type_id": 6, "value": "大小分", "tag": "dxf"},
    {"type_id": 7, "value": "免费", "tag": "free"}
  ];
  int type_index = 0;
  int cur_index = 0;
  late TabController _tabC;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    _tabC = TabController(
      length: tabs.length,
      initialIndex: 0,
      vsync: this,
    );
    getData();
    getExpertInfo();
  }

  Future getData() async {
    G.api.game.getTalentRank({"type": cur_index}).then((value) {
      setState(() {
        List ss = value;
        List<expert> s = ss
            .map((e) => expert.fromJson((e as Map<String, dynamic>)))
            .toList();
        expert_info = s;
      });
    });
  }

  Future getExpertInfo() async {
    return G.api.game.getTalentPlan(
        {"type": talent_tabs[type_index]["tag"], "page": page}).then((value) {
      setState(() {
        expert_list.addAll(value);
      });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: classHeader(),
      controller: refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      footer: classFooter(),
      child: ListView(
        children: [
          TabBar(
            onTap: (e) {
              setState(() {
                cur_index = e;
              });
              getData();
            },
            tabAlignment: TabAlignment.center,
            dividerColor: Colors.transparent,
            padding: EdgeInsets.all(rpx(10)),

            labelPadding: EdgeInsets.all(0),

            labelColor: Colors.white,
            unselectedLabelColor: Color(0xff9f9f9f),
            indicatorColor: Colors.transparent,
            indicatorPadding: EdgeInsets.only(left: rpx(20), right: rpx(20)),

            // 选择的样式
            labelStyle: TextStyle(
              fontSize: rpx(12),
              fontWeight: FontWeight.bold,
            ),

            // 未选中的样式
            unselectedLabelStyle: TextStyle(
              fontSize: rpx(12),
            ),
            indicatorWeight: 1.0,

            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            splashFactory: NoSplash.splashFactory,

            controller: _tabC,
            tabs: List.generate(
                tabs.length,
                (index) => Container(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      color:
                          cur_index == index ? Colors.red : Color(0xfff0f0f0),
                      alignment: Alignment.center,
                      width: rpx(63.75),
                      child: Column(
                        children: [
                          Text(
                            tabs[index],
                          ),
                        ],
                      ),
                    )),
          ),
          Container(
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              runSpacing: rpx(4),
              children: getChilds(),
            ),
          ),
          GestureDetector(
            onTap: () {
              var p = {"index": 1, "is_flow": 0};
              G.router.navigateTo(
                  context, "/expertTalent" + G.parseQuery(params: p),
                  transition: TransitionType.inFromRight);
            },
            child: Container(
              padding: EdgeInsets.only(top: rpx(15)),
              alignment: Alignment.center,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  onClick(TextWidget("查看全部达人"), () {
                    var p = {"index": 0, "is_flow": 0};
                    G.router.navigateTo(
                        context, "/expertTalent" + G.parseQuery(params: p),
                        transition: TransitionType.inFromRight);
                  }),
                  Icon(
                    Icons.arrow_right,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            color: Color.fromARGB(255, 240, 240, 240),
            height: rpx(3),
          ),
          Container(
            padding: EdgeInsets.all(rpx(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("达人方案"),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        shape: BeveledRectangleBorder(),
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            alignment: Alignment.center,
                            height: rpx(320),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: rpx(40),
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          G.router.pop(context);
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.only(left: rpx(20)),
                                          child: Text("取消"),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.only(right: rpx(35)),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "筛选方案",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: rpx(14)),
                                        ),
                                      ),
                                      Container()
                                    ],
                                  ),
                                ),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  direction: Axis.vertical,
                                  children: List.generate(
                                      talent_tabs.length,
                                      (index) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                type_index = index;
                                                expert_list = [];
                                                page = 1;
                                              });
                                              refreshController.loadComplete();
                                              getExpertInfo();
                                              G.router.pop(context);
                                            },
                                            child: Container(
                                              height: rpx(40),
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  color: type_index == index
                                                      ? Color.fromARGB(
                                                          255, 240, 240, 240)
                                                      : Colors.white,
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.grey,
                                                          width: 0.1))),
                                              child: Text(
                                                talent_tabs[index]["value"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: rpx(15)),
                                              ),
                                            ),
                                          )),
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: Wrap(
                    spacing: rpx(12),
                    children: [
                      Text(talent_tabs[type_index]["value"].toString()),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                )
              ],
            ),
          ),
          expert_list.length > 0
              ? Column(
                  children: List.generate(
                      expert_list.length,
                      (index) => onClick(
                              planPreview(
                                data: expert_list[index],
                                show_head: true,
                              ), () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => planDetail(
                                  user: userModel
                                      .fromJson(expert_list[index]["user"]),
                                  plan: expert_list[index],
                                  uid: expert_list[index]["uid"],
                                ),
                              ),
                            );
                          })),
                )
              : Container(
                  height: rpx(300),
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/nosubscribe.png",
                    width: rpx(150),
                  ),
                ),
        ],
      ),
    );
  }

  void _onRefresh() async {
    refreshController.loadComplete();
    setState(() {
      page = 1;
      expert_info = [];
      expert_list = [];
    });
    getExpertInfo();
    getData();
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    setState(() {
      page++;
    });
    getExpertInfo().then((value) {
      if (value.isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    });
  }

  getChilds() {
    List<expert> ll = [];
    if (expert_info.length >= 8) {
      ll = expert_info.sublist(0, 7);
    } else {
      ll = expert_info;
    }

    List<Widget> list = List.generate(
        ll.length,
        (index) => onClick(
            expertPreview(expertModel: expert_info[index]),
            () => G.router.navigateTo(
                context,
                "/talentDetail" +
                    G.parseQuery(params: {"uid": expert_info[index].userId}))));
    list.add(GestureDetector(
      onTap: () {
        G.router.navigateTo(context,
            "/talentRank" + G.parseQuery(params: {"index": _tabC.index}),
            transition: TransitionType.inFromRight);
      },
      child: Container(
        padding: EdgeInsets.only(top: rpx(10), left: rpx(25)),
        width: MediaQuery.of(context).size.width * 0.25, // 屏幕宽度的50%,
        child: Wrap(
          spacing: rpx(5),
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Image.asset(
              "assets/images/seeMore.png",
              fit: BoxFit.cover,
              width: rpx(40),
            ),
            Text("更多")
          ],
        ),
      ),
    ));
    return list;
  }
}
