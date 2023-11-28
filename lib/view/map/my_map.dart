import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/view/home/no_activity_view.dart';
import 'package:smartfit_app_mobile/view/map/mobile/mobile_my_map.dart';
import 'package:smartfit_app_mobile/view/map/web/web_my_map.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  @override
  Widget build(BuildContext context) {
    return context
            .watch<User>()
            .managerSelectedActivity
            .activitySelected
            .isEmpty
        ? ScreenTypeLayout.builder(
            mobile: (_) => const NoActivityView(),
            desktop: (_) => const NoActivityView(),
          )
        : ScreenTypeLayout.builder(
            mobile: (_) => const MobileMyMaps(),
            desktop: (_) => const WebMyMaps(),
          );
  }
}
