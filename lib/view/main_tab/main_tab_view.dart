import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/view/activity/list_activity.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/button/tab_button.dart';
import 'package:smartfit_app_mobile/view/activity/activity.dart';
import 'package:smartfit_app_mobile/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/view/main_tab/mobile/mobile_main_tab_view.dart';
import 'package:smartfit_app_mobile/view/main_tab/web/web_main_tab_view.dart';
import 'package:smartfit_app_mobile/view/map/my_map.dart';
import 'package:smartfit_app_mobile/view/profile/profile_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
@override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const MobileMainTabView(),
      desktop: (_) => const WebMainTabView(),
    );
  }
}