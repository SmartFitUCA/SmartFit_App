import 'dart:convert';

import 'package:smartfit_app_mobile/modele/activity_info/activity_info.dart';

class ActivityInfoGeneric extends ActivityInfo {
  ActivityInfoGeneric.fromJson(super.map) : super.fromJson();
  ActivityInfoGeneric() : super.fromJson(null);

  // ------- Ajout --------- //

  // ------- Activity Info -------- //
  @override
  ActivityInfo getData(List<List<String>> csv) {
    super.getData(csv);
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

  @override
  Map<String, dynamic> toMap() {
    return {};
  }
}
