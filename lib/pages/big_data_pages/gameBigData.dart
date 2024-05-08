import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/big_data_pages/components/gameCard.dart';
import 'package:jingcai_app/pages/big_data_pages/components/gameHistoryTable.dart';
import 'package:jingcai_app/pages/big_data_pages/components/gamePieChart.dart';
import 'package:jingcai_app/pages/big_data_pages/components/historyBattle.dart';
import 'package:jingcai_app/pages/big_data_pages/components/jqAnasy.dart';
import 'package:jingcai_app/pages/big_data_pages/components/jqChart.dart';
import 'package:jingcai_app/pages/big_data_pages/components/jqRqRate.dart';
import 'package:jingcai_app/pages/big_data_pages/components/jqTable.dart';
import 'package:jingcai_app/pages/big_data_pages/components/rqAnasy.dart';
import 'package:jingcai_app/pages/big_data_pages/components/rqChart.dart';
import 'package:jingcai_app/pages/big_data_pages/components/rqTable.dart';
import 'package:jingcai_app/pages/big_data_pages/components/scorePrediction.dart';
import 'package:jingcai_app/pages/big_data_pages/components/spfAnasy.dart';
import 'package:jingcai_app/pages/big_data_pages/components/spfChart.dart';
import 'package:jingcai_app/pages/big_data_pages/components/spfRate.dart';
import 'package:jingcai_app/pages/big_data_pages/components/spfTable.dart';
import 'package:jingcai_app/pages/big_data_pages/components/spfTrendChart.dart';
import 'package:jingcai_app/pages/big_data_pages/components/teamAnasy.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/G.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class gameBigData extends StatefulWidget {
  int? id;
  gameBigData({super.key, required this.id});

  @override
  State<StatefulWidget> createState() {
    return gameBigDatas();
  }
}

// ignore: camel_case_types
class gameBigDatas extends State<gameBigData> {
  List seriesList = [];

  JcFootModel foot = JcFootModel.fromJson({
    "leagues": Map<String, dynamic>.from({}),
    "home_team": Map<String, dynamic>.from({}),
    "away_team": Map<String, dynamic>.from({})
  });
  Map data = {"home_ball": "0", "away_ball": "0"};
  spfPl spf_pl_start = spfPl.fromJson({});
  spfPl spf_pl_cur = spfPl.fromJson({});

  RqPl rq_pl_start = RqPl.fromJson({});
  RqPl rq_pl_cur = RqPl.fromJson({});

  jqPl jq_pl_start = jqPl.fromJson({});
  jqPl jq_pl_cur = jqPl.fromJson({});
  double win_kaili = 0;
  double draw_kaili = 0;
  double loss_kaili = 0;
  @override
  void initState() {
    super.initState();

    G.api.game.getMatchAnalyse({"id": widget.id}).then((value) {
      setState(() {
        foot = JcFootModel.fromJson(value["footData"]);
        data = value;

        if (value["spf_pl_start"] != null && value["spf_pl_start"] != "") {
          spf_pl_start = spfPl.fromJson(value["spf_pl_start"]);
        }

        if (value["spf_pl_cur"] != null && value["spf_pl_cur"] != "") {
          spf_pl_cur = spfPl.fromJson(value["spf_pl_cur"]);
        }

        if (value["rq_pl_start"] != null && value["rq_pl_start"] != "") {
          rq_pl_start = RqPl.fromJson(value["rq_pl_start"]);
        }

        if (value["rq_pl_cur"] != null && value["rq_pl_cur"] != "") {
          rq_pl_cur = RqPl.fromJson(value["rq_pl_cur"]);
        }

        if (value["jq_pl_start"] != null && value["jq_pl_start"] != "") {
          jq_pl_start = jqPl.fromJson(value["jq_pl_start"]);
        }

        if (value["jq_pl_cur"] != null && value["jq_pl_cur"] != "") {
          jq_pl_cur = jqPl.fromJson(value["jq_pl_cur"]);
        }
        win_kaili = value["win_kaili"].toDouble();

        draw_kaili = value["draw_kaili"].toDouble();
        loss_kaili = value["loss_kaili"].toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xff36394c),
        title: TextWidget(
          "福神大数据",
          fontSize: rpx(16),
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: ListView(
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
                  child: Column(
                children: [
                  Container(
                    height: rpx(160),
                  ),
                  scorePrediction(
                      foot: foot,
                      home_ball: data["home_ball"].toString(),
                      away_ball: data["away_ball"].toString()),
                  spfRate(
                      win_rate: data["win_rate"].toString(),
                      draw_rate: data["draw_rate"].toString(),
                      loss_rate: data["lose_rate"].toString()),
                  data["dq_rate"] != null
                      ? jqRqRate(
                          rq_num: data["rq_num"].toString(),
                          dxq_num: data["dxq_num"].toString(),
                          dq_rate: data["dq_rate"],
                          xq_rate: data["xq_rate"],
                          rq_lose_rate: data["rq_lose_rate"],
                          rq_win_rate: data["rq_win_rate"],
                        )
                      : Container(),
                  Container(
                    height: rpx(4),
                    color: Color.fromARGB(255, 238, 238, 238),
                  ),
                  SizedBox(
                    height: rpx(10),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: rpx(15)),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: rpx(10),
                      children: [
                        Container(
                          color: Colors.red,
                          width: rpx(3),
                          height: rpx(16),
                        ),
                        TextWidget(
                          "指数分析",
                          fontSize: rpx(17),
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
                  foot.spfPls!.isNotEmpty
                      ? spfAnasy(
                          spfPlList: foot.spfPls,
                          spf_pl_start: spf_pl_start,
                          spf_pl_cur: spf_pl_cur,
                          win_kaili: win_kaili,
                          draw_kaili: draw_kaili,
                          loss_kaili: loss_kaili,
                        )
                      : Container(),
                  SizedBox(
                    height: rpx(10),
                  ),
                  foot.spfPls!.isNotEmpty
                      ? rqAnasy(
                          rqPlList: foot.rqPl,
                          rq_pl_start: rq_pl_start,
                          rq_pl_cur: rq_pl_cur,
                        )
                      : Container(),
                  SizedBox(
                    height: rpx(10),
                  ),
                  foot.spfPls!.isNotEmpty
                      ? jqAnasy(
                          jqPlList: foot.dxqPl,
                          jq_pl_start: jq_pl_start,
                          jq_pl_cur: jq_pl_cur,
                        )
                      : Container(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: rpx(15)),
                    height: rpx(4),
                    color: Color.fromARGB(255, 231, 231, 231),
                  ),
                  teamAnasy(
                    id: widget.id,
                  ),
                  historyBattle(id: widget.id),
                  Container(
                    height: rpx(40),
                  )
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }
}
