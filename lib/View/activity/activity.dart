import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/View/home/mobile/mobile_Activity_view.dart';
import 'package:smartfit_app_mobile/View/home/mobile/mobile_homeview.dart';
import 'package:smartfit_app_mobile/View/home/web/web_Activity_view.dart';
import 'package:smartfit_app_mobile/View/home/web/web_homeview.dart';
import 'package:smartfit_app_mobile/common_widget/steps.dart';
import 'package:smartfit_app_mobile/common_widget/graph.dart';
import 'package:smartfit_app_mobile/common_widget/info.dart' hide Stats;
import 'package:smartfit_app_mobile/common_widget/stats.dart';
import 'package:flutter/material.dart';

class Activity extends StatelessWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const MobileActivity(),
      desktop: (_) => const WebActivity(),
    );
  }
}
