abstract class ActivityInfo {
  // -- Time -- //
  String startTime = "2000-01-01";
  double timeOfActivity = 0.0;

  // -- BPM -- //
  int bpmMax = 0;
  int bpmMin = 300;
  int bpmAvg = 0;

  // -- Fonction pour lire le csv et remplir la classe -- //
  ActivityInfo getData(List<List<String>> csv);

  String toJson();
}
