import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/commity_pages/expertList.dart';
import 'package:jingcai_app/pages/commity_pages/talenttList.dart';
import 'package:jingcai_app/util/rpx.dart';

import 'talentEvent.dart';

class expertTalent extends StatefulWidget {
  int index = 0;
  int is_flow = 0;
  expertTalent({required this.index, required this.is_flow});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _expertTalent();
  }
}

class _expertTalent extends State<expertTalent> with TickerProviderStateMixin {
  late TabController _tabC;
  // var tabs = ["福神专家", "红榜达人"];
  var tabs = ["红榜达人"];
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    talentBus.fire(talentEvent());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "达人",
          style: TextStyle(fontSize: rpx(15)),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [_tarbarview()],
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
      indicatorPadding: EdgeInsets.only(left: rpx(80), right: rpx(80)),

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
              width: MediaQuery.of(context).size.width * 0.5,
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
        expertList(
          is_flow: widget.is_flow,
        ),
      ]),
    );
  }
}
