import 'dart:convert';

import 'package:smartfit_app_mobile/modele/activity_info/activity_info.dart';

class ActivityInfoWalking implements ActivityInfo {
  // ------- Ajout --------- //

  // -- Denivelé -- //
  double denivelePositif = 0.0;
  double deniveleNegatif = 0.0;

  // ------- Activity Info -------- //
  @override
  int bpmAvg = 0;

  @override
  int bpmMax = 0;

  @override
  int bpmMin = 0;

  @override
  String startTime = "2000-01-01";

  @override
  double timeOfActivity = 0.0;

  @override
  ActivityInfo getData(List<List<String>> csv) {
    for (int i = 0; i < csv.length; i++) {}
    return this;
  }

  @override
  // Méthode pour convertir les attributs en JSON
  String toJson() {
    Map<String, dynamic> jsonMap = {
      'denivelePositif': denivelePositif,
      'deniveleNegatif': deniveleNegatif,
      'bpmAvg': bpmAvg,
      'bpmMax': bpmMax,
      'bpmMin': bpmMin,
      'startTime': startTime,
      'timeOfActivity': timeOfActivity,
    };
    return jsonEncode(jsonMap);
  }
}
