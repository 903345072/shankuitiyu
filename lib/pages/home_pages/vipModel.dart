import 'package:flutter/material.dart';
import 'package:jingcai_app/components/payWidget.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/big_data_pages/gameBigData.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/pages/home_pages/modelChilds/GameIndexChangeDetail.dart';
import 'package:jingcai_app/pages/home_pages/modelChilds/ModelboSongDetail.dart';
import 'package:jingcai_app/pages/home_pages/modelChilds/ModelcompanyDiffDetail.dart';
import 'package:jingcai_app/pages/home_pages/modelChilds/ModelindexDiffDetail.dart';
import 'package:jingcai_app/pages/home_pages/modelChilds/modelGameBigData.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/rpx.dart';

class vipModel extends StatefulWidget {
  JcFootModel foot = JcFootModel.fromJson({
    "leagues": Map<String, dynamic>.from({}),
    "home_team": Map<String, dynamic>.from({}),
    "away_team": Map<String, dynamic>.from({})
  });
  int? id;
  vipModel({required this.id, required this.foot});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return historyData_();
  }
}

class historyData_ extends State<vipModel> with TickerProviderStateMixin {
  int _cur_index = 0;
  PageController _pageController = PageController(initialPage: 0);
  var tabs = ["大数据", "指数异动", "泊松分布", "指数分歧", "机构分歧"];
  late final TabController _tabC = TabController(
    length: tabs.length,
    initialIndex: 0,
    vsync: this,
  );
  List homes = [];
  List aways = [];
  List battle = [];
  bool is_buy1 = false;
  bool is_buy2 = false;
  bool is_buy3 = false;
  bool is_buy4 = false;
  bool is_buy5 = false;
  List model = [];
  @override
  void initState() {
    super.initState();

    G.api.gameAdd.getHistoryData({"id": widget.id}).then((value) {
      setState(() {
        homes = value["home_his"];
        aways = value["away_his"];
        battle = value["battle"];
      });
    });
    getAllIsBuy();
  }

  getAllIsBuy() {
    G.api.user.getAllIsBuy({}).then((value) {
      setState(() {
        model = value;
        is_buy1 = getIsBuy(value, 1);
        is_buy2 = getIsBuy(value, 2);
        is_buy3 = getIsBuy(value, 3);
        is_buy4 = getIsBuy(value, 4);
        is_buy5 = getIsBuy(value, 5);
      });
    });
  }

  bool getIsBuy(List s, int id) {
    Map m = s.where((element) => element["id"] == id).first;
    return m["is_buy"] == 1 ? true : false;
  }

  String getPrice(int id) {
    Map m = model.where((element) => element["id"] == id).first;
    return m["price"].toString();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [_tabars(), _tarbarview()],
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
            getModel(is_buy1, modelGameBigData(id: widget.id), 1,
                " 订阅后可获得比分、胜平负、让球、进球数概率预测等服务，以及更加全面的分析数据。 ", () {
              setState(() {
                is_buy1 = true;
              });
            }),
            getModel(is_buy2, GameIndexChangeDetail(id: widget.id), 2,
                "  订阅后，当比赛有指数异动的时候，可获得即时的数据情报 ", () {
              setState(() {
                is_buy2 = true;
              });
            }),
            getModel(is_buy3, ModelboSongDetail(id: widget.id), 3,
                " 根据泊松分布公式，计算球队进球和比分的概率分布数据 ", () {
              setState(() {
                is_buy3 = true;
              });
            }),
            getModel(is_buy4, ModelindexDiffDetail(id: widget.id), 4,
                " 统计各个机构的指数分歧数据，从中发现机构对球队的赛事观点 ", () {
              setState(() {
                is_buy4 = true;
              });
            }),
            getModel(is_buy5, ModelcompanyDiffDetail(id: widget.id), 5,
                " 计算各个机构的指数分歧、方差，发现机构的不同观点看法 ", () {
              setState(() {
                is_buy5 = true;
              });
            }),
          ]),
    );
  }

  Widget getModel(bool buy_is, Widget wd, int id, String desc, Function d) {
    return buy_is
        ? wd
        : Container(
            margin: EdgeInsets.only(top: rpx(50)),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/nosubscribe.png",
                  width: rpx(100),
                  fit: BoxFit.cover,
                ),
                Container(
                  height: rpx(10),
                ),
                Container(
                  width: rpx(200),
                  child: Text(
                    desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: rpx(13), color: Colors.grey),
                  ),
                ),
                Container(
                  height: rpx(10),
                ),
                model.isNotEmpty
                    ? payWidget(
                        price: getPrice(id),
                        button: Container(
                          alignment: Alignment.center,
                          height: rpx(35),
                          margin: EdgeInsets.symmetric(horizontal: rpx(40)),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(rpx(35))),
                          child: TextWidget(
                            "订阅此数据模型${getPrice(id)}红币每月",
                            color: Colors.white,
                          ),
                        ),
                        pay_after: (Map data) {
                          d();
                        },
                        map: {"id": id},
                        type: 2)
                    : Container()
              ],
            ),
          );
  }

  _tabars() {
    Map select_style = {"color": Colors.white, "backGroundColor": Colors.red};
    Map unselect_style = {
      "color": Colors.black,
      "backGroundColor": Colors.white
    };
    return Container(
      height: rpx(50),
      color: Color(0xfff0f0f0),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            tabs.length,
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
                            ? BorderRadius.only(
                                topLeft: Radius.circular(3),
                                bottomLeft: Radius.circular(3))
                            : BorderRadius.only(
                                topRight: Radius.circular(3),
                                bottomRight: Radius.circular(3))),
                    padding:
                        EdgeInsets.only(left: 7, right: 7, top: 3, bottom: 3),
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
