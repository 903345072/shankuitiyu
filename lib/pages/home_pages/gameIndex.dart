import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/pages/home_pages/bdPlList.dart';
import 'package:jingcai_app/pages/home_pages/jcFootPlList.dart';
import 'package:jingcai_app/pages/home_pages/jqzhiList.dart';
import 'package:jingcai_app/pages/home_pages/ouzhiList.dart';
import 'package:jingcai_app/pages/home_pages/yazhiList.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class gameIndex extends StatefulWidget {
  int? id;
  int have_jc = 0;
  int have_bd = 0;
  gameIndex({required this.id, required this.have_bd, required this.have_jc});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return gameIndex_();
  }
}

class gameIndex_ extends State<gameIndex> with TickerProviderStateMixin {
  var tabs = ["竞足", "北单", "欧指", "亚指", "进球数"];
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int _cur_index = 0;

  PageController _pageController = PageController(initialPage: 0);
  late final TabController _tabC;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.have_jc == 0) {
      tabs.removeAt(0);
    }
    if (widget.have_bd == 0) {
      tabs.removeAt(0);
    }
    _tabC = TabController(
      length: tabs.length,
      initialIndex: 0,
      vsync: this,
    );
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: rpx(50),
          color: Color(0xfff0f0f0),
          child: _tabars(),
        ),
        _tarbarview()
      ],
    );
  }

  _tabars() {
    Map select_style = {"color": Colors.white, "backGroundColor": Colors.red};
    Map unselect_style = {
      "color": Colors.black,
      "backGroundColor": Colors.white
    };
    return Container(
      child: Wrap(
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
                        EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 3),
                    child: Text(
                      tabs[index],
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
            jcFootPlList(
              id: widget.id,
            ),
            bdPlList(
              id: widget.id,
            ),
            ouzhiList(
              id: widget.id,
            ),
            yazhiList(
              id: widget.id,
            ),
            jqzhiList(
              id: widget.id,
            ),
          ]),
    );
  }
}
