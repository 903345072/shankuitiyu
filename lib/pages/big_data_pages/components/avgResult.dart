import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

class avgResult extends StatelessWidget {
  List<RqPl>? rqPlList;
  int flag = 0;
  Map cur = {};

  avgResult({super.key, required this.rqPlList, required this.cur});

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
    var sortedMap = Map.fromEntries(cur.entries.toList()
      ..sort(
        (e1, e2) => (double.parse(e1.key)).compareTo((double.parse(e2.key))),
      ));

    List<FlSpot> spots_win = sortedMap.entries.map((e) {
      return FlSpot(double.parse(e.key), e.value["win_rate"] * 100);
    }).toList();

    List<FlSpot> spots_handicaps = sortedMap.entries.map((e) {
      return FlSpot(double.parse(e.key), e.value["draw_rate"] * 100);
    }).toList();

    List<FlSpot> spots_loss = sortedMap.entries.map((e) {
      return FlSpot(double.parse(e.key), e.value["loss_rate"] * 100);
    }).toList();
    return Container(
        alignment: Alignment.center,
        child: LineChart(LineChartData(
          minY: 0,
          maxY: 100,
          titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(
                sideTitles: SideTitles(
                    reservedSize: rpx(50),
                    getTitlesWidget: (double value, TitleMeta meta) {
                      return Text(
                        value.toString() + "%",
                        style: TextStyle(fontSize: rpx(12)),
                      );
                    },
                    showTitles: true)),
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
