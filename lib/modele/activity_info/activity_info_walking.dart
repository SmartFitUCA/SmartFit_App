import 'dart:convert';

import 'package:smartfit_app_mobile/modele/activity_info/activity_info.dart';

class ActivityInfoWalking extends ActivityInfo {
  ActivityInfoWalking.fromJson(map) : super.fromJson(map) {
    deniveleNegatif = map["deniveleNegatif"].toDouble();
    denivelePositif = map["denivelePositif"].toDouble();
  }
  ActivityInfoWalking() : super.fromJson(null);

  // ------- Ajout --------- //

  // -- Denivelé -- //
  double denivelePositif = 0.0;
  double deniveleNegatif = 0.0;

  @override
  ActivityInfo getData(List<List<String>> csv) {
    super.getData(csv);

    Map<String, int> enteteCSV = getEntete(csv.first);
    // -- Denivelé -- //
    double lastDenivele = 0.0;

    // -- Lecture du corps -- //
    for (int i = 1; i < csv.length; i++) {
      // -- Denivele -- //
      if (!isNull(enteteCSV["Value_${managerFile.fieldAltitude}"]!, csv[i])) {
        double value = double.parse(
            csv[i][enteteCSV["Value_${managerFile.fieldAltitude}"]!]);
        if (value > lastDenivele) {
          denivelePositif += value - lastDenivele;
        } else {
          deniveleNegatif += (value - lastDenivele) * -1;
        }
        lastDenivele = value;
      }
    }
    return this;
  }

  @override
  // Méthode pour convertir les attributs en JSON
  String toJson() {
    Map<String, dynamic> jsonMap = {
      // Unique
      'denivelePositif': denivelePositif,
      'deniveleNegatif': deniveleNegatif,
      // All
      'bpmAvg': bpmAvg,
      'bpmMax': bpmMax,
      'bpmMin': bpmMin,
      // Ligne session
      'startTime': startTime,
      'timeOfActivity': timeOfActivity,
    };
    return jsonEncode(jsonMap);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "DenivelePositif": denivelePositif,
      "DeniveleNegatif": denivelePositif
    };
  }
}
