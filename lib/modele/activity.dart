import 'package:fl_chart/fl_chart.dart';

class ActivityOfUser {
  final String _type = "Default";

  late List<dynamic> _contentActivity;

  List<dynamic> get contentActivity => _contentActivity;

  ActivityOfUser(List<dynamic> listeDynamic) {
    _contentActivity = listeDynamic;
  }

  List<FlSpot> getHeartRateWithTime() {
    List<FlSpot> result = List.empty(growable: true);
    int firtTimeStamp = 0;

    for (List<dynamic> ligne in _contentActivity) {
      if (ligne[0] == "Data") {
        if (ligne.length >= 10 && ligne[9] == "heart_rate") {
          if (firtTimeStamp == 0) {
            firtTimeStamp = ligne[4];
          }
          //result.add([(ligne[4] - firtTimeStamp) ~/ 100, ligne[10]]);
          result.add(
              FlSpot((ligne[4] - firtTimeStamp) / 100, ligne[10].toDouble()));
        } else if (ligne.length >= 16 && ligne[15] == "heart_rate") {
          if (firtTimeStamp == 0) {
            firtTimeStamp = ligne[4];
          }
          //result.add([(ligne[4] - firtTimeStamp) ~/ 100, ligne[17]]);
          result.add(
              FlSpot((ligne[4] - firtTimeStamp) / 100, ligne[16].toDouble()));
        }
      }
    }
    return result;
  }

  List<FlSpot> getDistanceWithTime() {
    List<FlSpot> result = List.empty(growable: true);
    int firtTimeStamp = 0;

    for (List<dynamic> ligne in _contentActivity) {
      if (ligne.length >= 8 && ligne[0] == "Data" && ligne[6] == "distance") {
        if (firtTimeStamp == 0) {
          firtTimeStamp = ligne[4];
        }
        //result.add([(ligne[4] - firtTimeStamp) ~/ 100, ligne[7].toInt()]);
        result
            .add(FlSpot((ligne[4] - firtTimeStamp) / 100, ligne[7].toDouble()));
      }
    }
    return result;
  }

  List<FlSpot> getAltitudeWithTime() {
    List<FlSpot> result = List.empty(growable: true);
    int firtTimeStamp = 0;

    for (List<dynamic> ligne in _contentActivity) {
      if (ligne.length >= 14 && ligne[0] == "Data" && ligne[12] == "altitude") {
        if (firtTimeStamp == 0) {
          firtTimeStamp = ligne[4];
        }
        //result.add([(ligne[4] - firtTimeStamp) ~/ 100, ligne[13].toInt()]);
        result.add(
            FlSpot((ligne[4] - firtTimeStamp) / 100, ligne[13].toDouble()));
      }
    }
    return result;
  }

  double getDistance() {
    double result = 0.0;
    for (int i = _contentActivity.length - 1; i >= 0; i--) {
      if (_contentActivity[i].length >= 8 &&
          _contentActivity[i][0] == "Data" &&
          _contentActivity[i][6] == "distance") {
        if (_contentActivity[i][7] > result) {
          result = _contentActivity[i][7].toDouble();
        }
      }
    }
    return result;
  }

  List<FlSpot> getSpeedWithTime() {
    List<FlSpot> result = List.empty(growable: true);
    int firtTimeStamp = 0;

    for (List<dynamic> ligne in _contentActivity) {
      if (ligne[0] == "Data" && ligne[1] == 1) {
        if (firtTimeStamp == 0) {
          firtTimeStamp = ligne[4];
        }
        result.add(
            FlSpot((ligne[4] - firtTimeStamp) / 100, ligne[19].toDouble()));
      }
      if (ligne[0] == "Data" && ligne[1] == 2) {
        if (firtTimeStamp == 0) {
          firtTimeStamp = ligne[4];
        }
        result.add(
            FlSpot((ligne[4] - firtTimeStamp) / 100, ligne[25].toDouble()));
      }
    }
    return result;
  }
}
