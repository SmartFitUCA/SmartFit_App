import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common_widget/steps.dart';
import 'package:smartfit_app_mobile/common_widget/graph.dart';
import 'package:smartfit_app_mobile/common_widget/info.dart' hide Stats;
import 'package:smartfit_app_mobile/common_widget/stats.dart';
import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/modele/user.dart';

class MobileActivity extends StatelessWidget {
  const MobileActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.watch<User>().listActivity.isEmpty) {
      return const Scaffold(body: Text("C'est vide"));
    }

    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
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
