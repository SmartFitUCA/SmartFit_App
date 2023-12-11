import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common_widget/container/container_stats_activities.dart';
import 'package:smartfit_app_mobile/modele/convertisseur.dart';

class VolumesList extends StatelessWidget {
  final Map<String, dynamic> volume;

  const VolumesList({super.key, required this.volume});
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    // TODO: True message with variables and context aware
    if (volume["nbActivity"] == 0) {
      return const Text("Aucune activité ces x jours/mois/années");
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ContainerStatsActivities(volume["nbActivity"].toString(),
              "Nombre Activitée(s)", Icons.numbers),
          SizedBox(
            width: media.width * 0.03,
          ),
          ContainerStatsActivities(
              "${Convertisseur.secondeIntoMinute(volume["durationActiviy"]).toStringAsFixed(2)} m",
              "Temps Total",
              Icons.timer),
          SizedBox(
            width: media.width * 0.03,
          ),
          ContainerStatsActivities(
              volume["bpmAvg"].toString(), "Bpm Moyens", Icons.favorite),
          SizedBox(
            width: media.width * 0.03,
          ),
          ContainerStatsActivities(
              " ${Convertisseur.msIntoKmh(volume["speedAvg"]).toStringAsFixed(2)} km/h",
              "Vitesse Moyenne",
              Icons.bolt),
          SizedBox(
            width: media.width * 0.03,
          ),
          ContainerStatsActivities(
              "${volume["denivelePositif"].toStringAsFixed(2)} m",
              "Dénivelé Positif",
              Icons.hiking),
        ],
      ),
    );
  }
}
