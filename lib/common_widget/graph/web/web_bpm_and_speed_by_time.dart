import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/data_home_view.dart';

class WebGraphBpmAndSpeedByTime extends StatefulWidget {
  final Size media;
  final DataHomeView data;

  const WebGraphBpmAndSpeedByTime(this.media, this.data, {Key? key})
      : super(key: key);

  @override
  State<WebGraphBpmAndSpeedByTime> createState() =>
      _WebGraphBpmAndSpeedByTime();
}

class _WebGraphBpmAndSpeedByTime extends State<WebGraphBpmAndSpeedByTime> {
  TextEditingController bpmController = TextEditingController();

  List<int> showingTooltipOnSpots = [0];

  SideTitles get rightTitles => SideTitles(
        getTitlesWidget: rightTitleWidgets,
        showTitles: true,
        interval: 20,
        reservedSize: 40,
      );

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
    final double maxY =
        context.watch<User>().managerSelectedActivity.getMaxBpm() + 2;
    final double minY =
        context.watch<User>().managerSelectedActivity.getMinBpm() - 2;
    final double maxY1 =
        context.watch<User>().managerSelectedActivity.getMaxBpm() + 2;
    final double minY2 =
        context.watch<User>().managerSelectedActivity.getMinBpm() - 2;
    final double maxX =
        widget.data.bpmSecondes[widget.data.bpmSecondes.length - 1].x;
    final double minX = 0.0;

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

    return Container(
        padding: const EdgeInsets.only(left: 15),
        height: widget.media.width * 0.20,
        width: widget.media.width * 0.35,
        child: LineChart(
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
              touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
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
                    const FlLine(
                      color: Colors.transparent,
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
                    return LineTooltipItem(
                      "Seconde ${lineBarSpot.x.toInt() / 10} ",
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
            lineBarsData: lineBarsData1,
            minY: 0,
            maxY: 110,
            titlesData: FlTitlesData(
                show: true,
                leftTitles: AxisTitles(
                  sideTitles: rightTitles,
                ),
                topTitles: const AxisTitles(),
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                  reservedSize: 20,
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text(
                        "${double.parse((value / 10).toStringAsFixed(2))}s");
                  },
                )),
                rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                  reservedSize: 70,
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text(
                        "${double.parse(value.toStringAsFixed(2))} BPM");
                  },
                ))),
            gridData: FlGridData(
                drawVerticalLine: true,
                drawHorizontalLine: true,
                horizontalInterval: (maxY - minY) / 5,
                verticalInterval: (maxX - minX) / 4,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: TColor.gray.withOpacity(0.15),
                    strokeWidth: 1,
                  );
                }),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
          ),
        ));
  }
}
