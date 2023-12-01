import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/modele/activity.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/view/home/no_activity_view.dart';
import 'package:smartfit_app_mobile/view/map/chose_map.dart';
import 'package:smartfit_app_mobile/view/map/my_map_osm.dart';
import 'package:smartfit_app_mobile/view/map/web/web_my_map.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  @override
  Widget build(BuildContext context) {
    List<ActivityOfUser> listSelected =
        context.watch<User>().managerSelectedActivity.activitySelected;

    if (listSelected.isEmpty) {
      return ScreenTypeLayout.builder(
        mobile: (_) => const NoActivityView("Pas d'activité sélectionnée"),
        desktop: (_) => const NoActivityView("Pas d'activité sélectionnée"),
      );
    }
    if (listSelected.length > 1) {
      return ScreenTypeLayout.builder(
        mobile: (_) => const NoActivityView(
            "Qu'une seule activité doit être sélectionner"),
        desktop: (_) => const NoActivityView(
            "Qu'une seule activité doit être sélectionner"),
      );
    }
    return ScreenTypeLayout.builder(
      mobile: (_) => const ChoseMap(),
      desktop: (_) => const ChoseMap(),
    );
  }
}
