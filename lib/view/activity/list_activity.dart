import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smartfit_app_mobile/view/activity/mobile/mobile_list_activity.dart';
import 'package:smartfit_app_mobile/view/activity/web/web_list_activity.dart';

class ListActivity extends StatefulWidget {
  const ListActivity({super.key});

  @override
  State<ListActivity> createState() => _ListActivityState();
}

class _ListActivityState extends State<ListActivity> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const MobileListActivity(),
      desktop: (_) => const WebListActivity(),
    );
  }
}
