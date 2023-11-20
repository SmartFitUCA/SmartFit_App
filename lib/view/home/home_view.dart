import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/view/home/mobile/mobile_homeview.dart';
import 'package:smartfit_app_mobile/view/home/web/web_homeview.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
        mobile: (_) => const MobileHomeView(),
        desktop: (_) => const WebHomeView(),
      );
    }
  }
}
