import 'dart:convert';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jingcai_app/components/homes/dongtai.dart';
import 'package:jingcai_app/components/homes/dry_news.dart';
import 'package:jingcai_app/components/homes/expertPlan.dart';
import 'package:jingcai_app/components/homes/recommend.dart';
import 'package:jingcai_app/model/draymodel.dart';
import 'package:jingcai_app/model/expert.dart';
import 'package:jingcai_app/model/recommendModel.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class expertDetail extends StatefulWidget {
  int id;
  expertDetail({required this.id});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return expertDetail_();
  }
}

class expertDetail_ extends State<expertDetail> with TickerProviderStateMixin {
  var tabs = ["动态", "方案", "免费"];
  ScrollController sc = ScrollController();
  late TabController tc;
  late expert expert_data = expert();
  List<recommendModel> recmmend_data = [];
  List<recommendModel> free_data = [];
  List<drayModel> dry_data = [];
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    tc = TabController(
      length: tabs.length,
      initialIndex: 0,
      vsync: this,
    );

    getExpertData();
    getRecommendData();
    getFreeData();
    getDrayData();
  }

  Future getDrayData() async {
    //通过rootBundle.loadString();解析并返回
    String jsonData = await rootBundle.loadString("assets/mock/drys.json");
    final List jsonresult = json.decode(jsonData)["data"];
    setState(() {
      dry_data = jsonresult
          .map((e) => drayModel.fromJson((e as Map<String, dynamic>)))
          .toList();
    });
  }

  Future getFreeData() async {
    //通过rootBundle.loadString();解析并返回
    String jsonData = await rootBundle.loadString("assets/mock/recommend.json");
    final List jsonresult = json.decode(jsonData)["data"];
    setState(() {
      free_data = jsonresult
          .map((e) => recommendModel.fromJson((e as Map<String, dynamic>)))
          .toList();
    });
  }

  Future getRecommendData() async {
    //通过rootBundle.loadString();解析并返回
    String jsonData = await rootBundle.loadString("assets/mock/recommend.json");
    final List jsonresult = json.decode(jsonData)["data"];
    setState(() {
      recmmend_data = jsonresult
          .map((e) => recommendModel.fromJson((e as Map<String, dynamic>)))
          .toList();
    });
  }

  Future getExpertData() async {
    //通过rootBundle.loadString();解析并返回
    String jsonData = await rootBundle.loadString("assets/mock/expert.json");
    final List jsonresult = json.decode(jsonData)["data"];
    setState(() {
      expert_data = jsonresult
          .map((e) => expert.fromJson((e as Map<String, dynamic>)))
          .toList()[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    double pinnedHeaderHeight = rpx(statusBarHeight) - rpx(30);

    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xff002868),
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              G.router.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Text(
            "专家详情",
            style: TextStyle(color: Colors.white, fontSize: rpx(15)),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff002868)),
      body: expert_data.avatar != null
          ? ExtendedNestedScrollView(
              controller: sc,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: rpx(15)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Color(0xff002868),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      spacing: rpx(10),
                                      children: [
                                        CircleAvatar(
                                          radius: rpx(30),
                                          backgroundImage: NetworkImage(
                                            expert_data.avatar.toString(),
                                          ),
                                        ),
                                        Wrap(
                                          spacing: rpx(3),
                                          direction: Axis.vertical,
                                          children: [
                                            Text(
                                              expert_data.name.toString(),
                                              style: TextStyle(
                                                  fontSize: rpx(14),
                                                  color: Colors.white),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: rpx(2),
                                                  right: rpx(2),
                                                  top: rpx(2),
                                                  bottom: rpx(2)),
                                              color: Color.fromARGB(
                                                  255, 57, 98, 163),
                                              child: Text(
                                                expert_data.intro.toString(),
                                                style: TextStyle(
                                                    fontSize: rpx(11),
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Wrap(
                                              spacing: rpx(3),
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                Text(
                                                  expert_data.fans.toString() +
                                                      "粉丝",
                                                  style: TextStyle(
                                                      fontSize: rpx(12),
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  "|",
                                                  style: TextStyle(
                                                      fontSize: rpx(12),
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  expert_data.count.toString() +
                                                      "方案",
                                                  style: TextStyle(
                                                      fontSize: rpx(12),
                                                      color: Colors.white),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                        child: Container(
                                      height: rpx(32),
                                      width: rpx(70),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: expert_data.is_subscribe == 1
                                              ? Color(0xff002868)
                                              : Colors.white,
                                          border: Border.all(
                                              color: Colors.white, width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(rpx(16)))),
                                      margin: EdgeInsets.only(right: rpx(15)),
                                      child: Text(
                                        expert_data.is_subscribe == 1
                                            ? "已关注"
                                            : "+关注",
                                        style: TextStyle(
                                          fontSize: rpx(14),
                                          color: expert_data.is_subscribe == 0
                                              ? Colors.red
                                              : Colors.white,
                                        ),
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: rpx(10)),
                                child: Text(
                                  expert_data.desc.toString(),
                                  style: TextStyle(
                                      fontSize: rpx(15), color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: rpx(15)),
                          child: Image.network(expert_data.banner.toString(),
                              width: double.infinity, fit: BoxFit.cover),
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
                  children: [_tabars(), _tarbarview()],
                ),
              ),
            )
          : Container(),
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
          indicatorPadding: EdgeInsets.only(left: rpx(30), right: rpx(30)),

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

          controller: tc,
          tabs: tabs
              .map(
                (label) => Container(
                  width: MediaQuery.of(context).size.width * 0.33,
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
      child: TabBarView(controller: tc, children: [
        //因为有两个tabar所以写死了两个Container
        //在实际开发中我们通过接口获取tabar和children的数量 用list存储
        dongtai(),

        expertPlan(),

        SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: classHeader(),
            controller: refreshController,
            onRefresh: _onRefreshFreeData,
            onLoading: _onLoadingFreeData,
            footer: classFooter(),
            child: ListView(
              children: List.generate(
                  free_data.length,
                  (index) => Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: const Color.fromARGB(
                                        255, 243, 243, 243),
                                    width: 1))),
                        padding: EdgeInsets.all(rpx(10)),
                        child: Wrap(
                          spacing: rpx(3),
                          crossAxisAlignment: WrapCrossAlignment.start,
                          direction: Axis.vertical,
                          children: [
                            Text(
                              free_data[index].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: rpx(14)),
                            ),
                            Wrap(
                              spacing: rpx(5),
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  free_data[index].date + "前" + "  发布",
                                  style: TextStyle(
                                      fontSize: rpx(12),
                                      color: const Color.fromARGB(
                                          255, 128, 128, 128)),
                                ),
                                Text(
                                  free_data[index].count.toString() + "人查看",
                                  style: TextStyle(
                                      fontSize: rpx(12),
                                      color:
                                          Color.fromARGB(255, 128, 128, 128)),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
            )),
      ]),
    );
  }

  void _onRefreshFreeData() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void _onLoadingFreeData() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 3000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    refreshController.loadNoData();
  }
}
