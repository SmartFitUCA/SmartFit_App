import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/view/home/mobile/mobile_Activity_view.dart';
import 'package:smartfit_app_mobile/view/home/web/web_Activity_view.dart';
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
