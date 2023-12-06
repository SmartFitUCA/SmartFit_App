import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common_widget/container/container_stats_activities.dart';

class VolumesList extends StatefulWidget {
  const VolumesList({Key? key}) : super(key: key);

  @override
  State<VolumesList> createState() => _VolumesList();
}

class _VolumesList extends State<VolumesList> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ContainerStatsActivities("??", "Nombre Activitée(s)", Icons.numbers),
          SizedBox(
            width: media.width * 0.03,
          ),
          ContainerStatsActivities("?? s", "Temps Total", Icons.timer),
          SizedBox(
            width: media.width * 0.03,
          ),
          ContainerStatsActivities("?? BPM", "Bpm Moyens", Icons.favorite),
          SizedBox(
            width: media.width * 0.03,
          ),
          ContainerStatsActivities("?? m/s", "Vitesse Moyenne", Icons.bolt),
          SizedBox(
            width: media.width * 0.03,
          ),
          ContainerStatsActivities("?? + m", "Dénivelé Positif", Icons.hiking),
        ],
      ),
    );
  }
}
