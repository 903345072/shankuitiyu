import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';

class talentBattleChart extends StatelessWidget {
  List<dynamic> homes = [];
  talentBattleChart({required this.homes});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LineChart(
      mainData(),
    );
  }

  var t = {"1": "黑", "2": "走", "3": "红"};
  getText(String t) {
    String tex = "红";
    Color c = Colors.red;
    if (t == "2") {
      tex = "走";
      c = Color(0xff002868);
    }
    if (t == "1") {
      tex = "黑";
      c = Colors.black;
    }
    return TextWidget(
      tex,
      color: c,
    );
  }

  LineChartData mainData() {
    return LineChartData(
      titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: false,
          )),
          leftTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: getText(meta.formattedValue.toString()),
                    );
                  })),
          rightTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: false,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text(
                        meta.formattedValue,
                      ),
                    );
                  }))),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.shade300,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      borderData: FlBorderData(
          show: true,
          border: Border(
              top: BorderSide(
                color: Colors.grey.shade300,
              ),
              bottom: BorderSide(
                color: Colors.grey.shade300,
              ))),
      minX: 0,
      maxX: homes.length.toDouble(),
      minY: 1,
      maxY: 3,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final List<int> showIndexes = homes.asMap().keys.toList();
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: List.generate(
          homes.length,
          (index) =>
              FlSpot(index.toDouble(), double.parse(homes[index].toString()))),
      isCurved: false,
      barWidth: 1,
      color: Colors.grey.shade300,
      showingIndicators: showIndexes,
      isStrokeCapRound: false,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          if (homes[index] == 3) {
            return FlDotCirclePainter(
                radius: 1,
                color: Colors.red,
                strokeWidth: 2,
                strokeColor: Colors.red);
          } else if (homes[index] == 1) {
            return FlDotCirclePainter(
              radius: 1,
              color: Colors.black,
              strokeWidth: 2,
              strokeColor: Colors.black,
            );
          } else {
            return FlDotCirclePainter(
              radius: 1,
              color: Color(0xff002868),
              strokeWidth: 2,
              strokeColor: Color(0xff002868),
            );
          }
        },
        // checkToShowDot: (spot, barData) {
        //   return spot.x != 0 && spot.x != 6;
        // }
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [lineChartBarData1];
  }
}
