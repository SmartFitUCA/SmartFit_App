import 'package:fl_chart/fl_chart.dart';
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
    String maxBpm = context.watch<User>().listActivity[0].getMaxBpm();
    String minBpm = context.watch<User>().listActivity[0].getMinBpm();
    String avgBpm = context.watch<User>().listActivity[0].getAvgBpm();
    data = HomeViewUtil().initData(context);

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
                GraphBpmByTime(media, data),
                SizedBox(
                  height: media.width * 0.05,
                ),
                LigneContainerStats(
                    minBpm + " BPM",
                    maxBpm + " BPM",
                    avgBpm + " BPM",
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
                const LigneContainerStats("1", "2", "3", "s", "s", "s"),
                GraphAltitudeByTime(media, data)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
