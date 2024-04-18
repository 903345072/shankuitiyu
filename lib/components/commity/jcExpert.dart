import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jingcai_app/components/homes/expertPreview.dart';

import 'package:jingcai_app/components/homes/planPreviewTest.dart';
import 'package:jingcai_app/model/expert.dart';
import 'package:jingcai_app/model/recommendModel.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class jcExpert extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return jcExpert_();
  }
}

class jcExpert_ extends State<jcExpert> {
  List<expert> expert_info = [];
  List<recommendModel> expert_list = [];
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    String jsonData = await rootBundle.loadString("assets/mock/expert.json");
    final List jsonresult = json.decode(jsonData)["data"];
    setState(() {
      expert_info = jsonresult
          .map((e) => expert.fromJson((e as Map<String, dynamic>)))
          .toList();
    });

    String recommendData =
        await rootBundle.loadString("assets/mock/recommend.json");
    final List recommenjsonresult = json.decode(recommendData)["data"];
    setState(() {
      expert_list = recommenjsonresult
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
      onLoading: _onLoading,
      footer: classFooter(),
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: rpx(10)),
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              runSpacing: rpx(4),
              children: getChilds(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 13),
            color: Color.fromARGB(255, 219, 219, 219),
            height: rpx(0.5),
          ),
          Column(
            children: List.generate(expert_list.length,
                (index) => planPreviewTest(recmodel: expert_list[index])),
          )
        ],
      ),
    );
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 3000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    refreshController.loadNoData();
  }

  getChilds() {
    List<expert> ll = [];
    if (expert_info.length >= 8) {
      ll = expert_info.sublist(0, 7);
    } else {
      ll = expert_info;
    }

    List<Widget> list = List.generate(
        ll.length, (index) => expertPreview(expertModel: expert_info[index]));
    list.add(Container(
      padding: EdgeInsets.only(top: rpx(10), left: rpx(25)),
      width: MediaQuery.of(context).size.width * 0.25, // 屏幕宽度的50%,
      child: GestureDetector(
        onTap: () {
          var p = {"index": 0, "is_flow": 0};
          G.router.navigateTo(
              context, "/expertTalent" + G.parseQuery(params: p),
              transition: TransitionType.inFromRight);
        },
        child: Wrap(
          spacing: rpx(5),
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Image.asset(
              "assets/images/seeMore.png",
              fit: BoxFit.cover,
              width: rpx(40),
            ),
            Text("更多")
          ],
        ),
      ),
    ));
    return list;
  }
}
