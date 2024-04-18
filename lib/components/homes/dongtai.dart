import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jingcai_app/components/homes/dryBase.dart';

import 'package:jingcai_app/model/draymodel.dart';
import 'package:jingcai_app/util/commonComponents.dart';

import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class dongtai extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _dryNews();
  }
}

class _dryNews extends State<dongtai> {
  List<drayModel> data = [];
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    getDrayData();
  }

  Future getDrayData() async {
    //通过rootBundle.loadString();解析并返回
    String jsonData = await rootBundle.loadString("assets/mock/drys.json");
    final List jsonresult = json.decode(jsonData)["data"];
    setState(() {
      data = jsonresult
          .map((e) => drayModel.fromJson((e as Map<String, dynamic>)))
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
        onRefresh: _onRefresh_,
        onLoading: _onload_,
        footer: classFooter(),
        child: ListView(
          padding: EdgeInsets.all(0),
          children:
              List.generate(data.length, (index) => dryBase(data: data[index])),
        ));
  }

  _onload_() async {
    await Future.delayed(Duration(milliseconds: 3000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    refreshController.loadNoData();
  }

  _onRefresh_() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }
}
