import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

class spfChart extends StatelessWidget {
  List<spfPl>? spfPlList;
  int flag = 0;
  spfChart({super.key, required this.spfPlList});

  double getMaxY() {
    List<double> wins =
        spfPlList!.map((e) => double.parse(e.win.toString())).toList();

    List<double> draws =
        spfPlList!.map((e) => double.parse(e.draw.toString())).toList();
    List<double> loss =
        spfPlList!.map((e) => double.parse(e.loss.toString())).toList();
    wins.addAll(draws);
    wins.addAll(loss);

    return wins.isNotEmpty ? wins.reduce(max) : 0;
  }

  @override
  Widget build(BuildContext context) {
    List<double> wins =
        spfPlList!.map((e) => double.parse(e.win.toString())).toList();
    List<double> draws =
        spfPlList!.map((e) => double.parse(e.draw.toString())).toList();
    List<double> loss =
        spfPlList!.map((e) => double.parse(e.loss.toString())).toList();
    List<FlSpot> spots_win = wins.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value);
    }).toList();

    List<FlSpot> spots_draw = draws.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value);
    }).toList();

    List<FlSpot> spots_loss = loss.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value);
    }).toList();
    return Container(
        alignment: Alignment.center,
        child: LineChart(LineChartData(
          minY: 0,
          maxY: getMaxY(),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(
              show: false,
              border: Border.all(color: const Color(0xff37434d), width: 1)),
          lineBarsData: [
            LineChartBarData(
              color: Colors.red,
              barWidth: 3,
              spots: spots_win,
              isCurved: false,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: false,
              ),
            ),
            LineChartBarData(
              color: Color(0xff30b27a),
              barWidth: 3,
              spots: spots_draw,
              isCurved: false,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: false,
              ),
            ),
            LineChartBarData(
              color: Color(0xff002868),
              barWidth: 3,
              spots: spots_loss,
              isCurved: false,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: false,
              ),
            )
          ],
        )));
  }
}

class AvgDataBaseData {
  final double avg;

  AvgDataBaseData({required this.avg});
}
