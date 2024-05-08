import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/model/bigDataModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class dataModel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dataModel_();
  }
}

class dataModel_ extends State<dataModel> {
  List list = [];

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    G.api.gameAdd.getModelList({}).then((value) {
      setState(() {
        list = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: classHeader(),
          controller: refreshController,
          onRefresh: _onRefresh,
          footer: classFooter(),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(rpx(10)),
                child: Image.asset(
                  "assets/images/data_model_banner.png",
                  fit: BoxFit.cover,
                ),
              ),
              Wrap(
                children: List.generate(
                    list.length,
                    (index) => onClick(
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(rpx(10))),
                              padding: EdgeInsets.all(rpx(10)),
                              margin: EdgeInsets.all(rpx(5)),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: rpx(15)),
                                    child: netImg(
                                        list[index]["logo"].toString(),
                                        rpx(120),
                                        rpx(120)),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                            list[index]["title"].toString()),
                                      ),
                                      Container(
                                        width: rpx(200),
                                        margin: EdgeInsets.only(
                                            top: rpx(5), bottom: rpx(5)),
                                        child: Text(
                                            list[index]["desc"].toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style:
                                                TextStyle(fontSize: rpx(12))),
                                      ),
                                      Container(
                                        child: Text(
                                            list[index]["buy_count"]
                                                    .toString() +
                                                "人购买",
                                            style:
                                                TextStyle(fontSize: rpx(12))),
                                      ),
                                      Container(
                                        width: rpx(200),
                                        margin: EdgeInsets.only(top: rpx(10)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Wrap(
                                              spacing: rpx(3),
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                Text(
                                                  (double.parse(
                                                          list[index]["price"]))
                                                      .toInt()
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: rpx(19),
                                                      color: Colors.red),
                                                ),
                                                Text("金豆/月",
                                                    style: TextStyle(
                                                        fontSize: rpx(12),
                                                        color: Colors.red))
                                              ],
                                            ),
                                            GestureDetector(
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: rpx(28),
                                                width: rpx(80),
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            rpx(14))),
                                                child: Text("立即查看",
                                                    style: TextStyle(
                                                        fontSize: rpx(15),
                                                        color: Colors.white)),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ), () {
                          if (index == 0) {
                            G.router.navigateTo(
                                context,
                                "/dataReport" +
                                    G.parseQuery(params: {
                                      "price": list[index]["price"],
                                      "buy_count": list[index]["buy_count"],
                                    }));
                          }
                          if (index == 1) {
                            G.router.navigateTo(
                                context,
                                "/indexChange" +
                                    G.parseQuery(params: {
                                      "price": list[index]["price"],
                                      "buy_count": list[index]["buy_count"],
                                    }));
                          }
                          if (index == 2) {
                            G.router.navigateTo(
                                context,
                                "/bsfb" +
                                    G.parseQuery(params: {
                                      "price": list[index]["price"],
                                      "buy_count": list[index]["buy_count"],
                                    }));
                          }
                          if (index == 3) {
                            G.router.navigateTo(
                                context,
                                "/indexDiff" +
                                    G.parseQuery(params: {
                                      "price": list[index]["price"],
                                      "buy_count": list[index]["buy_count"],
                                    }));
                          }
                          if (index == 4) {
                            G.router.navigateTo(
                                context,
                                "/companyDiff" +
                                    G.parseQuery(params: {
                                      "price": list[index]["price"],
                                      "buy_count": list[index]["buy_count"],
                                    }));
                          }
                        })),
              )
            ],
          )),
    );
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }
}
