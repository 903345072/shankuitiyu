import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'package:jingcai_app/components/scores/footGame.dart';

import 'package:jingcai_app/model/footModel.dart';
import 'package:dio/dio.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/score_pages/dataSource.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class course extends StatefulWidget {
  dataSource dataSource_;
  Function setDate;
  course(this.dataSource_, {required this.setDate, super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return courseing();
  }
}

class courseing extends State<course> with SingleTickerProviderStateMixin {
  // FootModel datra;
  List<JcFootModel> list = [];
  List pickerData_ = [];
  List weekList = [];
  Map y_ar = {};
  Map m_ar = {};
  List d_ar = [];
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  late TabController _tabC;
  int cur_index = 0;
  int page = 1;
  int type = 0;
  List leagus_id = [];
  @override
  void initState() {
    super.initState();

    var dd_ = DateTime.now();
    var weekday = [" ", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"];
    for (var i = 0; i <= 7; i++) {
      DateTime dg = dd_.add(Duration(days: i));
      weekList.add({
        "date": formatDate(dg, [m, '-', dd]),
        "week": weekday[dg.weekday],
        "stamp": formatDate(dg, [yyyy, '-', mm, '-', dd]),
      });
      var y_ = formatDate(dg, [yyyy]);
      var m_ = formatDate(dg, [mm]);
      var d_ = formatDate(dg, [dd]);
      if (!y_ar.containsKey("y_")) {
        y_ar[y_] = [];
      }
      if (!m_ar.containsKey(y_ + "-" + m_)) {
        m_ar[y_ + "-" + m_] = [];
      }
      if (!d_ar.contains(y_ + "-" + m_ + "-" + d_)) {
        d_ar.add(y_ + "-" + m_ + "-" + d_);
      }
    }
    List.generate(d_ar.length, (index) {
      String gg = d_ar[index];
      List g = gg.split("-");
      var g0 = g[0];
      var g1 = g[1];
      var g2 = g[2];
      (m_ar[g0 + "-" + g1] as List).add(g2);
    });

    // ignore: unused_local_variable
    for (var key in m_ar.keys) {
      List g = key.toString().split("-");
      var g0 = g[0];
      var g1 = g[1];
      (y_ar[g0] as List).add({g1: m_ar[key]});
      // print(m_ar[key]);
    }

    for (var key in y_ar.keys) {
      pickerData_.add({key: y_ar[key]});
      // print(m_ar[key]);
    }
    // print(pickerData_);

    _tabC = TabController(
      length: weekList.length,
      initialIndex: 0,
      vsync: this,
    );
    loadArticle();
  }

  clearData(Map data) {
    setState(() {
      list = [];
      page = 1;
      type = data["index"];
      leagus_id = data["id"] ?? [];
    });
    refreshController.loadComplete();
  }

  Future loadArticle() async {
    Map<String, dynamic> p = {
      "page": page,
      "date": weekList[cur_index]["stamp"],
      "state": 1,
      "type": type
    };
    if (leagus_id.isNotEmpty) {
      p["league_id[]"] = leagus_id;
    }
    return G.api.gameAdd.getScoreList(p, widget.dataSource_.url).then((value) {
      setState(() {
        list.addAll(value["act"]!);
      });
      return value["act"];
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Column(
      children: [
        Row(
          children: [
            Expanded(
                flex: 9,
                child: TabBar(
                  onTap: (e) {
                    setState(() {
                      cur_index = e;
                      widget.setDate(weekList[cur_index]["stamp"]);
                      list = [];
                      page = 1;
                    });
                    loadArticle();
                  },
                  tabAlignment: TabAlignment.center,
                  dividerColor: Colors.transparent,
                  padding: EdgeInsets.all(rpx(10)),

                  labelPadding: EdgeInsets.all(0),

                  labelColor: Colors.red,
                  unselectedLabelColor: Color(0xff9f9f9f),
                  indicatorColor: Colors.transparent,
                  indicatorPadding:
                      EdgeInsets.only(left: rpx(20), right: rpx(20)),

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
                      weekList.length,
                      (index) => Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            color: cur_index == index
                                ? Color.fromRGBO(239, 47, 47, .06)
                                : Colors.transparent,
                            alignment: Alignment.center,
                            width: rpx(63.75),
                            child: Column(
                              children: [
                                Text(
                                  weekList[index]["date"],
                                ),
                                Text(weekList[index]["week"]),
                              ],
                            ),
                          )),
                )),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () async {
                    const PickerData = "";

                    Picker picker = Picker(
                        cancelText: "取消",
                        confirmText: "确认",
                        adapter:
                            PickerDataAdapter<String>(pickerData: pickerData_),
                        changeToFirst: true,
                        textAlign: TextAlign.left,
                        columnPadding: const EdgeInsets.all(8.0),
                        onConfirm: (Picker picker, List value) {
                          List.generate(weekList.length, (index) {
                            if (weekList[index]["stamp"] ==
                                picker.getSelectedValues().join("-")) {
                              cur_index = index;
                              _tabC.index = index;
                              page = 1;
                              list = [];
                              loadArticle();
                              widget.setDate(weekList[index]["stamp"]);
                            }
                          });
                        });
                    picker.showBottomSheet(context);
                  },
                  child: Icon(Icons.calendar_month),
                )) //
          ],
        ),
        Container(
          width: double.infinity,
          height: rpx(2),
          color: Color.fromARGB(255, 238, 238, 238),
        ),
        Expanded(
            child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: const ClassicHeader(
              completeText: "刷新成功", refreshingText: "刷新中", idleText: "下拉刷新"),
          controller: refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          footer: classFooter(),
          child: ListView(
            children: List.generate(list.length,
                (index) => widget.dataSource_.gamemodel_(list[index])),
          ),
        ))
      ],
    );
  }

  void _onRefresh() async {
    setState(() {
      page = 1;
      list = [];

      leagus_id = [];
    });
    loadArticle();
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    setState(() {
      page++;
    });
    loadArticle().then((value) {
      if (value.isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    });
  }
}
