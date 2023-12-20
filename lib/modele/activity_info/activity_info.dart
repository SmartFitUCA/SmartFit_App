import 'dart:convert';

import 'package:smartfit_app_mobile/modele/manager_file.dart';

class ActivityInfo {
  ManagerFile managerFile = ManagerFile();
  ActivityInfo();

  // -- Time -- // Ne pas calculer (Ligne session)
  DateTime startTime = DateTime.now();
  double timeOfActivity = 0.0;
  double distance = 0.0;
  int calories = 0;
  int steps = 0;
  // ----------- BPM ------------ //
  int bpmMax = 0;
  int bpmMin = 300;
  int bpmAvg = 0;
  bool bpmNotZero = false;
  // ----------- Denivelé ------------ //
  double denivelePositif = 0.0;
  double deniveleNegatif = 0.0;
  // ----------- Altitude ------------ //
  double altitudeMax = 0.0;
  double altitudeMin = 30000.0;
  double altitudeAvg = 0.0;
  bool altitudeNotZero = false;
  // ----------- Température --------- //
  int temperatureMax = 0;
  int temperatureMin = 3000;
  int temperatureAvg = 0;
  bool temperatureNotZero = false;
  // ----------- Vitesse ------------- //
  double vitesseMax = 0.0;
  double vitesseMin = 999999.0;
  double vitesseAvg = 0.0;
  bool vitesseNotZero = false;

  // ---------------------------------------------------------------------- //

  // -- Fonction pour lire le csv et remplir la classe -- //
  ActivityInfo getDataWalking(List<List<String>> csv) {
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
    // -- Température -- //
    int temperatureSomme = 0;
    int temperatureNb = 0;
    // -- Vitesse -- //
    double vitesseSomme = 0.0;
    int vitesseNb = 0;

    // --- Boucle -- //
    for (int i = 1; i < csv.length; i++) {
      //
      // ---------------------- BPM ---------------------- //
      if (!isNull(enteteCSV["Value_${managerFile.fielBPM}"]!, csv[i])) {
        int value =
            int.parse(csv[i][enteteCSV["Value_${managerFile.fielBPM}"]!]);
        bpmSomme += value;
        bpmNb += 1;
        bpmNotZero = true;
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
        altitudeNotZero = true;
      }

      // ------------------------ Température ----------------------- //
      if (!isNull(
          enteteCSV["Value_${managerFile.fieldTemperature}"]!, csv[i])) {
        int value = int.parse(
            csv[i][enteteCSV["Value_${managerFile.fieldTemperature}"]!]);
        temperatureSomme += value;
        temperatureNb += 1;
        temperatureNotZero = true;
        if (value > temperatureMax) {
          temperatureMax = value;
        }
        if (value < temperatureMin) {
          temperatureMin = value;
        }
      }

      // ------------------------ Vitesse -----------------------------//
      if (!isNull(enteteCSV["Value_${managerFile.fieldSpeed}"]!, csv[i])) {
        double value =
            double.parse(csv[i][enteteCSV["Value_${managerFile.fieldSpeed}"]!]);
        vitesseSomme += value;
        vitesseNb += 1;
        vitesseNotZero = true;
        if (value > vitesseMax) {
          vitesseMax = value;
        }
        if (value < vitesseMin) {
          vitesseMin = value;
        }
      }
    }

    // -- BPM -- //
    if (bpmNotZero) {
      bpmAvg = bpmSomme ~/ bpmNb;
    }
    // -- Atitude -- //
    if (altitudeNotZero) {
      altitudeAvg = altitudeSomme / alititudeNb;
    }
    // -- Température -- //
    if (temperatureNotZero) {
      temperatureAvg = temperatureSomme ~/ temperatureNb;
    }
    // -- Vitesse -- //
    if (vitesseNotZero) {
      vitesseAvg = vitesseSomme / vitesseNb;
    }
    return this;
  }

  // -- Fonction pour lire le csv et remplir la classe -- //
  ActivityInfo getDataCycling(List<List<String>> csv) {
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
    // -- Température -- //
    int temperatureSomme = 0;
    int temperatureNb = 0;
    // -- Vitesse -- //
    double vitesseSomme = 0.0;
    int vitesseNb = 0;

    // --- Boucle -- //
    for (int i = 1; i < csv.length; i++) {
      //
      // ---------------------- BPM ---------------------- //
      if (!isNull(enteteCSV["Value_${managerFile.fielBPM}"]!, csv[i])) {
        int value =
            int.parse(csv[i][enteteCSV["Value_${managerFile.fielBPM}"]!]);
        bpmSomme += value;
        bpmNb += 1;
        bpmNotZero = true;
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
        altitudeNotZero = true;
      }

      // ------------------------ Température ----------------------- //
      if (!isNull(
          enteteCSV["Value_${managerFile.fieldTemperature}"]!, csv[i])) {
        int value = int.parse(
            csv[i][enteteCSV["Value_${managerFile.fieldTemperature}"]!]);
        temperatureSomme += value;
        temperatureNb += 1;
        vitesseNotZero = true;
        if (value > temperatureMax) {
          temperatureMax = value;
        }
        if (value < temperatureMin) {
          temperatureMin = value;
        }
      }

      // ------------------------ Vitesse -----------------------------//
      if (!isNull(enteteCSV["Value_${managerFile.fieldSpeed}"]!, csv[i])) {
        double value =
            double.parse(csv[i][enteteCSV["Value_${managerFile.fieldSpeed}"]!]);
        vitesseSomme += value;
        vitesseNb += 1;
        vitesseNotZero = true;
        if (value > vitesseMax) {
          vitesseMax = value;
        }
        if (value < vitesseMin) {
          vitesseMin = value;
        }
      }
    }

    // -- BPM -- //
    if (bpmNotZero) {
      bpmAvg = bpmSomme ~/ bpmNb;
    }
    // -- Atitude -- //
    if (altitudeNotZero) {
      altitudeAvg = altitudeSomme / alititudeNb;
    }
    // -- Température -- //
    if (temperatureNotZero) {
      temperatureAvg = temperatureSomme ~/ temperatureNb;
    }
    // -- Vitesse -- //
    if (vitesseNotZero) {
      vitesseAvg = vitesseSomme / vitesseNb;
    }
    return this;
  }

// -- Fonction pour lire le csv et remplir la classe -- //
  ActivityInfo getDataGeneric(List<List<String>> csv) {
    print(csv);
    // - Entete - //
    Map<String, int> enteteCSV = getEntete(csv.first);
    print(enteteCSV);
    // ------------- Var tmp ---------- //
    // -- BPM -- //
    int bpmSomme = 0;
    int bpmNb = 0;
    // -- Denivelé -- //
    double lastDenivele = 0.0;
    // -- Altitude -- //
    double altitudeSomme = 0;
    int alititudeNb = 0;
    // -- Température -- //
    int temperatureSomme = 0;
    int temperatureNb = 0;
    // -- Vitesse -- //
    double vitesseSomme = 0.0;
    int vitesseNb = 0;

    // --- Boucle -- //
    for (int i = 1; i < csv.length; i++) {
      print("Ligne $i");
      //
      // ---------------------- BPM ---------------------- //
      if (!isNull(enteteCSV["Value_${managerFile.fielBPM}"]!, csv[i])) {
        int value =
            int.parse(csv[i][enteteCSV["Value_${managerFile.fielBPM}"]!]);
        bpmSomme += value;
        bpmNb += 1;
        bpmNotZero = true;
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
        altitudeNotZero = true;
      }

      // ------------------------ Température ----------------------- //
      if (!isNull(
          enteteCSV["Value_${managerFile.fieldTemperature}"]!, csv[i])) {
        int value = int.parse(
            csv[i][enteteCSV["Value_${managerFile.fieldTemperature}"]!]);
        temperatureSomme += value;
        temperatureNb += 1;
        temperatureNotZero = true;
        if (value > temperatureMax) {
          temperatureMax = value;
        }
        if (value < temperatureMin) {
          temperatureMin = value;
        }
      }

      // ------------------------ Vitesse -----------------------------//
      if (!isNull(enteteCSV["Value_${managerFile.fieldSpeed}"]!, csv[i])) {
        double value =
            double.parse(csv[i][enteteCSV["Value_${managerFile.fieldSpeed}"]!]);
        vitesseSomme += value;
        vitesseNb += 1;
        vitesseNotZero = true;
        if (value > vitesseMax) {
          vitesseMax = value;
        }
        if (value < vitesseMin) {
          vitesseMin = value;
        }
      }
    }

    // -- BPM -- //
    if (bpmNotZero) {
      bpmAvg = bpmSomme ~/ bpmNb;
    }
    // -- Atitude -- //
    if (altitudeNotZero) {
      altitudeAvg = altitudeSomme / alititudeNb;
    }
    // -- Température -- //
    if (temperatureNotZero) {
      temperatureAvg = temperatureSomme ~/ temperatureNb;
    }
    // -- Vitesse -- //
    if (vitesseNotZero) {
      vitesseAvg = vitesseSomme / vitesseNb;
    }
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
      "AltitudeAvg": altitudeAvg,
      // -- Vitesse -- //
      "VitesseAvg": vitesseAvg
    };
  }

  // ---------------  JSON  --------- //
  // -- Lecture -- //
  ActivityInfo.fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }
    // -- Ligne session -- //
    try {
      startTime = DateTime.parse(map["startTime"]);
    } catch (e) {
      print("Impossible de recup -> startTime");
    }
    try {
      timeOfActivity = map["timeOfActivity"];
    } catch (e) {
      print("Impossible de recup -> timeOfActivity");
    }
    try {
      distance = map["distance"].toDouble();
    } catch (e) {
      print("Impossible de recup -> distance");
    }
    try {
      calories = map["calories"];
    } catch (e) {
      print("Impossible de recup -> calories");
    }
    try {
      steps = map["steps"];
    } catch (e) {
      print("Impossible de recup -> steps");
    }
    // -- BPM -- //
    try {
      bpmAvg = map["bpmAvg"];
    } catch (e) {
      print("Impossible de recup -> ");
    }
    try {
      bpmMax = map["bpmMax"];
    } catch (e) {
      print("Impossible de recup -> ");
    }
    try {
      bpmMin = map["bpmMin"];
    } catch (e) {
      print("Impossible de recup -> ");
    }
    // -- Denivelé -- //
    try {
      deniveleNegatif = map["deniveleNegatif"];
    } catch (e) {
      print("Impossible de recup -> deniveleNegatif");
    }
    try {
      denivelePositif = map["denivelePositif"];
    } catch (e) {
      print("Impossible de recup -> denivelePositif");
    }
    // -- Altitude -- //
    try {
      altitudeMax = map["altitudeMax"];
    } catch (e) {
      print("Impossible de recup -> altitudeMax");
    }
    try {
      altitudeMin = map["altitudeMin"];
    } catch (e) {
      print("Impossible de recup -> altitudeMin");
    }
    try {
      altitudeAvg = map["altitudeAvg"];
    } catch (e) {
      print("Impossible de recup -> altitudeAvg");
    }
    // -- Température -- //
    try {
      temperatureMax = map["temperatureMax"];
    } catch (e) {
      print("Impossible de recup -> temperatureMax");
    }
    try {
      temperatureMin = map["temperatureMin"];
    } catch (e) {
      print("Impossible de recup -> temperatureMin");
    }
    try {
      temperatureAvg = map["temperatureAvg"];
    } catch (e) {
      print("Impossible de recup -> temperatureAvg");
    }
    // -- Vitesse -- //
    try {
      vitesseMax = map["vitesseMax"].toDouble();
    } catch (e) {
      print("Impossible de recup -> vitesseMax");
    }
    try {
      vitesseMin = map["vitesseMin"].toDouble();
    } catch (e) {
      print("Impossible de recup -> vitesseMin");
    }
    try {
      vitesseAvg = map["vitesseAvg"].toDouble();
    } catch (e) {
      print("Impossible de recup -> vitesseAvg");
    }
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
      // -- Température -- //
      'temperatureMax': temperatureMax,
      'temperatureMin': temperatureMin,
      'temperatureAvg': temperatureAvg,
      // -- Vitesse -- //
      'vitesseMax': vitesseMax,
      'vitesseMin': vitesseMin,
      'vitesseAvg': vitesseAvg,
      // Ligne session
      'startTime': startTime.toIso8601String(),
      'timeOfActivity': timeOfActivity,
      'distance': distance,
      'calories': calories,
      'steps': steps
    };
    return jsonEncode(jsonMap);
  }
}
