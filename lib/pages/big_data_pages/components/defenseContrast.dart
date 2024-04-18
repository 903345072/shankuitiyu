import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

class defenseContrast extends StatelessWidget {
  Map home = {};
  Map away = {};

  defenseContrast({required this.home, required this.away});

  String getAvg(Map m, String type) {
    String c = "0";

    if (m["matches"] == 0) {
      return "0";
    }
    if (m[type] == null) {
      m[type] = 0;
    }
    c = (m[type] / m["matches"]).toStringAsFixed(2);
    return c;
  }

  Widget getJdt(String type, int dir) {
    Container c = Container();
    double p = 150;

    if (dir == 1) {
      if (double.parse(getAvg(home, type)) + double.parse(getAvg(away, type)) !=
          0) {
        p = (double.parse(getAvg(away, type)) /
                (double.parse(getAvg(home, type)) +
                    double.parse(getAvg(away, type)))) *
            150;
      }
      c = Container(
        height: rpx(8),
        width: rpx(150),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(rpx(8)),
            color: Color(0xfff0f0f0)),
        child: Container(
          margin: EdgeInsets.only(left: rpx(p)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(rpx(8)), color: Colors.red),
        ),
      );
    } else {
      if (double.parse(getAvg(home, type)) + double.parse(getAvg(away, type)) !=
          0) {
        p = (double.parse(getAvg(home, type)) /
                (double.parse(getAvg(home, type)) +
                    double.parse(getAvg(away, type)))) *
            150;
      }
      c = Container(
        height: rpx(8),
        width: rpx(150),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(rpx(8)),
            color: Color(0xfff0f0f0)),
        child: Container(
          margin: EdgeInsets.only(right: rpx(p)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(rpx(8)), color: Colors.blue),
        ),
      );
    }

    return c;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: rpx(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: rpx(4),
                    height: rpx(20),
                    color: Colors.red,
                  ),
                  Container(
                    width: rpx(5),
                  ),
                  TextWidget(
                    "数据对比",
                    fontSize: rpx(18),
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
              Wrap(
                spacing: rpx(5),
                children: [
                  Row(
                    children: [
                      Container(
                        height: rpx(8),
                        width: rpx(8),
                        color: Colors.red,
                      ),
                      Container(
                        width: rpx(3),
                      ),
                      TextWidget("主队")
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: rpx(8),
                        width: rpx(8),
                        color: Colors.blue,
                      ),
                      Container(
                        width: rpx(3),
                      ),
                      TextWidget("客队")
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: rpx(10),
        ),
        home.isNotEmpty && away.isNotEmpty
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: rpx(10)),
                child: Wrap(
                  runSpacing: rpx(15),
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(getAvg(home, "goals")),
                              TextWidget("场均进球"),
                              TextWidget(getAvg(away, "goals")),
                            ],
                          ),
                          SizedBox(
                            height: rpx(10),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getJdt("goals", 1),
                              getJdt("goals", 2),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(getAvg(home, "goals_against")),
                              TextWidget("场均失球"),
                              TextWidget(getAvg(away, "goals_against")),
                            ],
                          ),
                          SizedBox(
                            height: rpx(10),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getJdt("goals_against", 1),
                              getJdt("goals_against", 2),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(home["attact_value"].toString()),
                              TextWidget("进攻能力"),
                              TextWidget(away["attact_value"].toString()),
                            ],
                          ),
                          SizedBox(
                            height: rpx(10),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getJdt("attact_value", 1),
                              getJdt("attact_value", 2),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(home["defense_value"].toString()),
                              TextWidget("防守能力"),
                              TextWidget(away["defense_value"].toString()),
                            ],
                          ),
                          SizedBox(
                            height: rpx(10),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getJdt("defense_value", 1),
                              getJdt("defense_value", 2),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container()
      ],
    );
  }
}
