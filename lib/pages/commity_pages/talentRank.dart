import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/components/commity/lianHong.dart';
import 'package:jingcai_app/components/commity/winRateList.dart';
import 'package:jingcai_app/model/winRateListModel.dart';
import 'package:jingcai_app/util/rpx.dart';

class talentRank extends StatefulWidget {
  int index = 0;
  talentRank({required this.index});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return talentRank_();
  }
}

class talentRank_ extends State<talentRank> with TickerProviderStateMixin {
  late TabController _tabC;
  var tabs = ["命中率", "盈利率", "连红数"];
  List<winRateModel> mzList = [];
  List<winRateModel> rateList = [];
  List<winRateModel> hongList = [];
  @override
  void initState() {
    super.initState();

    _tabC = TabController(
      length: tabs.length,
      initialIndex: widget.index,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "红榜达人排行榜",
          style: TextStyle(fontSize: rpx(15), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [_tabBar(), _tarbarview()],
      ),
    );
  }

  _tabBar() {
    return TabBar(
      tabAlignment: TabAlignment.center,
      dividerColor: Colors.transparent,

      labelPadding: EdgeInsets.only(bottom: rpx(10)),

      labelColor: Colors.red,
      unselectedLabelColor: Colors.black,
      indicatorColor: Colors.red,
      indicatorPadding: EdgeInsets.only(left: rpx(40), right: rpx(40)),

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
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.33,
              child: Text(
                tabs[index],
              ))),
    );
  }

  _tarbarview() {
    return Expanded(
      child: TabBarView(controller: _tabC, children: [
        //因为有两个tabar所以写死了两个Container
        //在实际开发中我们通过接口获取tabar和children的数量 用list存储
        winRateList(
          type: 0,
        ),
        winRateList(
          type: 1,
        ),
        winRateList(
          type: 2,
        ),
      ]),
    );
  }
}
