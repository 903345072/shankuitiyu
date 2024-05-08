import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/big_data_pages/aiGuess.dart';
import 'package:jingcai_app/pages/big_data_pages/dataBase.dart';
import 'package:jingcai_app/pages/big_data_pages/dataModel.dart';
import 'package:jingcai_app/util/rpx.dart';

class bigData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return bigData_();
  }
}

class bigData_ extends State<bigData> with TickerProviderStateMixin {
  late TabController _tabC;
  var tabs = ["数据模型", "福神AI方案", "资料库"];
  @override
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
    var stateBarHeight = MediaQuery.of(context).padding.top;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: stateBarHeight),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _tabBar(),
                // Icon(
                //   Icons.subject,
                //   color: Colors.red,
                // )
                Container()
              ],
            ),
            _tarbarview()
          ],
        ),
      ),
    );
  }

  _tarbarview() {
    return Expanded(
      child: TabBarView(controller: _tabC, children: [
        //因为有两个tabar所以写死了两个Container
        //在实际开发中我们通过接口获取tabar和children的数量 用list存储
        dataModel(),
        aiGuess(),
        dataBase(),
      ]),
    );
  }

  _tabBar() {
    return TabBar(
      physics: NeverScrollableScrollPhysics(),
      tabAlignment: TabAlignment.start,
      padding: EdgeInsets.all(0),
      dividerColor: Colors.transparent,
      labelPadding: EdgeInsets.all(0),

      labelColor: Colors.red,
      unselectedLabelColor: Colors.black,
      indicatorColor: Colors.transparent,

      // 选择的样式
      labelStyle: TextStyle(
        fontSize: rpx(18),
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
              width: MediaQuery.of(context).size.width * 0.23,
              child: Tab(text: "$label"),
            ),
          )
          .toList(),
    );
  }
}
