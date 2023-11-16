import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/view/home/mobile/mobile_Activity_view.dart';
import 'package:smartfit_app_mobile/view/home/web/web_Activity_view.dart';
import 'package:flutter/material.dart';

class Activity extends StatelessWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.watch<User>().listActivity.isEmpty) {
      return const Scaffold(
          body: Column(
        children: [
          Text("C'est vide"),
          Text("C'est vide"),
          Text("C'est vide"),
          Text("C'est vide")
        ],
      ));
    } else {
      return ScreenTypeLayout.builder(
        mobile: (_) => const MobileActivity(),
        desktop: (_) => const WebActivity(),
      );
    }
  }
}
