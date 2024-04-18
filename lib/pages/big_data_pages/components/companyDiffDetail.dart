import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/big_data_pages/components/DataContrast.dart';
import 'package:jingcai_app/pages/big_data_pages/components/allIndex.dart';
import 'package:jingcai_app/pages/big_data_pages/components/allIndexBack.dart';
import 'package:jingcai_app/pages/big_data_pages/components/allScores.dart';
import 'package:jingcai_app/pages/big_data_pages/components/avgResult.dart';
import 'package:jingcai_app/pages/big_data_pages/components/boSongPredict.dart';
import 'package:jingcai_app/pages/big_data_pages/components/changeIndexData.dart';
import 'package:jingcai_app/pages/big_data_pages/components/defenseContrast.dart';
import 'package:jingcai_app/pages/big_data_pages/components/gameCard.dart';
import 'package:jingcai_app/pages/big_data_pages/components/sameIndexGame.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class companyDiffDetail extends StatefulWidget {
  int id;
  companyDiffDetail({required this.id});
  JcFootModel foot = JcFootModel.fromJson({
    "leagues": Map<String, dynamic>.from({}),
    "home_team": Map<String, dynamic>.from({}),
    "away_team": Map<String, dynamic>.from({})
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return indexChangeDetail_();
  }
}

class indexChangeDetail_ extends State<companyDiffDetail> {
  JcFootModel foot = JcFootModel.fromJson({
    "leagues": Map<String, dynamic>.from({}),
    "home_team": Map<String, dynamic>.from({}),
    "away_team": Map<String, dynamic>.from({})
  });

  Map cur = {};
  Map cur_diff = {};
  Map init_diff = {};
  @override
  void initState() {
    super.initState();
    print(widget.id);
    getData();
  }

  getData() {
    G.api.game.getCompanyResultChange({"id": widget.id}).then((value) {
      setState(() {
        cur = value["curpl"];
        foot = JcFootModel.fromJson(value["foot"]);
        cur_diff = cur.values.first;
        init_diff = cur.values.last;
      });
    });
  }

  Color getColor(int id) {
    Color c = Colors.black;
    if (id == 1) {
      c = Colors.red;
    }
    if (id == 2) {
      c = Colors.green;
    }
    return c;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xff36394c),
        title: TextWidget(
          "机构分歧详情",
          fontSize: rpx(16),
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/images/gameBigData.png",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                height: rpx(120),
              ),
              Positioned(
                top: rpx(10),
                left: 0,
                right: 0,
                child: gameCard(foot: foot),
              ),
              Positioned(
                  child: Container(
                child: cur_diff.isNotEmpty
                    ? Column(
                        children: [
                          Container(
                            height: rpx(160),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: rpx(10)),
                            padding: EdgeInsets.symmetric(
                                horizontal: rpx(10), vertical: rpx(15)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5), // 阴影的颜色
                                  offset: Offset(5, 5), // 阴影与容器的距离
                                  blurRadius: 12.0, // 高斯的标准偏差与盒子的形状卷积。
                                  spreadRadius: 0.0, // 在应用模糊之前，框应该膨胀的量。
                                ),
                              ],
                              borderRadius: BorderRadius.circular(rpx(8)),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextWidget("初指"),
                                    TextWidget("即指"),
                                  ],
                                ),
                                Container(
                                  height: rpx(10),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: rpx(160),
                                      child: Wrap(
                                        runSpacing: rpx(5),
                                        children: [
                                          Container(
                                            width: rpx(54),
                                            child: Column(
                                              children: [
                                                TextWidget("主胜"),
                                                TextWidget(
                                                    init_diff["win"].toString())
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: rpx(54),
                                            child: Column(
                                              children: [
                                                TextWidget("平"),
                                                TextWidget(init_diff["draw"]
                                                    .toString())
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: rpx(54),
                                            child: Column(
                                              children: [
                                                TextWidget("客胜"),
                                                TextWidget(init_diff["loss"]
                                                    .toString())
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: rpx(160),
                                      child: Wrap(
                                        runSpacing: rpx(5),
                                        children: [
                                          Container(
                                            width: rpx(54),
                                            child: Column(
                                              children: [
                                                TextWidget("主胜"),
                                                TextWidget(
                                                  cur_diff["win"].toString(),
                                                  color: getColor(
                                                      cur_diff["win_direct"]),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: rpx(54),
                                            child: Column(
                                              children: [
                                                TextWidget("平"),
                                                TextWidget(
                                                  cur_diff["draw"].toString(),
                                                  color: getColor(
                                                      cur_diff["draw_direct"]),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: rpx(54),
                                            child: Column(
                                              children: [
                                                TextWidget("客胜"),
                                                TextWidget(
                                                  cur_diff["loss"].toString(),
                                                  color: getColor(
                                                      cur_diff["loss_direct"]),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: rpx(10),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextWidget("机构分歧"),
                                    TextWidget("机构分歧"),
                                  ],
                                ),
                                Container(
                                  height: rpx(10),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: rpx(160),
                                      child: Wrap(
                                        runSpacing: rpx(5),
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: rpx(54),
                                            child: TextWidget(
                                                init_diff["win_diff"]
                                                    .toStringAsFixed(2)),
                                          ),
                                          Container(
                                            width: rpx(54),
                                            child: TextWidget(
                                                init_diff["draw_diff"]
                                                    .toStringAsFixed(2)),
                                          ),
                                          Container(
                                            width: rpx(54),
                                            child: TextWidget(
                                                init_diff["loss_diff"]
                                                    .toStringAsFixed(2)),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: rpx(160),
                                      child: Wrap(
                                        runSpacing: rpx(5),
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: rpx(54),
                                            child: TextWidget(
                                                cur_diff["win_diff"]
                                                    .toStringAsFixed(2)),
                                          ),
                                          Container(
                                            width: rpx(54),
                                            child: TextWidget(
                                                cur_diff["draw_diff"]
                                                    .toStringAsFixed(2)),
                                          ),
                                          Container(
                                            width: rpx(54),
                                            child: TextWidget(
                                                cur_diff["loss_diff"]
                                                    .toStringAsFixed(2)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: rpx(15),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextWidget("方差"),
                                    TextWidget("方差"),
                                  ],
                                ),
                                Container(
                                  height: rpx(10),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: rpx(160),
                                      child: Wrap(
                                        runSpacing: rpx(5),
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: rpx(54),
                                            child: TextWidget(
                                                init_diff["win_fangcha"]
                                                    .toStringAsFixed(2)),
                                          ),
                                          Container(
                                            width: rpx(54),
                                            child: TextWidget(
                                                init_diff["draw_fangcha"]
                                                    .toStringAsFixed(2)),
                                          ),
                                          Container(
                                            width: rpx(54),
                                            child: TextWidget(
                                                init_diff["loss_fangcha"]
                                                    .toStringAsFixed(2)),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: rpx(160),
                                      child: Wrap(
                                        runSpacing: rpx(5),
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: rpx(54),
                                            child: TextWidget(
                                                cur_diff["win_fangcha"]
                                                    .toStringAsFixed(2)),
                                          ),
                                          Container(
                                            width: rpx(54),
                                            child: TextWidget(
                                                cur_diff["draw_fangcha"]
                                                    .toStringAsFixed(2)),
                                          ),
                                          Container(
                                            width: rpx(54),
                                            child: TextWidget(
                                                cur_diff["loss_fangcha"]
                                                    .toStringAsFixed(2)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: rpx(15),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextWidget(
                                        "返还率${(init_diff["back_rate"] * 100).toStringAsFixed(2)}%"),
                                    TextWidget(
                                        "${"返还率" + (cur_diff["back_rate"] * 100).toStringAsFixed(2)}%")
                                  ],
                                ),
                                Container(
                                  height: rpx(10),
                                ),
                                Container(
                                  width: rpx(290),
                                  height: rpx(30),
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: rpx(5)),
                                  color: Color(
                                      0xfff5f5f5), //${a["cur_index_diff"]["jigou_count"]}
                                  child: Row(
                                    children: [
                                      TextWidget(
                                        "查询到",
                                        fontSize: rpx(11),
                                      ),
                                      TextWidget(
                                        '${cur_diff["jigou_count"]}',
                                        fontSize: rpx(11),
                                        color: Colors.red,
                                      ),
                                      TextWidget(
                                        "条机构数据;已完成分歧数据运算",
                                        fontSize: rpx(11),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: rpx(25),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: rpx(15)),
                            height: rpx(40),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        width: rpx(0.5), color: Colors.grey),
                                    bottom: BorderSide(
                                        width: rpx(0.5), color: Colors.grey))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(flex: 4, child: TextWidget("胜/平/负")),
                                Expanded(flex: 4, child: TextWidget("机构分歧/方差")),
                                Expanded(flex: 2, child: TextWidget("返还率")),
                                Expanded(flex: 3, child: TextWidget("更新时间")),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: rpx(15),
                          ),
                          cur.isNotEmpty
                              ? Column(
                                  children: getList(),
                                )
                              : Container()
                        ],
                      )
                    : Container(),
              ))
            ],
          )
        ],
      ),
    );
  }

  List<Column> getList() {
    List<Column> c = [];

    var sortedMap = Map.fromEntries(cur.entries.toList());

    c = sortedMap.entries
        .map((e) => Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: rpx(15)),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidget(e.value["win"]),
                              SizedBox(
                                width: rpx(5),
                              ),
                              TextWidget(e.value["draw"]),
                              SizedBox(
                                width: rpx(5),
                              ),
                              TextWidget(e.value["loss"]),
                            ],
                          )),
                      Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextWidget(
                                      e.value["win_diff"].toStringAsFixed(2)),
                                  SizedBox(
                                    width: rpx(5),
                                  ),
                                  TextWidget(
                                      e.value["draw_diff"].toStringAsFixed(2)),
                                  SizedBox(
                                    width: rpx(5),
                                  ),
                                  TextWidget(
                                      e.value["loss_diff"].toStringAsFixed(2)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextWidget(e.value["win_fangcha"]
                                      .toStringAsFixed(2)),
                                  SizedBox(
                                    width: rpx(5),
                                  ),
                                  TextWidget(e.value["draw_fangcha"]
                                      .toStringAsFixed(2)),
                                  SizedBox(
                                    width: rpx(5),
                                  ),
                                  TextWidget(e.value["loss_fangcha"]
                                      .toStringAsFixed(2)),
                                ],
                              )
                            ],
                          )),
                      Expanded(
                          flex: 2,
                          child: TextWidget(
                              (e.value["back_rate"] * 100).toStringAsFixed(2) +
                                  "%")),
                      Expanded(flex: 3, child: TextWidget(getIndexName(e.key))),
                    ],
                  ),
                ),
                SizedBox(
                  height: rpx(15),
                )
              ],
            ))
        .toList();

    return c;
  }

  getIndexName(String name) {
    String c = "";
    c = "赛前$name小时";
    if (name == "0") {
      c = "即指";
    }
    if (name == "初指") {
      c = "初指";
    }

    return c;
  }
}
