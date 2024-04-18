import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

class rqChart extends StatelessWidget {
  List<RqPl>? rqPlList;
  int flag = 0;
  rqChart({super.key, required this.rqPlList});

  double getMaxY(int type) {
    List<double> wins =
        rqPlList!.map((e) => double.parse(e.win.toString())).toList();

    List<double> handicaps =
        rqPlList!.map((e) => double.parse(e.handicap.toString())).toList();
    List<double> loss =
        rqPlList!.map((e) => double.parse(e.loss.toString())).toList();
    wins.addAll(handicaps);
    wins.addAll(loss);
    if (type == 1) {
      return wins.isNotEmpty ? wins.reduce(max) : 0;
    }
    return wins.isNotEmpty ? wins.reduce(min) : 0;
  }

  @override
  Widget build(BuildContext context) {
    List<double> wins =
        rqPlList!.map((e) => double.parse(e.win.toString())).toList();
    List<double> handicaps =
        rqPlList!.map((e) => double.parse(e.handicap.toString())).toList();
    List<double> loss =
        rqPlList!.map((e) => double.parse(e.loss.toString())).toList();

    List<FlSpot> spots_win = wins.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value);
    }).toList();

    List<FlSpot> spots_handicaps = handicaps.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value);
    }).toList();

    List<FlSpot> spots_loss = loss.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value);
    }).toList();
    return Container(
        alignment: Alignment.center,
        child: LineChart(LineChartData(
          minY: getMaxY(2),
          maxY: getMaxY(1),
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
              spots: spots_handicaps,
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
