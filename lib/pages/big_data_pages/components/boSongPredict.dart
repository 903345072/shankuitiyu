import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

class boSongPredict extends StatelessWidget {
  List goals;
  Map scores;
  boSongPredict({required this.goals, required this.scores});

  List<TextWidget> getBfWidget(Map p) {
    Container c = Container();
    List<TextWidget> d = [];

    //  p.values.toList().sort();

    var sortedMap = Map.fromEntries(
      p.entries.toList()
        ..sort(
          (e1, e2) => e2.value.compareTo(e1.value),
        ),
    );
    List keys = sortedMap.keys.toList();

    // 只保留前10个元素
    List topTenKeys = keys.sublist(0, min(3, keys.length));
    for (var element in topTenKeys) {
      var ii = element.toString();
      var ddd = "${(double.parse(sortedMap[ii]) * 100).toStringAsFixed(2)}%";
      d.add(TextWidget(element + "($ddd)"));
    }

    return d;
  }

  List<TextWidget> getGoalWidget(List p) {
    Container c = Container();
    List<TextWidget> d = [];

    p.asMap().values.toList().sort();

    var sortedMap = Map.fromEntries(
      p.asMap().entries.toList()
        ..sort(
          (e1, e2) => e2.value.compareTo(e1.value),
        ),
    );
    List keys = sortedMap.keys.toList();
    String k0 = (p[keys[0]] * 100).toStringAsFixed(2) + "%";
    String k1 = (p[keys[1]] * 100).toStringAsFixed(2) + "%";
    String k2 = (p[keys[2]] * 100).toStringAsFixed(2) + "%";
    d.add(TextWidget(keys[0].toString() + "球" + "($k0)"));
    d.add(TextWidget(keys[1].toString() + "球" + "($k1)"));
    d.add(TextWidget(keys[2].toString() + "球" + "($k2)"));
    // 只保留前10个元素
    // List topTenKeys = keys.sublist(0, min(3, keys.length));
    // for (var element in topTenKeys) {
    //   var ii = element.toString();
    //   var ddd = "${(double.parse(sortedMap[ii]) * 100).toStringAsFixed(2)}%";
    //   d.add(TextWidget(element + "球" + "($ddd)"));
    // }

    return d;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.symmetric(horizontal: rpx(10)),
        child: Column(
          children: [
            Container(
              height: rpx(10),
            ),
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
                  "泊松分布预测",
                  fontSize: rpx(18),
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
            Container(
              height: rpx(10),
            ),
            Row(
              children: [
                TextWidget(
                  "比分",
                  fontSize: rpx(16),
                ),
                Container(
                  width: rpx(280),
                  height: rpx(25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(rpx(5)),
                  ),
                  child: Wrap(
                    spacing: rpx(10),
                    children: getBfWidget(scores),
                  ),
                )
              ],
            ),
            Container(
              height: rpx(10),
            ),
            Row(
              children: [
                TextWidget(
                  "进球数",
                  fontSize: rpx(16),
                ),
                Container(
                  width: rpx(280),
                  height: rpx(25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(rpx(5)),
                  ),
                  child: Wrap(
                    spacing: rpx(10),
                    children: getGoalWidget(goals),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
