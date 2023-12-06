import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common_widget/container/ligne_container_stats.dart';
import 'package:smartfit_app_mobile/common_widget/graph/altitude_by_time.dart';
import 'package:smartfit_app_mobile/common_widget/graph/bpm_and_speed_by_time.dart';
import 'package:smartfit_app_mobile/common_widget/graph/bpm_by_time.dart';
import 'package:smartfit_app_mobile/common_widget/other/entete_home_view.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/modele/manager_selected_activity.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/data_home_view.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/home_view_util.dart';

class MobileHomeView extends StatefulWidget {
  const MobileHomeView({super.key});

  @override
  State<MobileHomeView> createState() => _MobileHomeView();
}

class _MobileHomeView extends State<MobileHomeView> {
  late DataHomeView data;
  TextEditingController bpmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    ManagerSelectedActivity managerSelectedActivity =
        context.watch<User>().managerSelectedActivity;

    data = HomeViewUtil().initData(context);
    // -- BPM -- //
    data.maxBPM =
        managerSelectedActivity.activitySelected.first.activityInfo.bpmMax;
    data.minBPM =
        managerSelectedActivity.activitySelected.first.activityInfo.bpmMin;
    int avgBpm =
        managerSelectedActivity.activitySelected.first.activityInfo.bpmAvg;

    // -- Altitude -- //
    double minAltitude =
        managerSelectedActivity.activitySelected.first.activityInfo.altitudeMin;
    double maxAltitude =
        managerSelectedActivity.activitySelected.first.activityInfo.altitudeMax;
    double avgAltitude =
        managerSelectedActivity.activitySelected.first.activityInfo.altitudeAvg;
    // -- Speed -- //
    double maxSpeed = managerSelectedActivity.getMaxSpeed();
    double avgSpeed = managerSelectedActivity.getAvgSpeed();
    data.maxSpeed = maxSpeed;
    data.time = context.watch<User>().managerSelectedActivity.getTotalTime();
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  height: media.width * 0.02,
                ),
                BpmByTime(media, data),
                SizedBox(
                  height: media.width * 0.05,
                ),
                LigneContainerStats(
                    "${data.minBPM.toString()} BPM",
                    "${data.maxBPM.toString()} BPM",
                    "${avgBpm.toString()} BPM",
                    "Minimum",
                    "Maximum",
                    "Moyenne",
                    Icons.trending_down,
                    Icons.trending_up,
                    Icons.favorite_outline),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rythme cardique et vitesse",
                      style: TextStyle(
                          color: TColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                GraphBpmAndSpeedByTime(media, data),
                SizedBox(
                  height: media.width * 0.05,
                ),
                LigneContainerStats(
                    "${double.parse(maxSpeed.toStringAsFixed(2))} m/s",
                    "${double.parse(avgSpeed.toStringAsFixed(2))} m/s",
                    "${avgBpm.toString()} BPM",
                    "Max Speed",
                    "Moyenne Speed",
                    "Moyenne BPM",
                    Icons.trending_down,
                    Icons.trending_up,
                    Icons.favorite_outline),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Altitude",
                      style: TextStyle(
                          color: TColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                GraphAltitudeByTime(media, data),
                LigneContainerStats(
                    "${minAltitude.toInt()} M",
                    "${maxAltitude.toInt()} M",
                    "${avgAltitude.toInt()} M",
                    "Minimum",
                    "Maximum",
                    "Moyenne",
                    Icons.trending_down,
                    Icons.trending_up,
                    Icons.favorite_outline),
                SizedBox(
                  height: media.width * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
