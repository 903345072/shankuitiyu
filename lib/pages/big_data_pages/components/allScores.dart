import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

class allScores extends StatelessWidget {
  Map scores;
  allScores({required this.scores});
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
                "泊松预测比分概率",
                fontSize: rpx(18),
                fontWeight: FontWeight.bold,
              )
            ],
          ),
          Container(
            height: rpx(10),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(color: Colors.grey, width: rpx(0.6)),
                    top: BorderSide(color: Colors.grey, width: rpx(0.6)))),
            child: Wrap(
              children: getList(context),
            ),
          ),
          Container(
            height: rpx(10),
          ),
        ],
      ),
    );
  }

  List<Container> getList(BuildContext context) {
    List<Container> c = [];

    List keys = scores.keys.toList();

    // 只保留前10个元素
    List topTenKeys = keys.sublist(0, min(46, keys.length));

    for (var element in topTenKeys) {
      String a = element.toString();
      String b = (double.parse(scores[element]) * 100).toStringAsFixed(2) + "%";
      c.add(Container(
        width: MediaQuery.of(context).size.width * 0.15,
        decoration: BoxDecoration(
            border: Border(
                right: BorderSide(color: Colors.grey, width: rpx(0.6)),
                bottom: BorderSide(color: Colors.grey, width: rpx(0.6)))),
        child: Column(
          children: [
            TextWidget(
              a,
              fontWeight: FontWeight.bold,
            ),
            TextWidget(b)
          ],
        ),
      ));
    }

    return c;
  }
}
