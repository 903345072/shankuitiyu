import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/pages/score_pages/foot.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:path_provider/path_provider.dart';

class pushBf extends StatelessWidget {
  JcFootModel foot = JcFootModel.fromJson({
    "elapsed": "0",
    "change_id": "0",
    "leagues": Map<String, dynamic>.from({}),
    "home_team": Map<String, dynamic>.from({}),
    "away_team": Map<String, dynamic>.from({})
  });
  pushBf({required this.foot});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Container(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/bf_push.png",
              fit: BoxFit.cover,
            )),
        Positioned(
            left: rpx(27),
            top: rpx(20),
            child: Row(
              crossAxisAlignment: foot.change_id == 1
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.end,
              children: [
                Image.asset(
                  "assets/images/have_goal.png",
                  width: rpx(15),
                  fit: BoxFit.cover,
                ),
                Container(
                  width: rpx(5),
                ),
                Wrap(
                  direction: Axis.vertical,
                  spacing: rpx(6),
                  children: [
                    Container(
                      width: rpx(140),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: rpx(100),
                            child: TextWidget(
                              foot.leagues != null
                                  ? foot.leagues!.nameShort.toString()
                                  : "未知",
                              color: Colors.black,
                            ),
                          ),
                          // Container(
                          //   width: rpx(25),
                          //   alignment: Alignment.center,
                          //   child: TextWidget(
                          //     foot.elapsed != null
                          //         ? foot.elapsed!.toString() + "'"
                          //         : "",
                          //     textAlign: TextAlign.center,
                          //     color: Colors.black,
                          //   ),
                          // )
                          Container()
                        ],
                      ),
                    ),
                    Container(
                      width: rpx(290),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: rpx(100),
                            child: TextWidget(
                              foot.homeTeam != null
                                  ? foot.homeTeam!.nameShort.toString()
                                  : "未知",
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: rpx(100),
                          ),
                          Container(
                            width: rpx(35),
                            alignment: Alignment.center,
                            child: TextWidget(
                              getGoal(1) + " ",
                              textAlign: TextAlign.center,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: rpx(15),
                            ),
                          ),
                          Container(
                            width: rpx(20),
                          ),
                          Container(
                            width: rpx(35),
                            alignment: Alignment.center,
                            child: TextWidget(
                              "进球",
                              textAlign: TextAlign.center,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: rpx(290),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: rpx(100),
                            child: TextWidget(
                              foot.awayTeam != null
                                  ? foot.awayTeam!.nameShort.toString()
                                  : "未知",
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: rpx(100),
                          ),
                          Container(
                            width: rpx(35),
                            alignment: Alignment.center,
                            child: TextWidget(
                              getGoal(2) + " ",
                              textAlign: TextAlign.center,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: rpx(15),
                            ),
                          ),
                          Container(
                            width: rpx(20),
                          ),
                          Container(
                            width: rpx(35),
                            alignment: Alignment.center,
                            child: TextWidget(
                              foot.elapsed != null
                                  ? foot.elapsed!.toString() + "'"
                                  : "",
                              textAlign: TextAlign.center,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ))
      ],
    );
  }

  bool getWIn() {
    bool c = true;
    return c;
  }

  getGoal(int type) {
    String s = foot.currentScore ?? "0:0";
    if (s.isEmpty) {
      s = "0:0";
    }
    List score = s.split(":");
    if (type == 1) {
      return score[0];
    }
    return score[1];
  }
}



  // Future _playLocalSound() async {
  //   return await _audioPlayer.play(AssetSource("music/hecai.mp3"));
  // }



