import 'dart:convert';

import 'package:smartfit_app_mobile/modele/activity_info/activity_info.dart';

class ActivityInfoGeneric implements ActivityInfo {
  // ------- Ajout --------- //

  // ------- Activity Info -------- //
  @override
  late int bpmAvg;

  @override
  late int bpmMax;

  @override
  late int bpmMin;

  @override
  late String startTime;

  @override
  late double timeOfActivity;

  @override
  ActivityInfo getData(List<List<String>> csv) {
    return this;
  }

  @override
  // Méthode pour convertir les attributs en JSON
  String toJson() {
    Map<String, dynamic> jsonMap = {
      'bpmAvg': bpmAvg,
      'bpmMax': bpmMax,
      'bpmMin': bpmMin,
      'startTime': startTime,
      'timeOfActivity': timeOfActivity,
    };
    return jsonEncode(jsonMap);
  }
}
