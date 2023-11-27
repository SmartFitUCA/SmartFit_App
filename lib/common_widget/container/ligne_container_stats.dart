
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/common_widget/container/mobile/mobile_ligne_container_stats.dart';
import 'package:smartfit_app_mobile/common_widget/container/web/web_ligne_container_stats.dart';

class LigneContainerStats extends StatelessWidget {
  const LigneContainerStats(this.value1, this.value2, this.value3,
      this.designation1, this.designation2, this.designation3,
      this.icon1, this.icon2, this.icon3,
      {Key? key})
      : super(key: key);

  final String value1;
  final String value2;
  final String value3;

  final String designation1;
  final String designation2;
  final String designation3;

  final IconData icon1;
  final IconData icon2;
  final IconData icon3;

 @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) =>  MobileLigneContainerStats(value1, value2, value3, designation1, designation2, designation3, icon1, icon2, icon3),
      desktop: (_) =>  WebLigneContainerStats(value1, value2, value3, designation1, designation2, designation3, icon1, icon2, icon3),
    );
  }
}
