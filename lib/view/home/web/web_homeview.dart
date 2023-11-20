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
    int maxBpm = context.watch<User>().listActivity[0].getMaxBpm();
    int minBpm = context.watch<User>().listActivity[0].getMinBpm();
    int avgBpm = context.watch<User>().listActivity[0].getAvgBpm();
    // -- Altitude -- //
    double minAltitude = context.watch<User>().listActivity[0].getMinAltitude();
    double maxAltitude = context.watch<User>().listActivity[0].getMaxAltitude();
    double avgAltitude = (maxAltitude + minAltitude) / 2;
    // -- Speed -- //
    double maxSpeed = context.watch<User>().listActivity[0].getMaxSpeed();
    double avgSpeed = context.watch<User>().listActivity[0].getAvgSpeed();

    data = HomeViewUtil().initData(context);

    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 200),
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
                  height: media.width * 0.02,
                ),
                GraphBpmByTime(media, data),
                SizedBox(
                  height: media.width * 0.05,
                ),
                LigneContainerStats(
                    "${double.parse(maxSpeed.toStringAsFixed(2))} KM/H",
                    "${double.parse(avgSpeed.toStringAsFixed(2))} km/H",
                    "${avgBpm.toString()} BPM",
                    "Minimum",
                    "Maximum",
                    "Moyenne",
                    Icons.trending_down,
                    Icons.trending_up,
                    Icons.favorite_outline),
                SizedBox(
                  height: media.width * 0.05,
                ),
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
                GraphAltitudeByTime(media, data),
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
