import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'package:dio/dio.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/pages/score_pages/dataSource.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class flowMatch extends StatefulWidget {
  dataSource dataSource_;
  Function setDate;
  flowMatch(this.dataSource_, {required this.setDate, super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return flowMatchs();
  }
}

class flowMatchs extends State<flowMatch> with AutomaticKeepAliveClientMixin {
  // FootModel datra;
  List<JcFootModel> list1_living = [];
  List<JcFootModel> list1_Noliving = [];
  List leagus_id = [];
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  late TabController _tabC;

  Color label_color = Colors.red;
  int page = 1;
  int offset = 0;
  int type = 0;
  @override
  void initState() {
    super.initState();

    loadArticle();
  }

  Future loadArticle() async {
    Map<String, dynamic> p = {"page": page, "offset": offset, "type": type};
    // if (leagus_id.isNotEmpty) {
    //   p["league_id[]"] = leagus_id;
    // }

    return G.api.gameAdd.getScoreList(p, widget.dataSource_.url).then((value) {
      setState(() {
        list1_living.addAll(value["act"]!);
        offset = value["offset"];
      });
      return value["act"];
    });
  }

  clearData(Map data) {
    setState(() {
      list1_living = [];
      list1_Noliving = [];
      page = 1;
      offset = 0;
      type = data["index"];

      leagus_id = data["id"] ?? [];
    });
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Column(
      children: [
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
          child: list1_Noliving.isNotEmpty || list1_living.isNotEmpty
              ? ListView(
                  children: [
                    Column(
                      children: List.generate(
                          list1_living.length,
                          (index) => widget.dataSource_
                              .gamemodel_(list1_living[index])),
                    ),
                    Column(
                      children: List.generate(
                          list1_Noliving.length,
                          (index) => widget.dataSource_
                              .gamemodel_(list1_Noliving[index])),
                    ),
                  ],
                )
              : Container(
                  alignment: Alignment.center,
                  child: TextWidget(
                    "暂无数据",
                    color: Colors.grey.shade500,
                  ),
                ),
        ))
      ],
    );
  }

  void _onRefresh() async {
    setState(() {
      page = 1;
      list1_Noliving = [];
      list1_living = [];
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
