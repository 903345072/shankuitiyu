import 'package:flutter/material.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class basketPlayerData extends StatefulWidget {
  JcFootModel foot = JcFootModel.fromJson({
    "leagues": Map<String, dynamic>.from({}),
    "home_team": Map<String, dynamic>.from({}),
    "away_team": Map<String, dynamic>.from({})
  });
  int? id;
  List home_player = [];
  List away_player = [];
  Map? home_team = {};
  Map? away_team = {};
  basketPlayerData(
      {required this.foot,
      required this.id,
      required this.away_player,
      required this.away_team,
      required this.home_player,
      required this.home_team});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return basketPlayerDetail_();
  }
}

class basketPlayerDetail_ extends State<basketPlayerData>
    with TickerProviderStateMixin {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int _cur_index = 0;

  PageController _pageController = PageController(initialPage: 0);
  late final TabController _tabC = TabController(
    length: 3,
    initialIndex: 0,
    vsync: this,
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: rpx(50),
          color: const Color(0xfff0f0f0),
          child: _tabars(),
        ),
        _tarbarview()
      ],
    );
  }

  _tabars() {
    var tabs = [
      widget.foot.awayTeam!.nameShort,
      widget.foot.homeTeam!.nameShort,
      "球队数据"
    ];
    Map select_style = {"color": Colors.white, "backGroundColor": Colors.red};
    Map unselect_style = {
      "color": Colors.black,
      "backGroundColor": Colors.white
    };
    return Container(
      child: Wrap(
        children: List.generate(
            3,
            (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _cur_index = index;
                      _pageController.jumpToPage(index);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                                width: rpx(0.3), color: Colors.grey)),
                        color: _cur_index == index
                            ? select_style["backGroundColor"]
                            : unselect_style["backGroundColor"],
                        borderRadius: index == 0
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(3),
                                bottomLeft: Radius.circular(3))
                            : const BorderRadius.only(
                                topRight: Radius.circular(3),
                                bottomRight: Radius.circular(3))),
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 3, bottom: 3),
                    child: Text(
                      tabs[index]!,
                      style: TextStyle(
                          color: _cur_index == index
                              ? select_style["color"]
                              : unselect_style["color"],
                          fontSize: rpx(13)),
                    ),
                  ),
                )),
      ),
    );
  }

  _tarbarview() {
    return Expanded(
      child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            //因为有两个tabar所以写死了两个Container
            //在实际开发中我们通过接口获取tabar和children的数量 用list存储
            widget.away_player.isNotEmpty
                ? Container(
                    margin: EdgeInsets.only(top: rpx(15)),
                    child: ListView(
                      children: [getPlayerWidget(widget.away_player)],
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    child: TextWidget("暂无数据"),
                  ),
            widget.home_player.isNotEmpty
                ? Container(
                    margin: EdgeInsets.only(top: rpx(15)),
                    child: ListView(
                      children: [getPlayerWidget(widget.home_player)],
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    child: TextWidget("暂无数据"),
                  ),
            widget.away_team != null && widget.home_team != null
                ? ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(rpx(10)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: rpx(10),
                                  children: [
                                    Container(
                                      height: rpx(14),
                                      width: rpx(2),
                                      color: Colors.red,
                                    ),
                                    TextWidget(widget.foot.awayTeam!.nameShort!
                                        .toString())
                                  ],
                                ),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: rpx(10),
                                  children: [
                                    TextWidget(widget.foot.homeTeam!.nameShort!
                                        .toString()),
                                    Container(
                                      height: rpx(14),
                                      width: rpx(2),
                                      color: Color(0xff002868),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [getBatleWidget("总得分", "points")],
                            ),
                            Column(
                              children: [getBatleWidget("篮板球", "rebounds")],
                            ),
                            Column(
                              children: [getBatleWidget("助攻数", "assists")],
                            ),
                            Column(
                              children: [getBatleWidget("抢断数", "steals")],
                            ),
                            Column(
                              children: [getBatleWidget("盖帽数", "blocks")],
                            ),
                            Column(
                              children: [getBatleWidget("失误数", "turnovers")],
                            ),
                            Column(
                              children: [getBatleWidget("犯规数", "fouls")],
                            ),
                            Column(
                              children: [
                                getBatleWidget("投篮命中率", "field_goals_percent")
                              ],
                            ),
                            Column(
                              children: [
                                getBatleWidget("三分命中率", "points3_percent")
                              ],
                            ),
                            Column(
                              children: [
                                getBatleWidget("罚球命中率", "free_throws_percent")
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
                : Container(
                    alignment: Alignment.center,
                    child: TextWidget("暂无数据"),
                  )
          ]),
    );
  }

  double getWidth(double? l1, double? t) {
    double c = 0;
    if (t == 0) {
      return 50;
    } else {
      c = (l1! / t!) * rpx(250);
    }

    return c;
  }

  Widget getBatleWidget(String title, String field) {
    Widget c = Container();
    if (widget.away_team![field] != null) {
      c = c = Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          direction: Axis.vertical,
          children: [
            TextWidget(title),
            Row(
              children: [
                Container(
                  width: rpx(50),
                  child: TextWidget(widget.away_team![field].toString()),
                ),
                Container(
                  width: rpx(5),
                ),
                Row(
                  children: [
                    Container(
                      height: rpx(10),
                      width: getWidth(
                          double.parse(widget.away_team![field] ?? "0"),
                          double.parse(widget.away_team![field] ?? "0") +
                              double.parse(widget.home_team![field] ?? "0")),
                      decoration: BoxDecoration(color: Colors.red),
                    ),
                    Container(
                      height: rpx(10),
                      width: 250 -
                          getWidth(
                              double.parse(widget.away_team![field] ?? "0"),
                              double.parse(widget.away_team![field] ?? "0") +
                                  double.parse(
                                      widget.home_team![field] ?? "0")),
                      decoration: BoxDecoration(
                        color: Color(0xff002868),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: rpx(5),
                ),
                Container(
                  width: rpx(50),
                  child: TextWidget(widget.home_team![field].toString()),
                ),
              ],
            )
          ]);
    }

    return c;
  }

  Widget getPlayerWidget(List data) {
    return Container(
      height: rpx(340),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: getPlayerList(data),
          ),
          Expanded(
              child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              Row(
                children: [
                  Column(
                    children: getPlayerList1("时间", "minutes", data),
                  ),
                  Column(
                    children: getPlayerList1("得分", "points", data),
                  ),
                  Column(
                    children: getPlayerList1("篮板", "rebounds", data),
                  ),
                  Column(
                    children: getPlayerList1("助攻", "assists", data),
                  ),
                  Column(
                    children: getThrow(data),
                  ),
                  Column(
                    children: getThreeThrow(data),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  List<Widget> getPlayerList(List data) {
    List<Widget> s = [];
    s.add(Container(
      width: rpx(100),
      height: rpx(25),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xfff0f0f0),
          border: Border(
              bottom: BorderSide(color: Colors.grey.shade100),
              right: BorderSide(color: Colors.grey.shade300))),
      child: TextWidget("球员"),
    ));
    data.forEach((element) {
      if (element["player"] != null) {
        s.add(Container(
          width: rpx(100),
          height: rpx(25),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey.shade100),
                  right: BorderSide(color: Colors.grey.shade100))),
          child: TextWidget(element["player"]["name_short"].toString()),
        ));
      }
    });
    return s;
  }

  List<Widget> getThrow(List data) {
    List<Widget> s = [];
    s.add(Container(
      width: rpx(100),
      height: rpx(25),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xfff0f0f0),
          border: Border(
              bottom: BorderSide(color: Colors.grey.shade100),
              right: BorderSide(color: Colors.grey.shade300))),
      child: TextWidget("投篮"),
    ));
    data.forEach((element) {
      s.add(Container(
        width: rpx(100),
        height: rpx(25),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.grey.shade100),
                right: BorderSide(color: Colors.grey.shade100))),
        child: element["field_goals_made"] != null
            ? TextWidget(element["field_goals_made"].toString() +
                "/" +
                element["field_goals"].toString())
            : TextWidget("未知"),
      ));
    });
    return s;
  }

  List<Widget> getThreeThrow(List data) {
    List<Widget> s = [];
    s.add(Container(
      width: rpx(100),
      height: rpx(25),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xfff0f0f0),
          border: Border(
              bottom: BorderSide(color: Colors.grey.shade100),
              right: BorderSide(color: Colors.grey.shade300))),
      child: TextWidget("三分"),
    ));
    data.forEach((element) {
      s.add(Container(
        width: rpx(100),
        height: rpx(25),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.grey.shade100),
                right: BorderSide(color: Colors.grey.shade100))),
        child: element["points3"] != null
            ? TextWidget(element["points3_made"].toString() +
                "/" +
                element["points3"].toString())
            : TextWidget("未知"),
      ));
    });
    return s;
  }

  List<Widget> getPlayerList1(String title, String field, List data) {
    List<Widget> s = [];
    s.add(Container(
      width: rpx(100),
      height: rpx(25),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xfff0f0f0),
          border: Border(
              bottom: BorderSide(color: Colors.grey.shade100),
              right: BorderSide(color: Colors.grey.shade300))),
      child: TextWidget(title),
    ));
    data.forEach((element) {
      s.add(Container(
        width: rpx(100),
        height: rpx(25),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.grey.shade100),
                right: BorderSide(color: Colors.grey.shade100))),
        child: TextWidget(
            element[field] != null ? element[field].toString() : "未知"),
      ));
    });
    return s;
  }
}
