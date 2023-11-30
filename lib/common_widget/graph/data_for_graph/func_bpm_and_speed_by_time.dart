import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/data_home_view.dart';

class FuncBpmAndSpeedByTime {
  final DataHomeView data;

  FuncBpmAndSpeedByTime(this.data);

  List<int> showingTooltipOnSpots = [0];

  SideTitles get rightTitles => SideTitles(
        getTitlesWidget: rightTitleWidgets,
        showTitles: true,
        interval: 20,
        reservedSize: 40,
      );

  late final lineBarsData = [
    LineChartBarData(
      spots: data.bpmSecondes,
      isCurved: false,
      barWidth: 2,
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(colors: [
          TColor.secondaryColor1.withOpacity(0.4),
          TColor.secondaryColor2.withOpacity(0.1),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      dotData: const FlDotData(show: false),
      gradient: LinearGradient(
        colors: TColor.secondaryG,
      ),
    ),
  ];
  late final tooltipsOnBar = lineBarsData[0];

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0%';
        break;
      case 20:
        text = '20%';
        break;
      case 40:
        text = '40%';
        break;
      case 60:
        text = '60%';
        break;
      case 80:
        text = '80%';
        break;
      case 100:
        text = '100%';
        break;
      default:
        return Container();
    }

    return Text(text,
        style: TextStyle(
          color: TColor.gray,
          fontSize: 12,
        ),
        textAlign: TextAlign.center);
  }

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
      ];

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        gradient: LinearGradient(colors: [
          TColor.primaryColor2.withOpacity(0.5),
          TColor.primaryColor1.withOpacity(0.5),
        ]),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: data.vitesseSecondes,
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        gradient: LinearGradient(colors: [
          TColor.secondaryColor2.withOpacity(0.5),
          TColor.secondaryColor1.withOpacity(0.5),
        ]),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
        ),
        spots: data.bpmSecondes2,
      );
}
