import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common_widget/container/ligne_container_stats.dart';
import 'package:smartfit_app_mobile/common_widget/graph/altitude_by_time.dart';
import 'package:smartfit_app_mobile/common_widget/graph/bpm_and_speed_by_time.dart';
import 'package:smartfit_app_mobile/common_widget/graph/bpm_by_time.dart';
import 'package:smartfit_app_mobile/common_widget/other/entete_home_view.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
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
    // -- BPM -- //
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
    // -- Altitude -- //
    double minAltitude =
        context.watch<User>().managerSelectedActivity.getMinAltitude();
    double maxAltitude =
        context.watch<User>().managerSelectedActivity.getMaxAltitude();
    double avgAltitude = (maxAltitude + minAltitude) / 2;
    // -- Speed -- //
    double maxSpeed =
        context.watch<User>().managerSelectedActivity.getMaxSpeed();
    double avgSpeed =
        context.watch<User>().managerSelectedActivity.getAvgSpeed();

    data = HomeViewUtil().initData(context);

    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: media.width * 0.03,
                ),
                const EnteteHomeView(),
                SizedBox(
                  height: media.width * 0.03,
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        Row(children: [
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rythme cardique et vitesse",
                          style: TextStyle(
                              color: TColor.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: media.width * 0.02,
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
      ),
    );
  }
}
