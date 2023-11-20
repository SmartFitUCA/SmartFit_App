import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/data_home_view.dart';

class GraphBpmByTime extends StatefulWidget {
  final Size media;
  final DataHomeView data;

  const GraphBpmByTime(this.media, this.data, {Key? key}) : super(key: key);

  @override
  State<GraphBpmByTime> createState() => _GraphBpmByTime();
}

class _GraphBpmByTime extends State<GraphBpmByTime> {
  TextEditingController bpmController = TextEditingController();

  // Il faut chercher à le suprimer
  List<int> showingTooltipOnSpots = [0];

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
        spots: widget.data.vitesseSecondes,
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
        spots: widget.data.bpmSecondes2,
      );

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    final lineBarsData = [
      LineChartBarData(
        spots: widget.data.bpmSecondes,
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

    final tooltipsOnBar = lineBarsData[0];

    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        height: media.height * 0.3,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: TColor.primaryColor2.withOpacity(0.3),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rythme cardiaque",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  TextField(
                    controller: bpmController,
                    readOnly: true,
                    style: TextStyle(
                        color: TColor.primaryColor1.withOpacity(0.8),
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                    decoration: const InputDecoration(
                      border: InputBorder
                          .none, // Ajoutez cette ligne pour supprimer la bordure
                    ),
                  ),
                ],
              ),
            ),
            LineChart(
              LineChartData(
                showingTooltipIndicators: showingTooltipOnSpots.map((index) {
                  return ShowingTooltipIndicators([
                    LineBarSpot(
                      tooltipsOnBar,
                      lineBarsData.indexOf(tooltipsOnBar),
                      tooltipsOnBar.spots[index],
                    ),
                  ]);
                }).toList(),
                lineTouchData: LineTouchData(
                  enabled: true,
                  handleBuiltInTouches: false,
                  touchCallback:
                      (FlTouchEvent event, LineTouchResponse? response) {
                    if (response == null || response.lineBarSpots == null) {
                      return;
                    }
                    if (event is FlTapUpEvent) {
                      final spotIndex = response.lineBarSpots!.first.spotIndex;
                      showingTooltipOnSpots.clear();
                      setState(() {
                        showingTooltipOnSpots.add(spotIndex);
                      });
                    }
                  },
                  mouseCursorResolver:
                      (FlTouchEvent event, LineTouchResponse? response) {
                    if (response == null || response.lineBarSpots == null) {
                      return SystemMouseCursors.basic;
                    }
                    return SystemMouseCursors.click;
                  },
                  getTouchedSpotIndicator:
                      (LineChartBarData barData, List<int> spotIndexes) {
                    return spotIndexes.map((index) {
                      return TouchedSpotIndicatorData(
                        FlLine(
                          color: TColor.secondaryColor1,
                        ),
                        FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) =>
                              FlDotCirclePainter(
                            radius: 3,
                            color: Colors.white,
                            strokeWidth: 3,
                            strokeColor: TColor.secondaryColor1,
                          ),
                        ),
                      );
                    }).toList();
                  },
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: TColor.secondaryColor1,
                    tooltipRoundedRadius: 20,
                    getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                      return lineBarsSpot.map((lineBarSpot) {
                        bpmController.text = "${lineBarSpot.y} BPM";
                        return LineTooltipItem(
                          "Seconde ${lineBarSpot.x.toInt() / 10}",
                          const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
                lineBarsData: lineBarsData,
                minY: 50,
                maxY: 250,
                titlesData: const FlTitlesData(
                  show: false,
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
