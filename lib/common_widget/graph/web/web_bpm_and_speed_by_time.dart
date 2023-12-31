import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/graph/data_for_graph/func_bpm_and_speed_by_time.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/data_home_view.dart';

class WebGraphBpmAndSpeedByTime extends StatefulWidget {
  final Size media;
  final DataHomeView data;
  final FuncBpmAndSpeedByTime func;

  const WebGraphBpmAndSpeedByTime(this.media, this.data, this.func, {Key? key})
      : super(key: key);

  @override
  State<WebGraphBpmAndSpeedByTime> createState() =>
      _WebGraphBpmAndSpeedByTime();
}

class _WebGraphBpmAndSpeedByTime extends State<WebGraphBpmAndSpeedByTime> {
  TextEditingController bpmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double maxY = widget.data.maxBPM + 2;
    final double minY = widget.data.minBPM - 2;
     final double maxX =
        widget.data.bpmSecondes[widget.data.bpmSecondes.length - 1].x;
    const double minX = 0.0;
    return Container(
        padding: const EdgeInsets.only(left: 15),
        height: widget.media.width * 0.20,
        width: widget.media.width * 0.35,
        child: LineChart(
          LineChartData(
            showingTooltipIndicators:
                widget.func.showingTooltipOnSpots.map((index) {
              return ShowingTooltipIndicators([
                LineBarSpot(
                  widget.func.tooltipsOnBar,
                  widget.func.lineBarsData.indexOf(widget.func.tooltipsOnBar),
                  widget.func.tooltipsOnBar.spots[index],
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
                  widget.func.showingTooltipOnSpots.clear();
                  setState(() {
                    widget.func.showingTooltipOnSpots.add(spotIndex);
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
            lineBarsData: widget.func.lineBarsData1,
            minY: -10,
            maxY: 110,
            titlesData: FlTitlesData(
                show: true,
                leftTitles: AxisTitles(
                  sideTitles: widget.func.leftTitles,
                ),
                topTitles: const AxisTitles(),
                bottomTitles:AxisTitles(
                  sideTitles: widget.func.bottomTitles,
                ),
                rightTitles: AxisTitles(
                  sideTitles: widget.func.rightTitles,
                ),),
            gridData: FlGridData(
                drawVerticalLine: true,
                drawHorizontalLine: true,
                horizontalInterval: (maxY - minY) / 5,
                verticalInterval: (maxX - minX) / 5 ,
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
