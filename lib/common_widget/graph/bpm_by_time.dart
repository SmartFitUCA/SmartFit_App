import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/common_widget/graph/data_for_graph/func_bpm_by_time.dart';
import 'package:smartfit_app_mobile/common_widget/graph/mobile/mobile_bpm_by_time.dart';
import 'package:smartfit_app_mobile/common_widget/graph/web/web_bpm_by_time.dart';
import 'package:smartfit_app_mobile/modele/utile/home_view/data_home_view.dart';

class BpmByTime extends StatefulWidget {
  final Size media;
  final DataHomeView data;

  const BpmByTime(this.media, this.data, {Key? key}) : super(key: key);

  @override
  State<BpmByTime> createState() => _BpmByTime();
}

class _BpmByTime extends State<BpmByTime> {
  @override
  Widget build(BuildContext context) {
    final FuncBpmByTime funcBpm = FuncBpmByTime(widget.data);

    return ScreenTypeLayout.builder(
      mobile: (_) => MobileBpmByTime(widget.media, widget.data, funcBpm),
      desktop: (_) => WebBpmByTime(widget.media, widget.data, funcBpm),
    );
  }
}
