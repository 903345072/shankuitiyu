import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/my/page/dataSubscribeRecord.dart';
import 'package:jingcai_app/pages/botom_pages/my/page/talentPlanRecord.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';
import '../../widget/PreferredSizeWidget.dart';

class myPlan extends StatefulWidget {
  const myPlan({Key? key}) : super(key: key);

  @override
  State<myPlan> createState() => _PurchaseRecordPageState();
}

class _PurchaseRecordPageState extends State<myPlan>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  var tabs = [
    "我的方案",
  ];
  late TabController _tabC;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabC = TabController(
      length: tabs.length,
      initialIndex: 0,
      vsync: this,
    );
  }

  _tabBar() {
    return TabBar(
      physics: NeverScrollableScrollPhysics(),
      tabAlignment: TabAlignment.start,
      padding: EdgeInsets.all(0),

      labelPadding: EdgeInsets.all(0),
      indicatorPadding: EdgeInsets.only(left: rpx(15), right: rpx(15)),
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
              width: MediaQuery.of(context).size.width * (1 / tabs.length),
              child: Tab(text: "$label"),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: appbar('我发布的方案'),
        body: TabBarView(
          controller: _tabC,
          children: [
            talentPlanRecord(type: 1),
          ],
        ),
      ),
    );
  }
}
