import 'package:fl_chart/fl_chart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartfit_app_mobile/common_widget/graph/graph.dart';
import 'package:smartfit_app_mobile/modele/manager_file.dart';

class ActivityOfUser {
  // A afficher
  late String _categorie;
  late String _date;
  late String _fileUuid;
  late String _nameFile;
  // ------------ //
  late String _imageName;
  late List<List<dynamic>> _contentActivity;
  Map<String, int> enteteCSV = {};

  // ManagerFile for the field
  final ManagerFile _managerFile = ManagerFile();

  // -- Getter/Setter -- //
  List<List<dynamic>> get contentActivity => _contentActivity;
  set contentActivity(List<List<dynamic>> content) {
    _contentActivity = content;
    for (int i = 0; i < content.first.length; i++) {
      enteteCSV.addAll({content.first[i]: i});
    }
    _contentActivity.removeAt(0);
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

// -- func utile -- //
  bool notNull(int ligne, int colonne) {
    if (_contentActivity[ligne][colonne] == "null") {
      return false;
    }
    return true;
  }

// ----------------- X WithTime ------------ //

  List<FlSpot> getXWithTime(String field) {
    List<FlSpot> result = List.empty(growable: true);

    int firstTimestamp = 0;

    for (int i = 0; i < contentActivity.length; i++) {
      if (notNull(i, enteteCSV["Value_$field"]!)) {
        if (firstTimestamp == 0) {
          firstTimestamp = contentActivity[i]
              [enteteCSV["Value_${_managerFile.fieldTimeStamp}"]!];
        }
        result.add(FlSpot(
            (((contentActivity[i][enteteCSV[
                            "Value_${_managerFile.fieldTimeStamp}"]!]) -
                        firstTimestamp) ~/
                    100)
                .toDouble(),
            contentActivity[i][enteteCSV["Value_$field"]!].toDouble()));
      }
    }
    return result;
  }

// -----------------  BPM ------------------ //

  // Retourne le BPM Max (Fichier CSV)
  int getMaxBpm() {
    int max = 0;
    for (int i = 0; i < contentActivity.length; i++) {
      if (notNull(i, enteteCSV["Value_${_managerFile.fielBPM}"]!)) {
        int valueTmp =
            contentActivity[i][enteteCSV["Value_${_managerFile.fielBPM}"]!];
        if (valueTmp > max) {
          max = valueTmp;
        }
      }
    }
    return max;
  }

// Retourne le BPM Min (Fichier CSV)
  int getMinBpm() {
    int min = 300;
    for (int i = 0; i < contentActivity.length; i++) {
      if (notNull(i, enteteCSV["Value_${_managerFile.fielBPM}"]!)) {
        int valueTmp =
            contentActivity[i][enteteCSV["Value_${_managerFile.fielBPM}"]!];
        if (valueTmp < min) {
          min = valueTmp;
        }
      }
    }
    return min;
  }

  // Retourne le BPM avg (Fichier CSV)
  int getAvgBpm() {
    int somme = 0;
    int nb = 0;
    for (int i = 0; i < contentActivity.length; i++) {
      if (notNull(i, enteteCSV["Value_${_managerFile.fielBPM}"]!)) {
        somme += contentActivity[i][enteteCSV["Value_${_managerFile.fielBPM}"]!]
            as int;
        nb++;
      }
    }
    return somme ~/ nb;
  }

  // -------------------------- FIN BPM ---------------------- //

  // ---------------------- Distance ---------------------- //

  double getTotalDistance() {
    double max = 0;
    for (int i = contentActivity.length - 1; i != 0; i--) {
      if (notNull(i, enteteCSV["Value_${_managerFile.fieldDistance}"]!)) {
        double valueTmp = contentActivity[i]
            [enteteCSV["Value_${_managerFile.fieldDistance}"]!];
        if (valueTmp > max) {
          max = valueTmp;
        }
      }
    }
    return max;
  }

  // ---------------------- FIN Distance ---------------------- //

  // ---------------------- Calories ---------------------- //
  int getCalorie() {
    for (int i = contentActivity.length - 1; i != 0; i--) {
      if (notNull(i, enteteCSV["Value_${_managerFile.fieldTotalCalories}"]!)) {
        return contentActivity[i]
            [enteteCSV["Value_${_managerFile.fieldTotalCalories}"]!] as int;
      }
    }
    return 0;
  }

  // ---------------------- FIN Calories ---------------------- //

  // ---------------------- Step ------------------------------//

  int getTotalSteps() {
    for (int i = contentActivity.length - 1; i != 0; i--) {
      if (notNull(i, enteteCSV["Value_${_managerFile.fieldTotalStep}"]!)) {
        return contentActivity[i]
            [enteteCSV["Value_${_managerFile.fieldTotalStep}"]!];
      }
    }
    return 0;
  }
  // ----------------------- FIN Step ------------------------ //

  // ------------------------- Time ----------------------------- //

  int getTotalTime() {
    for (int i = contentActivity.length - 1; i != 0; i--) {
      if (notNull(i, enteteCSV["Value_${_managerFile.fieldTimeStamp}"]!)) {
        return contentActivity[i]
            [enteteCSV["Value_${_managerFile.fieldTimeStamp}"]!];
      }
    }
    return 0;
  }
  // ---------------------------- FIN time -------------------- //

  // ---------------------------------------- Altitude -------------------- //

  // --- Fichier CSV --- //
  double getMaxAltitude() {
    double max = 0;
    for (int i = 0; i < contentActivity.length; i++) {
      if (notNull(i, enteteCSV["Value_${_managerFile.fieldAltitude}"]!)) {
        double valueTmp = contentActivity[i]
            [enteteCSV["Value_${_managerFile.fieldAltitude}"]!];
        if (valueTmp > max) {
          max = valueTmp;
        }
      }
    }
    return max;
  }

  // --- Fichier CSV --- //
  double getMinAltitude() {
    double min = 5000;
    for (int i = 0; i < contentActivity.length; i++) {
      if (notNull(i, enteteCSV["Value_${_managerFile.fieldAltitude}"]!)) {
        double valueTmp = contentActivity[i]
            [enteteCSV["Value_${_managerFile.fieldAltitude}"]!];
        if (valueTmp < min) {
          min = valueTmp;
        }
      }
    }
    return min;
  }

  // -------------------------- FIN altitude ---------------------- //

  // -------------------------- Speed  ---------------------- //

  // -- CSV -- //
  List<DataPoint> getSpeedWithTimeActivity() {
    List<DataPoint> result = List.empty(growable: true);
    int firstTimestamp = 0;

    for (int i = 0; i < contentActivity.length; i++) {
      if (notNull(i, enteteCSV["Value_${_managerFile.fieldTimeStamp}"]!) &&
          notNull(i, enteteCSV["Value_${_managerFile.fieldSpeed}"]!)) {
        if (firstTimestamp == 0) {
          firstTimestamp = contentActivity[i]
              [enteteCSV["Value_${_managerFile.fieldTimeStamp}"]!];
        }
        result.add(DataPoint(
            (((contentActivity[i][enteteCSV[
                            "Value_${_managerFile.fieldTimeStamp}"]!]) -
                        firstTimestamp) ~/
                    100)
                .toDouble(),
            contentActivity[i]
                [enteteCSV["Value_${_managerFile.fieldSpeed}"]!]));
      }
    }
    return result;
  }

  // Retourne la Speed Max (Fichier CSV)
  double getMaxSpeed() {
    double max = 0.00;
    for (int i = 0; i < contentActivity.length; i++) {
      if (notNull(i, enteteCSV["Value_${_managerFile.fieldSpeed}"]!)) {
        double valueTmp =
            contentActivity[i][enteteCSV["Value_${_managerFile.fieldSpeed}"]!];
        if (valueTmp > max) {
          max = valueTmp;
        }
      }
    }
    return max;
  }

  // Retourne avg Max (Fichier CSV)
  double getAvgSpeed() {
    double somme = 0;
    int nb = 0;
    for (int i = 0; i < contentActivity.length; i++) {
      if (notNull(i, enteteCSV["Value_${_managerFile.fieldSpeed}"]!)) {
        somme +=
            contentActivity[i][enteteCSV["Value_${_managerFile.fieldSpeed}"]!];
        nb++;
      }
    }
    return somme / nb;
  }

  // -------------------------- FIN Speed  ---------------------- //

  // -------------------------- Localisation ------------------- //

  // Retourne les positions (Fichier CSV)
  List<LatLng> getPosition() {
    List<LatLng> list = List.empty(growable: true);

    for (int i = 0; i < contentActivity.length; i++) {
      if (notNull(
              i, enteteCSV["Value_${_managerFile.fieldPositionLatitude}"]!) &&
          notNull(
              i, enteteCSV["Value_${_managerFile.fieldPositionLongitude}"]!)) {
        list.add(LatLng(
            contentActivity[i]
                [enteteCSV["Value_${_managerFile.fieldPositionLatitude}"]!],
            contentActivity[i]
                [enteteCSV["Value_${_managerFile.fieldPositionLongitude}"]!]));
      }
    }
    return list;
  }

  // -------------------------- FIN Localisation  ---------------------- //

  Map<String, dynamic> toMap() {
    return {'categorie': _categorie, 'image': _imageName, 'date': _date};
  }
}
