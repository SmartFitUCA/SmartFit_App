import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/graph/data_for_graph/func_bpm_by_time.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/data_home_view.dart';

class MobileGraphAltitudeByTime extends StatefulWidget {
  final Size media;
  final DataHomeView data;
  final FuncBpmByTime func;

  const MobileGraphAltitudeByTime(this.media, this.data, this.func, {Key? key})
      : super(key: key);

  @override
  State<MobileGraphAltitudeByTime> createState() =>
      _MobileGraphAltitudeByTime();
}

class _MobileGraphAltitudeByTime extends State<MobileGraphAltitudeByTime> {
  @override
  Widget build(BuildContext context) {
    final double maxY = context
            .watch<User>()
            .managerSelectedActivity
            .activitySelected
            .first
            .activityInfo
            .altitudeMax +
        2;
    final double minY = context
            .watch<User>()
            .managerSelectedActivity
            .activitySelected
            .first
            .activityInfo
            .altitudeMin -
        2;

    final lineBarsData = [
      LineChartBarData(
          spots: widget.data.altitudeSeconde,
          isCurved: false,
          gradient: LinearGradient(
            colors: TColor.primaryG,
          ),
          dotData: const FlDotData(show: false))
    ];

    return Container(
        padding: const EdgeInsets.only(left: 15),
        height: widget.media.width * 0.3,
        width: double.maxFinite,
        child: LineChart(LineChartData(
            lineBarsData: lineBarsData,
            borderData: FlBorderData(show: false),
            maxY: maxY,
            minY: minY,
            gridData: FlGridData(
                drawVerticalLine: false,
                drawHorizontalLine: true,
                horizontalInterval: (maxY - minY) / 5,
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
                reservedSize: 60,
                showTitles: true,
                getTitlesWidget: (value, meta) {
                   return Text("${double.parse(value.toStringAsFixed(2))} m",
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
