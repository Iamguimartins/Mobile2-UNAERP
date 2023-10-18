import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/chart_section.dart';

class LineChartCustom extends StatelessWidget {
  LineChartCustom(
      {super.key,
      required this.title,
      required this.sections,
      required this.colorLine,});

  String title;
  List<ChartSection> sections;
  Color colorLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 17)),
        const SizedBox(
          height: 30,
        ),
        AspectRatio(
          aspectRatio: 1.0,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, top: 25, left: 20),
            child: LineChart(
                LineChartData(
              minY: 0,
              maxY: getMaxValue() + 10,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                horizontalInterval: 10,
                verticalInterval: 1,
                getDrawingHorizontalLine: (value) {
                  return const FlLine(
                    color: Colors.grey,
                    strokeWidth: 1,
                  );
                },
                getDrawingVerticalLine: (value) {
                  return const FlLine(
                    color: Colors.grey,
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: 1,
                    getTitlesWidget: bottomTitleWidgets,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: leftTitleWidgets,
                    reservedSize: 42,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.grey),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(sections.length, (i) {
                    return FlSpot(i.toDouble(), sections[i].value);
                  }),
                  isCurved: true,
                  color: colorLine,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(
                    show: true,
                  ),
                ),
              ],
            )),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(sections[value.toInt()].title,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          )),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    String text;

    if (value == 10) {
      text = '10';
    } else if (value == getMaxValue() / 2) {
      text = (getMaxValue().toInt() ~/ 2).toString();
    } else if (value == getMaxValue()) {
      text = '${getMaxValue().toInt()}';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(text,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          )),
    );
  }

  double getMaxValue() {
    double maxValue = 0;

    for (var e in sections) {
      if (e.value >= maxValue) {
        maxValue = e.value;
      }
    }

    return maxValue;
  }
}
