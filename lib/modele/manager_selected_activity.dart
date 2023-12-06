import 'package:fl_chart/fl_chart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartfit_app_mobile/common_widget/graph/graph.dart';
import 'package:smartfit_app_mobile/modele/activity.dart';
import 'package:smartfit_app_mobile/modele/manager_file.dart';
import 'package:latlong2/latlong.dart' as osm;

class ManagerSelectedActivity {
  final ManagerFile _managerFile = ManagerFile();
  List<ActivityOfUser> activitySelected = List.empty(growable: true);

  bool addSelectedActivity(ActivityOfUser activityOfUser) {
    if (activitySelected.isNotEmpty &&
        activityOfUser.category != activitySelected.first.category) {
      return false;
    }
    activitySelected.add(activityOfUser);
    return true;
  }

  bool removeSelectedActivity(String fileUuid) {
    for (ActivityOfUser activityOfUser in activitySelected) {
      if (activityOfUser.fileUuid == fileUuid) {
        activitySelected.remove(activityOfUser);
        return true;
      }
    }
    return false;
  }

  // ---- Function utile ---- //
  // -- func utile -- //
  bool fileNotSelected(String fileUuid) {
    for (ActivityOfUser activityOfUser in activitySelected) {
      if (activityOfUser.fileUuid == fileUuid) {
        return false;
      }
    }
    return true;
  }

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

    for (int c = 0; c < activitySelected.length; c++) {
      for (int i = 0; i < activitySelected[c].contentActivity.length; i++) {
        if (_notNull(c, i, activitySelected[c].enteteCSV["Value_$field"]!)) {
          if (firstTimestamp == 0) {
            firstTimestamp = activitySelected[c].contentActivity[i][
                activitySelected[c]
                    .enteteCSV["Value_${_managerFile.fieldTimeStamp}"]!];
          }
          result.add(FlSpot(
              (((activitySelected[c].contentActivity[i][
                              activitySelected[c].enteteCSV[
                                  "Value_${_managerFile.fieldTimeStamp}"]!]) -
                          firstTimestamp) ~/
                      100)
                  .toDouble(),
              activitySelected[c]
                  .contentActivity[i]
                      [activitySelected[c].enteteCSV["Value_$field"]!]
                  .toDouble()));
        }
      }
    }
    return result;
  }

//-------------------------------------------------------------------------------------------//

// -----------------  BPM ------------------ //
  int getBpmMaxAllActivitieSelected() {
    int max = 0;
    for (ActivityOfUser activityOfUser in activitySelected) {
      if (activityOfUser.activityInfo.bpmMax > max) {
        max = activityOfUser.activityInfo.bpmMax;
      }
    }
    return max;
  }

  int getBpmMinAllActivitieSelected() {
    int min = 999;
    for (ActivityOfUser activityOfUser in activitySelected) {
      if (activityOfUser.activityInfo.bpmMax < min) {
        min = activityOfUser.activityInfo.bpmMin;
      }
    }
    return min;
  }

  int getBpmAvgAllActivitieSelected() {
    int somme = 0;
    for (ActivityOfUser activityOfUser in activitySelected) {
      somme += activityOfUser.activityInfo.bpmAvg;
    }
    return somme ~/ activitySelected.length;
  }

  // ------------------ Fin BPM ------------------- //
  // ------------------ Altitude ------------------ //
  double getMaxAltitudeAllActivitySelected() {
    double max = 0.0;
    for (ActivityOfUser activityOfUser in activitySelected) {
      if (activityOfUser.activityInfo.altitudeMax > max) {
        max = activityOfUser.activityInfo.altitudeMax;
      }
    }
    return max;
  }

  double getMinAltitudeAllActivitySelected() {
    double min = 99999.0;
    for (ActivityOfUser activityOfUser in activitySelected) {
      if (activityOfUser.activityInfo.altitudeMax < min) {
        min = activityOfUser.activityInfo.altitudeMin;
      }
    }
    return min;
  }

  double getAvgAltitudeAllActivitySelected() {
    double somme = 0;
    for (ActivityOfUser activityOfUser in activitySelected) {
      somme += activityOfUser.activityInfo.altitudeAvg;
    }
    return somme / activitySelected.length;
  }
  // ------------------ Fin Altitude ------------------- //

  // ------------------ Température -------------------- //
  int getAvgTemperatureAllActivitySelected() {
    int somme = 0;
    for (ActivityOfUser activityOfUser in activitySelected) {
      somme += activityOfUser.activityInfo.temperatureAvg;
    }
    return somme ~/ activitySelected.length;
  }

  int getMaxTemperatureAllActivitySelected() {
    int max = 0;
    for (ActivityOfUser activityOfUser in activitySelected) {
      if (activityOfUser.activityInfo.temperatureMax > max) {
        max = activityOfUser.activityInfo.temperatureMax;
      }
    }
    return max;
  }

  int getMinTemperatureAllActivitySelected() {
    int min = 0;
    for (ActivityOfUser activityOfUser in activitySelected) {
      if (activityOfUser.activityInfo.temperatureMin > min) {
        min = activityOfUser.activityInfo.temperatureMin;
      }
    }
    return min;
  }
  // -------------------------- FIN Température ---------------------- //

  // ---------------------- Distance ---------------------- //

  double getDistanceAllActivitySelected() {
    double somme = 0;
    for (ActivityOfUser activityOfUser in activitySelected) {
      somme += activityOfUser.activityInfo.distance;
    }
    return somme;
  }

  // ---------------------- FIN Distance ---------------------- //

  // ---------------------- Calories ---------------------- //
  int getCalorieAllActivitySelected() {
    int somme = 0;
    for (ActivityOfUser activityOfUser in activitySelected) {
      somme += activityOfUser.activityInfo.calories;
    }
    return somme;
  }

  // ---------------------- FIN Calories ---------------------- //
  // ---------------------- Step ------------------------------//

  int getStepsAllActivitySelected() {
    int somme = 0;
    for (ActivityOfUser activityOfUser in activitySelected) {
      somme += activityOfUser.activityInfo.steps;
    }
    return somme;
  }
  // ----------------------- FIN Step ------------------------ //

  // ------------------------- Time ----------------------------- //

  double getTimeAllActivitySelected() {
    double somme = 0;
    for (ActivityOfUser activityOfUser in activitySelected) {
      somme += activityOfUser.activityInfo.timeOfActivity;
    }
    return somme;
  }
  // ---------------------------- FIN time -------------------- //

  // -------------------------- Speed  ---------------------- //

  // -- CSV -- //
  List<DataPoint> getSpeedWithTimeActivity() {
    List<DataPoint> result = List.empty(growable: true);
    int firstTimestamp = 0;

    for (int c = 0; c < activitySelected.length; c++) {
      for (int i = 0; i < activitySelected[c].contentActivity.length; i++) {
        if (_notNull(
                c,
                i,
                activitySelected[c]
                    .enteteCSV["Value_${_managerFile.fieldTimeStamp}"]!) &&
            _notNull(
                c,
                i,
                activitySelected[c]
                    .enteteCSV["Value_${_managerFile.fieldSpeed}"]!)) {
          if (firstTimestamp == 0) {
            firstTimestamp = activitySelected[c].contentActivity[i][
                activitySelected[c]
                    .enteteCSV["Value_${_managerFile.fieldTimeStamp}"]!];
          }
          result.add(DataPoint(
              (((activitySelected[c].contentActivity[i][
                              activitySelected[c].enteteCSV[
                                  "Value_${_managerFile.fieldTimeStamp}"]!]) -
                          firstTimestamp) ~/
                      100)
                  .toDouble(),
              activitySelected[c]
                  .contentActivity[i][activitySelected[c]
                      .enteteCSV["Value_${_managerFile.fieldSpeed}"]!]
                  .toDouble()));
        }
      }
    }
    return result;
  }

  double getMaxSpeedAllActivitySelected() {
    double max = 0.00;
    for (ActivityOfUser activityOfUser in activitySelected) {
      if (activityOfUser.activityInfo.vitesseMax > max) {
        max = activityOfUser.activityInfo.vitesseMax;
      }
    }
    return max;
  }

  double getMinSpeedAllActivitySelected() {
    double min = 99999.9;
    for (ActivityOfUser activityOfUser in activitySelected) {
      if (activityOfUser.activityInfo.vitesseMin < min) {
        min = activityOfUser.activityInfo.vitesseMin;
      }
    }
    return min;
  }

  double getAvgSpeedAllActivitySelected() {
    double somme = 0.0;
    for (ActivityOfUser activityOfUser in activitySelected) {
      somme += activityOfUser.activityInfo.vitesseAvg;
    }
    return somme / activitySelected.length;
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

  List<osm.LatLng> getPositionOSM() {
    List<osm.LatLng> list = List.empty(growable: true);

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
        list.add(osm.LatLng(
            activitySelected[0].contentActivity[i][activitySelected[0]
                .enteteCSV["Value_${_managerFile.fieldPositionLatitude}"]!],
            activitySelected[0].contentActivity[i][activitySelected[0]
                .enteteCSV["Value_${_managerFile.fieldPositionLongitude}"]!]));
      }
    }
    return list;
  }
}
