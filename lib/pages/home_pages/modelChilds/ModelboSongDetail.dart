import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/big_data_pages/components/DataContrast.dart';
import 'package:jingcai_app/pages/big_data_pages/components/allIndex.dart';
import 'package:jingcai_app/pages/big_data_pages/components/allIndexBack.dart';
import 'package:jingcai_app/pages/big_data_pages/components/allScores.dart';
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

class ModelboSongDetail extends StatefulWidget {
  int? id;
  ModelboSongDetail({required this.id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return indexChangeDetail_();
  }
}

class indexChangeDetail_ extends State<ModelboSongDetail> {
  JcFootModel foot = JcFootModel.fromJson({
    "leagues": Map<String, dynamic>.from({}),
    "home_team": Map<String, dynamic>.from({}),
    "away_team": Map<String, dynamic>.from({})
  });

  Map home = {};
  Map away = {};
  List goals = [];
  Map scores = {};
  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() {
    G.api.game.getBoSongDetail({"id": widget.id}).then((value) {
      setState(() {
        foot = JcFootModel.fromJson(value["foot"]);
        home = value["home_data"];
        away = value["away_data"];
        goals = value["goals_guess"];
        scores = value["score_guess"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
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
                      height: rpx(7),
                      margin: EdgeInsets.symmetric(vertical: rpx(10)),
                      color: const Color.fromARGB(255, 233, 233, 233),
                    ),
                    home.isNotEmpty && away.isNotEmpty
                        ? defenseContrast(
                            home: home,
                            away: away,
                          )
                        : Container(),
                    Container(
                      height: rpx(5),
                      margin: EdgeInsets.symmetric(vertical: rpx(10)),
                      color: const Color.fromARGB(255, 233, 233, 233),
                    ),
                    goals.isNotEmpty && scores.isNotEmpty
                        ? boSongPredict(
                            scores: scores,
                            goals: goals,
                          )
                        : Container(),
                    Container(
                      height: rpx(5),
                      margin: EdgeInsets.symmetric(vertical: rpx(10)),
                      color: const Color.fromARGB(255, 233, 233, 233),
                    ),
                    scores.isNotEmpty
                        ? allScores(
                            scores: scores,
                          )
                        : Container(),
                  ],
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
