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

class ModelindexDiffDetail extends StatefulWidget {
  int? id;
  ModelindexDiffDetail({required this.id});
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

class indexChangeDetail_ extends State<ModelindexDiffDetail> {
  JcFootModel foot = JcFootModel.fromJson({
    "leagues": Map<String, dynamic>.from({}),
    "home_team": Map<String, dynamic>.from({}),
    "away_team": Map<String, dynamic>.from({})
  });

  Map cur = {};
  Map init = {};
  Map cur_diff = {};
  Map init_diff = {};
  @override
  void initState() {
    super.initState();
    print(widget.id);
    getData();
  }

  getData() {
    G.api.game.getResultChange({"id": widget.id}).then((value) {
      setState(() {
        if (value["curpl"] != null) {
          cur = value["curpl"];
          init = value["initpl"];
          cur_diff = value["curdiff"];
          init_diff = value["initdiff"];
          foot = JcFootModel.fromJson(value["foot"]);
        }
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
    return cur.isNotEmpty
        ? Scaffold(
            backgroundColor: Color(0xfff5f5f5),
            body: ListView(
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
                            child: init_diff.isNotEmpty
                                ? Column(
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
                                                      TextWidget(init_diff["pl"]
                                                              ["win"]
                                                          .toString())
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: rpx(54),
                                                  child: Column(
                                                    children: [
                                                      TextWidget("平"),
                                                      TextWidget(init_diff["pl"]
                                                              ["draw"]
                                                          .toString())
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: rpx(54),
                                                  child: Column(
                                                    children: [
                                                      TextWidget("客胜"),
                                                      TextWidget(init_diff["pl"]
                                                              ["loss"]
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
                                                        cur_diff["pl"]["win"]
                                                            .toString(),
                                                        color: getColor(
                                                            cur_diff["pl"]
                                                                ["win_direct"]),
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
                                                        cur_diff["pl"]["draw"]
                                                            .toString(),
                                                        color: getColor(
                                                            cur_diff["pl"][
                                                                "draw_direct"]),
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
                                                        cur_diff["pl"]["loss"]
                                                            .toString(),
                                                        color: getColor(
                                                            cur_diff["pl"][
                                                                "loss_direct"]),
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
                                          TextWidget("分歧值"),
                                          TextWidget("分歧值"),
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
                                                          .toString()),
                                                ),
                                                Container(
                                                  width: rpx(54),
                                                  child: TextWidget(
                                                      init_diff["draw_diff"]
                                                          .toString()),
                                                ),
                                                Container(
                                                  width: rpx(54),
                                                  child: TextWidget(
                                                      init_diff["loss_diff"]
                                                          .toString()),
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
                                                          .toString()),
                                                ),
                                                Container(
                                                  width: rpx(54),
                                                  child: TextWidget(
                                                      cur_diff["draw_diff"]
                                                          .toString()),
                                                ),
                                                Container(
                                                  width: rpx(54),
                                                  child: TextWidget(
                                                      cur_diff["loss_diff"]
                                                          .toString()),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: rpx(15),
                                      ),
                                      Container(
                                        width: rpx(290),
                                        height: rpx(30),
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: rpx(5)),
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
                                      SizedBox(
                                        height: rpx(15),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          TextWidget(
                                            '主胜${(cur_diff["win_rate"] * 100).toStringAsFixed(0)}%',
                                            color: Colors.red,
                                            fontSize: rpx(15),
                                          ),
                                          TextWidget(
                                            '平${(100 - (cur_diff["loss_rate"] * 100) - (cur_diff["win_rate"] * 100)).toStringAsFixed(0)}%',
                                            color: Colors.red,
                                            fontSize: rpx(15),
                                          ),
                                          TextWidget(
                                            '客胜${(cur_diff["loss_rate"] * 100).toStringAsFixed(0)}%',
                                            color: Colors.red,
                                            fontSize: rpx(15),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                : Container(),
                          ),
                          SizedBox(
                            height: rpx(25),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Wrap(
                                spacing: rpx(10),
                                children: [
                                  Row(
                                    children: [
                                      TextWidget("主胜"),
                                      Container(
                                        width: rpx(15),
                                        height: rpx(15),
                                        color: Colors.red,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      TextWidget("平"),
                                      Container(
                                        width: rpx(15),
                                        height: rpx(15),
                                        color: Color(0xff30b27a),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      TextWidget("客胜"),
                                      Container(
                                        width: rpx(15),
                                        height: rpx(15),
                                        color: Color(0xff002868),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                width: rpx(15),
                              )
                            ],
                          ),
                          SizedBox(
                            height: rpx(15),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: rpx(15)),
                            height: rpx(200),
                            child: avgResult(rqPlList: [], cur: cur),
                          ),
                          SizedBox(
                            height: rpx(15),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: rpx(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextWidget(
                                  "(赛前48小时)",
                                  color: Colors.grey,
                                ),
                                TextWidget(
                                  "(赛前24小时)",
                                  color: Colors.grey,
                                ),
                                TextWidget(
                                  "比赛开始",
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: rpx(15),
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
                              children: [
                                Expanded(flex: 1, child: TextWidget("主胜")),
                                Expanded(flex: 1, child: TextWidget("平")),
                                Expanded(flex: 1, child: TextWidget("客胜")),
                                Expanded(flex: 2, child: TextWidget("更新时间")),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: rpx(15),
                          ),
                          init.isNotEmpty
                              ? Column(
                                  children: getList(),
                                )
                              : Container()
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
          );
  }

  List<Column> getList() {
    List<Column> c = [];
    var sortedMap = Map.fromEntries(cur.entries.toList()
      ..sort(
        (e1, e2) => (double.parse(e1.key)).compareTo((double.parse(e2.key))),
      ));
    c = sortedMap.entries
        .map((e) => Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: rpx(15)),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: TextWidget(
                              (e.value["win_rate"] * 100).toStringAsFixed(0) +
                                  "%")),
                      Expanded(
                          flex: 1,
                          child: TextWidget(
                              (e.value["draw_rate"] * 100).toStringAsFixed(0) +
                                  "%")),
                      Expanded(
                          flex: 1,
                          child: TextWidget(
                              (e.value["loss_rate"] * 100).toStringAsFixed(0) +
                                  "%")),
                      Expanded(flex: 2, child: TextWidget("赛前" + e.key + "小时")),
                    ],
                  ),
                ),
                SizedBox(
                  height: rpx(15),
                )
              ],
            ))
        .toList();
    c.add(Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: rpx(15)),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: TextWidget(
                      (init["win_rate"] * 100).toStringAsFixed(0) + "%")),
              Expanded(
                  flex: 1,
                  child: TextWidget(
                      (init["draw_rate"] * 100).toStringAsFixed(0) + "%")),
              Expanded(
                  flex: 1,
                  child: TextWidget(
                      (init["loss_rate"] * 100).toStringAsFixed(0) + "%")),
              Expanded(flex: 2, child: TextWidget("初指")),
            ],
          ),
        ),
        SizedBox(
          height: rpx(25),
        )
      ],
    ));
    return c;
  }
}
