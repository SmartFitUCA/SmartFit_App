import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/graph/data_for_graph/func_bpm_by_time.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/data_home_view.dart';

class MobileBpmByTime extends StatefulWidget {
  final Size media;
  final DataHomeView data;
  final FuncBpmByTime func;

  const MobileBpmByTime(this.media, this.data,this.func,  {Key? key}) : super(key: key);

  @override
  State<MobileBpmByTime> createState() => _MobileBpmByTime();
}

class _MobileBpmByTime extends State<MobileBpmByTime> {
  @override
  Widget build(BuildContext context) {
    final double maxY = widget.data.maxBPM + 2;
    final double minY = widget.data.minBPM - 2;
    final double maxX =
        widget.data.bpmSecondes[widget.data.bpmSecondes.length - 1].x;
    const double minX = 0.0;
    final lineBarsData = [
      LineChartBarData(
          spots: widget.data.bpmSecondes,
          isCurved: true,
          gradient: LinearGradient(
            colors: TColor.primaryG,
          ),
          dotData: const FlDotData(show: false))
    ];

    return Container(
        padding: const EdgeInsets.only(left: 15),
        height: widget.media.width * 0.4,
        width: double.maxFinite,
        child: LineChart(LineChartData(
            lineBarsData: lineBarsData,
            borderData: FlBorderData(show: false),
            maxY: maxY,
            minY: minY,
            maxX: maxX,
            minX: minX,
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
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(),
              topTitles: const AxisTitles(),
              bottomTitles: AxisTitles(
                sideTitles: widget.func.bottomTitles,
              ),
              rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                reservedSize: 70,
                showTitles: true,
                getTitlesWidget: (value, meta) {
                   return Text("${double.parse(value.toStringAsFixed(2))} BPM",
                      style: TextStyle(
                        color: TColor.gray,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center);
                },
              )),
            ))));
  }
}
