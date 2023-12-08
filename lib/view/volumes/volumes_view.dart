import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common_widget/container/list/volumes_list.dart';
import 'package:smartfit_app_mobile/common_widget/other/entete_home_view.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/data_home_view.dart';

class VolumesView extends StatefulWidget {
  const VolumesView({super.key});

  @override
  State<VolumesView> createState() => _VolumesViews();
}

class _VolumesViews extends State<VolumesView> {
  late DataHomeView data;
  TextEditingController bpmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    User user = context.watch<User>();
    DateTime date = DateTime.now();

    Map<String, dynamic> volume7Days =
        user.getVolumeWhithDuration(const Duration(days: 7));
    Map<String, dynamic> volume1Months =
        user.getVolumeWhithDuration(const Duration(days: 30));
    Map<String, dynamic> volume1Year =
        user.getVolumeWhithDuration(const Duration(days: 366));
    Map<String, dynamic> volumeAllTime = user.getVolumeAllTime();

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
                  "Derniere semaine : ${date.day}/${date.month}/${date.year} - ${date.subtract(const Duration(days: 7)).day}/${date.subtract(const Duration(days: 7)).month}/${date.subtract(const Duration(days: 7)).year}",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.03,
                ),
                VolumesList(volume: volume7Days),
                SizedBox(
                  height: media.width * 0.03,
                ),
                Text(
                  "Dernier Mois : ${date.day}/${date.month}/${date.year} - ${date.subtract(const Duration(days: 30)).day}/${date.subtract(const Duration(days: 30)).month}/${date.subtract(const Duration(days: 30)).year}",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                VolumesList(volume: volume1Months),
                SizedBox(
                  height: media.width * 0.03,
                ),
                Text(
                  "Dernière année : ${date.day}/${date.month}/${date.year} - ${date.subtract(const Duration(days: 366)).day}/${date.subtract(const Duration(days: 366)).month}/${date.subtract(const Duration(days: 366)).year}",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                VolumesList(volume: volume1Year),
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
                VolumesList(volume: volumeAllTime),
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
