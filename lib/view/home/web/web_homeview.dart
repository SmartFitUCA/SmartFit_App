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

class WebHomeView extends StatefulWidget {
  const WebHomeView({super.key});

  @override
  State<WebHomeView> createState() => _WebHomeView();
}

class _WebHomeView extends State<WebHomeView> {
  late DataHomeView data;
  TextEditingController bpmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    ManagerSelectedActivity managerSelectedActivity =
        context.watch<User>().managerSelectedActivity;

    // -- BPM -- //
    int maxBpm =
        managerSelectedActivity.activitySelected.first.activityInfo.bpmMax;
    int minBpm =
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
    double maxSpeed = context
        .watch<User>()
        .managerSelectedActivity
        .getMaxSpeedAllActivitySelected();
    double avgSpeed = context
        .watch<User>()
        .managerSelectedActivity
        .getAvgSpeedAllActivitySelected();

    data = HomeViewUtil().initData(context);
    data.maxBPM = maxBpm;
    data.minBPM = minBpm;
    data.maxSpeed = maxSpeed;
    data.time = context
        .watch<User>()
        .managerSelectedActivity
        .getTimeAllActivitySelected();
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
            child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: media.width * 0.03,
                ),
                const EnteteHomeView(),
                SizedBox(
                  height: media.width * 0.03,
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BpmByTime(media, data),
                          SizedBox(
                            width: media.width * 0.01,
                          ),
                          LigneContainerStats(
                              "${minBpm.toString()} BPM",
                              "${maxBpm.toString()} BPM",
                              "${avgBpm.toString()} BPM",
                              "Minimum",
                              "Maximum",
                              "Moyenne",
                              Icons.trending_down,
                              Icons.trending_up,
                              Icons.favorite_outline),
                        ]),
                      ]),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Rythme cardique et vitesse",
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
                              GraphBpmAndSpeedByTime(media, data),
                              SizedBox(
                                height: media.width * 0.05,
                              ),
                              LigneContainerStats(
                                  "${double.parse(maxSpeed.toStringAsFixed(2))} m/s",
                                  "${double.parse(avgSpeed.toStringAsFixed(2))} m/s",
                                  "${avgBpm.toString()} BPM",
                                  "Max vitesse",
                                  "Moy vitesse",
                                  "Moy Bpm",
                                  Icons.trending_up,
                                  Icons.bolt,
                                  Icons.favorite_outline),
                              SizedBox(
                                height: media.width * 0.05,
                              ),
                            ]),
                      ]),
                ]),
                SizedBox(
                  height: media.width * 0.02,
                ),
                Text(
                  "Altitude",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  GraphAltitudeByTime(media, data),
                  LigneContainerStats(
                      "${minAltitude.toInt()} m",
                      "${maxAltitude.toInt()} m",
                      "${avgAltitude.toInt()} m",
                      "Minimum",
                      "Maximum",
                      "Moyenne",
                      Icons.trending_down,
                      Icons.trending_up,
                      Icons.favorite_outline),
                ]),
              ],
            ),
          ),
      ),
      
    );
  }
}
