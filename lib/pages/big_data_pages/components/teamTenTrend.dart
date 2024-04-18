import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/big_data_pages/components/gamePieChart.dart';
import 'package:jingcai_app/pages/big_data_pages/components/spfTrendChart.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

class teamTenTrend extends StatelessWidget {
  List<dynamic> homes = [];
  String name = "";

  teamTenTrend({required this.homes, required this.name});
  String getWindRate() {
    List s = homes.where((element) => element == 3).toList();

    return (s.length * 100 / homes.length).toStringAsFixed(0);
  }

  String getLossRate() {
    double win_rate = double.parse(getWindRate());
    double draw_rate = double.parse(getDrawRate());
    return (100 - win_rate - draw_rate).toStringAsFixed(0);
  }

  String getDrawRate() {
    List s = homes.where((element) => element == 2).toList();

    return (s.length * 100 / homes.length).toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          children: [
            Container(
                height: rpx(120),
                width: rpx(120),
                child: gamePieChart(
                  pie1: double.parse(getWindRate()),
                  pie2: double.parse(getDrawRate()),
                  pie3: double.parse(getLossRate()),
                )),
            TextWidget(name)
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: rpx(25)),
          child: Wrap(
            spacing: rpx(15),
            children: [
              Wrap(
                spacing: rpx(12),
                direction: Axis.vertical,
                children: [
                  Row(
                    children: [
                      Container(
                        width: rpx(10),
                        height: rpx(10),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(rpx(10))),
                      ),
                      TextWidget(getWindRate() + "%")
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: rpx(10),
                        height: rpx(10),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(rpx(10))),
                      ),
                      TextWidget(getDrawRate() + "%")
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: rpx(10),
                        height: rpx(10),
                        decoration: BoxDecoration(
                            color: Color(0xff002868),
                            borderRadius: BorderRadius.circular(rpx(10))),
                      ),
                      TextWidget(getLossRate() + "%")
                    ],
                  ),
                ],
              ),
              Wrap(
                direction: Axis.vertical,
                spacing: rpx(12),
                children: [
                  TextWidget(
                    "胜",
                    color: Colors.red,
                  ),
                  TextWidget(
                    "平",
                    color: Colors.green,
                  ),
                  TextWidget(
                    "负",
                    color: Color(0xff002868),
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          width: rpx(10),
        ),
        Expanded(
            child: Wrap(
          runSpacing: rpx(25),
          children: [
            Container(
              margin: EdgeInsets.only(top: rpx(25), right: rpx(10)),
              height: rpx(70),
              child: spfTrendChart(
                homes: homes,
              ),
            ),
            Wrap(
              spacing: rpx(15),
              children: [
                TextWidget("近10场走势"),
                Wrap(
                  spacing: rpx(10),
                  children: [
                    TextWidget(
                      "${homes.where((element) => element == 3).length}胜",
                      color: Colors.red,
                    ),
                    TextWidget(
                      "${homes.where((element) => element == 2).length}平",
                    ),
                    TextWidget(
                      "${homes.where((element) => element == 1).length}负",
                    ),
                  ],
                )
              ],
            )
          ],
        )),
      ],
    );
  }
}
