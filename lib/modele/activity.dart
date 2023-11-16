import 'package:fl_chart/fl_chart.dart';
import 'package:smartfit_app_mobile/common_widget/graph/graph.dart';

class ActivityOfUser {
  late String _nomActivite;
  late String _imageName;
  late List<dynamic> _contentActivity;
  late int _dataSession;

  List<dynamic> get contentActivity => _contentActivity;

  ActivityOfUser(String nom, List<dynamic> listeDynamic) {
    _nomActivite = nom;
    _imageName = "assets/img/workout1.svg";
    _contentActivity = listeDynamic;
    _dataSession = getDataSession();
  }

  // ----- Retourne l'indice de la ligne qui contient les données de la session -- //
  int getDataSession() {
    for (int i = _contentActivity.length - 1; i != 0; i--) {
      if (_contentActivity[i][0] == "Data" &&
          _contentActivity[i][2] == "session") {
        return i;
      }
    }
    return 0;
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

  List<FlSpot> getCalories() {
    List<FlSpot> result = List.empty(growable: true);
    int firtTimeStamp = 0;
    for (List<dynamic> ligne in _contentActivity) {
      if (ligne.length >= 39 &&
          ligne[0] == "Data" &&
          ligne[39] == "total_calories") {
        if (firtTimeStamp == 0) {
          firtTimeStamp = ligne[4];
        }
        //result.add([(ligne[4] - firtTimeStamp) ~/ 100, ligne[7].toInt()]);
        result.add(
            FlSpot((ligne[4] - firtTimeStamp) / 100, ligne[40].toDouble()));
      }
    }
    return result;
  }

  String getTotalSteps() {
    for (int i = 0; i < _contentActivity[_dataSession].length; i++) {
      if (_contentActivity[_dataSession][i] == "total_strides") {
        return _contentActivity[_dataSession][i + 1].toString();
      }
    }
    return "null";
  }

  String getTotalCalorie() {
    for (int i = 0; i < _contentActivity[_dataSession].length; i++) {
      if (_contentActivity[_dataSession][i] == "total_calories") {
        return _contentActivity[_dataSession][i + 1].toString();
      }
    }
    return "null";
  }

  String getTotalAvgHeartRate() {
    for (int i = 0; i < _contentActivity[_dataSession].length; i++) {
      if (_contentActivity[_dataSession][i] == "avg_heart_rate") {
        return _contentActivity[_dataSession][i + 1].toString();
      }
    }
    return "null";
  }

  String getTotalTime() {
    for (int i = 0; i < _contentActivity[_dataSession].length; i++) {
      if (_contentActivity[_dataSession][i] == "total_elapsed_time") {
        return _contentActivity[_dataSession][i + 1].toString();
      }
    }
    return "null";
  }

  String getTotalDistance() {
    for (int i = 0; i < _contentActivity[_dataSession].length; i++) {
      if (_contentActivity[_dataSession][i] == "total_distance") {
        return _contentActivity[_dataSession][i + 1].toString();
      }
    }
    return "null";
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

  List<DataPoint> getSpeedWithTimeActivity() {
    List<DataPoint> result = List.empty(growable: true);
    int firtTimeStamp = 0;

    for (List<dynamic> ligne in _contentActivity) {
      if (ligne[0] == "Data" && ligne[1] == 1) {
        if (firtTimeStamp == 0) {
          firtTimeStamp = ligne[4];
        }
        result.add(DataPoint(
          ((ligne[4] - firtTimeStamp) / 100),
          ligne[19].toDouble(),
        ));
      }
      if (ligne[0] == "Data" && ligne[1] == 2) {
        if (firtTimeStamp == 0) {
          firtTimeStamp = ligne[4];
        }
        result.add(DataPoint(
            ((ligne[4] - firtTimeStamp) / 100), ligne[25].toDouble()));
      }
    }
    return result;
  }

  Map<String, dynamic> toMap() {
    return {
      'nomActivite': _nomActivite,
      'image': _imageName,
    };
  }
}
