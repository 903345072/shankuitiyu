import 'package:flutter/material.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class scorePrediction extends StatelessWidget {
  JcFootModel foot = JcFootModel.fromJson({
    "leagues": Map<String, dynamic>.from({}),
    "home_team": Map<String, dynamic>.from({}),
    "away_team": Map<String, dynamic>.from({})
  });
  String home_ball;
  String away_ball;
  scorePrediction(
      {super.key,
      required this.foot,
      required this.home_ball,
      required this.away_ball});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: rpx(15), vertical: rpx(8)),
          padding: EdgeInsets.symmetric(horizontal: rpx(15), vertical: rpx(6)),
          color: Color.fromRGBO(0, 40, 104, .06),
          child: TextWidget("比分预测"),
        ),
        Container(
          alignment: Alignment.center,
          child: Wrap(
            spacing: rpx(15),
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.vertical,
            children: [
              TextWidget(foot.startAt.toString()),
              Wrap(
                spacing: rpx(60),
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Wrap(
                    spacing: rpx(10),
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    children: [
                      foot.homeTeam!.logo != null
                          ? netImg(
                              foot.homeTeam!.logo.toString(), rpx(50), rpx(50))
                          : Container(
                              width: rpx(50),
                              height: rpx(50),
                            ),
                      Container(
                        width: rpx(80),
                        child: TextWidget(foot.homeTeam!.nameShort.toString()),
                      )
                    ],
                  ),
                  TextWidget(
                    home_ball + " : " + away_ball,
                    color: Colors.red,
                    fontSize: rpx(30),
                    fontWeight: FontWeight.bold,
                  ),
                  Wrap(
                    spacing: rpx(10),
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    children: [
                      foot.awayTeam!.logo != null
                          ? netImg(
                              foot.awayTeam!.logo.toString(), rpx(50), rpx(50))
                          : Container(
                              width: rpx(50),
                              height: rpx(50),
                            ),
                      Container(
                        width: rpx(80),
                        child: TextWidget(foot.awayTeam!.nameShort.toString()),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
