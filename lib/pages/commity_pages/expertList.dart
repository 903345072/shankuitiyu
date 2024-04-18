import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/model/expert.dart';
import 'package:jingcai_app/model/talentExpert.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class expertList extends StatefulWidget {
  int is_flow = 0;
  expertList({required this.is_flow});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return expertList_();
  }
}

class expertList_ extends State<expertList> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List data = [];
  int page = 1;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    return G.api.game
        .getAllTalent({"page": page, "is_flow": widget.is_flow}).then((value) {
      setState(() {
        data.addAll(value);
      });
      return value;
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
          children: List.generate(
              data.length,
              (index) => onClick(
                  Container(
                    padding: EdgeInsets.all(rpx(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: rpx(3)),
                              child: CircleAvatar(
                                radius: rpx(20),
                                backgroundImage: NetworkImage(
                                  data[index]["avatar"].toString(),
                                ),
                              ),
                            ),
                            data[index]["plan_num"] > 0
                                ? Positioned(
                                    right: rpx(0),
                                    child: Container(
                                      height: 16,
                                      alignment: Alignment(0, 0),
                                      padding: EdgeInsets.only(
                                          left: rpx(4), right: rpx(4)),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.white),
                                          color: Colors.red,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Text(
                                        data[index]["plan_num"].toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: rpx(10)),
                                      ),
                                    ))
                                : Container(),
                          ],
                        ),
                        Wrap(
                          spacing: rpx(4),
                          direction: Axis.vertical,
                          children: [
                            Text(data[index]["real_name"].toString()),
                            Container(
                              width: rpx(230),
                              child: Text(
                                data[index]["introduce"].toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )
                          ],
                        ),
                        Wrap(
                          direction: Axis.vertical,
                          spacing: 5,
                          children: [
                            Wrap(
                              spacing: 3,
                              children: [
                                Text("粉丝数"),
                                Text(data[index]["fans"].toString())
                              ],
                            ),
                            getFlowButton(data[index]["is_subscribe"], index)
                          ],
                        )
                      ],
                    ),
                  ),
                  () => G.router.navigateTo(
                      context,
                      "/talentDetail" +
                          G.parseQuery(params: {"uid": data[index]["uid"]})))),
        ));
  }

  void _onRefresh() async {
    refreshController.loadComplete();
    setState(() {
      page = 1;
      data = [];
    });
    getData();
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    setState(() {
      page++;
    });
    getData().then((value) {
      if (value.isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    });
  }

  Widget getFlowButton(int i, index) {
    return onClick(
        i == 1
            ? Container(
                alignment: Alignment.center,
                width: rpx(70),
                height: rpx(30),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  "已关注",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(15)),
                alignment: Alignment.center,
                width: rpx(70),
                height: rpx(30),
                child: Text(
                  "+关注",
                  style: TextStyle(color: Colors.white),
                ),
              ), () {
      G.api.user.flowUser({"uid": data[index]["uid"]}).then((value) {
        setState(() {
          data[index]["is_subscribe"] =
              data[index]["is_subscribe"] == 1 ? 0 : 1;
          if (data[index]["is_subscribe"] == 0) {
            data[index]["fans"]--;
          } else {
            data[index]["fans"]++;
          }
        });
      });
    });
  }
}
