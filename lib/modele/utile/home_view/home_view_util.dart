import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/modele/manager_file.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/data_home_view.dart';

class HomeViewUtil {
  DataHomeView initData(BuildContext context) {
    final ManagerFile managerFile = ManagerFile();

    List<FlSpot> bpmSecondes = Provider.of<User>(context)
        .managerSelectedActivity
        .getXWithTime(managerFile.fielBPM);
    List<FlSpot> vitesseSecondes = Provider.of<User>(context)
        .managerSelectedActivity
        .getXWithTime(managerFile.fieldSpeed);
    List<FlSpot> altitudeSeconde = Provider.of<User>(context)
        .managerSelectedActivity
        .getXWithTime(managerFile.fieldAltitude);

    List<FlSpot> bpmSecondes2 = List.from(bpmSecondes);

    return DataHomeView(normaliserPremierElement(bpmSecondes), normaliserPremierElement(normaliserDeuxiemeElement(bpmSecondes2)),
         normaliserPremierElement(normaliserDeuxiemeElement(vitesseSecondes)), altitudeSeconde);
  }

  List<FlSpot> normaliserDeuxiemeElement(List<FlSpot> liste) {
    // Trouver le plus grand élément dans la liste
    double maxElement = 0.0;
    for (var spot in liste) {
      if (spot.y > maxElement) {
        maxElement = spot.y;
      }
    }
    // Calculer le facteur de normalisation
    double normalisationFactor = maxElement != 0.0 ? 100 / maxElement : 1.0;
    // Mettre à jour tous les éléments de la liste
    for (int i = 0; i < liste.length; i++) {
      liste[i] = FlSpot(liste[i].x, liste[i].y * normalisationFactor);
    }
    return liste;
  }
  List<FlSpot> normaliserPremierElement(List<FlSpot> liste) {
  // Trouver le plus grand élément dans le premier élément de chaque FlSpot
  double maxElement = 0.0;
  for (var spot in liste) {
    if (spot.x > maxElement) {
      maxElement = spot.x;
    }
  }
  // Calculer le facteur de normalisation
  double normalisationFactor = maxElement != 0.0 ? 100 / maxElement : 1.0;
  // Mettre à jour tous les premiers éléments de la liste
  for (int i = 0; i < liste.length; i++) {
    liste[i] = FlSpot(liste[i].x * normalisationFactor, liste[i].y);
  }
  return liste;
}

}
