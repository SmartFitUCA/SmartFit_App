import 'package:fl_chart/fl_chart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartfit_app_mobile/common_widget/graph/graph.dart';
import 'package:smartfit_app_mobile/modele/activity.dart';
import 'package:smartfit_app_mobile/modele/manager_file.dart';

class ManagerSelectedActivity {
  final ManagerFile _managerFile = ManagerFile();
  List<ActivityOfUser> activitySelected = List.empty(growable: true);

  bool addSelectedActivity(ActivityOfUser activityOfUser) {
    // Chercher le contenu du fichier
    // Regarder si l'entete est la même
    // Supprimer l'entete
    return true;
  }

  // ---- Function utile ---- //
  // -- func utile -- //
  bool _notNull(int indexActivitySelected, int ligne, int colonne) {
    if (activitySelected[indexActivitySelected].contentActivity[ligne]
            [colonne] ==
        "null") {
      return false;
    }
    return true;
  }
  // ------------------- Fonction pour calcul --------- //
  // ----------------- X WithTime ------------ //

  List<FlSpot> getXWithTime(String field) {
    List<FlSpot> result = List.empty(growable: true);

    int firstTimestamp = 0;

    for (int i = 0; i < activity.contentActivity.length; i++) {
      if (_notNull(
          activity.contentActivity, i, activity.enteteCSV["Value_$field"]!)) {
        if (firstTimestamp == 0) {
          firstTimestamp = activity.contentActivity[i]
              [activity.enteteCSV["Value_${_managerFile.fieldTimeStamp}"]!];
        }
        result.add(FlSpot(
            (((activity.contentActivity[i][activity.enteteCSV[
                            "Value_${_managerFile.fieldTimeStamp}"]!]) -
                        firstTimestamp) ~/
                    100)
                .toDouble(),
            activity.contentActivity[i][activity.enteteCSV["Value_$field"]!]
                .toDouble()));
      }
    }
    return result;
  }

// -----------------  BPM ------------------ //

  // Retourne le BPM Max (Fichier CSV)
  int getMaxBpm() {
    int max = 0;
    for (int i = 0; i < activity.contentActivity.length; i++) {
      if (_notNull(activity.contentActivity, i,
          activity.enteteCSV["Value_${_managerFile.fielBPM}"]!)) {
        int valueTmp = activity.contentActivity[i]
            [activity.enteteCSV["Value_${_managerFile.fielBPM}"]!];
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
    for (int i = 0; i < activity.contentActivity.length; i++) {
      if (_notNull(activity.contentActivity, i,
          activity.enteteCSV["Value_${_managerFile.fielBPM}"]!)) {
        int valueTmp = activity.contentActivity[i]
            [activity.enteteCSV["Value_${_managerFile.fielBPM}"]!];
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
      if (_notNull(
          contentActivity, i, enteteCSV["Value_${_managerFile.fielBPM}"]!)) {
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
      if (_notNull(contentActivity, i,
          enteteCSV["Value_${_managerFile.fieldDistance}"]!)) {
        double valueTmp = contentActivity[i]
                [enteteCSV["Value_${_managerFile.fieldDistance}"]!]
            .toDouble();
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
      if (_notNull(contentActivity, i,
          enteteCSV["Value_${_managerFile.fieldTotalCalories}"]!)) {
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
      if (_notNull(contentActivity, i,
          enteteCSV["Value_${_managerFile.fieldTotalStep}"]!)) {
        return contentActivity[i]
                [enteteCSV["Value_${_managerFile.fieldTotalStep}"]!]
            .toInt();
      }
    }
    return 0;
  }
  // ----------------------- FIN Step ------------------------ //

  // ------------------------- Time ----------------------------- //

  int getTotalTime() {
    for (int i = contentActivity.length - 1; i != 0; i--) {
      if (_notNull(contentActivity, i,
          enteteCSV["Value_${_managerFile.fieldTimeStamp}"]!)) {
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
      if (_notNull(contentActivity, i,
          enteteCSV["Value_${_managerFile.fieldAltitude}"]!)) {
        double valueTmp = contentActivity[i]
                [enteteCSV["Value_${_managerFile.fieldAltitude}"]!]
            .toDouble();
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
      if (_notNull(contentActivity, i,
          enteteCSV["Value_${_managerFile.fieldAltitude}"]!)) {
        double valueTmp = contentActivity[i]
                [enteteCSV["Value_${_managerFile.fieldAltitude}"]!]
            .toDouble();
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
      if (_notNull(contentActivity, i,
              enteteCSV["Value_${_managerFile.fieldTimeStamp}"]!) &&
          notNull(contentActivity, i,
              enteteCSV["Value_${_managerFile.fieldSpeed}"]!)) {
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
            contentActivity[i][enteteCSV["Value_${_managerFile.fieldSpeed}"]!]
                .toDouble()));
      }
    }
    return result;
  }

  // Retourne la Speed Max (Fichier CSV)
  double getMaxSpeed() {
    double max = 0.00;
    for (int i = 0; i < contentActivity.length; i++) {
      if (_notNull(
          contentActivity, i, enteteCSV["Value_${_managerFile.fieldSpeed}"]!)) {
        double valueTmp = contentActivity[i]
                [enteteCSV["Value_${_managerFile.fieldSpeed}"]!]
            .toDouble();
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
      if (_notNull(
          contentActivity, i, enteteCSV["Value_${_managerFile.fieldSpeed}"]!)) {
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
  // Utilisable que si qu'une seule activité à été utilisé !!!
  List<LatLng> getPosition() {
    List<LatLng> list = List.empty(growable: true);

    for (int i = 0; i < activitySelected[0].contentActivity.length; i++) {
      if (_notNull(
              0,
              i,
              activitySelected[0]
                  .enteteCSV["Value_${_managerFile.fieldPositionLatitude}"]!) &&
          _notNull(
              0,
              i,
              activitySelected[0].enteteCSV[
                  "Value_${_managerFile.fieldPositionLongitude}"]!)) {
        list.add(LatLng(
            activitySelected[0].contentActivity[i][activitySelected[0]
                .enteteCSV["Value_${_managerFile.fieldPositionLatitude}"]!],
            activitySelected[0].contentActivity[i][activitySelected[0]
                .enteteCSV["Value_${_managerFile.fieldPositionLongitude}"]!]));
      }
    }
    return list;
  }
}
