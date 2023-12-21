import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common_widget/container/container_stats_activities.dart';
import 'package:smartfit_app_mobile/common_widget/other/entete_home_view.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/modele/convertisseur.dart';
import 'package:smartfit_app_mobile/modele/manager_selected_activity.dart';
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
    ManagerSelectedActivity managerSelectedActivity =
        context.watch<User>().managerSelectedActivity;

    // -- BPM -- //
    int maxBpm = managerSelectedActivity.getBpmMaxAllActivitieSelected();
    int minBpm = managerSelectedActivity.getBpmMinAllActivitieSelected();
    int avgBpm = managerSelectedActivity.getBpmAvgAllActivitieSelected();
    // -- Altitude -- //
    double maxAltitude =
        managerSelectedActivity.getMaxAltitudeAllActivitySelected();
    double minAltitude =
        managerSelectedActivity.getMinAltitudeAllActivitySelected();
    double avgAltitude =
        managerSelectedActivity.getAvgAltitudeAllActivitySelected();

    // -- Température -- //
    double avgTemperature = context
        .watch<User>()
        .managerSelectedActivity
        .getAvgTemperatureAllActivitySelected()
        .toDouble();
    double maxTemperature = context
        .watch<User>()
        .managerSelectedActivity
        .getMaxTemperatureAllActivitySelected()
        .toDouble();
    double minTemperature = context
        .watch<User>()
        .managerSelectedActivity
        .getMinTemperatureAllActivitySelected()
        .toDouble();
    // ----- Distance ---- //
    double getTotalDistance = context
        .watch<User>()
        .managerSelectedActivity
        .getDistanceAllActivitySelected();
    // ---- Calories --- //
    int totalCalories = context
        .watch<User>()
        .managerSelectedActivity
        .getCalorieAllActivitySelected();
    // --- Steps --- //
    int totalSteps = context
        .watch<User>()
        .managerSelectedActivity
        .getStepsAllActivitySelected();
    // -- Time -- //
    double totalTime = context
        .watch<User>()
        .managerSelectedActivity
        .getTimeAllActivitySelected();

    // -- Speed -- //
    double avgSpeed = context
        .watch<User>()
        .managerSelectedActivity
        .getAvgSpeedAllActivitySelected();
    double maxSpeed = context
        .watch<User>()
        .managerSelectedActivity
        .getMaxSpeedAllActivitySelected();
    double minSpeed = context
        .watch<User>()
        .managerSelectedActivity
        .getMinSpeedAllActivitySelected();

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
                        "${Convertisseur.msIntoKmh(avgSpeed).toStringAsFixed(0)} km/h",
                        "Moyenne vitesse",
                        Icons.bolt),
                    SizedBox(
                      width: media.width * 0.03,
                    ),
                    ContainerStatsActivities(
                        "${Convertisseur.msIntoKmh(maxSpeed).toStringAsFixed(0)} km/h",
                        "Maximum vitesse",
                        Icons.trending_up),
                    SizedBox(
                      width: media.width * 0.03,
                    ),
                    ContainerStatsActivities(
                        "${Convertisseur.msIntoKmh(minSpeed).toStringAsFixed(0)} km/h",
                        "Minimum vitesse",
                        Icons.trending_down)
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
                        "${avgAltitude.toStringAsFixed(2)} m",
                        "Moyenne Altitude",
                        Icons.landscape),
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
                        "${Convertisseur.secondeIntoMinute(totalTime)} min",
                        "Temps Total",
                        Icons.timer),
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
