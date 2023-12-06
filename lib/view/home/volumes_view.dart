import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common_widget/container/container_stats_activities.dart';
import 'package:smartfit_app_mobile/common_widget/other/entete_home_view.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/modele/manager_selected_activity.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/data_home_view.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/home_view_util.dart';

class Volumes extends StatefulWidget {
  const Volumes({super.key});

  @override
  State<Volumes> createState() => _Volumes();
}

class _Volumes extends State<Volumes> {
  late DataHomeView data;
  TextEditingController bpmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    data = HomeViewUtil().initData(context);
    ManagerSelectedActivity managerSelectedActivity =
        context.watch<User>().managerSelectedActivity;

    // -- BPM -- //
    int avgBpm = managerSelectedActivity.getBpmAvgAllActivitieSelected();

    // -- Speed -- //
    String avgSpeed = context
        .watch<User>()
        .managerSelectedActivity
        .getAvgSpeedAllActivitySelected().toStringAsFixed(2);



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
                  "Derniere semaine",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.03,
                ),
                 SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ContainerStatsActivities(
                            "??", "Nombre Activitée(s)", Icons.numbers),
                        SizedBox(
                          width: media.width * 0.03,
                        ),
                        ContainerStatsActivities(
                            "?? s", "Temps Total", Icons.timer),
                        SizedBox(
                          width: media.width * 0.03,
                        ),
                        ContainerStatsActivities(
                            "?? BPM", "Bpm Moyens", Icons.favorite),
                            SizedBox(
                          width: media.width * 0.03,
                        ),
                        ContainerStatsActivities(
                            "?? m/s", "Vitesse Moyenne", Icons.bolt),
                            SizedBox(
                          width: media.width * 0.03,
                        ),
                        ContainerStatsActivities(
                            "?? + m", "Dénivelé Positif", Icons.hiking),
                      ],
                    ),),
                SizedBox(
                  height: media.width * 0.03,
                ),
                Text(
                  "Dernier Mois",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                 SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ContainerStatsActivities(
                            "??", "Nombre Activitée(s)", Icons.numbers),
                        SizedBox(
                          width: media.width * 0.03,
                        ),
                        ContainerStatsActivities(
                            "?? s", "Temps Total", Icons.timer),
                        SizedBox(
                          width: media.width * 0.03,
                        ),
                        ContainerStatsActivities(
                            "?? BPM", "Bpm Moyens", Icons.favorite),
                            SizedBox(
                          width: media.width * 0.03,
                        ),
                        ContainerStatsActivities(
                            "?? m/s", "Vitesse Moyenne", Icons.bolt),
                            SizedBox(
                          width: media.width * 0.03,
                        ),
                        ContainerStatsActivities(
                            "?? + m", "Dénivelé Positif", Icons.hiking),
                      ],
                    ),),
                SizedBox(
                  height: media.width * 0.03,
                ),
                Text(
                  "Dernière année",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                 SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ContainerStatsActivities(
                            "??", "Nombre Activitée(s)", Icons.numbers),
                        SizedBox(
                          width: media.width * 0.03,
                        ),
                        ContainerStatsActivities(
                            "?? s", "Temps Total", Icons.timer),
                        SizedBox(
                          width: media.width * 0.03,
                        ),
                        ContainerStatsActivities(
                            "?? BPM", "Bpm Moyens", Icons.favorite),
                            SizedBox(
                          width: media.width * 0.03,
                        ),
                        ContainerStatsActivities(
                            "?? m/s", "Vitesse Moyenne", Icons.bolt),
                            SizedBox(
                          width: media.width * 0.03,
                        ),
                        ContainerStatsActivities(
                            "?? + m", "Dénivelé Positif", Icons.hiking),
                      ],
                    ),),
                SizedBox(
                  height: media.width * 0.03,
                ),
                Text(
                  "Total",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                 SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ContainerStatsActivities(
                            "??", "Nombre Activitée(s)", Icons.numbers),
                        SizedBox(
                          width: media.width * 0.03,
                        ),
                        ContainerStatsActivities(
                            "?? s", "Temps Total", Icons.timer),
                        SizedBox(
                          width: media.width * 0.03,
                        ),
                        ContainerStatsActivities(
                            "?? BPM", "Bpm Moyens", Icons.favorite),
                            SizedBox(
                          width: media.width * 0.03,
                        ),
                        ContainerStatsActivities(
                            "?? m/s", "Vitesse Moyenne", Icons.bolt),
                            SizedBox(
                          width: media.width * 0.03,
                        ),
                        ContainerStatsActivities(
                            "?? + m", "Dénivelé Positif", Icons.hiking),
                      ],
                    ),),
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


// nombre activité / durée totale/ bpm moyens / denivelé positif / vitesse moyenne