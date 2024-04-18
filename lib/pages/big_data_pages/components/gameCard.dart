import 'package:flutter/material.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/commonComponents.dart';
import 'package:jingcai_app/util/rpx.dart';

class gameCard extends StatelessWidget {
  JcFootModel foot = JcFootModel.fromJson({
    "leagues": Map<String, dynamic>.from({}),
    "home_team": Map<String, dynamic>.from({}),
    "away_team": Map<String, dynamic>.from({})
  });
  gameCard({required this.foot});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: rpx(15)),
      padding: EdgeInsets.symmetric(vertical: rpx(15)),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26.withOpacity(0.1), // 阴影的颜色
              offset: Offset(5, 2), // 阴影与容器的距离
              blurRadius: 5.0, // 高斯的标准偏差与盒子的形状卷积。
              spreadRadius: 0.0, // 在应用模糊之前，框应该膨胀的量。
            ),
          ],
          borderRadius: BorderRadius.circular(rpx(15))),
      alignment: Alignment.center,
      child: Wrap(
        spacing: rpx(15),
        crossAxisAlignment: WrapCrossAlignment.start,
        direction: Axis.vertical,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: rpx(5),
            children: [
              TextWidget(foot.leagues!.nameShort.toString()),
              TextWidget(foot.startAt.toString()),
            ],
          ),
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
                      ? netImg(foot.homeTeam!.logo.toString(), rpx(40), rpx(40))
                      : Container(
                          width: rpx(50),
                          height: rpx(50),
                        ),
                  TextWidget(foot.homeTeam!.nameShort.toString())
                ],
              ),
              Wrap(
                direction: Axis.vertical,
                spacing: rpx(10),
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  getFootGameStateText(foot.statusId, foot.elapsed,
                      size: rpx(18)),
                  getFootGameScoreText(foot.statusId, foot.currentScore,
                      size: rpx(18))
                ],
              ),
              Wrap(
                spacing: rpx(10),
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                children: [
                  foot.awayTeam!.logo != null
                      ? netImg(foot.awayTeam!.logo.toString(), rpx(40), rpx(40))
                      : Container(
                          width: rpx(50),
                          height: rpx(50),
                        ),
                  TextWidget(foot.awayTeam!.nameShort.toString())
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
