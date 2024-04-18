import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:jingcai_app/model/jcFootModel.dart';

import 'package:jingcai_app/pages/score_pages/dataSource.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';

import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class timely extends StatefulWidget {
  dataSource dataSource_;
  Function setDate;
  timely(this.dataSource_, {required this.setDate, super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return timeling();
  }
}

class timeling extends State<timely> {
  // FootModel datra;
  List<JcFootModel> list1_living = [];
  List<JcFootModel> list1_Noliving = [];
  List leagus_id = [];
  int page = 1;
  int offset = 0;
  int type = 0;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();

    loadArticle();
  }

  Future loadArticle() async {
    Map<String, dynamic> p = {"page": page, "offset": offset, "type": type};
    if (leagus_id.isNotEmpty) {
      p["league_id[]"] = leagus_id;
    }

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

    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: const ClassicHeader(
          completeText: "刷新成功", refreshingText: "刷新中", idleText: "下拉刷新"),
      controller: refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      footer: classFooter(),
      child: ListView(
        children: [
          Column(
            children: List.generate(list1_living.length,
                (index) => widget.dataSource_.gamemodel_(list1_living[index])),
          ),
        ],
      ),
    );
  }

  void _onRefresh() async {
    setState(() {
      page = 1;
      list1_Noliving = [];
      list1_living = [];
      offset = 0;
      type = 0;
      leagus_id = [];
    });
    loadArticle();
    refreshController.loadComplete();
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
