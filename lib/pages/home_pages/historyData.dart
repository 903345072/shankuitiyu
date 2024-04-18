import 'package:flutter/material.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class historyData extends StatefulWidget {
  JcFootModel foot = JcFootModel.fromJson({
    "leagues": Map<String, dynamic>.from({}),
    "home_team": Map<String, dynamic>.from({}),
    "away_team": Map<String, dynamic>.from({})
  });
  int? id;
  historyData({required this.id, required this.foot});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return historyData_();
  }
}

class historyData_ extends State<historyData> with TickerProviderStateMixin {
  int _cur_index = 0;
  late final TabController _tabC = TabController(
    length: 2,
    initialIndex: 0,
    vsync: this,
  );
  List homes = [];
  List aways = [];
  List battle = [];
  List home_missing = [];
  List away_missing = [];
  @override
  void initState() {
    super.initState();

    G.api.gameAdd.getHistoryData({"id": widget.id}).then((value) {
      setState(() {
        homes = value["home_his"];
        aways = value["away_his"];
        battle = value["battle"];
        home_missing = value["home_missing"];
        away_missing = value["away_missing"];
      });
    });
  }

  getMissing() {
    List s = [];
    if (_cur_index == 0) {
      s = home_missing;
    } else {
      s = away_missing;
    }
    if (s.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin:
                EdgeInsets.symmetric(vertical: rpx(10), horizontal: rpx(15)),
            child: TextWidget("伤停情况"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
                s.length,
                (index) => Container(
                      padding: EdgeInsets.only(
                          left: rpx(15), top: rpx(5), bottom: rpx(5)),
                      width: MediaQuery.of(context).size.width * 0.44,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: rpx(1), color: Colors.grey.shade200)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: rpx(40),
                            height: rpx(40),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(rpx(40)),
                              child: netImg(
                                  s[index]["player"]["logo"], rpx(40), rpx(40)),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(s[index]["player"]["name_short"]),
                              TextWidget(
                                s[index]["reason"],
                                color: Colors.grey,
                              )
                            ],
                          )
                        ],
                      ),
                    )),
          )
        ],
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: [
        _tabars(),
        Container(
          child: getMissing(),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: rpx(10), top: rpx(10), bottom: rpx(10)),
          child: TextWidget(
            "近期战绩",
            fontWeight: FontWeight.bold,
            fontSize: rpx(15),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: rpx(10)),
          child: Table(
            columnWidths: {2: FixedColumnWidth(rpx(170))},
            children: getChild(),
          ),
        ),
        SizedBox(
          height: rpx(10),
        ),
        Container(height: rpx(4), color: Color(0xfff0f0f0)),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: rpx(10), top: rpx(10), bottom: rpx(10)),
          child: TextWidget(
            "历史交锋",
            fontWeight: FontWeight.bold,
            fontSize: rpx(15),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: rpx(10)),
          child: Table(
            columnWidths: {2: FixedColumnWidth(rpx(170))},
            children: getChild(id: 1),
          ),
        ),
      ],
    );
  }

  List<TableRow> getChild({int id = 0}) {
    List<TableRow> c = [];
    c.add(TableRow(
        decoration: BoxDecoration(
          color: Color(
            0xfff0f0f0,
          ),
        ),
        children: [
          Container(
            height: rpx(20),
            alignment: Alignment.center,
            child: TextWidget("日期"),
          ),
          Container(
            height: rpx(20),
            alignment: Alignment.center,
            child: TextWidget("赛事"),
          ),
          Container(
            height: rpx(20),
            alignment: Alignment.center,
            child: TextWidget("主队vs客队"),
          ),
          Container(
            height: rpx(20),
            alignment: Alignment.center,
            child: TextWidget("半全场"),
          )
        ]));
    List s = [];
    if (_cur_index == 0) {
      s = homes;
    } else {
      s = aways;
    }
    if (id == 1) {
      s = battle;
    }

    s.forEach((element) {
      c.add(TableRow(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: rpx(0.2)))),
          children: [
            Container(
              height: rpx(40),
              alignment: Alignment.center,
              child: Text(
                element["start_at"].toString().substring(0, 10),
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: rpx(11)),
              ),
            ),
            Container(
              height: rpx(40),
              alignment: Alignment.center,
              child: TextWidget(
                element["leagues"]["name_short"].toString(),
                fontSize: rpx(11),
              ),
            ),
            Container(
              height: rpx(40),
              alignment: Alignment.center,
              child: getbfWid(element),
            ),
            Container(
              height: rpx(40),
              alignment: Alignment.center,
              child: getbqcWid(element),
            )
          ]));
    });

    return c;
  }

  Widget getbqcWid(Map d) {
    Widget c = Container();
    String bf = d["current_score"] ?? "0:0";

    String bc_bf = d["half_score"] ?? "0:0";

    List bf_ = bf.split(":");
    List bc_bf_ = bc_bf.split(":");

    Color left_color = Colors.red;
    Color right_color = Colors.red;
    String left_txt = "胜";
    String right_txt = "胜";
    if (double.parse(bf_[0]) < double.parse(bf_[1])) {
      left_color = Colors.green;

      left_txt = "负";
    }
    if (double.parse(bf_[0]) == double.parse(bf_[1])) {
      left_color = Colors.blue;
      left_txt = "平";
    }

    if (double.parse(bc_bf_[0]) < double.parse(bc_bf_[1])) {
      right_color = Colors.green;

      right_txt = "负";
    }
    if (double.parse(bc_bf_[0]) == double.parse(bc_bf_[1])) {
      right_color = Colors.blue;
      right_txt = "平";
    }
    c = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(
          right_txt,
          color: right_color,
        ),
        TextWidget(
          left_txt,
          color: left_color,
        ),
      ],
    );
    return c;
  }

  Widget getbfWid(Map d) {
    Widget c = Container();
    String bf = d["current_score"].toString();
    List bf_ = bf.split(":");

    Color left_color = Colors.red;
    Color right_color = Colors.green;
    if (double.parse(bf_[0]) < double.parse(bf_[1])) {
      left_color = Colors.green;
      right_color = Colors.red;
    }
    if (double.parse(bf_[0]) == double.parse(bf_[1])) {
      left_color = Colors.blue;
      right_color = Colors.blue;
    }
    c = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: rpx(70),
          child: TextWidget(
            d["home_team"]["name_short"].toString(),
            fontSize: rpx(12),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: rpx(3)),
          child: Row(
            children: [
              TextWidget(
                bf_[0],
                color: left_color,
              ),
              TextWidget(":"),
              TextWidget(
                bf_[1],
                color: right_color,
              )
            ],
          ),
        ),
        Container(
          width: rpx(70),
          child: TextWidget(
            d["away_team"]["name_short"].toString(),
            fontSize: rpx(12),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
    return c;
  }

  _tabars() {
    var tabs = [
      widget.foot.homeTeam!.nameShort,
      widget.foot.awayTeam!.nameShort,
    ];
    Map select_style = {"color": Colors.white, "backGroundColor": Colors.red};
    Map unselect_style = {
      "color": Colors.black,
      "backGroundColor": Colors.white
    };
    return Container(
      height: rpx(50),
      color: Color(0xfff0f0f0),
      alignment: Alignment.center,
      child: Wrap(
        children: List.generate(
            2,
            (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _cur_index = index;
                      //  _pageController.jumpToPage(index);
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
                            ? BorderRadius.only(
                                topLeft: Radius.circular(3),
                                bottomLeft: Radius.circular(3))
                            : BorderRadius.only(
                                topRight: Radius.circular(3),
                                bottomRight: Radius.circular(3))),
                    padding:
                        EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 3),
                    child: Text(
                      tabs[index].toString(),
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
}
