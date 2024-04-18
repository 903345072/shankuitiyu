import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:jingcai_app/components/homes/planPreviewTest.dart';
import 'package:jingcai_app/model/recommendModel.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class expertPlan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _recommend();
  }
}

class _recommend extends State<expertPlan> {
  List<recommendModel> data = [];
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    getReCommendData();
  }

  Future getReCommendData() async {
    //通过rootBundle.loadString();解析并返回
    String jsonData = await rootBundle.loadString("assets/mock/recommend.json");
    final List jsonresult = json.decode(jsonData)["data"];
    setState(() {
      data = jsonresult
          .map((e) => recommendModel.fromJson((e as Map<String, dynamic>)))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: classHeader(),
      controller: refreshController,
      onRefresh: _onRefresh,
      onLoading: _onload,
      footer: classFooter(),
      child: ListView(
        padding: EdgeInsets.all(0),
        children: List.generate(
            data.length,
            (index) => planPreviewTest(
                  recmodel: data[index],
                  is_head: true,
                )),
      ),
    );
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void _onload() async {
    await Future.delayed(Duration(milliseconds: 3000));
    // if failed,use refreshFailed()
    refreshController.loadNoData();
  }
}
