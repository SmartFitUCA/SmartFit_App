import 'package:smartfit_app_mobile/common_widget/steps.dart';
import 'package:smartfit_app_mobile/common_widget/dates.dart';
import 'package:smartfit_app_mobile/common_widget/graph.dart';
import 'package:smartfit_app_mobile/common_widget/info.dart' hide Stats;
import 'package:smartfit_app_mobile/common_widget/stats.dart';
import 'package:flutter/material.dart';

class Activity extends StatelessWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: const [
          Divider(height: 80),
          Steps(),
          Graph(),
          Info(),
          Divider(height: 30),
          Stats(),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}