import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/data_home_view.dart';

class FuncBpmByTime {
  final DataHomeView data;

  FuncBpmByTime(this.data);


  SideTitles get rightTitles => SideTitles(
        getTitlesWidget: rightTitleWidgets,
        showTitles: true,
        interval: 20,
        reservedSize: 40,
      );

  SideTitles get bottomTitles => SideTitles(
        getTitlesWidget: bottomTitleWidgets,
        showTitles: true,
        interval: 20,
        reservedSize: 20,
      );



  Widget rightTitleWidgets(double value, TitleMeta meta) {
    int minBpm = data.minBPM;
    int maxBpm = data.maxBPM;
    double interval = (maxBpm-minBpm)/ 5;

    print(value.toString()+ "tessst");
    String text;
    switch (value.toInt()) {
      case 0:
        text = (minBpm).toStringAsFixed(2)+" BPM";
        break;
      case 20:
        text = (minBpm+interval).toStringAsFixed(2)+" BPM";
        break;
      case 40:
        text = (minBpm+interval*2).toStringAsFixed(2)+" BPM";
        break;
      case 60:
        text = (minBpm+interval*3).toStringAsFixed(2)+" BPM";
        break;
      case 80:
        text = (minBpm+interval*4).toStringAsFixed(2)+" BPM";
        break;
      case 100:
        text = (maxBpm).toStringAsFixed(2)+" BPM";
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
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    double interval = data.time/ 5;
    String text;
    switch (value) {
      case 0:
        text = '0 s';
        break;
      case 20:
        text = (interval).toStringAsFixed(2)+" s";
        break;
      case 40:
        text = (interval*2).toStringAsFixed(2)+" s";
        break;
      case 60:
        text = (interval*3).toStringAsFixed(2)+" s";
        break;
      case 80:
        text = (interval*4).toStringAsFixed(2)+" s";
        break;
      case 100:
        text = (interval*5).toStringAsFixed(2)+" s";
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

 


}
