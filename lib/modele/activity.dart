import 'package:fl_chart/fl_chart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartfit_app_mobile/common_widget/graph/graph.dart';

class ActivityOfUser {
  // A afficher
  late String _categorie;
  late String _date;
  late String _fileUuid;
  late String _nameFile;
  // ------------ //
  late String _imageName;
  late List<dynamic> _contentActivity;
  late int _dataSession;

  // -- Getter/Setter -- //
  List<dynamic> get contentActivity => _contentActivity;
  set contentActivity(List<dynamic> content) {
    _contentActivity = content;
    _dataSession = getDataSession();
  }

  String get fileUuid => _fileUuid;
  String get nameFile => _nameFile;

  ActivityOfUser(
      String date, String categorie, String fileUuid, String nameFile) {
    _categorie = categorie;
    _date = date;
    _fileUuid = fileUuid;
    _nameFile = nameFile;

    // Mettre dans une fonction appart
    if (categorie == "Walking") {
      _imageName = "assets/img/workout1.svg";
    } else {
      // Mettre des conditions pour d'autre type d'activité
      _imageName = "assets/img/workout1.svg";
    }
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

  // -----------------  BPM ------------------ //
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

  int getMaxBpm() {
    for (int i = 0; i < _contentActivity[_dataSession].length; i++) {
      if (_contentActivity[_dataSession][i] == "max_heart_rate") {
        return _contentActivity[_dataSession][i + 1];
      }
    }
    return 0;
  }

  int getMinBpm() {
    for (int i = 0; i < _contentActivity[_dataSession].length; i++) {
      if (_contentActivity[_dataSession][i] == "min_heart_rate") {
        return _contentActivity[_dataSession][i + 1];
      }
    }
    return 0;
  }

  int getAvgBpm() {
    for (int i = 0; i < _contentActivity[_dataSession].length; i++) {
      if (_contentActivity[_dataSession][i] == "avg_heart_rate") {
        return _contentActivity[_dataSession][i + 1];
      }
    }
    return 0;
  }
  // -------------------------- FIN BPM ---------------------- //

  // ---------------------- Distance ---------------------- //
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

  String getTotalDistance() {
    for (int i = 0; i < _contentActivity[_dataSession].length; i++) {
      if (_contentActivity[_dataSession][i] == "total_distance") {
        return _contentActivity[_dataSession][i + 1].toString();
      }
    }
    return "null";
  }

  // ---------------------- FIN Distance ---------------------- //

  // ---------------------- Calories ---------------------- //
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

  String getTotalCalorie() {
    for (int i = 0; i < _contentActivity[_dataSession].length; i++) {
      if (_contentActivity[_dataSession][i] == "total_calories") {
        return _contentActivity[_dataSession][i + 1].toString();
      }
    }
    return "null";
  }

  // ---------------------- FIN Calories ---------------------- //

  // ---------------------- Step ------------------------------//
  String getTotalSteps() {
    for (int i = 0; i < _contentActivity[_dataSession].length; i++) {
      if (_contentActivity[_dataSession][i] == "total_strides") {
        return _contentActivity[_dataSession][i + 1].toString();
      }
    }
    return "null";
  }
  // ----------------------- FIN Step ------------------------ //

  // ------------------------- Time ----------------------------- //
  String getTotalTime() {
    for (int i = 0; i < _contentActivity[_dataSession].length; i++) {
      if (_contentActivity[_dataSession][i] == "total_elapsed_time") {
        return _contentActivity[_dataSession][i + 1].toString();
      }
    }
    return "null";
  }
  // ---------------------------- FIN time -------------------- //

  // ---------------------------------------- Altitude -------------------- //
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

  double getMaxAltitude() {
    for (int i = 4; i < _contentActivity[_dataSession].length; i++) {
      if (_contentActivity[_dataSession][i] == "max_altitude") {
        return _contentActivity[_dataSession][i + 1];
      }
    }
    return 0.0;
  }

  double getMinAltitude() {
    for (int i = 4; i < _contentActivity[_dataSession].length; i++) {
      if (_contentActivity[_dataSession][i] == "min_altitude") {
        return _contentActivity[_dataSession][i + 1];
      }
    }
    return 0.0;
  }
  // -------------------------- FIN altitude ---------------------- //

  // -------------------------- Speed  ---------------------- //

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

  double getMaxSpeed() {
    for (int i = 4; i < _contentActivity[_dataSession].length; i++) {
      if (_contentActivity[_dataSession][i] == "max_speed") {
        return _contentActivity[_dataSession][i + 1];
      }
    }
    return 0.0;
  }

  double getAvgSpeed() {
    for (int i = 4; i < _contentActivity[_dataSession].length; i++) {
      if (_contentActivity[_dataSession][i] == "avg_speed") {
        return _contentActivity[_dataSession][i + 1];
      }
    }
    return 0.0;
  }

  // -------------------------- FIN Speed  ---------------------- //

  // -------------------------- Localisation ------------------- //

  List<LatLng> getPosition() {
    List<LatLng> list = List.empty(growable: true);

    for (List<dynamic> ligne in _contentActivity) {
      if (ligne[0] == "Data" && ligne[6] == "position_lat") {
        list.add(LatLng(ligne[7], ligne[10]));
      }
    }
    return list;
  }

  // -------------------------- FIN Localisation  ---------------------- //

  Map<String, dynamic> toMap() {
    return {'categorie': _categorie, 'image': _imageName, 'date': _date};
  }
}
