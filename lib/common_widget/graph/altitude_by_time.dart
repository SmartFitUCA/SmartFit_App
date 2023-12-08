import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/common_widget/graph/data_for_graph/func_bpm_by_time.dart';
import 'package:smartfit_app_mobile/common_widget/graph/mobile/mobile_altitude_by_time.dart';
import 'package:smartfit_app_mobile/common_widget/graph/web/web_altitude_by_time.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/data_home_view.dart';

class GraphAltitudeByTime extends StatefulWidget {
  final Size media;
  final DataHomeView data;

  const GraphAltitudeByTime(this.media, this.data, {Key? key})
      : super(key: key);

  @override
  State<GraphAltitudeByTime> createState() => _GraphAltitudeByTime();
}

class _GraphAltitudeByTime extends State<GraphAltitudeByTime> {
  @override
  Widget build(BuildContext context) {
    final FuncBpmByTime funcBpm = FuncBpmByTime(widget.data);
    return ScreenTypeLayout.builder(
      mobile: (_) => MobileGraphAltitudeByTime(widget.media, widget.data, funcBpm),
      desktop: (_) => WebGraphAltitudeByTime(widget.media, widget.data, funcBpm),
    );
  }
}
