import 'dart:convert';

import 'package:smartfit_app_mobile/modele/manager_file.dart';

class ActivityInfo {
  ManagerFile managerFile = ManagerFile();
  ActivityInfo();

  // -- Time -- // Ne pas calculer (Ligne session)
  String startTime = "2000-01-01";
  double timeOfActivity = 0.0;

  // ----------- BPM ------------ //
  int bpmMax = 0;
  int bpmMin = 300;
  int bpmAvg = 0;
  // ----------- Denivelé ------------ //
  double denivelePositif = 0.0;
  double deniveleNegatif = 0.0;
  // ----------- Altitude ------------ //
  double altitudeMax = 0.0;
  double altitudeMin = 30000.0;
  double altitudeAvg = 0.0;

  // ---------------------------------------------------------------------- //

  // -- Fonction pour lire le csv et remplir la classe -- //
  ActivityInfo getData(List<List<String>> csv) {
    // - Entete - //
    Map<String, int> enteteCSV = getEntete(csv.first);
    // ------------- Var tmp ---------- //
    // -- BPM -- //
    int bpmSomme = 0;
    int bpmNb = 0;
    // -- Denivelé -- //
    double lastDenivele = 0.0;
    // -- Altitude -- //
    double altitudeSomme = 0;
    int alititudeNb = 0;

    // --- Boucle -- //
    for (int i = 1; i < csv.length; i++) {
      //
      // ---------------------- BPM ---------------------- //
      if (!isNull(enteteCSV["Value_${managerFile.fielBPM}"]!, csv[i])) {
        int value =
            int.parse(csv[i][enteteCSV["Value_${managerFile.fielBPM}"]!]);
        bpmSomme += value;
        bpmNb += 1;
        if (value > bpmMax) {
          bpmMax = value;
        }
        if (value < bpmMin) {
          bpmMin = value;
        }
      }

      /// ------------------ Denivele et Altitude --------------- //
      if (!isNull(enteteCSV["Value_${managerFile.fieldAltitude}"]!, csv[i])) {
        double value = double.parse(
            csv[i][enteteCSV["Value_${managerFile.fieldAltitude}"]!]);
        // -- Denivelé -- //
        if (value > lastDenivele) {
          denivelePositif += value - lastDenivele;
        } else {
          deniveleNegatif += (value - lastDenivele) * -1;
        }
        lastDenivele = value;
        // -- Altitude -- //
        if (value > altitudeMax) {
          altitudeMax = value;
        }
        if (value < altitudeMin) {
          altitudeMin = value;
        }
        altitudeSomme += value;
        alititudeNb += 1;
      }
    }

    // -- BPM -- //
    bpmAvg = bpmSomme ~/ bpmNb;
    // -- Atitude -- //
    altitudeAvg = altitudeSomme / alititudeNb;
    return this;
  }

  // ------------ Fonction utile ------------------- //
  Map<String, int> getEntete(List<dynamic> content) {
    Map<String, int> enteteCSV = {};
    for (int i = 0; i < content.length; i++) {
      enteteCSV.addAll({content[i]: i});
    }
    return enteteCSV;
  }

  bool isNull(int colonne, List<dynamic> ligne) {
    return ligne[colonne] == "null";
  }

  // ------------- Pour print ----------------- //
  Map<String, dynamic> toMapWalking() {
    return {
      // -- Denivelé -- //
      "DenivelePositif": denivelePositif,
      "DeniveleNegatif": denivelePositif,
      // -- Altitude -- //
      "AltitudeMax": altitudeMax,
      "AltitudeMin": altitudeMin,
      "AltitudeAvg": altitudeAvg
    };
  }

  // ---------------  JSON  --------- //
  // -- Lecture -- //
  ActivityInfo.fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }
    // -- Ligne session -- //
    startTime = map["startTime"];
    timeOfActivity = map["timeOfActivity"].toDouble();
    // -- BPM -- //
    bpmAvg = map["bpmAvg"];
    bpmMax = map["bpmMax"];
    bpmMin = map["bpmMin"];
    // -- Denivelé -- //
    deniveleNegatif = map["deniveleNegatif"].toDouble();
    denivelePositif = map["denivelePositif"].toDouble();
    // -- Altitude -- //
    altitudeMax = map["altitudeMax"].toDouble();
    altitudeMin = map["altitudeMin"].toDouble();
    altitudeAvg = map["altitudeAvg"].toDouble();
  }

  // -- Ecriture -- //
  String toJson() {
    Map<String, dynamic> jsonMap = {
      // -- BPM -- //
      'bpmAvg': bpmAvg,
      'bpmMax': bpmMax,
      'bpmMin': bpmMin,
      // -- Denivelé -- //
      'denivelePositif': denivelePositif,
      'deniveleNegatif': deniveleNegatif,
      // -- Altitude -- //
      'altitudeMax': altitudeMax,
      'altitudeMin': altitudeMin,
      'altitudeAvg': altitudeAvg,
      // Ligne session
      'startTime': startTime,
      'timeOfActivity': timeOfActivity,
    };
    return jsonEncode(jsonMap);
  }
}
