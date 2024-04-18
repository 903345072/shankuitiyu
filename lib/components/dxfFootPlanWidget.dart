import 'package:flutter/material.dart';
import 'package:jingcai_app/model/jcFootMetModel.dart';
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/PreferredSizeWidget.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';
import 'package:jingcai_app/util/timeUtil.dart';

class dxfFootPlanWidget extends StatefulWidget {
  JcFootModel j;
  Function changeGame;
  Function deleteGame;
  int index;
  dxfFootPlanWidget(
      {super.key,
      required this.j,
      required this.changeGame,
      required this.deleteGame,
      required this.index});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return plan_();
  }
}

class plan_ extends State<dxfFootPlanWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return jcFoot(widget.j);
  }

  Widget jcFoot(JcFootModel j) {
    return Container(
      padding: EdgeInsets.all(rpx(10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(j.leagues!.nameShort.toString() +
                  " | " +
                  j.startAt.toString()),
              onClick(
                  Container(
                    padding: EdgeInsets.all(rpx(5)),
                    child: Icon(Icons.arrow_right),
                  ),
                  () => widget.changeGame(widget.index))
            ],
          ),
          SizedBox(
            height: rpx(10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Wrap(
                direction: Axis.vertical,
                spacing: rpx(10),
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Image.network(
                    j.awayTeam!.logo.toString(),
                    fit: BoxFit.cover,
                    width: rpx(30),
                  ),
                  TextWidget(
                    j.awayTeam!.nameShort.toString(),
                    fontSize: rpx(14),
                  )
                ],
              ),
              TextWidget(
                "VS",
                fontSize: rpx(24),
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              Wrap(
                direction: Axis.vertical,
                spacing: rpx(10),
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Image.network(
                    j.homeTeam!.logo.toString(),
                    fit: BoxFit.cover,
                    width: rpx(30),
                  ),
                  TextWidget(
                    j.homeTeam!.nameShort.toString(),
                    fontSize: rpx(14),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: rpx(10),
          ),
          getRq(),
          onClick(
              Container(
                padding: EdgeInsets.all(rpx(15)),
                alignment: Alignment.bottomRight,
                child: TextWidget(
                  "删除比赛",
                  color: Colors.blue,
                  fontSize: rpx(14),
                ),
              ),
              () => widget.deleteGame(widget.index)),
        ],
      ),
    );
  }

  getRq() {
    List<Rq> rq = widget.j.jcFootMetModel_!.dxf!.values.toList();

    if (rq[0].pl == '0') {
      return Container();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(right: rpx(20)),
          alignment: Alignment.center,
          height: rpx(48),
          width: rpx(48),
          decoration: BoxDecoration(
              color: Color(0xfff2f2f2),
              borderRadius: BorderRadius.circular(rpx(48))),
          child: TextWidget(
            "+" + double.parse(widget.j.jcFootMetModel_!.daxiaoNum).toString(),
            fontSize: rpx(13),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
              rq.length,
              (index) => onClick(
                      Container(
                        margin: EdgeInsets.only(right: rpx(20)),
                        width: rpx(80),
                        alignment: Alignment.center,
                        height: rpx(36),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: rq[index].check == true
                                    ? Colors.red
                                    : Color(0xfff2f2f2),
                                width: rpx(1)),
                            borderRadius: BorderRadius.circular(rpx(18))),
                        child: TextWidget(
                          rq[index].name.toString() + rq[index].pl.toString(),
                          fontSize: rpx(13),
                        ),
                      ), () {
                    setState(() {
                      rq[index].check = rq[index].check == true ? false : true;
                    });
                  })),
        ),
      ],
    );
  }
}
