import 'package:flutter/material.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class basketGen extends StatefulWidget {
  JcFootModel foot = JcFootModel.fromJson({
    "leagues": Map<String, dynamic>.from({}),
    "home_team": Map<String, dynamic>.from({}),
    "away_team": Map<String, dynamic>.from({})
  });
  int? id;
  basketGen({required this.id, required this.foot});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return historyData_();
  }
}

class historyData_ extends State<basketGen> with TickerProviderStateMixin {
  int _cur_index = 0;
  late final TabController _tabC = TabController(
    length: 2,
    initialIndex: 0,
    vsync: this,
  );
  List homes = [];
  List aways = [];

  @override
  void initState() {
    super.initState();

    G.api.gameAdd.getBasketGen({"id": widget.id}).then((value) {
      setState(() {
        homes = value["home_his"];
        aways = value["away_his"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: [
        _tabars(),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: rpx(10), top: rpx(10), bottom: rpx(10)),
          child: TextWidget(
            "有利情报",
            fontWeight: FontWeight.bold,
            fontSize: rpx(15),
          ),
        ),
        getGen(1).isNotEmpty
            ? Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: rpx(10)),
                    child: Divider(
                      height: rpx(3),
                    ),
                  ),
                  SizedBox(
                    height: rpx(10),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: rpx(10)),
                    child: Column(
                      children: List.generate(
                          getGen(1).length,
                          (index) => Container(
                                child: Text(
                                  getGen(1)[index]["text"],
                                  maxLines: 100,
                                  style: TextStyle(fontSize: rpx(13)),
                                ),
                              )),
                    ),
                  )
                ],
              )
            : TextWidget(
                "-暂无数据-",
                color: Colors.grey,
              ),
        SizedBox(
          height: rpx(10),
        ),
        Container(height: rpx(4), color: Color(0xfff0f0f0)),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: rpx(10), top: rpx(10), bottom: rpx(10)),
          child: TextWidget(
            "不利情报",
            fontWeight: FontWeight.bold,
            fontSize: rpx(15),
          ),
        ),
        getGen(2).isNotEmpty
            ? Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: rpx(10)),
                    child: Divider(
                      height: rpx(3),
                    ),
                  ),
                  SizedBox(
                    height: rpx(10),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: rpx(10)),
                    child: Column(
                      children: List.generate(
                          getGen(2).length,
                          (index) => Container(
                                child: Text(
                                  getGen(1)[index]["text"],
                                  maxLines: 100,
                                  style: TextStyle(fontSize: rpx(13)),
                                ),
                              )),
                    ),
                  )
                ],
              )
            : TextWidget(
                "-暂无数据-",
                color: Colors.grey,
              ),
        SizedBox(
          height: rpx(10),
        ),
        Container(height: rpx(4), color: Color(0xfff0f0f0)),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: rpx(10), top: rpx(10), bottom: rpx(10)),
          child: TextWidget(
            "中立情报",
            fontWeight: FontWeight.bold,
            fontSize: rpx(15),
          ),
        ),
        getGen(0).isNotEmpty
            ? Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: rpx(10)),
                    child: Divider(
                      height: rpx(3),
                    ),
                  ),
                  SizedBox(
                    height: rpx(10),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: rpx(10)),
                    child: Column(
                      children: List.generate(
                          getGen(0).length,
                          (index) => Container(
                                child: Text(
                                  getGen(1)[index]["text"],
                                  maxLines: 100,
                                  style: TextStyle(fontSize: rpx(13)),
                                ),
                              )),
                    ),
                  )
                ],
              )
            : TextWidget(
                "-暂无数据-",
                color: Colors.grey,
              ),
        SizedBox(
          height: rpx(10),
        ),
      ],
    );
  }

  List getGen(int type) {
    List s = [];
    if (_cur_index == 0) {
      s = aways;
    } else {
      s = homes;
    }
    return s.where((element) => element["type_id"] == type).toList();
  }

  _tabars() {
    var tabs = [
      widget.foot.awayTeam!.nameShort,
      widget.foot.homeTeam!.nameShort,
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
