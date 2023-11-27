import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/common_widget/container/mobile/mobile_container_stats.dart';
import 'package:smartfit_app_mobile/common_widget/container/web/web_container_stats.dart';

class ContainerStats extends StatelessWidget {
  const ContainerStats(this.value, this.designation, this.icon, {Key? key})
      : super(key: key);

  final String value;
  final String designation;
  final IconData icon;

 @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) =>  MobileContainerStats(this.value, this.designation, this.icon),
      desktop: (_) =>  WebContainerStats(this.value, this.designation, this.icon),
    );
  }
}
