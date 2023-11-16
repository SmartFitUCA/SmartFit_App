import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/data_home_view.dart';

class HomeViewUtil {
  DataHomeView initData(BuildContext context) {
    List<FlSpot> bpmSecondes =
        Provider.of<User>(context).listActivity[0].getHeartRateWithTime();
    List<FlSpot> vitesseSecondes =
        Provider.of<User>(context).listActivity[0].getSpeedWithTime();

    List<FlSpot> bpmSecondes2 = List.from(bpmSecondes);
    return DataHomeView(
        normaliserDeuxiemeElement(bpmSecondes),
        normaliserDeuxiemeElement(bpmSecondes2),
        normaliserDeuxiemeElement(vitesseSecondes));
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
}
