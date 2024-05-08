import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/score_pages/dataSourceFactory.dart';
import 'package:jingcai_app/pages/score_pages/socreFoot/course.dart';
import 'package:jingcai_app/pages/score_pages/socreFoot/finished.dart';
import 'package:jingcai_app/pages/score_pages/socreFoot/flowMatch.dart';

import 'package:jingcai_app/pages/score_pages/socreFoot/timely.dart';
import 'package:jingcai_app/util/rpx.dart';

class basket extends StatefulWidget {
  Function setDate;
  Function close_tab;
  basket({required this.setDate, super.key, required this.close_tab});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return basketing();
  }
}

class basketing extends State<basket> with TickerProviderStateMixin {
  late TabController _tabC;
  int type = 0;
  var tabs = ["即时", "赛程", "已完场", "关注"];
  GlobalKey<timeling> timekey = GlobalKey<timeling>();
  GlobalKey<courseing> coursekey = GlobalKey<courseing>();
  GlobalKey<finishing> finishkey = GlobalKey<finishing>();
  GlobalKey<flowMatchs> flowkey = GlobalKey<flowMatchs>();
  @override
  void initState() {
    super.initState();
    _tabC = TabController(
      length: tabs.length,
      initialIndex: 0,
      vsync: this,
    );
    _tabC.addListener(() {
      if (_tabC.index == 3) {
        widget.close_tab(false);
      } else {
        widget.close_tab(true);
      }
    });
  }

  refreshData({Object? value}) {
    if (value != null) {
      setState(() {
        var g = value as Map;
        type = g["index"];
      });
      if (timekey.currentState != null) {
        timekey.currentState?.clearData(value as Map);
        timekey.currentState?.loadArticle();
      }
      if (coursekey.currentState != null) {
        coursekey.currentState?.clearData(value as Map);
        coursekey.currentState?.loadArticle();
      }

      if (finishkey.currentState != null) {
        finishkey.currentState?.clearData(value as Map);
        finishkey.currentState?.loadArticle();
      }
      if (flowkey.currentState != null) {
        flowkey.currentState?.clearData(value as Map);
        flowkey.currentState?.loadArticle();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [_tabars(), _tarbarview()],
      ),
    );
  }

  _tabars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TabBar(
          physics: NeverScrollableScrollPhysics(),
          tabAlignment: TabAlignment.center,
          padding: EdgeInsets.all(0),

          labelPadding: EdgeInsets.all(0),

          labelColor: Colors.red,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.red,
          indicatorPadding: EdgeInsets.only(left: rpx(20), right: rpx(20)),

          // 选择的样式
          labelStyle: TextStyle(
            fontSize: rpx(13),
            fontWeight: FontWeight.bold,
          ),
          // 未选中的样式
          unselectedLabelStyle: TextStyle(
            fontSize: rpx(13),
          ),
          indicatorWeight: 1.0,

          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,

          controller: _tabC,
          tabs: tabs
              .map(
                (label) => Container(
                  padding: EdgeInsets.only(bottom: 10),
                  alignment: Alignment.center,
                  width: rpx(93.75),
                  child: Text(label),
                ),
              )
              .toList(),
        )
      ],
    );
  }

  _tarbarview() {
    return Expanded(
      child: TabBarView(controller: _tabC, children: [
        //因为有两个tabar所以写死了两个Container
        //在实际开发中我们通过接口获取tabar和children的数量 用list存储

        timely(
          dataSourceFactory()
              .getBasketDataSource("/common/basket/getScoreList"),
          type: type,
          setDate: (e) {
            widget.setDate(e);
          },
          key: timekey,
        ),
        course(
          dataSourceFactory()
              .getBasketDataSource("/common/basket/getScoreCourseList"),
          type: type,
          setDate: (e) {
            widget.setDate(e);
          },
          key: coursekey,
        ),
        finished(
          dataSourceFactory()
              .getBasketDataSource("/common/basket/getScoreCourseList"),
          type: type,
          setDate: (e) {
            widget.setDate(e);
          },
          key: finishkey,
        ),
        flowMatch(
          dataSourceFactory()
              .getBasketDataSource("/common/basket/getScoreFlowList"),
          setDate: (e) {
            widget.setDate(e);
          },
          key: flowkey,
        ),
      ]),
    );
  }
}
