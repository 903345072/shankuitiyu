import 'package:flutter/material.dart';
import 'package:jingcai_app/enum/planType.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/colors.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

class jcGameTitle extends StatelessWidget {
  JcFootModel? footModel_;
  jcGameTitle({super.key, this.footModel_});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          height: rpx(45),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: MyColors.red.withOpacity(0.1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/jc_foot.png",
                width: rpx(30),
              ),
              TextWidget(
                footModel_!.leagues!.nameShort.toString(),
                fontSize: rpx(15),
              ),
              TextWidget(
                '|',
                fontSize: rpx(15),
              ),
              TextWidget(
                footModel_!.jc!.matchNumStr.toString(),
                fontSize: rpx(15),
              ),
              TextWidget(
                '|',
                fontSize: rpx(15),
              ),
              TextWidget(
                footModel_!.homeTeam!.nameShort.toString(),
                fontSize: rpx(15),
              ),
              TextWidget(
                'VS',
                fontSize: rpx(15),
              ),
              TextWidget(
                footModel_!.awayTeam!.nameShort.toString(),
                fontSize: rpx(15),
              ),
            ],
          ),
        ),
        SizedBox(
          height: rpx(5),
        )
      ],
    );
  }
}

class rqGameTitle extends StatelessWidget {
  JcFootModel? footModel_;
  rqGameTitle({super.key, this.footModel_});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          height: rpx(45),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: MyColors.red.withOpacity(0.1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/rangqiu.png",
                width: rpx(30),
              ),
              TextWidget(
                footModel_!.leagues!.nameShort.toString(),
                fontSize: rpx(15),
              ),
              TextWidget(
                '|',
                fontSize: rpx(15),
              ),
              TextWidget(
                footModel_!.homeTeam!.nameShort.toString(),
                fontSize: rpx(15),
              ),
              TextWidget(
                'VS',
                fontSize: rpx(15),
              ),
              TextWidget(
                footModel_!.awayTeam!.nameShort.toString(),
                fontSize: rpx(15),
              ),
            ],
          ),
        ),
        SizedBox(
          height: rpx(5),
        )
      ],
    );
  }
}

class rfsfTitle extends StatelessWidget {
  JcFootModel? footModel_;
  rfsfTitle({super.key, this.footModel_});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          height: rpx(45),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: MyColors.red.withOpacity(0.1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/rangqiu.png",
                width: rpx(30),
              ),
              TextWidget(
                footModel_!.leagues!.nameShort.toString(),
                fontSize: rpx(15),
              ),
              TextWidget(
                '|',
                fontSize: rpx(15),
              ),
              TextWidget(
                footModel_!.awayTeam!.nameShort.toString(),
                fontSize: rpx(15),
              ),
              TextWidget(
                'VS',
                fontSize: rpx(15),
              ),
              TextWidget(
                footModel_!.homeTeam!.nameShort.toString(),
                fontSize: rpx(15),
              ),
            ],
          ),
        ),
        SizedBox(
          height: rpx(5),
        )
      ],
    );
  }
}

class daxiaoGameTitle extends StatelessWidget {
  JcFootModel? footModel_;
  daxiaoGameTitle({super.key, this.footModel_});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          height: rpx(45),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: MyColors.red.withOpacity(0.1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/jinqiu.png",
                width: rpx(30),
              ),
              TextWidget(
                footModel_!.leagues!.nameShort.toString(),
                fontSize: rpx(13),
              ),
              TextWidget(
                '|',
                fontSize: rpx(13),
              ),
              TextWidget(
                footModel_!.awayTeam!.nameShort.toString(),
                fontSize: rpx(13),
              ),
              TextWidget(
                'VS',
                fontSize: rpx(13),
              ),
              TextWidget(
                footModel_!.homeTeam!.nameShort.toString(),
                fontSize: rpx(13),
              ),
            ],
          ),
        ),
        SizedBox(
          height: rpx(5),
        )
      ],
    );
  }
}
