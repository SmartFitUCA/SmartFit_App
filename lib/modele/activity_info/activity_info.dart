import 'package:smartfit_app_mobile/modele/manager_file.dart';

abstract class ActivityInfo {
  ManagerFile managerFile = ManagerFile();

  // -- Time -- // Ne pas calculer (Ligne session)
  String startTime = "2000-01-01";
  double timeOfActivity = 0.0;

  // -- BPM -- //
  int bpmMax = 0;
  int bpmMin = 300;
  int bpmAvg = 0;

  // -- Fonction pour lire le csv et remplir la classe -- //
  ActivityInfo getData(List<List<String>> csv) {
    // -- BPM -- //
    int bpmSomme = 0;
    int bpmNb = 0;
    Map<String, int> enteteCSV = getEntete(csv.first);
    for (int i = 1; i < csv.length; i++) {
      // -- BPM -- //
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
    }

    // -- BPM -- //
    bpmAvg = bpmSomme ~/ bpmNb;
    return this;
  }

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

  String toJson();
  Map<String, dynamic> toMap();
  ActivityInfo.fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }
    startTime = map["startTime"];
    timeOfActivity = map["timeOfActivity"].toDouble();
    bpmAvg = map["bpmAvg"];
    bpmMax = map["bpmMax"];
    bpmMin = map["bpmMin"];
  }
}
