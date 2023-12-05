import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/graph/data_for_graph/func_bpm_by_time.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/data_home_view.dart';

class WebBpmByTime extends StatefulWidget {
  final Size media;
  final DataHomeView data;
  final FuncBpmByTime func;

  const WebBpmByTime(this.media, this.data, this.func, {Key? key})
      : super(key: key);

  @override
  State<WebBpmByTime> createState() => _WebBpmByTime();
}

class _WebBpmByTime extends State<WebBpmByTime> {
  @override
  Widget build(BuildContext context) {
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
        height: widget.media.width * 0.20,
        width: widget.media.width * 0.35,
        child: LineChart(LineChartData(
            lineBarsData: lineBarsData,
            minY: widget.data.minBPM.toDouble() * 0.95,
            borderData: FlBorderData(show: false),
            gridData: FlGridData(
                drawVerticalLine: true,
                drawHorizontalLine: true,
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
