import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

class gamePieChart extends StatelessWidget {
  double pie1 = 100;
  double pie2 = 0;
  double pie3 = 0;
  gamePieChart({required this.pie1, required this.pie2, required this.pie3});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _simplePie();
  }

  Widget _simplePie() {
    return PieChart(
      PieChartData(
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 20,
          sections: showingSections()),
    );
  }

  List<PieChartSectionData> showingSections() {
    final double fontSize = rpx(13);
    final double radius = 12;
    return [
      PieChartSectionData(
        color: const Color(0xffef2f2f),
        value: pie1,
        title: pie1.toString() + '%',
        showTitle: false,
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff)),
      ),
      PieChartSectionData(
        color: const Color(0xff30b27a),
        value: pie2,
        title: pie2.toString() + '%',
        showTitle: false,
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff)),
      ),
      PieChartSectionData(
        color: const Color(0xff002868),
        value: pie3,
        title: pie3.toString() + '%',
        showTitle: false,
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff)),
      ),
    ];
  }
}
