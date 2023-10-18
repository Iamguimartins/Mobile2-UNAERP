import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:trabalho_faculdade/infrastructure/domain/entities/chart_section.dart';
import 'package:trabalho_faculdade/infrastructure/presentations/shared/widgets/chart/pie_chart/components/pie_indicator.dart';

class PieChartCustom extends StatelessWidget {
  PieChartCustom(
      {Key? key,
      required this.title,
      required this.sections})
      : super(key: key);

  String title;
  List<ChartSection> sections;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: const TextStyle(fontSize: 17)),
        Row(
          children: <Widget>[
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.2,
                child: PieChart(
                  PieChartData(
                    borderData: FlBorderData(
                      show: true,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: sectionsChart(),
                  ),
                ),
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: indicators()),
          ],
        ),
      ],
    );
  }

  List<PieChartSectionData> sectionsChart() {
    return List.generate(sections.length, (i) {
      return PieChartSectionData(
        color: sections[i].color,
        value: sections[i].value,
        title: formatPercent(sections[i].value),
        showTitle: true,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    });
  }

  List<Widget> indicators() {
    return List.generate(sections.length, (i) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: PieIndicator(
          color: sections[i].color!,
          text: sections[i].title,
        ),
      );
    });
  }

  String formatPercent(double value) {
    return "$value%";
  }
}
