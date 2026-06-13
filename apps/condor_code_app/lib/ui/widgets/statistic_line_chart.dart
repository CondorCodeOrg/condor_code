import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// TODO: Add later.
class StatisticlineChart extends StatelessWidget {
  const StatisticlineChart({
    super.key,
    Color? line1Color,
    Color? line2Color,
    Color? betweenColor,
  }) : line1Color = line1Color ?? Colors.yellow,
       line2Color = line2Color ?? Colors.black,
       betweenColor = betweenColor ?? Colors.greenAccent;

  final Color line1Color;
  final Color line2Color;
  final Color betweenColor;

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10, fontWeight: FontWeight.bold);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mon';
        break;
      case 1:
        text = 'Tues';
        break;
      case 2:
        text = 'Wed';
        break;
      case 3:
        text = 'Thur';
        break;
      case 4:
        text = 'Frid';
        break;
      case 5:
        text = 'Sat';
        break;
      case 6:
        text = 'Sun';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(text, style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text('${value + 10}', style: style),
    );
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 200,
    width: 500,
    child: AspectRatio(
      aspectRatio: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 18, top: 10, bottom: 4),
        child: LineChart(
          LineChartData(
            lineTouchData: const LineTouchData(enabled: false),
            lineBarsData: [
              LineChartBarData(
                spots: const [
                  FlSpot(0, 4),
                  FlSpot(1, 3.5),
                  FlSpot(2, 4.5),
                  FlSpot(3, 1),
                  FlSpot(4, 4),
                  FlSpot(5, 6),
                  FlSpot(6, 6.5),
                  FlSpot(7, 6),
                  FlSpot(8, 4),
                  FlSpot(9, 6),
                  FlSpot(10, 6),
                  FlSpot(11, 7),
                ],
                isCurved: true,
                barWidth: 2,
                color: line1Color,
                dotData: const FlDotData(show: false),
              ),
              LineChartBarData(
                spots: const [
                  FlSpot(0, 6),
                  FlSpot(1, 3),
                  FlSpot(2, 4),
                  FlSpot(3, 2),
                  FlSpot(4, 3),
                  FlSpot(5, 4),
                  FlSpot(6, 5),
                  FlSpot(7, 3),
                  FlSpot(8, 1),
                  FlSpot(9, 8),
                  FlSpot(10, 1),
                  FlSpot(11, 3),
                ],
                isCurved: false,
                barWidth: 2,
                color: line2Color,
                dotData: const FlDotData(show: false),
              ),
            ],
            betweenBarsData: [
              BetweenBarsData(fromIndex: 0, toIndex: 1, color: betweenColor),
            ],
            minY: 0,
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: bottomTitleWidgets,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: leftTitleWidgets,
                  interval: 1,
                  reservedSize: 36,
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 1,
              checkToShowHorizontalLine: (double value) =>
                  value == 4 || value == 2 || value == 7 || value == 3,
            ),
          ),
        ),
      ),
    ),
  );
}
