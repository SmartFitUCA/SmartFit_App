import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/data_home_view.dart';

class WebGraphAltitudeByTime extends StatefulWidget {
  final Size media;
  final DataHomeView data;

  const WebGraphAltitudeByTime(this.media, this.data, {Key? key})
      : super(key: key);

  @override
  State<WebGraphAltitudeByTime> createState() => _WebGraphAltitudeByTime();
}

class _WebGraphAltitudeByTime extends State<WebGraphAltitudeByTime> {
  @override
  Widget build(BuildContext context) {
    final double maxX =
        widget.data.bpmSecondes[widget.data.bpmSecondes.length - 1].x;
    final double minX = 0.0;
    final double maxY =
        context.watch<User>().managerSelectedActivity.getMaxAltitude() + 2;
    final double minY =
        context.watch<User>().managerSelectedActivity.getMinAltitude() - 2;

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
        height: widget.media.width * 0.20,
        width: widget.media.width * 0.35,
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
                reservedSize: 60,
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text("${double.parse(value.toStringAsFixed(2))} m");
                },
              )),
            ))));
  }
}
