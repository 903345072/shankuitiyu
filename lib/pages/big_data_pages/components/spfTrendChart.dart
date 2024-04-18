import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class spfTrendChart extends StatelessWidget {
  List<dynamic> homes = [];
  spfTrendChart({required this.homes});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LineChart(
      mainData(),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      titlesData: FlTitlesData(show: false),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
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
          border: Border.all(color: const Color(0xff37434d), width: 1)),
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
      barWidth: 2,
      showingIndicators: showIndexes,
      isStrokeCapRound: false,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          if (homes[index] == 3) {
            return FlDotCirclePainter(
                radius: 1,
                color: Colors.red,
                strokeWidth: 3,
                strokeColor: Colors.red);
          } else if (homes[index] == 2) {
            return FlDotCirclePainter(
              radius: 1,
              color: Colors.green,
              strokeWidth: 3,
              strokeColor: Colors.green,
            );
          } else {
            return FlDotCirclePainter(
              radius: 1,
              color: Color(0xff002868),
              strokeWidth: 3,
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

  Widget _simpleLine() {
    var data1 = [
      LinearSales(1, 0),
      LinearSales(2, 1),
      LinearSales(3, 2),
      LinearSales(4, 1),
      LinearSales(5, 2),
      LinearSales(7, 2),
      LinearSales(8, 2),
      LinearSales(9, 1),
      LinearSales(10, 2),
      LinearSales(11, 1),
      LinearSales(12, 2),
    ];

    var seriesList = [
      charts.Series<LinearSales, int>(
        overlaySeries: true,
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        // dashPatternFn: (_, __) => [8, 2, 4, 2],
        data: data1,
      ),
    ];

    return charts.LineChart(seriesList,
        animate: false,
        defaultRenderer: charts.LineRendererConfig(
          // 圆点大小
          radiusPx: 5.0,
          stacked: false,
          // 线的宽度
          strokeWidthPx: 2.0,
          // 是否显示线
          includeLine: true,
          // 是否显示圆点
          includePoints: true,
          // 是否显示包含区域
          includeArea: true,
          // 区域颜色透明度 0.0-1.0
          areaOpacity: 0,
        ));
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
