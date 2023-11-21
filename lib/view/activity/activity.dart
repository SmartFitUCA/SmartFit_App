import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/view/activity/mobile/mobile_Activity_view.dart';
import 'package:smartfit_app_mobile/view/activity/web/web_Activity_view.dart';
import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/view/home/no_activity_view.dart';

class Activity extends StatelessWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.watch<User>().listActivity.isEmpty
        ? ScreenTypeLayout.builder(
            mobile: (_) => const NoActivityView(),
            desktop: (_) => const NoActivityView(),
          )
        : ScreenTypeLayout.builder(
            mobile: (_) => const MobileActivity(),
            desktop: (_) => const WebActivity(),
          );
  }
}
