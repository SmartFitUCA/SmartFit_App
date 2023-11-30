import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/common_widget/graph/data_for_graph/func_bpm_and_speed_by_time.dart';
import 'package:smartfit_app_mobile/common_widget/graph/mobile/mobile_bpm_and_speed_by_time.dart';
import 'package:smartfit_app_mobile/common_widget/graph/web/web_bpm_and_speed_by_time.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/data_home_view.dart';

class GraphBpmAndSpeedByTime extends StatefulWidget {
  final Size media;
  final DataHomeView data;

  const GraphBpmAndSpeedByTime(this.media, this.data, {Key? key})
      : super(key: key);

  @override
  State<GraphBpmAndSpeedByTime> createState() => _GraphBpmAndSpeedByTime();
}

class _GraphBpmAndSpeedByTime extends State<GraphBpmAndSpeedByTime> {
  @override
  Widget build(BuildContext context) {
    final FuncBpmAndSpeedByTime func = FuncBpmAndSpeedByTime(widget.data);

    return ScreenTypeLayout.builder(
      mobile: (_) =>
          MobileGraphBpmAndSpeedByTime(widget.media, widget.data, func),
      desktop: (_) =>
          WebGraphBpmAndSpeedByTime(widget.media, widget.data, func),
    );
  }
}
