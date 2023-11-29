import 'package:fl_chart/fl_chart.dart';

class DataHomeView {
  late List<FlSpot> bpmSecondes;
  late List<FlSpot> bpmSecondes2;
  late List<FlSpot> vitesseSecondes;
  late List<FlSpot> altitudeSeconde;
  int minBPM = 0;
  int maxBPM = 0;

  DataHomeView(this.bpmSecondes, this.bpmSecondes2, this.vitesseSecondes,
      this.altitudeSeconde);
}
