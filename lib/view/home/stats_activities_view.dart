import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common_widget/container/container_stats_activities.dart';
import 'package:smartfit_app_mobile/common_widget/other/entete_home_view.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/data_home_view.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/home_view_util.dart';

class StatAtivities extends StatefulWidget {
  const StatAtivities({super.key});

  @override
  State<StatAtivities> createState() => _StatAtivities();
}

class _StatAtivities extends State<StatAtivities> {
  late DataHomeView data;
  TextEditingController bpmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    data = HomeViewUtil().initData(context);
    int maxBpm = context
        .watch<User>()
        .managerSelectedActivity
        .activitySelected
        .first
        .activityInfo
        .bpmMax;
    int minBpm = context
        .watch<User>()
        .managerSelectedActivity
        .activitySelected
        .first
        .activityInfo
        .bpmMin;
    int avgBpm = context
        .watch<User>()
        .managerSelectedActivity
        .activitySelected
        .first
        .activityInfo
        .bpmAvg;
    double getTotalDistance =
        context.watch<User>().managerSelectedActivity.getTotalDistance();
    int totalSteps =
        context.watch<User>().managerSelectedActivity.getTotalSteps();
    double totalTime =
        context.watch<User>().managerSelectedActivity.getTotalTime();
    int totalCalories =
        context.watch<User>().managerSelectedActivity.getCalorie();
    double avgSpeed =
        context.watch<User>().managerSelectedActivity.getAvgSpeed();
    double avgAltitude =
        context.watch<User>().managerSelectedActivity.getAvgAltitude();

    double avgTemperature =
        context.watch<User>().managerSelectedActivity.getAvgTemperature();
    double maxAltitude =
        context.watch<User>().managerSelectedActivity.getMaxAltitude();

    double maxTemperature =
        context.watch<User>().managerSelectedActivity.getMaxTemperature();

    double maxSpeed =
        context.watch<User>().managerSelectedActivity.getMaxSpeed();
    double minSpeed =
        context.watch<User>().managerSelectedActivity.getMinSpeed();
    double minAltitude =
        context.watch<User>().managerSelectedActivity.getMinAltitude();
    double minTemperature =
        context.watch<User>().managerSelectedActivity.getMinTemperature();

    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: media.width * 0.03,
                ),
                const EnteteHomeView(),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Text(
                  "Status d'activité",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ContainerStatsActivities(
                        "$avgBpm BPM", "Moyenne Bpm", Icons.favorite),
                    SizedBox(
                      width: media.width * 0.03,
                    ),
                    ContainerStatsActivities(
                        "$maxBpm BPM", "Maximum Bpm", Icons.trending_up),
                    SizedBox(
                      width: media.width * 0.03,
                    ),
                    ContainerStatsActivities(
                        "$minBpm BPM", "Minimum Bpm", Icons.trending_down)
                  ],
                ),
                SizedBox(
                  height: media.width * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ContainerStatsActivities(
                        "$avgSpeed m/s", "Moyenne vitesse", Icons.bolt),
                    SizedBox(
                      width: media.width * 0.03,
                    ),
                    ContainerStatsActivities(
                        "$maxSpeed m/s", "Maximum vitesse", Icons.trending_up),
                    SizedBox(
                      width: media.width * 0.03,
                    ),
                    ContainerStatsActivities(
                        "$minSpeed m/s", "Minimum vitesse", Icons.trending_down)
                  ],
                ),
                SizedBox(
                  height: media.width * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ContainerStatsActivities("$avgTemperature °C",
                        "Moyenne Temperature", Icons.thermostat),
                    SizedBox(
                      width: media.width * 0.03,
                    ),
                    ContainerStatsActivities("$maxTemperature °C",
                        "Maximum Temperature", Icons.trending_up),
                    SizedBox(
                      width: media.width * 0.03,
                    ),
                    ContainerStatsActivities("$minTemperature °C",
                        "Minimum Temperature", Icons.trending_down)
                  ],
                ),
                SizedBox(
                  height: media.width * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ContainerStatsActivities(
                        "$avgAltitude m", "Moyenne Altitude", Icons.landscape),
                    SizedBox(
                      width: media.width * 0.03,
                    ),
                    ContainerStatsActivities("$maxAltitude m",
                        "Maximum Altitude", Icons.trending_up),
                    SizedBox(
                      width: media.width * 0.03,
                    ),
                    ContainerStatsActivities("$minAltitude m",
                        "Minimum Altitude", Icons.trending_down)
                  ],
                ),
                SizedBox(
                  height: media.width * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ContainerStatsActivities("$getTotalDistance m",
                        "Distance Totale", Icons.double_arrow),
                    SizedBox(
                      width: media.width * 0.03,
                    ),
                    ContainerStatsActivities(
                        "$totalSteps", "Total Pas", Icons.do_not_step_rounded),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ContainerStatsActivities(
                        "$totalTime s", "Temps Total", Icons.timer),
                    SizedBox(
                      width: media.width * 0.03,
                    ),
                    ContainerStatsActivities("$totalCalories kCal",
                        "Calories Dépensées", Icons.local_fire_department),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
