import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/big_data_pages/components/DataContrast.dart';
import 'package:jingcai_app/pages/big_data_pages/components/allIndex.dart';
import 'package:jingcai_app/pages/big_data_pages/components/allIndexBack.dart';
import 'package:jingcai_app/pages/big_data_pages/components/changeIndexData.dart';
import 'package:jingcai_app/pages/big_data_pages/components/gameCard.dart';
import 'package:jingcai_app/pages/big_data_pages/components/sameIndexGame.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GameIndexChangeDetail extends StatefulWidget {
  int? id;
  GameIndexChangeDetail({required this.id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return indexChangeDetail_();
  }
}

class indexChangeDetail_ extends State<GameIndexChangeDetail> {
  GlobalKey<allIndexBack_> sonWidgetState = GlobalKey<allIndexBack_>();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  JcFootModel foot = JcFootModel.fromJson({
    "leagues": Map<String, dynamic>.from({}),
    "home_team": Map<String, dynamic>.from({}),
    "away_team": Map<String, dynamic>.from({})
  });

  void _onRefresh() async {
    // monitor network fetch

    refreshController.refreshCompleted();
    // if failed,use refreshFailed()
  }

  Map initPl = {};
  Map curPl = {};
  Map first_change = {};
  Map max_change = {};
  int type = 0;
  double change_value = 0;
  int win_count = 0;
  int draw_count = 0;
  int loss_count = 0;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() {
    G.api.game.getIndexChangeDetail({"id": widget.id}).then((value) {
      setState(() {
        if (value["data"] != null) {
          foot = JcFootModel.fromJson(value["foot"]);
          initPl = value["init_index"];
          first_change = value["first_change"];
          max_change = value["max_change"];
          curPl = value["cur_index"];
          type = value["type"];
          change_value = value["value"].toDouble();
          win_count = value["win_count"];
          draw_count = value["draw_count"];
          loss_count = value["loss_count"];
          foot = JcFootModel.fromJson(value["foot"]);
          initPl = value["init_index"];
          first_change = value["first_change"];
          max_change = value["max_change"];
          curPl = value["cur_index"];
          type = value["type"];
          change_value = value["value"].toDouble();
          win_count = value["win_count"];
          draw_count = value["draw_count"];
          loss_count = value["loss_count"];
        }
      });
    });
  }

  void _onLoading() async {
    // monitor network fetch
    // setState(() {
    //   pageNo++;
    // });
    // getData(2).then((value) {
    //   if (value.isEmpty) {
    //     refreshController.loadNoData();
    //   }
    // });
    // sonWidgetState
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    sonWidgetState.currentState?.addPage();
    sonWidgetState.currentState?.getData().then((value) {
      if (value.isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: initPl.isNotEmpty
          ? SmartRefresher(
              controller: refreshController,
              enablePullDown: true,
              enablePullUp: true,
              onLoading: _onLoading,
              onRefresh: _onRefresh,
              header: classHeader(),
              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  Stack(
                    children: [
                      Positioned(
                          child: Container(
                        child: Column(
                          children: [
                            Container(
                              height: rpx(10),
                            ),
                            changeIndexData(
                                initPl: initPl,
                                change_value: change_value,
                                curPl: curPl,
                                first_change: first_change,
                                max_change: max_change,
                                type: type),
                            Container(
                              height: rpx(7),
                              margin: EdgeInsets.symmetric(vertical: rpx(10)),
                              color: const Color.fromARGB(255, 233, 233, 233),
                            ),
                            sameIndexGame(
                                draw_count: draw_count,
                                loss_count: loss_count,
                                win_count: win_count),
                            Container(
                              height: rpx(7),
                              margin: EdgeInsets.symmetric(vertical: rpx(10)),
                              color: const Color.fromARGB(255, 233, 233, 233),
                            ),
                            type > 0
                                ? DataContrast(
                                    id: foot.id,
                                  )
                                : Container(),
                            Container(
                              height: rpx(7),
                              margin: EdgeInsets.symmetric(vertical: rpx(10)),
                              color: const Color.fromARGB(255, 233, 233, 233),
                            ),
                            type > 0
                                ? allIndexBack(
                                    type: type,
                                    id: foot.id,
                                    key: sonWidgetState,
                                  )
                                : Container(),
                          ],
                        ),
                      ))
                    ],
                  )
                ],
              ),
            )
          : Container(
              alignment: Alignment.center,
              child: TextWidget("暂无数据"),
            ),
    );
  }
}
