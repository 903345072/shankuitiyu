import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:jingcai_app/model/jcFootModel.dart';
import 'package:jingcai_app/pages/botom_pages/widget/textWidget.dart';
import 'package:jingcai_app/util/rpx.dart';

class spfChart extends StatelessWidget {
  List<spfPl>? spfPlList;
  spfChart({required this.spfPlList});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LineChart(
      mainData(),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      titlesData: const FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey,
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
      minY: 0,
      maxY: getMaxy(),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      lineBarsData: linesBarData1(),
    );
  }

  getMaxy() {
    List<double> wins =
        spfPlList!.map((e) => double.parse(e.win.toString())).toList();

    List<double> draws =
        spfPlList!.map((e) => double.parse(e.draw.toString())).toList();
    List<double> loss =
        spfPlList!.map((e) => double.parse(e.loss.toString())).toList();
    wins.addAll(draws);
    wins.addAll(loss);
    wins.sort();

    return wins.isNotEmpty ? wins[wins.length - 1].ceil().toDouble() : 2.0;
  }

// FlSpot(0, 1),
  List<LineChartBarData> linesBarData1() {
    List<double> wins =
        spfPlList!.map((e) => double.parse(e.win.toString())).toList();
    List<double> draws =
        spfPlList!.map((e) => double.parse(e.draw.toString())).toList();
    List<double> loss =
        spfPlList!.map((e) => double.parse(e.loss.toString())).toList();
    // List<double> times =
    //     spfPlList!.map((e) => double.parse(e.changeAt.toString())).toList();

    List<double> yValues = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0];
    final List<int> showIndexes = yValues.asMap().keys.toList();
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: List.generate(
          wins.length, (index) => FlSpot(index.toDouble(), wins[index])),
      isCurved: false,
      barWidth: 2,
      color: Colors.red,
      showingIndicators: showIndexes,
      isStrokeCapRound: false,
      dotData: const FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );

    final LineChartBarData lineChartBarData2 = LineChartBarData(
      spots: List.generate(
          draws.length, (index) => FlSpot(index.toDouble(), draws[index])),
      isCurved: false,
      barWidth: 2,
      color: Color(0xff30b27a),
      showingIndicators: showIndexes,
      isStrokeCapRound: false,
      dotData: const FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );

    final LineChartBarData lineChartBarData3 = LineChartBarData(
      spots: List.generate(
          loss.length, (index) => FlSpot(index.toDouble(), loss[index])),
      isCurved: false,
      barWidth: 2,
      color: Color(0xff002868),
      showingIndicators: showIndexes,
      isStrokeCapRound: false,
      dotData: const FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [lineChartBarData1, lineChartBarData2, lineChartBarData3];
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
