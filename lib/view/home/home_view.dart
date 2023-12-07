import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/view/home/mobile/mobile_homeview.dart';
import 'package:smartfit_app_mobile/view/home/no_activity_view.dart';
import 'package:smartfit_app_mobile/view/home/stats_activities_view.dart';
import 'package:smartfit_app_mobile/view/home/web/web_homeview.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final selectedActivitiesCount =
        context.watch<User>().managerSelectedActivity.activitySelected.length;

    return selectedActivitiesCount == 1
        ? ScreenTypeLayout.builder(
            mobile: (_) => const MobileHomeView(),
            desktop: (_) => const WebHomeView(),
          )
        : selectedActivitiesCount > 1
            ? const StatAtivities()
            : ScreenTypeLayout.builder(
                mobile: (_) =>
                    const NoActivityView("Pas d'activité sélectionnée"),
                desktop: (_) =>
                    const NoActivityView("Pas d'activité sélectionnée"),
              );
  }
}
